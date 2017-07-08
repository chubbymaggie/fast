#!/bin/bash

fast=$(which fast)
process=$(which process)
if [ "$fast" != "/usr/local/bin/fast" ]; then
	if [ ! -f ../fast -o ! -f ../process ]; then
		cd .. 
		make OPT="-g -O0 --coverage"
		sudo make install
		cd -
	fi
fi
fast=${fast:=../fast}
process=${process:=../process}

stdout() {
	hash=$1
	shift
	assertSame $hash $($fast $@ | shasum -a 256 | awk '{print $1}')
} 
export -f stdout

catout() {
	fast=cat stdout $@
}
export -f catout

stderr() {
	hash=$1
	shift
	assertSame $hash $($fast $@ 2>&1 > /dev/null | shasum -a 256 | awk '{print $1}')
} 
export -f stderr

stdouterr() {
	hash=$1
	shift
	assertSame $hash $($fast $@ 2>&1 | shasum -a 256 | awk '{print $1}')
} 
export -f stdouterr

testhello() {
	$fast -v
	$fast -h
}

testJava() 
{
	cat > Hello.java <<EOF

public class Hello {
	public static void main(String args[]) {
		System.out.println("Hello, world!");
	}
}
EOF
	catout a8e15f72dd2a6f880587f388abfd84d34dea74632566fcea8754b4ceca017a1e Hello.java
	$fast Hello.java Hello.xml
	catout 1207fa1c163baec58a7934e2ec7aefdd6fe9d0d08f997b168a3bd1b24a7eebf2 Hello.xml
	$fast Hello.java Hello.pb
	stdout 5d6a5d0fe43892ebd0d89f721abae274d76982b2474b449fe795ed5fa5ce8478 -d Hello.pb
	$fast -d Hello.pb Hello.txt
	catout 5d6a5d0fe43892ebd0d89f721abae274d76982b2474b449fe795ed5fa5ce8478 Hello.txt
}
testCC() 
{
	cat > example.cc <<EOF
int f(int x) {
	  int result = (x / 42);
	    return result;
}
EOF
	catout 094f521830f664a85196b5968349d0c76a84a99f902ae391ec78caaf926591d7 example.cc
	$fast example.cc example.xml
	catout 2368362bbad04bf0f9d0b9d010de277f1d6932636dc64756bc23a9abc61a784e example.xml
	$fast example.xml example.pb
	$fast example.pb example.pb.cc
	catout 094f521830f664a85196b5968349d0c76a84a99f902ae391ec78caaf926591d7 example.pb.cc
	$fast -p example.cc example.position.xml
	catout 873145704786c3f0671984705735f8c7415caf274414cf5fbf82be6bc6ba60cf example.position.xml
	$fast example.cc example.fbs
	$fast -p example.cc example.position.fbs
	stdout c287b1162d8b3d9e44dac808ec4edaf9dbd49282e0d0853db3f08a54ec5e3aea example.position.fbs
	$fast -p example.cc example.position.pb
	stdout d6382f209c7b6360033e1d6bdc5ce9be435a5e878075cd88b10d4157508dbf4d -d example.position.pb
	stdout e4efaf6a2ddfc909dd34f7740de7e487fae98aeb262213ab5d10eeef3b1a1536 -d example.pb
	$fast example.pb example.txt
	catout 094f521830f664a85196b5968349d0c76a84a99f902ae391ec78caaf926591d7 example.txt
}
testSmali() 
{
	cat > DuplicateVirtualMethods.smali <<EOF
.class public LDuplicateVirtualMethods;
.super Ljava/lang/Object;

.method public alah()V
    .registers 1
    return-void
.end method

.method public blah()V
    return-void
.end method

.method public blah()V
    .registers 1
    return-void
.end method

.method public clah()V
    .registers 1
    return-void
.end method
EOF
	cat > DuplicateVirtualMethods-v2.smali <<EOF
.class public LDuplicateVirtualMethods;
.super Ljava/lang/Object;

.method public alah()V
    return-void
.end method

.method private blahbla()V
    .registers 2

    return-void

.end method

.method public blah()V
    .registers 1
    return-void
.end method

.method public clah()V
    .registers 1
    return-void
.end method
EOF
	catout 14807015fc8bc8506ca3d02e40a71b5e7f7aa6d57f8c3b6c5db880d51af35c27 DuplicateVirtualMethods.smali
	catout 313fb700c0d562f562209a523e597d8bc6f70688e7fb176ed9da3faf5b8b221a DuplicateVirtualMethods-v2.smali
	$fast DuplicateVirtualMethods.smali DuplicateVirtualMethods.smali.xml
	catout c127eb3d6322b3f9d38eaead37e56faf6939fe776587924d361a3e1b280c1ee7 DuplicateVirtualMethods.smali.xml
	rm -f smali.proto
	$fast DuplicateVirtualMethods.smali DuplicateVirtualMethods.smali.pb
	catout 6ed7e11200def362490c5d8f35743798a646f7bc48ddff7a1304940b0d6f8956 smali.proto
	$fast DuplicateVirtualMethods.smali DuplicateVirtualMethods.smali.pb
	$fast -d DuplicateVirtualMethods.smali.pb > DuplicateVirtualMethods.smali.pb.txt
	catout 9ab34981b8cd72e1746b32decc0a571f0d0895157f4f60ed2cb105cf18be4474 DuplicateVirtualMethods.smali.pb.txt
}

testCS() {
	cat > test.cs <<EOF
@ namespace HandCoded.FpML.Validation
return (result);
}
		// --------------------------------------------------------------------
		private static bool Rule02 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule02 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "ExchangeRate"), errorHandler));

			return (
				  Rule02 (name, nodeIndex.GetElementsByName ("exchangeRate"), errorHandler));
		}

		private static bool Rule02 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement	context in list) {
				XmlElement 	forward = XPath.Path (context, "forwardPoints");
				XmlElement	spot	= XPath.Path (context, "spotRate");
				if (!((forward != null) && (spot == null))) continue;
				errorHandler ("305", context,
						"If forwardPoints exists then spotRate should also exist.",
						name, null);

				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule03 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule03 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "ExchangeRate"), errorHandler));
			return (
				  Rule03 (name, nodeIndex.GetElementsByName ("exchangeRate"), errorHandler));
		}

		private static bool Rule03 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement	context in list) {
				XmlElement 	forward = XPath.Path (context, "forwardPoints");
				XmlElement	spot	= XPath.Path (context, "spotRate");
				XmlElement	rate	= XPath.Path (context, "rate");
				if ((rate == null) || (forward == null) || (spot == null)) continue;
				if (ToDecimal (rate).Equals (ToDecimal (spot) + ToDecimal (forward)))
					continue;

				errorHandler ("305", context,
						"Sum of spotRate and forwardPoints does not equal rate.",
						name, ToToken (rate));

				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule04 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule04 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "ExchangeRate"), errorHandler));
			return (
				  Rule04 (name, nodeIndex.GetElementsByName ("exchangeRate"), errorHandler));
		}

		private static bool Rule04 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement 	baseCcy = XPath.Path (context, "sideRates", "baseCurrency");
				XmlElement	ccy1	= XPath.Path (context, "quotedCurrencyPair", "currency1");
				XmlElement	ccy2	= XPath.Path (context, "quotedCurrencyPair", "currency2");

				if ((baseCcy == null) || (ccy2 == null) || (ccy2 == null)) continue;

				if (Equal (baseCcy, ccy1) || Equal (baseCcy, ccy2)) {
					errorHandler ("305", context,
							"The side rate base currency must not be one of the trade currencies.",
							name, ToToken (baseCcy));
result = false;
}
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule05 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule05 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "ExchangeRate"), errorHandler));
			return (
				  Rule05 (name, nodeIndex.GetElementsByName ("exchangeRate"), errorHandler));
		}

		private static bool Rule05 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement	ccy		= XPath.Path (context, "quotedCurrencyPair", "currency1");
				XmlElement 	ccy1 	= XPath.Path (context, "sideRates", "currency1SideRate", "currency");
				if ((ccy == null) || (ccy1 == null) || Equal (ccy, ccy1)) continue;
				errorHandler ("305", context,
						"The side rate currency1 '" + ToToken (ccy1) +
						"' must be the same as trade currency1 '" + ToToken (ccy) + "'.",
						name, null);

				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule06 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule06 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "ExchangeRate"), errorHandler));
			return (
				  Rule06 (name, nodeIndex.GetElementsByName ("exchangeRate"), errorHandler));
		}

		private static bool Rule06 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement	ccy		= XPath.Path (context, "quotedCurrencyPair", "currency2");
				XmlElement 	ccy1 	= XPath.Path (context, "sideRates", "currency2SideRate", "currency");
				if ((ccy == null) || (ccy1 == null) || Equal (ccy, ccy1)) continue;

				errorHandler ("305", context,
						"The side rate currency2 '" + ToToken (ccy1) +
						"' must be the same as trade currency2 '" + ToToken (ccy) + "'.",
						name, null);

				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule07 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule07 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXAmericanTrigger"), errorHandler)
					& Rule07 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxAmericanTrigger"), errorHandler));

			return (
				  Rule07 (name, nodeIndex.GetElementsByName ("fxAmericanTrigger"), errorHandler));
		}

		private static bool Rule07 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement		rate	= XPath.Path (context, "triggerRate");
				if ((rate == null) || IsPositive (rate)) continue;

				errorHandler ("305", context,
						"The trigger rate must be positive",
						name, ToToken (rate));
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule08 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule08 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXAmericanTrigger"), errorHandler)
					& Rule08 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxAmericanTrigger"), errorHandler));

			return (
				  Rule08 (name, nodeIndex.GetElementsByName ("fxAmericanTrigger"), errorHandler));
		}

		private static bool Rule08 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	start	= XPath.Path (context, "observationStartDate");
				XmlElement	end		= XPath.Path (context, "observationEndDate");
				if ((start == null) || (end == null) ||
					LessOrEqual (ToDate (start), ToDate (end))) continue;

				errorHandler ("305", context,
						"The observationStartDate must not be after the observationEndDate",
						name, null);
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule09 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule09 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXAverageRateObservationSchedule"), errorHandler)
					& Rule09 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxAverageRateObservationSchedule"), errorHandler));

			return (
				  Rule09 (name, nodeIndex.GetElementsByName ("averageRateObservationSchedule"), errorHandler));
		}

		private static bool Rule09 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	start	= XPath.Path (context, "observationStartDate");
				XmlElement	end		= XPath.Path (context, "observationEndDate");
				if ((start == null) || (end == null) ||
					LessOrEqual (ToDate (start), ToDate (end))) continue;

				errorHandler ("305", context,
						"The observationStartDate must not be after the observationEndDate",
						name, null);
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule10 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule10 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXAverageRateObservationSchedule"), errorHandler)
					& Rule10 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxAverageRateObservationSchedule"), errorHandler));

			return (
				  Rule10 (name, nodeIndex.GetElementsByName ("averageRateObservationSchedule"), errorHandler));
		}

		private static bool Rule10 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	start	= XPath.Path (context, "observationStartDate");
				XmlElement	end		= XPath.Path (context, "observationEndDate");
				XmlElement	period	= XPath.Path (context, "calculationPeriodFrequency");
				if ((start == null) || (end == null) || (period == null) ||
						ToInterval (period).DividesDates(ToDate (start), ToDate (end))) continue;
				errorHandler ("305", context,
						"The observation period is not a multiple of the calculationPeriodFrequency",
						name, null);
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule11 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule11 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXAverageRateOption"), errorHandler)
					& Rule11 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxAverageRateOption"), errorHandler));

			return (
				  Rule11 (name, nodeIndex.GetElementsByName ("fxAverageRateOption"), errorHandler));
		}

		private static bool Rule11 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlNodeList	nodes	= XPath.Paths (context, "observedRates", "observationDate");
				int			limit	= nodes.Count;
				Date []		dates	= new Date [limit];

				for (int count = 0; count < limit; ++count)
					dates [count] = ToDate (nodes [count]);

				for (int outer = 0; outer < (limit - 1); ++outer) {
					for (int inner = outer + 1; inner < limit; ++inner) {
						if (Equal (dates [outer], dates [inner]))
							errorHandler ("305", nodes [inner],
									"Duplicate observation date",
									name, ToToken (nodes [inner]));
						result = false;
}
}
				dates = null;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule12 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule12 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXAverageRateOption"), errorHandler)
					& Rule12 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxAverageRateOption"), errorHandler));

			return (
				  Rule12 (name, nodeIndex.GetElementsByName ("fxAverageRateOption"), errorHandler));
		}

		private static bool Rule12 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	schedule	= XPath.Path (context, "averageRateObservationSchedule");
				if (schedule == null) continue;

				XmlElement	start	= XPath.Path (schedule, "observationStartDate");
				XmlElement	end		= XPath.Path (schedule, "observationEndDate");
				XmlElement	freq	= XPath.Path (schedule, "calculationPeriodFrequency");
				XmlElement	roll	= XPath.Path (freq, "rollConvention");

				if ((start == null) || (end == null) || (freq == null) || (roll == null)) continue;

				Date [] 	dates	= GenerateSchedule (ToDate (start), ToDate (end),
						ToInterval (freq), DateRoll.ForName (ToToken (roll)), null);

				XmlNodeList	nodes	= XPath.Paths (context, "observedRates", "observationDate");

				foreach (XmlElement observed in nodes) {
					Date		date 	 = ToDate (observed);
					bool		found = false;
					foreach (Date match in dates) {
						if (Equal (date, match)) {
							found = true;
							break;
}
					}

					if (!found) {
						errorHandler ("305", observed,
								"Observation date '" + ToToken (observed) +
								"' does not match with the schedule.",
								name, ToToken (observed));
						result = false;
}
}
				dates = null;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule13 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule13 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXAverageRateOption"), errorHandler)
					& Rule13 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxAverageRateOption"), errorHandler));

			return (
				  Rule13 (name, nodeIndex.GetElementsByName ("fxAverageRateOption"), errorHandler));
		}

		private static bool Rule13 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlNodeList	schedule	= XPath.Paths (context, "averageRateObservationDate", "observationDate");
				int			limit		= (schedule != null) ? schedule.Count : 0;
				if (limit == 0) continue;

				Date []		dates	= new Date [limit];

				for (int count = 0; count < limit; ++count)
					dates [count] = ToDate (schedule [count]);

				XmlNodeList	nodes	= XPath.Paths (context, "observedRates", "observationDate");

				foreach (XmlElement observed in nodes) {
					Date		date 	 = ToDate (observed);
					bool		found = false;
					for (int match = 0; match < dates.Length; ++match) {
						if (Equal (date, dates [match])) {
							found = true;
							break;
						}
					}
					if (!found) {
						errorHandler ("305", observed,
								"Observation date '" + ToToken (observed) +
								"' does not match with a defined observationDate.",
								name, ToToken (observed));

						result = false;
					}
}
				dates = null;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule14 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule14 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXBarrier"), errorHandler)
					& Rule14 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxBarrier"), errorHandler));

			return (
				  Rule14 (name, nodeIndex.GetElementsByName ("fxBarrier"), errorHandler));
		}

		private static bool Rule14 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	start	= XPath.Path (context, "observationStartDate");
				XmlElement	end		= XPath.Path (context, "observationEndDate");
				if ((start == null) || (end == null) ||
					LessOrEqual (ToDate (start), ToDate (end))) continue;

				errorHandler ("305", context,
						"The observationStartDate must not be after the observationEndDate",
						name, null);
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule15 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule15 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXBarrierOption"), errorHandler)
					& Rule15 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxBarrierOption"), errorHandler));

			return (
				  Rule15 (name, nodeIndex.GetElementsByName ("fxBarrierOption"), errorHandler));
		}

		private static bool Rule15 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	rate	= XPath.Path (context, "spotRate");
				if ((rate == null) || IsPositive (rate)) continue;

				errorHandler ("305", context,
						"The spot rate must be positive",
						name, ToToken (rate));
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule16 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule16 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXDigitalOption"), errorHandler)
					& Rule16 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxDigitalOption"), errorHandler));

			return (
				  Rule16 (name, nodeIndex.GetElementsByName ("fxDigitalOption"), errorHandler));
		}

		private static bool Rule16 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	rate	= XPath.Path (context, "spotRate");
				if ((rate == null) || IsPositive (rate)) continue;

				errorHandler ("305", context,
						"The spot rate must be positive",
						name, ToToken (rate));
				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule17 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (
					  Rule17 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXEuropeanTrigger"), errorHandler)
					& Rule17 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxEuropeanTrigger"), errorHandler));
			return (
				  Rule17 (name, nodeIndex.GetElementsByName ("fxEuropeanTrigger"), errorHandler));
		}

		private static bool Rule17 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement	rate	= XPath.Path (context, "triggerRate");

				if ((rate == null) || IsPositive (rate)) continue;

				errorHandler ("305", context,
						"The trigger rate must be positive",
						name, ToToken (rate));

				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule18 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule18 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXLeg"), errorHandler)
					& Rule18 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxLeg"), errorHandler));

			return (
				  Rule18 (name, nodeIndex.GetElementsByName ("fxSingleLeg"), errorHandler));
		}

		private static bool Rule18 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement	ccy1Pay	= XPath.Path (context, "exchangedCurrency1", "payerPartyReference");
				XmlElement	ccy1Rec	= XPath.Path (context, "exchangedCurrency1", "receiverPartyReference");
				XmlElement	ccy2Pay	= XPath.Path (context, "exchangedCurrency2", "payerPartyReference");
				XmlElement	ccy2Rec	= XPath.Path (context, "exchangedCurrency2", "receiverPartyReference");

				if ((ccy1Pay == null) || (ccy1Rec == null) ||
					(ccy2Pay == null) || (ccy2Rec == null)) continue;

				if (Equal (ccy1Pay.GetAttribute("href"), ccy2Rec.GetAttribute("href")) &&
					Equal (ccy2Pay.GetAttribute("href"), ccy1Rec.GetAttribute("href"))) continue;

				errorHandler ("305", context,
						"Exchanged currency payers and receivers don't match.",
						name, null);

				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule19 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (
					  Rule19 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXLeg"), errorHandler)
					& Rule19 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxLeg"), errorHandler));
			return (
				  Rule19 (name, nodeIndex.GetElementsByName ("fxSingleLeg"), errorHandler));
		}

		private static bool Rule19 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement	ccy1	= XPath.Path (context, "exchangedCurrency1", "paymentAmount", "currency");
				XmlElement	ccy2	= XPath.Path (context, "exchangedCurrency2", "paymentAmount", "currency");

				if ((ccy1 == null) || (ccy2 == null) || !IsSameCurrency (ccy1, ccy2)) continue;

				errorHandler ("305", context,
						"Exchanged currencies must be different.",
						name, null);
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------
		private static bool Rule20 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule20 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXLeg"), errorHandler)
					& Rule20 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxLeg"), errorHandler));

			return (
				  Rule20 (name, nodeIndex.GetElementsByName ("fxSingleLeg"), errorHandler));
		}

		private static bool Rule20 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement	context in list) {
				XmlElement	date1	= XPath.Path (context, "currency1ValueDate");
				XmlElement	date2	= XPath.Path (context, "currency2ValueDate");
				if ((date1 == null) || (date2 == null) ||
					NotEqual (ToDate (date1), ToDate (date2))) continue;

				errorHandler ("305", context,
						"currency1ValueDate and currency2ValueDate must be different.",
						name, null);
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule21 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule21 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXLeg"), errorHandler)
					& Rule21 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxLeg"), errorHandler));

			return (
				  Rule21 (name, nodeIndex.GetElementsByName ("fxSingleLeg"), errorHandler));
		}

		private static bool Rule21 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	ndf		= XPath.Path (context, "nonDeliverableForward");
				XmlElement	fwd		= XPath.Path (context, "exchangeRate", "forwardPoints");
				if ((ndf == null) || (fwd != null)) continue;

				errorHandler ("305", context,
						"Non-deliverable forward does not specify forwardPoints.",
						name, null);
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule22 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule22 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXOptionLeg"), errorHandler)
					& Rule22 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxOptionLeg"), errorHandler));

			return (
				  Rule22 (name, nodeIndex.GetElementsByName ("fxSimpleOption"), errorHandler)
				& Rule22 (name, nodeIndex.GetElementsByName ("fxBarrierOption"), errorHandler));
		}

		private static bool Rule22 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	buyer	 = XPath.Path (context, "buyerPartyReference");
				XmlElement	seller	 = XPath.Path (context, "sellerPartyReference");
				XmlElement	payer	 = XPath.Path (context, "fxOptionPremium", "payerPartyReference");
				XmlElement	receiver = XPath.Path (context, "fxOptionPremium", "receiverPartyReference");
				if ((buyer == null) || (seller == null) ||
					(payer == null) || (receiver == null)) continue;

				if (Equal (buyer.GetAttribute("href"), payer.GetAttribute("href")) &&
					Equal (seller.GetAttribute("href"), receiver.GetAttribute("href"))) continue;

				errorHandler ("305", context,
						"Premium payer and receiver don't match with option buyer and seller.",
						name, null);
				result = false;
}

			return (result);
		}
		// --------------------------------------------------------------------

		private static bool Rule23 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule23 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXOptionLeg"), errorHandler)
					& Rule23 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxOptionLeg"), errorHandler));

			return (
				  Rule23 (name, nodeIndex.GetElementsByName ("fxSimpleOption"), errorHandler)
				& Rule23 (name, nodeIndex.GetElementsByName ("fxBarrierOption"), errorHandler));
		}

		private static bool Rule23 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	ccy1	= XPath.Path (context, "putCurrencyAmount", "currency");
				XmlElement	ccy2	= XPath.Path (context, "callCurrencyAmount", "currency");
				if ((ccy1 == null) || (ccy2 == null) || !IsSameCurrency (ccy1, ccy2)) continue;

				errorHandler ("305", context,
						"Put and call currencies must be different.",
						name, null);
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule24 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule24 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXStrikePrice"), errorHandler)
					& Rule24 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxStrikePrice"), errorHandler));

			return (
				  Rule24 (name, nodeIndex.GetElementsByName ("fxStrikePrice"), errorHandler));
		}

		private static bool Rule24 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	rate	= XPath.Path (context, "rate");
				if ((rate == null) || IsPositive (rate)) continue;

				errorHandler ("305", context,
						"The rate must be positive",
						name, ToToken (rate));
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule25 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule25 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXSwap"), errorHandler)
					& Rule25 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxSwap"), errorHandler));

			return (
				  Rule25 (name, nodeIndex.GetElementsByName ("fxSwap"), errorHandler));
		}

		private static bool Rule25 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlNodeList	legs	= XPath.Paths (context, "fxSingleLeg");
				if (Count (legs) >= 2) continue;

				errorHandler ("305", context,
						"FX swaps must have at least two legs.",
						name, null);
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule26 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule26 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXSwap"), errorHandler)
					& Rule26 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxSwap"), errorHandler));

			return (
				  Rule26 (name, nodeIndex.GetElementsByName ("fxSwap"), errorHandler));
		}

		private static bool Rule26 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlNodeList	legs	= XPath.Paths (context, "fxSingleLeg");
				if (Count (legs) != 2) continue;
				XmlElement 	date1	= XPath.Path (legs [0] as XmlElement, "valueDate");
				XmlElement 	date2	= XPath.Path (legs [1] as XmlElement, "valueDate");

				if (NotEqual (ToDate (date1), ToDate (date2))) continue;

				errorHandler ("305", context,
						"FX swaps legs must settle on different days.",
						name, null);

				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule27 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule27 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "QuotedCurrencyPair"), errorHandler));
			return (
				  Rule27 (name, nodeIndex.GetElementsByName ("quotedCurrencyPair"), errorHandler));
		}

		private static bool Rule27 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement	context in list) {
				XmlElement	ccy1	= XPath.Path (context, "currency1");
				XmlElement	ccy2	= XPath.Path (context, "currency2");
				if ((ccy1 == null) || (ccy2 == null) || !IsSameCurrency (ccy1, ccy2)) continue;

				errorHandler ("305", context,
						"Currencies must be different.",
						name, null);

				result = false;
}
			return (result);
		}
		// --------------------------------------------------------------------

		private static bool Rule28 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule28 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "SideRate"), errorHandler));
			return (
				  Rule28 (name, nodeIndex.GetElementsByName ("currency1SideRate"), errorHandler)
				& Rule28 (name, nodeIndex.GetElementsByName ("currency2SideRate"), errorHandler));
		}

		private static bool Rule28 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement		rate	= XPath.Path (context, "rate");
				if ((rate == null) || IsPositive (rate)) continue;

				errorHandler ("305", context,
						"The rate must be positive",
						name, ToToken (rate));
				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule29 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule29 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "SideRate"), errorHandler));
			return (
				  Rule29 (name, nodeIndex.GetElementsByName ("currency1SideRate"), errorHandler)
				& Rule29 (name, nodeIndex.GetElementsByName ("currency2SideRate"), errorHandler));
		}

		private static bool Rule29 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement 	forward = XPath.Path (context, "forwardPoints");
				XmlElement	spot	= XPath.Path (context, "spotRate");
				if (!((forward != null) && (spot == null))) continue;

				errorHandler ("305", context,
						"If forwardPoints exists then spotRate should also exist.",
						name, null);

				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule30 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule30 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "SideRate"), errorHandler));
			return (
					  Rule30 (name, nodeIndex.GetElementsByName ("currency1SideRate"), errorHandler)
					& Rule30 (name, nodeIndex.GetElementsByName ("currency2SideRate"), errorHandler));
		}

		private static bool Rule30 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement 	forward = XPath.Path (context, "forwardPoints");
				XmlElement	spot	= XPath.Path (context, "spotRate");
				XmlElement	rate	= XPath.Path (context, "rate");

				if ((rate == null) || (forward == null) || (spot == null)) continue;

				if (ToDecimal (rate).Equals(ToDecimal (spot) + ToDecimal (forward)))
					continue;

				errorHandler ("305", context,
						"Sum of spotRate and forwardPoints does not equal rate.",
						name, ToToken (rate));
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule31 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule31 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "SideRates"), errorHandler));

			return (
					  Rule31 (name, nodeIndex.GetElementsByName ("sideRates"), errorHandler));
		}

		private static bool Rule31 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement 	baseCcy	= XPath.Path (context, "baseCurrency");
				XmlElement	ccy1	= XPath.Path (context, "currency1SideRate", "currency");
				XmlElement	ccy2	= XPath.Path (context, "currency2SideRate", "currency");

				if ((baseCcy == null) || (ccy1 == null) || (ccy2 == null) ||
					(!IsSameCurrency (baseCcy, ccy1) && !IsSameCurrency (baseCcy, ccy2))) continue;

				errorHandler ("305", context,
						"The base currency must be different from the side rate currencies.",
						name, ToToken (baseCcy));

				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule32 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule32 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "TermDeposit"), errorHandler));
			return (
					  Rule32 (name, nodeIndex.GetElementsByName ("termDeposit"), errorHandler));
		}

		private static bool Rule32 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement	payer	 = XPath.Path (context, "initialPayerReference");
				XmlElement	receiver = XPath.Path (context, "initialReceiverReference");

				if ((payer == null) || (receiver == null)) continue;
				if (NotEqual (payer.GetAttribute ("href"),
							  receiver.GetAttribute ("href"))) continue;
				errorHandler ("305", context,
						"The initial payer and receiver must be different",
						name, payer.GetAttribute ("href"));

				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule33 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule33 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "TermDeposit"), errorHandler));
			return (
					  Rule33 (name, nodeIndex.GetElementsByName ("termDeposit"), errorHandler));
		}

		private static bool Rule33 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement	start	 = XPath.Path (context, "startDate");
				XmlElement	maturity = XPath.Path (context, "maturityDate");
				if ((start == null) || (maturity == null) ||
					Less (ToDate (start), ToDate (maturity))) continue;

				errorHandler ("305", context,
						"The maturity date must be after the start date",
						name, ToToken (maturity));

				result = false;
}
			return (result);
		}
		// --------------------------------------------------------------------
		private static bool Rule34 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule34 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "TermDeposit"), errorHandler));
			return (
					  Rule34 (name, nodeIndex.GetElementsByName ("termDeposit"), errorHandler));
		}

		private static bool Rule34 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	amount	= XPath.Path (context, "principal", "amount");
				if ((amount == null) || IsPositive (amount)) continue;
				errorHandler ("305", context,
						"The principal amount must be positive",
						name, ToToken (amount));
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule35 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule35 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "TermDeposit"), errorHandler));

			return (
					  Rule35 (name, nodeIndex.GetElementsByName ("termDeposit"), errorHandler));
		}
		private static bool Rule35 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement	context in list) {
				XmlElement	rate	= XPath.Path (context, "fixedRate");

				if ((rate == null) || IsPositive (rate)) continue;

				errorHandler ("305", context,
						"The fixed rate must be positive",
						name, ToToken (rate));

				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule36 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule36 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "Trade"), errorHandler));
			return (
				  Rule36 (name, nodeIndex.GetElementsByName ("trade"), errorHandler));
		}

		private static bool Rule36 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement	tradeDate	 = XPath.Path (context, "tradeHeader", "tradeDate");
				XmlElement	expiryDate	 = XPath.Path (context, "fxAverageRateOption", "expiryDateTime", "expiryDate");
				if ((tradeDate == null) || (expiryDate == null)) continue;

				if (Less (ToDate (tradeDate), ToDate (expiryDate))) continue;

				errorHandler ("305", context,
						"Expiry date must be after trade date.",
						name, ToToken (expiryDate));

				result = false;
}

			return (result);
		}
		// --------------------------------------------------------------------

		private static bool Rule37 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule37 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "Trade"), errorHandler));

			return (
				  Rule37 (name, nodeIndex.GetElementsByName ("trade"), errorHandler));
		}

		private static bool Rule37 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement	tradeDate	 = XPath.Path (context, "tradeHeader", "tradeDate");
				XmlElement	expiryDate	 = XPath.Path (context, "fxBarrierOption", "expiryDateTime", "expiryDate");

				if ((tradeDate == null) || (expiryDate == null)) continue;

				if (Less (ToDate (tradeDate), ToDate (expiryDate))) continue;

				errorHandler ("305", context,
						"Expiry date must be after trade date.",
						name, ToToken (expiryDate));

				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule38 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule38 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "Trade"), errorHandler));

			return (
				  Rule38 (name, nodeIndex.GetElementsByName ("trade"), errorHandler));
		}

		private static bool Rule38 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement	tradeDate	 = XPath.Path (context, "tradeHeader", "tradeDate");
				XmlElement	expiryDate	 = XPath.Path (context, "fxDigitalOption", "expiryDateTime", "expiryDate");
				if ((tradeDate == null) || (expiryDate == null)) continue;
				if (Less (ToDate (tradeDate), ToDate (expiryDate))) continue;

				errorHandler ("305", context,
						"Expiry date must be after trade date.",
						name, ToToken (expiryDate));

				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule39 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule39 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "Trade"), errorHandler));
			return (
				  Rule39 (name, nodeIndex.GetElementsByName ("trade"), errorHandler));
		}

		private static bool Rule39 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement	tradeDate = XPath.Path (context, "tradeHeader", "tradeDate");
				XmlElement	valueDate = XPath.Path (context, "fxSingleLeg", "valueDate");
				XmlElement	value1Date = XPath.Path (context, "fxSingleLeg", "currency1ValueDate");
				XmlElement	value2Date = XPath.Path (context, "fxSingleLeg", "currency2ValueDate");

				if (tradeDate != null) {
					if (valueDate != null) {
						if (Less (ToDate (tradeDate), ToDate (valueDate))) continue;
						errorHandler ("305", context,
								"value date must be after trade date.",
								name, ToToken (valueDate));

						result = false;
					}
					if (value1Date != null) {
						if (Less (ToDate (tradeDate), ToDate (value1Date))) continue;

						errorHandler ("305", context,
								"value1date must be after trade date.",
								name, ToToken (value1Date));

						result = false;
					}

					if (value2Date != null) {
						if (Less (ToDate (tradeDate), ToDate (value2Date))) continue;

						errorHandler ("305", context,
								"value2date must be after trade date.",
								name, ToToken (value2Date));

						result = false;
					}
				}
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule40 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule40 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "Trade"), errorHandler));

			return (
				  Rule40 (name, nodeIndex.GetElementsByName ("trade"), errorHandler));
		}

		private static bool Rule40 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;

			foreach (XmlElement context in list) {
				XmlElement	tradeDate 	= XPath.Path (context, "tradeHeader", "tradeDate");
				XmlNodeList	legs	  	= XPath.Paths (context, "fxSwap", "fxSingleLeg");
				foreach (XmlElement leg in legs) {
					XmlElement	valueDate 	= XPath.Path (leg, "valueDate");
					XmlElement	value1Date 	= XPath.Path (leg, "currency1ValueDate");
					XmlElement	value2Date 	= XPath.Path (leg, "currency2ValueDate");
if (tradeDate != null) {
if (valueDate != null) {
							if (Less (ToDate (tradeDate), ToDate (valueDate))) continue;
							errorHandler ("305", leg,
"value date must be after trade date.",
									name, ToToken (valueDate));
result = false;
}
if (value1Date != null) {
							if (Less (ToDate (tradeDate), ToDate (value1Date))) continue;
							errorHandler ("305", leg,
									"value1date must be after trade date.",
									name, ToToken (value1Date));
result = false;
}
if (value2Date != null) {
							if (Less (ToDate (tradeDate), ToDate (value2Date))) continue;
							errorHandler ("305", leg,
									"value2date must be after trade date.",
									name, ToToken (value2Date));
result = false;
}
}
}
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule41 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule41 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXBarrier"), errorHandler)
					& Rule41 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxBarrier"), errorHandler));

			return (
				  Rule41 (name, nodeIndex.GetElementsByName ("fxBarrier"), errorHandler));
		}

		private static bool Rule41 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	rate	= XPath.Path (context, "triggerRate");
				if ((rate == null) || IsPositive (rate)) continue;

				errorHandler ("305", context,
						"The trigger rate must be positive",
						name, ToToken (rate));
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule42 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule42 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXAverageRateOption"), errorHandler)
					& Rule42 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxAverageRateOption"), errorHandler));

			return (
				  Rule42 (name, nodeIndex.GetElementsByName ("fxAverageRateOption"), errorHandler));
		}

		private static bool Rule42 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlNodeList	nodes	= XPath.Paths (context, "averageRateObservationDate", "observationDate");
				int			limit	= nodes.Count;
				Date []		dates	= new Date [limit];
				for (int count = 0; count < limit; ++count)
					dates [count] = ToDate (nodes [count]);
				for (int outer = 0; outer < (limit - 1); ++outer) {
					for (int inner = outer + 1; inner < limit; ++inner) {
						if (Equal (dates [outer], dates [inner]))
							errorHandler ("305", nodes [inner],
									"Duplicate observation date",
									name, ToToken (nodes [inner]));

						result = false;
}
}
				dates = null;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule43 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule43 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXAverageRateOption"), errorHandler)
					& Rule43 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxAverageRateOption"), errorHandler));

			return (
				  Rule43 (name, nodeIndex.GetElementsByName ("fxAverageRateOption"), errorHandler));
		}

		private static bool Rule43 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	ccy1	= XPath.Path (context, "putCurrencyAmount", "currency");
				XmlElement	ccy2	= XPath.Path (context, "callCurrencyAmount", "currency");
				if ((ccy1 == null) || (ccy2 == null) || !IsSameCurrency (ccy1, ccy2)) continue;

				errorHandler ("305", context,
						"Put and call currencies must be different.",
						name, null);
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule44 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule44 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXAverageRateOption"), errorHandler)
					& Rule44 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxAverageRateOption"), errorHandler));

			return (
				  Rule44 (name, nodeIndex.GetElementsByName ("fxAverageRateOption"), errorHandler));
		}

		private static bool Rule44 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	buyer	 = XPath.Path (context, "buyerPartyReference");
				XmlElement	seller	 = XPath.Path (context, "sellerPartyReference");
				XmlElement	payer	 = XPath.Path (context, "fxOptionPremium", "payerPartyReference");
				XmlElement	receiver = XPath.Path (context, "fxOptionPremium", "receiverPartyReference");
				if ((buyer == null) || (seller == null) ||
					(payer == null) || (receiver == null)) continue;
				if (Equal (buyer.GetAttribute ("href"), payer.GetAttribute ("href")) &&
					Equal (seller.GetAttribute ("href"), receiver.GetAttribute ("href"))) continue;

				errorHandler ("305", context,
						"Premium payer and receiver don't match with option buyer and seller.",
						name, null);

				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule45 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
return (
					  Rule45 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FXDigitalOption"), errorHandler)
					& Rule45 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "FxDigitalOption"), errorHandler));

			return (
				  Rule45 (name, nodeIndex.GetElementsByName ("fxDigitalOption"), errorHandler));
		}

		private static bool Rule45 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	buyer	 = XPath.Path (context, "buyerPartyReference");
				XmlElement	seller	 = XPath.Path (context, "sellerPartyReference");
				XmlElement	payer	 = XPath.Path (context, "fxOptionPremium", "payerPartyReference");
				XmlElement	receiver = XPath.Path (context, "fxOptionPremium", "receiverPartyReference");
				if ((buyer == null) || (seller == null) ||
					(payer == null) || (receiver == null)) continue;
				if (Equal (buyer.GetAttribute("href"), payer.GetAttribute("href")) &&
					Equal (seller.GetAttribute("href"), receiver.GetAttribute("href"))) continue;

				errorHandler ("305", context,
						"Premium payer and receiver don't match with option buyer and seller.",
						name, null);

				result = false;
}
			return (result);
		}

		// --------------------------------------------------------------------

		private static bool Rule46 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule46 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "SideRates"), errorHandler));
			return (
					  Rule46 (name, nodeIndex.GetElementsByName ("sideRates"), errorHandler));
		}

		private static bool Rule46 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	basis	= XPath.Path (context, "currency1SideRate", "sideRateBasis");
				if ((basis == null) ||
					ToToken (basis).ToUpper ().Equals ("CURRENCY1PERBASECURRENCY") ||
					ToToken (basis).ToUpper ().Equals ("BASECURRENCYPERCURRENCY1")) continue;

				errorHandler ("305", context,
						"Side rate basis for currency1 should not be expressed in terms of currency2.",
						name, ToToken (basis));
				result = false;
}

			return (result);
		}

		// --------------------------------------------------------------------
		private static bool Rule47 (string name, NodeIndex nodeIndex, ValidationErrorHandler errorHandler)
		{
			if (nodeIndex.HasTypeInformation)
				return (Rule47 (name, nodeIndex.GetElementsByType (DetermineNamespace (nodeIndex), "SideRates"), errorHandler));

			return (
					  Rule47 (name, nodeIndex.GetElementsByName ("sideRates"), errorHandler));
		}
		private static bool Rule47 (string name, XmlNodeList list, ValidationErrorHandler errorHandler)
		{
			bool		result	= true;
			foreach (XmlElement context in list) {
				XmlElement	basis	= XPath.Path (context, "currency2SideRate", "sideRateBasis");

				if ((basis == null) ||
					ToToken (basis).ToUpper ().Equals ("CURRENCY2PERBASECURRENCY") ||
					ToToken (basis).ToUpper ().Equals ("BASECURRENCYPERCURRENCY2")) continue;

				errorHandler ("305", context,
						"Side rate basis for currency2 should not be expressed in terms of currency1.",
						name, ToToken (basis));

				result = false;
			}
			return (result);
		}

		// --------------------------------------------------------------------

		/// <summary>
		/// Generates a set of dates according to schedule defined by a start date,
		/// an end date, an interval, roll convention and a calendar.
		/// </summary>
		/// <param name="start">The start date.</param>
		/// <param name="end">The end date.</param>
		/// <param name="frequency">The frequency of the schedule (e.g. 6M).</param>
		/// <param name="roll">The date roll convention or <c>null</c>.</param>
		/// <param name="calendar">The holiday calendar or <c>null</c>.</param>
		/// <returns>An array of calculated and adjusted dates.</returns>
		private static Date [] GenerateSchedule (Date start, Date end,
			Interval frequency, DateRoll roll, Calendar calendar)
		{
			Date		current = start;
			ArrayList	found	= new ArrayList ();
			Date []		dates;
			while (Less (current, end)) {
				Date		adjusted;

				if (roll != null)
					adjusted = roll.Adjust (calendar, current);
				else
					adjusted = current;

				if (!found.Contains (adjusted))
					found.Add (adjusted);

				if (frequency.Period == Period.TERM) {
					if (Equal (current, start))
						current = end;
					else
						break;
				}
else
					current = current.Plus (frequency);
}

			found.CopyTo (dates  = new Date [found.Count]);
			return (dates);
}
}
}
EOF
	catout 0d5e6c5133712faa85ce81b77ad37b386ea742346ce1b06d3e83831ebd990b28 test.cs
	$fast test.cs test.pb
	stdout 615ae83f7ddb56337d081165f1156f260af256a0c43d1780a493000e714c0515 -d test.pb
}

### rather lengthy test :-) 
notestFastPairs() {
	cat codelabel_new.csv > a.csv
	$process a.csv a.pb
	stdout 523e8be558707d3ca2b58e4eb7e59d5545914bb9a9569279d03fd46d614b1019 -d a.pb
}

testFastPairs564() {
	head -564 codelabel_new.csv | tail -1 > a.csv
	catout f94138acd03373ae2457dd29389f495224ebddf95181735f30f09419d3d87dc1 a.csv
	$process a.csv a.pb
	stdout 1a87bcd1e9f8ce710022a99d68fbce48029189e20bce3a923a01fd184c6c9fe6 -d a.pb
}

testFastSlice() {
	$fast -p Hello.java Hello.position.pb
	$fast -p Hello.java Hello.position.xml
	stdouterr 999560795c016bb2cccb1224c7208a9604e5f100701a808ab185d34f914700ec -S Hello.position.pb
	$fast -S Hello.position.pb Hello.slice.pb
	catout 3b89f50af2b9d6c1b1a9947324def412b718bc7bd857a9a5d0309fbb93dba67f Hello.slice.pb
	$fast -p example.cc example.position.fbs
	$fast -S example.position.pb > example-s.slice
	catout dd2881a93ed09a88b1a4cfbc7ee20b6a165dc1a568793e69cee49fe26ad41549 example-S.slice
	stdouterr dd2881a93ed09a88b1a4cfbc7ee20b6a165dc1a568793e69cee49fe26ad41549 -S example.position.fbs
	$fast -S example.position.pb example.slice.pb
	catout 1a5f26bf8f2be74082736ad14beb2b14c8ef5797a4c33832500a4a6dd72f8d08 example.slice.pb
}

testNoneExistingFile() {
	stderr 11fc423843b5ca25232bb2e03a0fb97c09ba5a6b38cdb353debe6ab8b39d82f0 Hello.fancy.java
	stderr edb2be541087eb4f3064ae2120900a62fa03294e85af0b01481ecfa4b863067c Hello.fancy.xml
	stderr 5197a6c6c7406cfa4b12321d846b23019535a955c836fa48553c15de97ded243 Hello.fancy.fbs
}

testLoadFBS() {
	$fast Hello.java Hello.fbs
	$fast Hello.fbs Hello.xml
	catout 43e589acc3b5381dcdac9699c4f7c344779f742d1f9f86a1bc8fe4aba81c3633 Hello.xml
	stdout 43e589acc3b5381dcdac9699c4f7c344779f742d1f9f86a1bc8fe4aba81c3633 Hello.fbs
	$fast test.cs test.fbs
	$fast test.fbs test.fbs.cs
	catout 0d5e6c5133712faa85ce81b77ad37b386ea742346ce1b06d3e83831ebd990b28 test.fbs.cs
}

testLoadPB() {
	$fast Hello.java Hello.pb
	stdout e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 -c Hello.pb
	$fast Hello.pb Hello.pb.xml
	catout c87941ccbb4c4ae5253ebfa3feb8b407979326e4251abb4a66f0f7d9264de683 Hello.pb.xml
	stdout c87941ccbb4c4ae5253ebfa3feb8b407979326e4251abb4a66f0f7d9264de683 Hello.pb
	$fast test.cs test.pb
	$fast test.pb test.pb.cs
	catout 0d5e6c5133712faa85ce81b77ad37b386ea742346ce1b06d3e83831ebd990b28 test.pb.cs
	$fast -d test.pb test.txt
	catout 615ae83f7ddb56337d081165f1156f260af256a0c43d1780a493000e714c0515 test.txt
	$fast -e test.txt test.pb
	$fast -e test.txt > test.pb
	$fast . all.xml
	$fast . all.pb
	$fast . all.fbs
}

testFinalReport() {
	rm -f *.pb *.fbs
	lcov --directory .. --capture --output-file ../fast.info
	lcov --remove ../fast.info '/usr/*' '/Applications/*' '*/smali/src/antlr4/*' '*/src/rapidxml/*' '*/src/*.hpp' '*/src/*.pb.*' '*/src/cpp/src*' '*/src/fast_generated.h' '*/src/antlr4-runtime/*' > fast.info
	genhtml fast.info
}

if [ ! -f ~/mirror/github.com/kward/shunit2/source/2.1/src/shunit2 ]; then
	git clone https://github.com/kward/shunit2 ~/mirror/github.com/kward/shunit2
fi

rm -f ../*.gcda
rm -rf ../fast.info index*.html *.png v1/ gcov.css Users usr
lcov --directory .. --zerocounters
. ~/mirror/github.com/kward/shunit2/source/2.1/src/shunit2
