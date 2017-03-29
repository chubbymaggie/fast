import sys
import subprocess
import re
import os
from pbjson import pb2json
from fast_pb2 import Element as EL
from google.protobuf.internal import encoder
import pdb
import xml.etree.ElementTree as ET
import cgi
import _fast
from Element import *
from Unit import *
from Literal import *
from Anonymous0 import *
from LanguageType import *
from LiteralType import *
from Kind import *
import flatbuffers
from var_dump import var_dump

mapping = {}

def dumpTree(root, rootfast):
    tag = re.sub(r"{.*}", "", root.tag)
    if root.text:
       rootfast.text = root.text
    if root.tail:
       rootfast.tail = root.tail
    if tag == "unit":
        rootfast.unit.filename = root.attrib['filename']
        rootfast.unit.revision = root.attrib['revision']
        lang = root.attrib['language'] 
        if lang == "C++":
            lang = "CXX"
        rootfast.unit.language = EL.Unit.LanguageType.DESCRIPTOR.values_by_name[lang].__dict__['number']
        if root.attrib.get('item') != None:
            rootfast.unit.item = root.attrib['item']
        tag = tag + "_KIND"
    elif tag == "literal":
        if root.attrib and root.attrib['type']:
            rootfast.literal.type = EL.Literal.LiteralType.DESCRIPTOR.values_by_name[root.attrib['type'] + "_type"].__dict__['number']
    rootfast.kind = EL.Kind.DESCRIPTOR.values_by_name[tag.upper()].__dict__['number']
    for child in root.findall("*"):
        childfast = rootfast.child.add()
        dumpTree(child, childfast)

def dumpXML(out, rootfast):
    tag = EL.Kind.DESCRIPTOR.values[rootfast.kind].name.lower()
    if tag == "unit_kind":
        tag = tag[:len(tag)-5] # strip the "_kind" suffix
        lang = EL.Unit.LanguageType.DESCRIPTOR.values[rootfast.unit.language].name
        if lang == "CXX":
            lang = "C++"
            lan = "cpp"
        else:
            lan = lang.lower()
        if rootfast.unit.item:
            item = " item=\"" + item + "\""
        else: 
            item = ""
        start_tag = "unit"  \
            + " xmlns=\"http://www.srcML.org/srcML/src\"" \
            + " xmlns:" + lan + "=\"http://www.srcML.org/srcML/" + lan + "\"" \
            + " revision=\"" + rootfast.unit.revision + "\"" \
            + " language=\"" + lang + "\"" \
            + " filename=\"" + rootfast.unit.filename + "\"" \
            + item
    elif tag == "literal":
        if rootfast.literal.type != None:
            n = EL.Literal.LiteralType.DESCRIPTOR.values[rootfast.literal.type].name 
            type = " type=\"" + n[0:len(n)-5] + "\""  # strip the "_type" suffix
        else:
            type = ""
        start_tag = "literal" \
            + type
    else:
        start_tag = tag
    if tag != "unit" or rootfast.unit.filename != "":
        out.write("<" + start_tag + ">")
    if rootfast.text:
       out.write(cgi.escape(rootfast.text).encode('ascii', 'xmlcharrefreplace'))
    for childfast in rootfast.child:
        dumpXML(out, childfast)
    if tag != "unit" or rootfast.unit.filename != "":
       out.write("</" + tag + ">")
    if rootfast.tail:
       out.write(cgi.escape(rootfast.tail).encode('ascii', 'xmlcharrefreplace'))

def dumpFlatBuffers(root, builder):
    tag = re.sub(r"{.*}", "", root.tag)
    rootText = None
    rootTail = None
    rootFilename = None
    rootLang = None
    rootItem = None
    if root.text:
        rootText = builder.CreateString(root.text)
    else:
        rootText = builder.CreateString("")
    if root.tail:
        rootTail = builder.CreateString(root.tail)
    else:
        rootTail = builder.CreateString("")
    if tag == "unit":
        if root.attrib and root.attrib['filename']:
            rootFilename = builder.CreateString(root.attrib['filename'])
        else:
            rootFilename = builder.CreateString("")
        if root.attrib and root.attrib['revision']:
            rootRevision = builder.CreateString(root.attrib['revision'])
        else:
            rootRevision = builder.CreateString("")
        if root.attrib:
            lang = root.attrib['language'] 
            if lang: 
                if lang == "C++":
                    lang = "CXX"
            rootLang = EL.Unit.LanguageType.DESCRIPTOR.values_by_name[lang].__dict__['number']
        else:
            rootLang = 0
        if root.attrib and root.attrib.get('item') != None:
            rootItem = int(root.attrib['item'])
        else:
            rootItem = 0
    childfasts=[]
    for child in root.findall("*"):
        childfasts.append(dumpFlatBuffers(child, builder))
    N = len(childfasts)
    ElementStartChildVector(builder, N)
    for i in reversed(range(0, N)):
        builder.PrependUOffsetTRelative(childfasts[i])
    rootChild = builder.EndVector(N)
    anonymous = None
    if tag == "unit":
        UnitStart(builder)
        UnitAddFilename(builder, rootFilename) 
        UnitAddRevision(builder, rootRevision) 
        UnitAddLanguage(builder, rootLang) 
        UnitAddItem(builder, rootItem) 
        unit = UnitEnd(builder)
        tag = tag + "_KIND"
        Anonymous0Start(builder)
        Anonymous0AddUnit(builder, unit)
        anonymous = Anonymous0End(builder)
    elif tag == "literal" and root.attrib and root.attrib['type']:
        LiteralStart(builder)
        LiteralAddType(builder, EL.Literal.LiteralType.DESCRIPTOR.values_by_name[root.attrib['type'] + "_type"].__dict__['number'])
        literal = LiteralEnd(builder)
        Anonymous0Start(builder)
        Anonymous0AddLiteral(builder, literal)
        anonymous = Anonymous0End(builder)
    ElementStart(builder)
    rootKind = EL.Kind.DESCRIPTOR.values_by_name[tag.upper()].__dict__['number']
    ElementAddKind(builder, rootKind)
    ElementAddText(builder, rootText)
    ElementAddTail(builder, rootTail)
    if anonymous:
        ElementAddExtra(builder,anonymous)
    ElementAddChild(builder, rootChild)
    return ElementEnd(builder)

debug = False
def read_xml(input_filename, output_filename):
    if debug:
        pdb.set_trace()
    output_basename, output_extension = os.path.splitext(output_filename)
    out_file = open(output_filename, "a")
    tree = ET.parse(input_filename)
    root = tree.getroot()
    if output_extension == ".pb": 
        unit = EL()
        dumpTree(root, unit)
        serializedMessage = unit.SerializeToString()
        out_file.write(serializedMessage)
        out_file.close()
    elif output_extension == ".fbs":
        builder = flatbuffers.Builder(0)
        data = dumpFlatBuffers(root, builder)
        builder.Finish(data)
        gen_buf, gen_off = builder.Bytes, builder.Head()
        out_file.write(gen_buf[gen_off:])
        out_file.close()


def read_pb(input_filename, output_filename):
    data = EL()
    with open(input_filename, 'rb') as f:
       data.ParseFromString(f.read())
       f.close()
       output_basename, output_extension = os.path.splitext(output_filename)
       with open(output_filename, 'w') as out:
           if output_extension == ".json":
               out.write(pb2json(data))
               out.close()
           elif output_extension == ".xml":
               out.write("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n");
               dumpXML(out, data)
               out.write("\n")
               out.close()
           elif output_extension == ".cpp" or output_extension == ".cc" or output_extension == ".java":
               with open(output_filename + ".xml", 'w') as xml_out:
                   dumpXML(xml_out, data)
                   xml_out.close()
               p = subprocess.Popen(["srcml", output_filename + ".xml"], stdout=subprocess.PIPE)
               for line in p.stdout:
                   out.write(line)
               out.close()
               os.remove(output_filename + ".xml")
           else: # do not output, to test performance of loading protobuf
               out.close()

def dumpFBS2XML(out, root):
    tag=""
    text=root.Text()
    tail=root.Tail()
    attr=""
    if root.Kind() == 0:
        tag = "unit"
        attr = attr + " filename=\"" + root.Extra().Unit().Filename() +"\""
        attr = attr + " revision=\"" + root.Extra().Unit().Revision() +"\""
        lang = LanguageType(root.Extra().Unit().Language()).name
        if lang == "CXX":
            lang = "C++"
            lan = "cpp"
        else:
            lan = lang.lower()
        attr = attr + " language=\"" + lan +"\""
        item = root.Extra().Unit().Item()
        if item:
            attr = attr + " item=\"" + ("%d" % item) +"\""
    elif root.Kind() == 47:
        tag = "literal"
        if root.Extra().Literal().Type():
            t = LiteralType(root.Extra().Literal().Type()).name
            attr = attr + " type=\"" + t[0:len(t)-5] +"\""
    else:
        tag = Kind(root.Kind()).name
    out.write("<%s%s>%s" % (tag, attr, text));
    for i in range(root.ChildLength()):
        child = root.Child(i)
        dumpFBS2XML(out, child)
    out.write("</%s>%s" % (tag, tail));

def read_fbs(input_filename, output_filename):
    with open(input_filename, 'rb') as f:
       buf = f.read()
       buf = bytearray(buf)
       data = Element.GetRootAsElement(buf, 0)
       output_basename, output_extension = os.path.splitext(output_filename)
       with open(output_filename, 'w') as out:
           if output_extension == ".json":
               out.close()
           elif output_extension == ".xml":
               out.write("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n");
               dumpFBS2XML(out, data)
               out.write("\n")
               out.close()
           elif output_extension == ".cpp" or output_extension == ".cc" or output_extension == ".java":
               out.close()
           else: # do not output, to test performance of loading protobuf
               out.close()

#if __name__ == "__main__":
def main():
       debug = False
       if sys.argv[1] == "-g": 
           debug = True
           sys.argv = sys.argv[1:] # shift
       if (os.path.exists(sys.argv[2])):
           os.remove(sys.argv[2])
       input_filename, input_extension = os.path.splitext(sys.argv[1])
       if (input_extension == ".xml"):
           read_xml(sys.argv[1], sys.argv[2])
       if (input_extension == ".pb"):
           read_pb(sys.argv[1], sys.argv[2])
       if (input_extension == ".fbs"):
           read_fbs(sys.argv[1], sys.argv[2])
