#!/bin/bash
fast=${fast:=../fast}
if [ ! -f $fast ]; then
	export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
	cd .. > /dev/null
	make OPT="-g -O0 -coverage" install
	cd - > /dev/null
fi

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
	stdouterr ee5397c0fd55f9ec049be604d0f597d12c9b511c1f80a1eccab912d181282c7d $fast
	$fast -v
	$fast -h
}

testnonexist() {
	stdouterr 6d923feba278c5442f74be977a8282931fd9bc91b46ca5685756711f885c7907 fancy.fbs
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
	stdout 9b6842ca561038c21edb0507e768c66cf2bf5dd25db879f616972d4b3c35fee4 -d -j Hello.pb
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
	stdout 9dd04891ffc62e40e7c4abf6aaad09e331f7c64fbdb86aacecc3247c12ab728f -d example.position.pb
	stdout 18348fea608d1893c97584bcb6fd106b27fe97b0ab3b2d5da0af0751b4039c55 -d example.pb
	$fast example.pb example.txt
	catout 094f521830f664a85196b5968349d0c76a84a99f902ae391ec78caaf926591d7 example.txt
}

testduplicate() {
	stdouterr 4e720cdf59ad75221122423634aedbe4d4dafc346cab54d7f82afdcf484c7244 Hello.java Hello.java
}

testObjectiveC() 
{
	$fast AFHTTPSessionManager.m AFHTTPSessionManager.pb
	#stdout 90d2d536817466cfae7899c970af5ca77cf35939a96dc6b255942d1669e10625 -d AFHTTPSessionManager.pb
	$fast -d AFHTTPSessionManager.pb > AFHTTPSessionManager.txt 
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
	stdout c127eb3d6322b3f9d38eaead37e56faf6939fe776587924d361a3e1b280c1ee7 DuplicateVirtualMethods.smali
	rm -f smali.proto
	$fast DuplicateVirtualMethods.smali DuplicateVirtualMethods.smali.pb
	catout 6ed7e11200def362490c5d8f35743798a646f7bc48ddff7a1304940b0d6f8956 smali.proto
	$fast DuplicateVirtualMethods.smali DuplicateVirtualMethods.smali.pb
	stdout 9ab34981b8cd72e1746b32decc0a571f0d0895157f4f60ed2cb105cf18be4474 -d DuplicateVirtualMethods.smali.pb
	stdout 2c82d17ff69209c7eab9122b93d18bd687d553f4a04a6fe0ffc4e11341a7f4e5 IntDef.smali
	stdout d916e5a39cc38372a4e779a8c6c688d4c16c2df67eeb70717f1bbb633fe3fd6b ForegroundLinearLayout.smali
	stdout ce8511380ea2edfa9790dbd0d4d7d8885ea039f06d0c62e6f48dfafd8e58521c NavigationMenuPresenter\$1.smali
	stdout fa2e460cee168acc315c423dbeffe98f8408a7590a892410400987f073402b90 BottomSheetBehavior.smali
	stdout 76832725679e1e2ed9bb407df03be3f44e3f10f82362ef7d60cdcb2d384be173 CoordinatorLayout.smali
	stdout 1bd495bdd84c7b7dfa789e4c3453af1d7ca682e9cf879a22bef2edb551db6d6a RunnerArgs.smali
	stdout 22e7a484d797695bfc50da0f20abf3fcd132497d4af0d9a323f8b8fe99de5015 ColorUtils.smali
	stdout 8c15ffd5ccfb57d645fd9d541e18658bb8199186a625170cb7c36e68fbda906e SparseArrayCompat.smali
	$fast DuplicateVirtualMethods.smali DuplicateVirtualMethods.xml
	catout c127eb3d6322b3f9d38eaead37e56faf6939fe776587924d361a3e1b280c1ee7 DuplicateVirtualMethods.xml
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
	stdout 46c0e43663a3a6b49faf6e7951efb9ef13662f3d6f8bdaf4425f89647f059716 -d test.pb
}

notestFastPairs() {
	$fast -l codelabel_new_with_hash.csv codelabel_new_with_hash.pb > /dev/null
	stdout 4e25d4ccd0dfaa46c91b8853c620c59e961035c07ee293052d800071e5b53c4a -d codelabel_new_with_hash.pb
}

testFastPairsWithHash564() {
	head -564 codelabel_new_with_hash.csv | tail -1 > a.csv
	catout c751a683e045b36af5d58e103f79daab9cb42b0c23a260392f39828212fa8bad a.csv
	$fast -l a.csv a.pb > /dev/null
	stdout 3203810cc6fb73eb59810cf3012d1d9e86acda95fdfdec53280160dc6b5c726a -d a.pb
	$fast -l -W 5 a.csv a5.pb > /dev/null
	stdout aeaabf7806746220defa155fb9e7fba301259dca5afe3147d406d0208bb17466 -d a5.pb
	$fast -w a5.pb > /dev/null
}

testFastSlice() {
	$fast -p Hello.java Hello.position.pb
	$fast -p Hello.java Hello.position.xml
	#$fast -s Hello.position.xml > /dev/null
	#$fast -s Hello.position.pb > /dev/null
	#$fast -s Hello.position.xml Hello.slice.csv > /dev/null
	stdouterr 999560795c016bb2cccb1224c7208a9604e5f100701a808ab185d34f914700ec -S Hello.position.pb
	$fast -S Hello.position.pb Hello.slice.pb > /dev/null
	#stdout 3b89f50af2b9d6c1b1a9947324def412b718bc7bd857a9a5d0309fbb93dba67f Hello.slice.pb
	$fast -p example.cc example.position.fbs
	$fast -S example.position.pb > example-s.slice
	catout dd2881a93ed09a88b1a4cfbc7ee20b6a165dc1a568793e69cee49fe26ad41549 example-s.slice
	stdouterr dd2881a93ed09a88b1a4cfbc7ee20b6a165dc1a568793e69cee49fe26ad41549 -S example.position.fbs
	$fast -S example.position.pb example.slice.pb
	#catout 1a5f26bf8f2be74082736ad14beb2b14c8ef5797a4c33832500a4a6dd72f8d08 example.slice.pb
	#$fast -p . s.pb
	#$fast -S s.pb s.slice.txt > /dev/null
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
	catout 46c0e43663a3a6b49faf6e7951efb9ef13662f3d6f8bdaf4425f89647f059716 test.txt
	$fast -e test.txt test.pb
	$fast -e test.txt > test.pb
	#$fast . all.xml
	#$fast . all.pb
	#$fast . all.fbs
	if [ "$keep" == "" ]; then
		cleanup_examples
	fi
}

position() {
	if [ ! -f $1/t.pb ]; then
		cd .. && fast -p -g $1 . t.pb && mv $1 test/ && cd test
	fi
}
slice() {
	if [ ! -f $1/slice.txt ]; then
		$fast -S $1/t.pb $1/slice.pb > $1/slice.txt
	fi
	if [ ! -f $1/slice.pb.txt ]; then
		$fast -x $1/slice.pb $1/slice.pb.txt > $1/slice.pb.xml
	fi
}
export -f position

cleanup_examples() {
	rm -f *.pb *.fbs Hello.* example.* DuplicateVirtualMethods.* *.xml *.cs *.txt a.csv *.slice smali.proto a/*.pb b/*.pb tmp.txt 
}
export -f cleanup_examples

testSliceDiff() {
	cd a > /dev/null
	../$fast -p example.cc example.positions.pb
	cd - > /dev/null
	$fast -S a/example.positions.pb a/example.slice.pb > /dev/null
	cd b > /dev/null
	../$fast -p example.cc example.positions.pb
	cd - > /dev/null
	$fast -S b/example.positions.pb b/example.slice.pb > /dev/null
	$fast -L a/example.slice.pb b/example.slice.pb diff.pb > tmp.txt
	stdout 11360a59f4f4a71b4921f501f9d06880a4120e1f110edccb1cb2d18dc27c67e7 -d diff.pb
}

testSliceDiff() {
	cd a
	../$fast -p example.cc example.positions.pb
	cd -
	$fast -S a/example.positions.pb a/example.slice.pb
	cd b
	../$fast -p example.cc example.positions.pb
	cd -
	$fast -S b/example.positions.pb b/example.slice.pb
	$fast -L a/example.slice.pb b/example.slice.pb diff.pb > tmp.txt
	stdout 11360a59f4f4a71b4921f501f9d06880a4120e1f110edccb1cb2d18dc27c67e7 -d diff.pb
}

testJSON() {
	stdout 4692fd4ea5c4513c89747657056e8f598bf4bb77fa6ad4101f858f373f7e5aeb -d -J '.slices.slice[].file[].function[].name' a/example.slice.pb
}

testPB2XML() {
	$fast -x a/example.slice.pb > /dev/null
	$fast -x a/example.slice.pb a/example.slice.txt > /dev/null
	#stdout c3a14e8fb712cd85a6cb76c2166b442519924919dc5629a233c5a508cb40065d -x a/example.slice.pb
	#stdout 5397fe73cf208062df264e1bbb8d46b136f3df24aed3b68579f83126a3bebdfc -x a/example.slice.pb a/example.slice.txt
	rm -f a/example.slice.txt
}

testId() {
	stdout 134bf923f22e023ca53dd7c01cb12dc1e0ba387300c9056bc30e85d30a080fa5 -i a/example.cc t.pb 
	# $fast -i -fcc . t.pb > /dev/null
}

testBug() {
	$fast -b Tomcat12.csv bug.pb
	stdout dc3a4c3936b21970a383f541ba86019de09d6895aa963414503dd5b6e6ea1fc5 -d bug.pb
	cp bug-xml bug.xml
	$fast -b bug.xml bug.pb
	stdout 514b57e9b2071e9ede8120e2e1a348b7905b13d302045a31d3a22b55c19acc0a -d bug.pb
}

testNormalise() {
	stdout 87974b33726e268a074effa1a8c7df62ebbb0dee67b7d39327edda0a6be7b200 -n normalise.list a/example2.cc
	stdout a8e15f72dd2a6f880587f388abfd84d34dea74632566fcea8754b4ceca017a1e -n normalise.list Hello1.java
	stdout 22e306ee864db6eef29499f913eb7b491246f949ec64eb4eee864d8617776627 -n api.list Hello1.java
}

testDiff() {
	stdout df4872b4209397f493a98a002a9e9f47cba95d96703c1c9bfa73ae0c9afee63a -D Hello1.java Hello2.java
}

testUML() {
	$fast -u Hello1.java Hello1.yuml
	catout e2dbb22b38b78c25c09cb5b101036e69e55985c66a824388d71ece6636d349f3 Hello1.yuml
	if [ "$keep" == "" ]; then
		cleanup_examples
	fi
}

testGitSliceDiff() {
	HEAD=HEAD
	r2=$(git rev-list $HEAD | head -1)
	r1=$(git rev-list $HEAD | head -2 | tail -1)
	position $r1 > /dev/null
	position $r2  > /dev/null
	slice $r1 > /dev/null
	slice $r2  > /dev/null
	$fast -L $r1/slice.pb $r2/slice.pb diff.pb > /dev/null
	$fast -d diff.pb > diff.txt
	diff $r1/slice.pb.xml $r2/slice.pb.xml > diff.xml
	rm -rf $r1 $r2
	if [ "$keep" == "" ]; then
		cleanup_examples
	fi
}

if [ ! -f ~/mirror/github.com/kward/shunit2/source/2.1/src/shunit2 ]; then
	git clone https://github.com/kward/shunit2 ~/mirror/github.com/kward/shunit2
fi

rm -f ../*.gcda
rm -rf ../fast.info index*.html *.png v1/ gcov.css Users usr
. ~/mirror/github.com/kward/shunit2/source/2.1/src/shunit2
