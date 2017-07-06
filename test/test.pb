
Ω@ *dï
namespace *D6*6	HandCoded*4.*6FpML*4.*6
Validation2	
return (*
6result2)*ı;2
}
		*XG// --------------------------------------------------------------------2
		private **ÿstatic2 *9*6bool2 *6Rule022 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*é<{
			*ëûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*øC
				*≥<*Æ«return *ü*4(*â*6Rule022 *ıi(*j**6name2, *∫j*±*¨*26*6	nodeIndex*4.*6GetElementsByType2 *ti(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *!j**0"ExchangeRate"B2)2, *j**6errorHandler2)*4)2;2

			*Ó«return *Ÿ*4(2
				  *∫*6Rule022 *¶i(*j**6name2, *lj*d*`*26*6	nodeIndex*4.*6GetElementsByName2 *(i(*!j**0"exchangeRate"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*Õ
*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule022 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*›<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*–Äforeach *Q(*G*@*9*6
XmlElement2	*6context2 *Vin **6list2)2 *Á<{
				*∞*§*9*6
XmlElement2 	*6forward2 *u= *m*i*!6*	6XPath*4.*6Path2 *Bi(*j**6context2, *"j**0"forwardPoints"B2)2;2
				*ß*õ*9*6
XmlElement2	*6spot2	*p= *h*d*!6*	6XPath*4.*6Path2 *=i(*j**6context2, *j**0
"spotRate"B2)2;2
				*–ûif *£;(*õ*4!*4(*4(*6forward2 *	4!=2 *0nullB*4)2 *4
&amp;&amp;2 *4(*6spot2 *	4==2 *0nullB*4)*4)2)*C *<*ö	continue;2
				*Û*Ê*ﬁ*6errorHandler2 *ƒi(*j**0"305"B2, *j**6context2,
						*Tj*F*B0:"If forwardPoints exists then spotRate should also exist."B2,
						*j**6name2, *j**0nullB2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*Ä*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule032 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ç<{
			*êûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*øC
				*≥<*Æ«return *ü*4(*â*6Rule032 *ıi(*j**6name2, *∫j*±*¨*26*6	nodeIndex*4.*6GetElementsByType2 *ti(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *!j**0"ExchangeRate"B2)2, *j**6errorHandler2)*4)2;2
			*Ó«return *Ÿ*4(2
				  *∫*6Rule032 *¶i(*j**6name2, *lj*d*`*26*6	nodeIndex*4.*6GetElementsByName2 *(i(*!j**0"exchangeRate"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*œ*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule032 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ﬂ<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*“Äforeach *Q(*G*@*9*6
XmlElement2	*6context2 *Vin **6list2)2 *È
<{
				*∞*§*9*6
XmlElement2 	*6forward2 *u= *m*i*!6*	6XPath*4.*6Path2 *Bi(*j**6context2, *"j**0"forwardPoints"B2)2;2
				*ß*õ*9*6
XmlElement2	*6spot2	*p= *h*d*!6*	6XPath*4.*6Path2 *=i(*j**6context2, *j**0
"spotRate"B2)2;2
				*£*ó*9*6
XmlElement2	*6rate2	*l= *d*`*!6*	6XPath*4.*6Path2 *9i(*j**6context2, *j**0"rate"B2)2;2
				*ıûif *»;(*¿*4(*6rate2 *	4==2 *0nullB*4)2 *	4||2 *4(*6forward2 *	4==2 *0nullB*4)2 *	4||2 *4(*6spot2 *	4==2 *0nullB*4)2)*C *<*ö	continue;2
				*îûif *·;(*Ÿ*0*6	ToDecimal2 *i(*j**6rate2)*4.*ò*6Equals2 *Ñi(*}j*v*3*6	ToDecimal2 *i(*j**6spot2)2 *4+2 *3*6	ToDecimal2 *i(*j**6forward2)2)2)*C
					*<*ö	continue;2

				*ì*Ü*˛*6errorHandler2 *‰i(*j**0"305"B2, *j**6context2,
						*Rj*D*@08"Sum of spotRate and forwardPoints does not equal rate."B2,
						*j**6name2, *9j*2*.*6ToToken2 *i(*j**6rate2)2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*Ä*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule042 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ç<{
			*êûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*øC
				*≥<*Æ«return *ü*4(*â*6Rule042 *ıi(*j**6name2, *∫j*±*¨*26*6	nodeIndex*4.*6GetElementsByType2 *ti(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *!j**0"ExchangeRate"B2)2, *j**6errorHandler2)*4)2;2
			*Ó«return *Ÿ*4(2
				  *∫*6Rule042 *¶i(*j**6name2, *lj*d*`*26*6	nodeIndex*4.*6GetElementsByName2 *(i(*!j**0"exchangeRate"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*ù*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule042 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*≠<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*üÄforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *∂<{
				*”*«*9*6
XmlElement2 	*6baseCcy2 *ó= *é*â*!6*	6XPath*4.*6Path2 *bi(*j**6context2, *j**0"sideRates"B2, *!j**0"baseCurrency"B2)2;2
				*’*…*9*6
XmlElement2	*6ccy12	*ù= *î*è*!6*	6XPath*4.*6Path2 *hi(*j**6context2, *(j* *0"quotedCurrencyPair"B2, *j**0"currency1"B2)2;2
				*÷*…*9*6
XmlElement2	*6ccy22	*ù= *î*è*!6*	6XPath*4.*6Path2 *hi(*j**6context2, *(j* *0"quotedCurrencyPair"B2, *j**0"currency2"B2)2;2

				*ˆûif *»;(*¿*4(*6baseCcy2 *	4==2 *0nullB*4)2 *	4||2 *4(*6ccy22 *	4==2 *0nullB*4)2 *	4||2 *4(*6ccy22 *	4==2 *0nullB*4)2)*C *<*ö	continue;2

				*©ûif *©;(*°*H*6Equal2 *3i(*j**6baseCcy2, *j**6ccy12)2 *	4||2 *E*6Equal2 *3i(*j**6baseCcy2, *j**6ccy22)2)*ÓC *Ê<{
					*°*ô*ë*6errorHandler2 *˜i(*j**0"305"B2, *j**6context2	,
							*aj*R*N0F"The side rate base currency must not be one of the trade currencies."B2	,
							*j**6name2, *<j*5*1*6ToToken2 *i(*j**6baseCcy2)2)2;2
*5*-*6result2 *4=2 *0falseB2;2
}2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*Ä*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule052 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ç<{
			*êûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*øC
				*≥<*Æ«return *ü*4(*â*6Rule052 *ıi(*j**6name2, *∫j*±*¨*26*6	nodeIndex*4.*6GetElementsByType2 *ti(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *!j**0"ExchangeRate"B2)2, *j**6errorHandler2)*4)2;2
			*Ó«return *Ÿ*4(2
				  *∫*6Rule052 *¶i(*j**6name2, *lj*d*`*26*6	nodeIndex*4.*6GetElementsByName2 *(i(*!j**0"exchangeRate"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*∞*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule052 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*¿<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*≤
Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *…	<{
				*’*…*9*6
XmlElement2	*6ccy2		*ù= *î*è*!6*	6XPath*4.*6Path2 *hi(*j**6context2, *(j* *0"quotedCurrencyPair"B2, *j**0"currency1"B2)2;2
				*˜*Î*9*6
XmlElement2 	*6ccy12 	*Ω= *¥*Ø*!6*	6XPath*4.*6Path2 *ái(*j**6context2, *j**0"sideRates"B2, *'j**0"currency1SideRate"B2, *j**0
"currency"B2)2;2
				*Äûif *”;(*À*4(*
6ccy2 *	4==2 *0nullB*4)2 *	4||2 *4(*6ccy12 *	4==2 *0nullB*4)2 *	4||2 *A*6Equal2 */i(*j**6ccy2, *j**6ccy12)2)*C *<*ö	continue;2
				*∞*£*õ*6errorHandler2 *Åi(*j**0"305"B2, *j**6context2,
						*êj*Å*&0"The side rate currency1 '"2 B*4+2 *1*6ToToken2 *i(*j**6ccy12)2 *4+2
						*40)"' must be the same as trade currency1 '"2 B*4+2 *0*6ToToken2 *i(*j**6ccy2)2 *4+2 *0"'."B2,
						*j**6name2, *j**0nullB2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*Ä*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule062 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ç<{
			*êûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*øC
				*≥<*Æ«return *ü*4(*â*6Rule062 *ıi(*j**6name2, *∫j*±*¨*26*6	nodeIndex*4.*6GetElementsByType2 *ti(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *!j**0"ExchangeRate"B2)2, *j**6errorHandler2)*4)2;2
			*Ó«return *Ÿ*4(2
				  *∫*6Rule062 *¶i(*j**6name2, *lj*d*`*26*6	nodeIndex*4.*6GetElementsByName2 *(i(*!j**0"exchangeRate"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*≤*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule062 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*¬<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*¥
Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 * 	<{
				*’*…*9*6
XmlElement2	*6ccy2		*ù= *î*è*!6*	6XPath*4.*6Path2 *hi(*j**6context2, *(j* *0"quotedCurrencyPair"B2, *j**0"currency2"B2)2;2
				*˜*Î*9*6
XmlElement2 	*6ccy12 	*Ω= *¥*Ø*!6*	6XPath*4.*6Path2 *ái(*j**6context2, *j**0"sideRates"B2, *'j**0"currency2SideRate"B2, *j**0
"currency"B2)2;2
				*Åûif *”;(*À*4(*
6ccy2 *	4==2 *0nullB*4)2 *	4||2 *4(*6ccy12 *	4==2 *0nullB*4)2 *	4||2 *A*6Equal2 */i(*j**6ccy2, *j**6ccy12)2)*C *<*ö	continue;2

				*∞*£*õ*6errorHandler2 *Åi(*j**0"305"B2, *j**6context2,
						*êj*Å*&0"The side rate currency2 '"2 B*4+2 *1*6ToToken2 *i(*j**6ccy12)2 *4+2
						*40)"' must be the same as trade currency2 '"2 B*4+2 *0*6ToToken2 *i(*j**6ccy2)2 *4+2 *0"'."B2,
						*j**6name2, *j**0nullB2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*∏	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule072 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*≈<{
			*√ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ÒC
*È<*‰«return *’*4(2
					  *ñ*6Rule072 *˙i(*j**6name2, *øj*∂*±*26*6	nodeIndex*4.*6GetElementsByType2 *yi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *&j**0"FXAmericanTrigger"B2)2, *j**6errorHandler2)2
					*4&amp;2 *é*6Rule072 *˙i(*j**6name2, *øj*∂*±*26*6	nodeIndex*4.*6GetElementsByType2 *yi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *&j**0"FxAmericanTrigger"B2)2, *j**6errorHandler2)*4)2;2

			*Û«return *ﬁ*4(2
				  *ø*6Rule072 *´i(*j**6name2, *qj*i*e*26*6	nodeIndex*4.*6GetElementsByName2 *-i(*&j**0"fxAmericanTrigger"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*à	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule072 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ò<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*ãÄforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *°<{
				*´*ü*9*6
XmlElement2		*6rate2	*s= *k*g*!6*	6XPath*4.*6Path2 *@i(*j**6context2, * j**0"triggerRate"B2)2;2
				*Øûif *Å;(*z*4(*6rate2 *	4==2 *0nullB*4)2 *	4||2 *1*6
IsPositive2 *i(*j**6rate2)2)*C *<*ö	continue;2

				*˝*Ò*È*6errorHandler2 *œi(*j**0"305"B2, *j**6context2,
						*=j*/*+0#"The trigger rate must be positive"B2,
						*j**6name2, *9j*2*.*6ToToken2 *i(*j**6rate2)2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*∏	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule082 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*≈<{
			*√ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ÒC
*È<*‰«return *’*4(2
					  *ñ*6Rule082 *˙i(*j**6name2, *øj*∂*±*26*6	nodeIndex*4.*6GetElementsByType2 *yi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *&j**0"FXAmericanTrigger"B2)2, *j**6errorHandler2)2
					*4&amp;2 *é*6Rule082 *˙i(*j**6name2, *øj*∂*±*26*6	nodeIndex*4.*6GetElementsByType2 *yi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *&j**0"FxAmericanTrigger"B2)2, *j**6errorHandler2)*4)2;2

			*Û«return *ﬁ*4(2
				  *ø*6Rule082 *´i(*j**6name2, *qj*i*e*26*6	nodeIndex*4.*6GetElementsByName2 *-i(*&j**0"fxAmericanTrigger"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*Ì*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule082 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*˝	<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *Ü<{
				*¥*®*9*6
XmlElement2	*6start2	*|= *t*p*!6*	6XPath*4.*6Path2 *Ii(*j**6context2, *)j*"*0"observationStartDate"B2)2;2
				*±*•*9*6
XmlElement2	*6end2		*z= *r*n*!6*	6XPath*4.*6Path2 *Gi(*j**6context2, *'j* *0"observationEndDate"B2)2;2
				*Ÿûif *´;(*£*4(*6start2 *	4==2 *0nullB*4)2 *	4||2 *4(*
6end2 *	4==2 *0nullB*4)2 *4||2
					*í*6LessOrEqual2 *zi(*:j*2*.*6ToDate2 *i(*j**	6start2)2, *7j*0*,*6ToDate2 *i(*j**6end2)2)2)*C *<*ö	continue;2

				*˚*Ô*Á*6errorHandler2 *Õi(*j**0"305"B2, *j**6context2,
						*]j*O*K0C"The observationStartDate must not be after the observationEndDate"B2,
						*j**6name2, *j**0nullB2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*Â	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule092 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Ú<{
			*„ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ëC
*â<*Ñ«return *ı*4(2
					  *¶*6Rule092 *äi(*j**6name2, *œj*∆*¡*26*6	nodeIndex*4.*6GetElementsByType2 *ài(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *5j*.**0""FXAverageRateObservationSchedule"B2)2, *j**6errorHandler2)2
					*4&amp;2 *û*6Rule092 *äi(*j**6name2, *œj*∆*¡*26*6	nodeIndex*4.*6GetElementsByType2 *ài(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *5j*.**0""FxAverageRateObservationSchedule"B2)2, *j**6errorHandler2)*4)2;2

			*Ä«return *Î*4(2
				  *Ã*6Rule092 *∏i(*j**6name2, *~j*v*r*26*6	nodeIndex*4.*6GetElementsByName2 *:i(*3j*,*(0 "averageRateObservationSchedule"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*Ì*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule092 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*˝	<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *Ü<{
				*¥*®*9*6
XmlElement2	*6start2	*|= *t*p*!6*	6XPath*4.*6Path2 *Ii(*j**6context2, *)j*"*0"observationStartDate"B2)2;2
				*±*•*9*6
XmlElement2	*6end2		*z= *r*n*!6*	6XPath*4.*6Path2 *Gi(*j**6context2, *'j* *0"observationEndDate"B2)2;2
				*Ÿûif *´;(*£*4(*6start2 *	4==2 *0nullB*4)2 *	4||2 *4(*
6end2 *	4==2 *0nullB*4)2 *4||2
					*í*6LessOrEqual2 *zi(*:j*2*.*6ToDate2 *i(*j**	6start2)2, *7j*0*,*6ToDate2 *i(*j**6end2)2)2)*C *<*ö	continue;2

				*˚*Ô*Á*6errorHandler2 *Õi(*j**0"305"B2, *j**6context2,
						*]j*O*K0C"The observationStartDate must not be after the observationEndDate"B2,
						*j**6name2, *j**0nullB2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*Â	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule102 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Ú<{
			*„ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ëC
*â<*Ñ«return *ı*4(2
					  *¶*6Rule102 *äi(*j**6name2, *œj*∆*¡*26*6	nodeIndex*4.*6GetElementsByType2 *ài(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *5j*.**0""FXAverageRateObservationSchedule"B2)2, *j**6errorHandler2)2
					*4&amp;2 *û*6Rule102 *äi(*j**6name2, *œj*∆*¡*26*6	nodeIndex*4.*6GetElementsByType2 *ài(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *5j*.**0""FxAverageRateObservationSchedule"B2)2, *j**6errorHandler2)*4)2;2

			*Ä«return *Î*4(2
				  *Ã*6Rule102 *∏i(*j**6name2, *~j*v*r*26*6	nodeIndex*4.*6GetElementsByName2 *:i(*3j*,*(0 "averageRateObservationSchedule"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*≥*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule102 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*√<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*∂Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *Ã
<{
				*¥*®*9*6
XmlElement2	*6start2	*|= *t*p*!6*	6XPath*4.*6Path2 *Ii(*j**6context2, *)j*"*0"observationStartDate"B2)2;2
				*±*•*9*6
XmlElement2	*6end2		*z= *r*n*!6*	6XPath*4.*6Path2 *Gi(*j**6context2, *'j* *0"observationEndDate"B2)2;2
				*º*∞*9*6
XmlElement2	*6period2	*Ç= *z*v*!6*	6XPath*4.*6Path2 *Oi(*j**6context2, */j*(*$0"calculationPeriodFrequency"B2)2;2
				*◊ûif *™;(*¢*4(*6start2 *	4==2 *0nullB*4)2 *	4||2 *4(*
6end2 *	4==2 *0nullB*4)2 *	4||2 *4(*6period2 *	4==2 *0nullB*4)2 *4||2
						*3*6
ToInterval2 *i(*j**
6period2)*4.*ê*6DividesDates*zi(*:j*2*.*6ToDate2 *i(*j**	6start2)2, *7j*0*,*6ToDate2 *i(*j**6end2)2)2)*C *<*ö	continue;2
				*Ñ*¯**6errorHandler2 *÷i(*j**0"305"B2, *j**6context2,
						*fj*X*T0L"The observation period is not a multiple of the calculationPeriodFrequency"B2,
						*j**6name2, *j**0nullB2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*æ	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule112 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*À<{
			*«ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ıC
*Ì<*Ë«return *Ÿ*4(2
					  *ò*6Rule112 *¸i(*j**6name2, *¡j*∏*≥*26*6	nodeIndex*4.*6GetElementsByType2 *{i(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *(j*!*0"FXAverageRateOption"B2)2, *j**6errorHandler2)2
					*4&amp;2 *ê*6Rule112 *¸i(*j**6name2, *¡j*∏*≥*26*6	nodeIndex*4.*6GetElementsByType2 *{i(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *(j*!*0"FxAverageRateOption"B2)2, *j**6errorHandler2)*4)2;2

			*ı«return *‡*4(2
				  *¡*6Rule112 *≠i(*j**6name2, *sj*k*g*26*6	nodeIndex*4.*6GetElementsByName2 */i(*(j*!*0"fxAverageRateOption"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*ú*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule112 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*¨<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*üÄforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *µ<{
				*Ÿ*Õ*9*6XmlNodeList2	*6nodes2	*ü= *ñ*ë*"6*	6XPath*4.*	6Paths2 *ii(*j**6context2, *#j**0"observedRates"B2, *$j**0"observationDate"B2)2;2
				*]*R*9*6int2			*6limit2	*+= *#*6*	6nodes*4.*	6Count2;2
				*Ç*v*9*6*6Date2 *>[]2		*6dates2	*@= *8*
4new2 *(6*6Date2 *>[**	6limit2]2;2

				*Œùfor *†(*?*8*9*6int2 *6count2 *= **00B 2;2 *2;*+*6count2 *4&lt;2 *	6limit2;2 *	**4++*	6count2)2
					*ó<*í*ç*,6*6dates2 *>[**	6count2]2 *4=2 *N*6ToDate2 *;i(*4j*-*)6*6nodes2 *>[**	6count2]2)2;2

				*‚ùfor *ø(*?*8*9*6int2 *6outer2 *= **00B 2;2 *V;*O*6outer2 *4&lt;2 *4(*6limit2 *4-2 *01B *4)2;2 *	**4++*	6outer2)2 *ç<{
					*ˇùfor *≥(*W*P*9*6int2 *6inner2 *+= *#*6outer2 *4+2 *01B 2;2 *2;*+*6inner2 *4&lt;2 *	6limit2;2 *	**4++*	6inner2)2 *π<{
						*Ûûif *î;(*å*Ñ*6Equal2 *ri(*5j*-*)6*6dates2 *>[**	6outer2]2, *4j*-*)6*6dates2 *>[**	6inner2]2)2)*»C
							*π<*¥*Ø*ß*6errorHandler2 *çi(*j**0"305"B2, *>j*-*)6*6nodes2 *>[**	6inner2]2,
									*9j*(*$0"Duplicate observation date"B2,
									*j**6name2, *Zj*S*O*6ToToken2 *;i(*4j*-*)6*6nodes2 *>[**	6inner2]2)2)2;2
						*5*-*6result2 *4=2 *0falseB2;2
}2
}2
				*3*+*6dates2 *4=2 *0nullB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*æ	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule122 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*À<{
			*«ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ıC
*Ì<*Ë«return *Ÿ*4(2
					  *ò*6Rule122 *¸i(*j**6name2, *¡j*∏*≥*26*6	nodeIndex*4.*6GetElementsByType2 *{i(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *(j*!*0"FXAverageRateOption"B2)2, *j**6errorHandler2)2
					*4&amp;2 *ê*6Rule122 *¸i(*j**6name2, *¡j*∏*≥*26*6	nodeIndex*4.*6GetElementsByType2 *{i(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *(j*!*0"FxAverageRateOption"B2)2, *j**6errorHandler2)*4)2;2

			*ı«return *‡*4(2
				  *¡*6Rule122 *≠i(*j**6name2, *sj*k*g*26*6	nodeIndex*4.*6GetElementsByName2 */i(*(j*!*0"fxAverageRateOption"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*˝*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule122 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ç<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*ÄÄforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *ñ<{
				*¬*∂*9*6
XmlElement2	*6schedule2	*Ü= *~*z*!6*	6XPath*4.*6Path2 *Si(*j**6context2, *3j*,*(0 "averageRateObservationSchedule"B2)2;2
				*cûif *6;(*/*6schedule2 *	4==2 *0nullB2)*C *<*ö	continue;2

				*µ*©*9*6
XmlElement2	*6start2	*}= *u*q*!6*	6XPath*4.*6Path2 *Ji(*j**6schedule2, *)j*"*0"observationStartDate"B2)2;2
				*≤*¶*9*6
XmlElement2	*6end2		*{= *s*o*!6*	6XPath*4.*6Path2 *Hi(*j**6schedule2, *'j* *0"observationEndDate"B2)2;2
				*ª*Ø*9*6
XmlElement2	*6freq2	*É= *{*w*!6*	6XPath*4.*6Path2 *Pi(*j**6schedule2, */j*(*$0"calculationPeriodFrequency"B2)2;2
				*´*û*9*6
XmlElement2	*6roll2	*s= *k*g*!6*	6XPath*4.*6Path2 *@i(*j**6freq2, *#j**0"rollConvention"B2)2;2

				*µûif *á;(*ˇ*4(*6start2 *	4==2 *0nullB*4)2 *	4||2 *4(*
6end2 *	4==2 *0nullB*4)2 *	4||2 *4(*6freq2 *	4==2 *0nullB*4)2 *	4||2 *4(*6roll2 *	4==2 *0nullB*4)2)*C *<*ö	continue;2

				*ƒ*∑*9*6*6Date2 *>[]2 	*6dates2	*Ä= *˜*Ú*6GenerateSchedule2 *‘i(*:j*2*.*6ToDate2 *i(*j**	6start2)2, *>j*0*,*6ToDate2 *i(*j**6end2)2,
						*=j*5*1*6
ToInterval2 *i(*j**6freq2)2, *yj*q*m*'6*6DateRoll*4.*6ForName2 *@i(*9j*2*.*6ToToken2 *i(*j**6roll2)2)2, *j**0nullB2)2;2

				*⁄*Õ*9*6XmlNodeList2	*6nodes2	*ü= *ñ*ë*"6*	6XPath*4.*	6Paths2 *ii(*j**6context2, *#j**0"observedRates"B2, *$j**0"observationDate"B2)2;2

				*ıÄforeach *S(*I*B*9*6
XmlElement2 *6observed2 *Vin **	6nodes2)2 *â<{
					*q*e*9*6Date2		*6date2 	 *== *5*1*6ToDate2 *i(*j**6observed2)2;2
					*L*@*9*6bool2		*6found2 *= **0falseB2;2
					*∫Äforeach *J(*@*9*9*6Date2 *6match2 *Vin **	6dates2)2 *’<{
						*∆ûif *Q;(*J*C*6Equal2 *1i(*j**6date2, *j**	6match2)2)*`C *Y<	{
							*9*+*6found2 *4=2 *0trueB2;2
							*ôbreak;2
}2
					}2

					*˝ûif *;(**4!*	6found2)*ŒC *∆<{
						*Ä*Ú*Í*6errorHandler2 *–i(*j**0"305"B2, * j**6observed2
,
								*∂j*•*0"Observation date '"2 B*4+2 *5*6ToToken2 *i(*j**6observed2)2 *4+2	
								*-0%"' does not match with the schedule."B2
,
								*j**6name2, *=j*6*2*6ToToken2 *i(*j**6observed2)2)2;2
						*5*-*6result2 *4=2 *0falseB2;2
}2
}2
				*3*+*6dates2 *4=2 *0nullB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*æ	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule132 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*À<{
			*«ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ıC
*Ì<*Ë«return *Ÿ*4(2
					  *ò*6Rule132 *¸i(*j**6name2, *¡j*∏*≥*26*6	nodeIndex*4.*6GetElementsByType2 *{i(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *(j*!*0"FXAverageRateOption"B2)2, *j**6errorHandler2)2
					*4&amp;2 *ê*6Rule132 *¸i(*j**6name2, *¡j*∏*≥*26*6	nodeIndex*4.*6GetElementsByType2 *{i(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *(j*!*0"FxAverageRateOption"B2)2, *j**6errorHandler2)*4)2;2

			*ı«return *‡*4(2
				  *¡*6Rule132 *≠i(*j**6name2, *sj*k*g*26*6	nodeIndex*4.*6GetElementsByName2 */i(*(j*!*0"fxAverageRateOption"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*ç*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule132 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ù<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*êÄforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *¶<{
				*È*›*9*6XmlNodeList2	*6schedule2	*¨= *£*û*"6*	6XPath*4.*	6Paths2 *vi(*j**6context2, *0j*(*$0"averageRateObservationDate"B2, *$j**0"observationDate"B2)2;2
				*–*ƒ*9*6int2			*6limit2		*õ= *í*çB*B;*>*4(*6schedule2 *	4!=2 *0nullB*4)2 ?*0C *)*"6*6schedule*4.*	6Count2 *D: **00B 2;2
				*[ûif *.;(*'*6limit2 *	4==2 *00B 2)*C *<*ö	continue;2

				*Ç*v*9*6*6Date2 *>[]2		*6dates2	*@= *8*
4new2 *(6*6Date2 *>[**	6limit2]2;2

				*—ùfor *†(*?*8*9*6int2 *6count2 *= **00B 2;2 *2;*+*6count2 *4&lt;2 *	6limit2;2 *	**4++*	6count2)2
					*ö<*ï*ê*,6*6dates2 *>[**	6count2]2 *4=2 *Q*6ToDate2 *>i(*7j*0*,6*6schedule2 *>[**	6count2]2)2;2

				*⁄*Õ*9*6XmlNodeList2	*6nodes2	*ü= *ñ*ë*"6*	6XPath*4.*	6Paths2 *ii(*j**6context2, *#j**0"observedRates"B2, *$j**0"observationDate"B2)2;2

				*í
Äforeach *S(*I*B*9*6
XmlElement2 *6observed2 *Vin **	6nodes2)2 *¶	<{
					*q*e*9*6Date2		*6date2 	 *== *5*1*6ToDate2 *i(*j**6observed2)2;2
					*L*@*9*6bool2		*6found2 *= **0falseB2;2
					*ƒùfor *≤(*?*8*9*6int2 *6match2 *= **00B 2;2 *I;*B*6match2 *4&lt;2 * 6*	6dates*4.*
6Length2;2 *	**4++*	6match2)2 *˚<{
						*Ïûif *q;(*j*c*6Equal2 *Qi(*j**6date2, *4j*-*)6*6dates2 *>[**	6match2]2)2)*fC *_<	{
							*9*+*6found2 *4=2 *0trueB2;2
							*ôbreak;2
						}2
					}2
					*êûif *;(**4!*	6found2)*·C *Ÿ<{
						*é*ˇ*˜*6errorHandler2 *›i(*j**0"305"B2, * j**6observed2
,
								*√j*≤*0"Observation date '"2 B*4+2 *5*6ToToken2 *i(*j**6observed2)2 *4+2	
								*:02"' does not match with a defined observationDate."B2
,
								*j**6name2, *=j*6*2*6ToToken2 *i(*j**6observed2)2)2;2

						*:*-*6result2 *4=2 *0falseB2;2
					}2
}2
				*3*+*6dates2 *4=2 *0nullB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*†	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule142 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*≠<{
			*≥ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*·C
*Ÿ<*‘«return *≈*4(2
					  *é*6Rule142 *Úi(*j**6name2, *∑j*Æ*©*26*6	nodeIndex*4.*6GetElementsByType2 *qi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FXBarrier"B2)2, *j**6errorHandler2)2
					*4&amp;2 *Ü*6Rule142 *Úi(*j**6name2, *∑j*Æ*©*26*6	nodeIndex*4.*6GetElementsByType2 *qi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FxBarrier"B2)2, *j**6errorHandler2)*4)2;2

			*Î«return *÷*4(2
				  *∑*6Rule142 *£i(*j**6name2, *ij*a*]*26*6	nodeIndex*4.*6GetElementsByName2 *%i(*j**0"fxBarrier"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*Ì*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule142 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*˝	<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *Ü<{
				*¥*®*9*6
XmlElement2	*6start2	*|= *t*p*!6*	6XPath*4.*6Path2 *Ii(*j**6context2, *)j*"*0"observationStartDate"B2)2;2
				*±*•*9*6
XmlElement2	*6end2		*z= *r*n*!6*	6XPath*4.*6Path2 *Gi(*j**6context2, *'j* *0"observationEndDate"B2)2;2
				*Ÿûif *´;(*£*4(*6start2 *	4==2 *0nullB*4)2 *	4||2 *4(*
6end2 *	4==2 *0nullB*4)2 *4||2
					*í*6LessOrEqual2 *zi(*:j*2*.*6ToDate2 *i(*j**	6start2)2, *7j*0*,*6ToDate2 *i(*j**6end2)2)2)*C *<*ö	continue;2

				*˚*Ô*Á*6errorHandler2 *Õi(*j**0"305"B2, *j**6context2,
						*]j*O*K0C"The observationStartDate must not be after the observationEndDate"B2,
						*j**6name2, *j**0nullB2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*≤	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule152 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ø<{
			*øûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ÌC
*Â<*‡«return *—*4(2
					  *î*6Rule152 *¯i(*j**6name2, *Ωj*¥*Ø*26*6	nodeIndex*4.*6GetElementsByType2 *wi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *$j**0"FXBarrierOption"B2)2, *j**6errorHandler2)2
					*4&amp;2 *å*6Rule152 *¯i(*j**6name2, *Ωj*¥*Ø*26*6	nodeIndex*4.*6GetElementsByType2 *wi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *$j**0"FxBarrierOption"B2)2, *j**6errorHandler2)*4)2;2

			*Ò«return *‹*4(2
				  *Ω*6Rule152 *©i(*j**6name2, *oj*g*c*26*6	nodeIndex*4.*6GetElementsByName2 *+i(*$j**0"fxBarrierOption"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*Å	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule152 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ë<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*ÑÄforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *ö<{
				*ß*õ*9*6
XmlElement2	*6rate2	*p= *h*d*!6*	6XPath*4.*6Path2 *=i(*j**6context2, *j**0
"spotRate"B2)2;2
				*Øûif *Å;(*z*4(*6rate2 *	4==2 *0nullB*4)2 *	4||2 *1*6
IsPositive2 *i(*j**6rate2)2)*C *<*ö	continue;2

				*˙*Ó*Ê*6errorHandler2 *Ãi(*j**0"305"B2, *j**6context2,
						*:j*,*(0 "The spot rate must be positive"B2,
						*j**6name2, *9j*2*.*6ToToken2 *i(*j**6rate2)2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*≤	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule162 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ø<{
			*øûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ÌC
*Â<*‡«return *—*4(2
					  *î*6Rule162 *¯i(*j**6name2, *Ωj*¥*Ø*26*6	nodeIndex*4.*6GetElementsByType2 *wi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *$j**0"FXDigitalOption"B2)2, *j**6errorHandler2)2
					*4&amp;2 *å*6Rule162 *¯i(*j**6name2, *Ωj*¥*Ø*26*6	nodeIndex*4.*6GetElementsByType2 *wi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *$j**0"FxDigitalOption"B2)2, *j**6errorHandler2)*4)2;2

			*Ò«return *‹*4(2
				  *Ω*6Rule162 *©i(*j**6name2, *oj*g*c*26*6	nodeIndex*4.*6GetElementsByName2 *+i(*$j**0"fxDigitalOption"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*Ä	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule162 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ê<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*ÉÄforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *ö<{
				*ß*õ*9*6
XmlElement2	*6rate2	*p= *h*d*!6*	6XPath*4.*6Path2 *=i(*j**6context2, *j**0
"spotRate"B2)2;2
				*Øûif *Å;(*z*4(*6rate2 *	4==2 *0nullB*4)2 *	4||2 *1*6
IsPositive2 *i(*j**6rate2)2)*C *<*ö	continue;2

				*˙*Ó*Ê*6errorHandler2 *Ãi(*j**0"305"B2, *j**6context2,
						*:j*,*(0 "The spot rate must be positive"B2,
						*j**6name2, *9j*2*.*6ToToken2 *i(*j**6rate2)2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*ª	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule172 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*»<{
			*∆ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ıC
				*È<*‰«return *’*4(2
					  *ñ*6Rule172 *˙i(*j**6name2, *øj*∂*±*26*6	nodeIndex*4.*6GetElementsByType2 *yi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *&j**0"FXEuropeanTrigger"B2)2, *j**6errorHandler2)2
					*4&amp;2 *é*6Rule172 *˙i(*j**6name2, *øj*∂*±*26*6	nodeIndex*4.*6GetElementsByType2 *yi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *&j**0"FxEuropeanTrigger"B2)2, *j**6errorHandler2)*4)2;2
			*Û«return *ﬁ*4(2
				  *ø*6Rule172 *´i(*j**6name2, *qj*i*e*26*6	nodeIndex*4.*6GetElementsByName2 *-i(*&j**0"fxEuropeanTrigger"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*ä	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule172 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ö<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*åÄforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *¢<{
				*´*û*9*6
XmlElement2	*6rate2	*s= *k*g*!6*	6XPath*4.*6Path2 *@i(*j**6context2, * j**0"triggerRate"B2)2;2

				*Øûif *Å;(*z*4(*6rate2 *	4==2 *0nullB*4)2 *	4||2 *1*6
IsPositive2 *i(*j**6rate2)2)*C *<*ö	continue;2

				*˛*Ò*È*6errorHandler2 *œi(*j**0"305"B2, *j**6context2,
						*=j*/*+0#"The trigger rate must be positive"B2,
						*j**6name2, *9j*2*.*6ToToken2 *i(*j**6rate2)2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*ö	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule182 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ß<{
			*´ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ŸC
*—<*Ã«return *Ω*4(2
					  *ä*6Rule182 *Ói(*j**6name2, *≥j*™*•*26*6	nodeIndex*4.*6GetElementsByType2 *mi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FXLeg"B2)2, *j**6errorHandler2)2
					*4&amp;2 *Ç*6Rule182 *Ói(*j**6name2, *≥j*™*•*26*6	nodeIndex*4.*6GetElementsByType2 *mi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FxLeg"B2)2, *j**6errorHandler2)*4)2;2

			*Ì«return *ÿ*4(2
				  *π*6Rule182 *•i(*j**6name2, *kj*c*_*26*6	nodeIndex*4.*6GetElementsByName2 *'i(* j**0"fxSingleLeg"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*˚*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule182 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ã<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*˝Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *î<{
				*‚*÷*9*6
XmlElement2	*6ccy1Pay2	*ß= *û*ô*!6*	6XPath*4.*6Path2 *ri(*j**6context2, *(j* *0"exchangedCurrency1"B2, *(j*!*0"payerPartyReference"B2)2;2
				*Â*Ÿ*9*6
XmlElement2	*6ccy1Rec2	*™= *°*ú*!6*	6XPath*4.*6Path2 *ui(*j**6context2, *(j* *0"exchangedCurrency1"B2, *+j*$* 0"receiverPartyReference"B2)2;2
				*‚*÷*9*6
XmlElement2	*6ccy2Pay2	*ß= *û*ô*!6*	6XPath*4.*6Path2 *ri(*j**6context2, *(j* *0"exchangedCurrency2"B2, *(j*!*0"payerPartyReference"B2)2;2
				*Ê*Ÿ*9*6
XmlElement2	*6ccy2Rec2	*™= *°*ú*!6*	6XPath*4.*6Path2 *ui(*j**6context2, *(j* *0"exchangedCurrency2"B2, *+j*$* 0"receiverPartyReference"B2)2;2

				*∆ûif *ò;(*ê*4(*6ccy1Pay2 *	4==2 *0nullB*4)2 *	4||2 *4(*6ccy1Rec2 *	4==2 *0nullB*4)2 *4||2
					*4(*6ccy2Pay2 *	4==2 *0nullB*4)2 *	4||2 *4(*6ccy2Rec2 *	4==2 *0nullB*4)2)*C *<*ö	continue;2

				*˙ûif *Ã;(*ƒ*“*6Equal2 *ºi(*Zj*R*N*(6*6ccy1Pay*4.*6GetAttribute* i(*j**0"href"B2)2, *Yj*R*N*(6*6ccy2Rec*4.*6GetAttribute* i(*j**0"href"B2)2)2 *4
&amp;&amp;2
					*œ*6Equal2 *ºi(*Zj*R*N*(6*6ccy2Pay*4.*6GetAttribute* i(*j**0"href"B2)2, *Yj*R*N*(6*6ccy1Rec*4.*6GetAttribute* i(*j**0"href"B2)2)2)*C *<*ö	continue;2

				*Ô*‚*⁄*6errorHandler2 *¿i(*j**0"305"B2, *j**6context2,
						*Pj*B*>06"Exchanged currency payers and receivers don't match."B2,
						*j**6name2, *j**0nullB2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*ù	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule192 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*™<{
			*Æûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*›C
				*—<*Ã«return *Ω*4(2
					  *ä*6Rule192 *Ói(*j**6name2, *≥j*™*•*26*6	nodeIndex*4.*6GetElementsByType2 *mi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FXLeg"B2)2, *j**6errorHandler2)2
					*4&amp;2 *Ç*6Rule192 *Ói(*j**6name2, *≥j*™*•*26*6	nodeIndex*4.*6GetElementsByType2 *mi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FxLeg"B2)2, *j**6errorHandler2)*4)2;2
			*Ì«return *ÿ*4(2
				  *π*6Rule192 *•i(*j**6name2, *kj*c*_*26*6	nodeIndex*4.*6GetElementsByName2 *'i(* j**0"fxSingleLeg"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*û*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule192 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Æ
<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*†	Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *∂<{
				*˙*Ó*9*6
XmlElement2	*6ccy12	*¬= *π*¥*!6*	6XPath*4.*6Path2 *åi(*j**6context2, *(j* *0"exchangedCurrency1"B2, *#j**0"paymentAmount"B2, *j**0
"currency"B2)2;2
				*˚*Ó*9*6
XmlElement2	*6ccy22	*¬= *π*¥*!6*	6XPath*4.*6Path2 *åi(*j**6context2, *(j* *0"exchangedCurrency2"B2, *#j**0"paymentAmount"B2, *j**0
"currency"B2)2;2

				*ìûif *Â;(*›*4(*6ccy12 *	4==2 *0nullB*4)2 *	4||2 *4(*6ccy22 *	4==2 *0nullB*4)2 *	4||2 *4!*K*6IsSameCurrency2 *0i(*j**6ccy12, *j**6ccy22)2)*C *<*ö	continue;2

				*·*’*Õ*6errorHandler2 *≥i(*j**0"305"B2, *j**6context2,
						*Cj*5*10)"Exchanged currencies must be different."B2,
						*j**6name2, *j**0nullB2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*PG// --------------------------------------------------------------------2
		*ö	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule202 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ß<{
			*´ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ŸC
*—<*Ã«return *Ω*4(2
					  *ä*6Rule202 *Ói(*j**6name2, *≥j*™*•*26*6	nodeIndex*4.*6GetElementsByType2 *mi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FXLeg"B2)2, *j**6errorHandler2)2
					*4&amp;2 *Ç*6Rule202 *Ói(*j**6name2, *≥j*™*•*26*6	nodeIndex*4.*6GetElementsByType2 *mi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FxLeg"B2)2, *j**6errorHandler2)*4)2;2

			*Ì«return *ÿ*4(2
				  *π*6Rule202 *•i(*j**6name2, *kj*c*_*26*6	nodeIndex*4.*6GetElementsByName2 *'i(* j**0"fxSingleLeg"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*Ë*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule202 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*¯	<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*ÎÄforeach *Q(*G*@*9*6
XmlElement2	*6context2 *Vin **6list2)2 *Å<{
				*≤*¶*9*6
XmlElement2	*6date12	*z= *r*n*!6*	6XPath*4.*6Path2 *Gi(*j**6context2, *'j* *0"currency1ValueDate"B2)2;2
				*≤*¶*9*6
XmlElement2	*6date22	*z= *r*n*!6*	6XPath*4.*6Path2 *Gi(*j**6context2, *'j* *0"currency2ValueDate"B2)2;2
				*⁄ûif *¨;(*§*4(*6date12 *	4==2 *0nullB*4)2 *	4||2 *4(*6date22 *	4==2 *0nullB*4)2 *4||2
					*ë*6NotEqual2 *|i(*:j*2*.*6ToDate2 *i(*j**	6date12)2, *9j*2*.*6ToDate2 *i(*j**	6date22)2)2)*C *<*ö	continue;2

				*ˆ*Í*‚*6errorHandler2 *»i(*j**0"305"B2, *j**6context2,
						*Xj*J*F0>"currency1ValueDate and currency2ValueDate must be different."B2,
						*j**6name2, *j**0nullB2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*ö	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule212 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ß<{
			*´ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ŸC
*—<*Ã«return *Ω*4(2
					  *ä*6Rule212 *Ói(*j**6name2, *≥j*™*•*26*6	nodeIndex*4.*6GetElementsByType2 *mi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FXLeg"B2)2, *j**6errorHandler2)2
					*4&amp;2 *Ç*6Rule212 *Ói(*j**6name2, *≥j*™*•*26*6	nodeIndex*4.*6GetElementsByType2 *mi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FxLeg"B2)2, *j**6errorHandler2)*4)2;2

			*Ì«return *ÿ*4(2
				  *π*6Rule212 *•i(*j**6name2, *kj*c*_*26*6	nodeIndex*4.*6GetElementsByName2 *'i(* j**0"fxSingleLeg"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*⁄
*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule212 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Í<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*›Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *Û<{
				*¥*®*9*6
XmlElement2	*6ndf2		*}= *u*q*!6*	6XPath*4.*6Path2 *Ji(*j**6context2, **j*#*0"nonDeliverableForward"B2)2;2
				*”*«*9*6
XmlElement2	*6fwd2		*õ= *í*ç*!6*	6XPath*4.*6Path2 *fi(*j**6context2, *"j**0"exchangeRate"B2, *"j**0"forwardPoints"B2)2;2
				*Æûif *Ä;(*y*4(*
6ndf2 *	4==2 *0nullB*4)2 *	4||2 *4(*
6fwd2 *	4!=2 *0nullB*4)2)*C *<*ö	continue;2

				*Ò*Â*›*6errorHandler2 *√i(*j**0"305"B2, *j**6context2,
						*Sj*E*A09"Non-deliverable forward does not specify forwardPoints."B2,
						*j**6name2, *j**0nullB2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*˛
*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule222 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ã	<{
			*∑ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ÂC
*›<*ÿ«return *…*4(2
					  *ê*6Rule222 *Ùi(*j**6name2, *πj*∞*´*26*6	nodeIndex*4.*6GetElementsByType2 *si(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, * j**0"FXOptionLeg"B2)2, *j**6errorHandler2)2
					*4&amp;2 *à*6Rule222 *Ùi(*j**6name2, *πj*∞*´*26*6	nodeIndex*4.*6GetElementsByType2 *si(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, * j**0"FxOptionLeg"B2)2, *j**6errorHandler2)*4)2;2

			*≈«return *∞*4(2
				  *√*6Rule222 *®i(*j**6name2, *nj*f*b*26*6	nodeIndex*4.*6GetElementsByName2 **i(*#j**0"fxSimpleOption"B2)2, *j**6errorHandler2)2
				*4&amp;2 *Ω*6Rule222 *©i(*j**6name2, *oj*g*c*26*6	nodeIndex*4.*6GetElementsByName2 *+i(*$j**0"fxBarrierOption"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*ù*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule222 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Æ<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*°Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *∑<{
				*¥*®*9*6
XmlElement2	*6buyer2	 *{= *s*o*!6*	6XPath*4.*6Path2 *Hi(*j**6context2, *(j*!*0"buyerPartyReference"B2)2;2
				*∂*™*9*6
XmlElement2	*6seller2	 *|= *t*p*!6*	6XPath*4.*6Path2 *Ii(*j**6context2, *)j*"*0"sellerPartyReference"B2)2;2
				*ﬁ*“*9*6
XmlElement2	*6payer2	 *§= *õ*ñ*!6*	6XPath*4.*6Path2 *oi(*j**6context2, *%j**0"fxOptionPremium"B2, *(j*!*0"payerPartyReference"B2)2;2
				*„*◊*9*6
XmlElement2	*6receiver2 *ß= *û*ô*!6*	6XPath*4.*6Path2 *ri(*j**6context2, *%j**0"fxOptionPremium"B2, *+j*$* 0"receiverPartyReference"B2)2;2
				*¬ûif *î;(*å*4(*6buyer2 *	4==2 *0nullB*4)2 *	4||2 *4(*6seller2 *	4==2 *0nullB*4)2 *4||2
					*4(*6payer2 *	4==2 *0nullB*4)2 *	4||2 *4(*6receiver2 *	4==2 *0nullB*4)2)*C *<*ö	continue;2

				*ˆûif *»;(*¿*Œ*6Equal2 *∏i(*Xj*P*L*&6*	6buyer*4.*6GetAttribute* i(*j**0"href"B2)2, *Wj*P*L*&6*	6payer*4.*6GetAttribute* i(*j**0"href"B2)2)2 *4
&amp;&amp;2
					*œ*6Equal2 *ºi(*Yj*Q*M*'6*
6seller*4.*6GetAttribute* i(*j**0"href"B2)2, *Zj*S*O*)6*6receiver*4.*6GetAttribute* i(*j**0"href"B2)2)2)*C *<*ö	continue;2

				*˛*Ú*Í*6errorHandler2 *–i(*j**0"305"B2, *j**6context2,
						*`j*R*N0F"Premium payer and receiver don't match with option buyer and seller."B2,
						*j**6name2, *j**0nullB2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2
		*QG// --------------------------------------------------------------------2

		*˛
*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule232 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ã	<{
			*∑ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ÂC
*›<*ÿ«return *…*4(2
					  *ê*6Rule232 *Ùi(*j**6name2, *πj*∞*´*26*6	nodeIndex*4.*6GetElementsByType2 *si(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, * j**0"FXOptionLeg"B2)2, *j**6errorHandler2)2
					*4&amp;2 *à*6Rule232 *Ùi(*j**6name2, *πj*∞*´*26*6	nodeIndex*4.*6GetElementsByType2 *si(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, * j**0"FxOptionLeg"B2)2, *j**6errorHandler2)*4)2;2

			*≈«return *∞*4(2
				  *√*6Rule232 *®i(*j**6name2, *nj*f*b*26*6	nodeIndex*4.*6GetElementsByName2 **i(*#j**0"fxSimpleOption"B2)2, *j**6errorHandler2)2
				*4&amp;2 *Ω*6Rule232 *©i(*j**6name2, *oj*g*c*26*6	nodeIndex*4.*6GetElementsByName2 *+i(*$j**0"fxBarrierOption"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*“*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule232 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*‚	<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*’Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *Î<{
				*”*«*9*6
XmlElement2	*6ccy12	*õ= *í*ç*!6*	6XPath*4.*6Path2 *fi(*j**6context2, *'j**0"putCurrencyAmount"B2, *j**0
"currency"B2)2;2
				*‘*»*9*6
XmlElement2	*6ccy22	*ú= *ì*é*!6*	6XPath*4.*6Path2 *gi(*j**6context2, *(j* *0"callCurrencyAmount"B2, *j**0
"currency"B2)2;2
				*ìûif *Â;(*›*4(*6ccy12 *	4==2 *0nullB*4)2 *	4||2 *4(*6ccy22 *	4==2 *0nullB*4)2 *	4||2 *4!*K*6IsSameCurrency2 *0i(*j**6ccy12, *j**6ccy22)2)*C *<*ö	continue;2

				*‰*ÿ*–*6errorHandler2 *∂i(*j**0"305"B2, *j**6context2,
						*Fj*8*40,"Put and call currencies must be different."B2,
						*j**6name2, *j**0nullB2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*¨	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule242 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*π<{
			*ªûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ÈC
*·<*‹«return *Õ*4(2
					  *í*6Rule242 *ˆi(*j**6name2, *ªj*≤*≠*26*6	nodeIndex*4.*6GetElementsByType2 *ui(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *"j**0"FXStrikePrice"B2)2, *j**6errorHandler2)2
					*4&amp;2 *ä*6Rule242 *ˆi(*j**6name2, *ªj*≤*≠*26*6	nodeIndex*4.*6GetElementsByType2 *ui(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *"j**0"FxStrikePrice"B2)2, *j**6errorHandler2)*4)2;2

			*Ô«return *⁄*4(2
				  *ª*6Rule242 *ßi(*j**6name2, *mj*e*a*26*6	nodeIndex*4.*6GetElementsByName2 *)i(*"j**0"fxStrikePrice"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*¯*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule242 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*à<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*˚Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *ë<{
				*£*ó*9*6
XmlElement2	*6rate2	*l= *d*`*!6*	6XPath*4.*6Path2 *9i(*j**6context2, *j**0"rate"B2)2;2
				*Øûif *Å;(*z*4(*6rate2 *	4==2 *0nullB*4)2 *	4||2 *1*6
IsPositive2 *i(*j**6rate2)2)*C *<*ö	continue;2

				*ı*È*·*6errorHandler2 *«i(*j**0"305"B2, *j**6context2,
						*5j*'*#0"The rate must be positive"B2,
						*j**6name2, *9j*2*.*6ToToken2 *i(*j**6rate2)2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*ó	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule252 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*§<{
			*≠ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*€C
*”<*Œ«return *ø*4(2
					  *ã*6Rule252 *Ôi(*j**6name2, *¥j*´*¶*26*6	nodeIndex*4.*6GetElementsByType2 *ni(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FXSwap"B2)2, *j**6errorHandler2)2
					*4&amp;2 *É*6Rule252 *Ôi(*j**6name2, *¥j*´*¶*26*6	nodeIndex*4.*6GetElementsByType2 *ni(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FxSwap"B2)2, *j**6errorHandler2)*4)2;2

			*Ë«return *”*4(2
				  *¥*6Rule252 *†i(*j**6name2, *fj*^*Z*26*6	nodeIndex*4.*6GetElementsByName2 *"i(*j**0"fxSwap"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*Ω*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule252 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Õ<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*¿Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *÷<{
				*¨*†*9*6XmlNodeList2	*6legs2	*t= *l*h*"6*	6XPath*4.*	6Paths2 *@i(*j**6context2, * j**0"fxSingleLeg"B2)2;2
				*Åûif *T;(*M*/*6Count2 *i(*j**6legs2)2 *4&gt;=2 *02B 2)*C *<*ö	continue;2

				*ﬂ*”*À*6errorHandler2 *±i(*j**0"305"B2, *j**6context2,
						*Aj*3*/0'"FX swaps must have at least two legs."B2,
						*j**6name2, *j**0nullB2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*ó	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule262 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*§<{
			*≠ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*€C
*”<*Œ«return *ø*4(2
					  *ã*6Rule262 *Ôi(*j**6name2, *¥j*´*¶*26*6	nodeIndex*4.*6GetElementsByType2 *ni(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FXSwap"B2)2, *j**6errorHandler2)2
					*4&amp;2 *É*6Rule262 *Ôi(*j**6name2, *¥j*´*¶*26*6	nodeIndex*4.*6GetElementsByType2 *ni(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FxSwap"B2)2, *j**6errorHandler2)*4)2;2

			*Ë«return *”*4(2
				  *¥*6Rule262 *†i(*j**6name2, *fj*^*Z*26*6	nodeIndex*4.*6GetElementsByName2 *"i(*j**0"fxSwap"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*‰*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule262 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Ù<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*Á
Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *˛	<{
				*¨*†*9*6XmlNodeList2	*6legs2	*t= *l*h*"6*	6XPath*4.*	6Paths2 *@i(*j**6context2, * j**0"fxSingleLeg"B2)2;2
				*}ûif *Q;(*J*/*6Count2 *i(*j**6legs2)2 *	4!=2 *02B 2)*C *<*ö	continue;2
				*Ê*⁄*9*6
XmlElement2 	*6date12	*¨= *£*û*!6*	6XPath*4.*6Path2 *wi(*Pj*H*)6*6legs2 *>[**00B 2]2 *	4as2 *6
XmlElement2, *j**0"valueDate"B2)2;2
				*Á*⁄*9*6
XmlElement2 	*6date22	*¨= *£*û*!6*	6XPath*4.*6Path2 *wi(*Pj*H*)6*6legs2 *>[**01B 2]2 *	4as2 *6
XmlElement2, *j**0"valueDate"B2)2;2

				*œûif *°;(*ô*ë*6NotEqual2 *|i(*:j*2*.*6ToDate2 *i(*j**	6date12)2, *9j*2*.*6ToDate2 *i(*j**	6date22)2)2)*C *<*ö	continue;2

				*Á*⁄*“*6errorHandler2 *∏i(*j**0"305"B2, *j**6context2,
						*Hj*:*60."FX swaps legs must settle on different days."B2,
						*j**6name2, *j**0nullB2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*å*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule272 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ô<{
			*ñûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*≈C
				*π<*¥«return *•*4(*è*6Rule272 *˚i(*j**6name2, *¿j*∑*≤*26*6	nodeIndex*4.*6GetElementsByType2 *zi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *'j* *0"QuotedCurrencyPair"B2)2, *j**6errorHandler2)*4)2;2
			*Ù«return *ﬂ*4(2
				  *¿*6Rule272 *¨i(*j**6name2, *rj*j*f*26*6	nodeIndex*4.*6GetElementsByName2 *.i(*'j* *0"quotedCurrencyPair"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*Ó
*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule272 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ˇ<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*ÒÄforeach *Q(*G*@*9*6
XmlElement2	*6context2 *Vin **6list2)2 *à<{
				*®*ú*9*6
XmlElement2	*6ccy12	*q= *i*e*!6*	6XPath*4.*6Path2 *>i(*j**6context2, *j**0"currency1"B2)2;2
				*®*ú*9*6
XmlElement2	*6ccy22	*q= *i*e*!6*	6XPath*4.*6Path2 *>i(*j**6context2, *j**0"currency2"B2)2;2
				*ìûif *Â;(*›*4(*6ccy12 *	4==2 *0nullB*4)2 *	4||2 *4(*6ccy22 *	4==2 *0nullB*4)2 *	4||2 *4!*K*6IsSameCurrency2 *0i(*j**6ccy12, *j**6ccy22)2)*C *<*ö	continue;2

				*ÿ*À*√*6errorHandler2 *©i(*j**0"305"B2, *j**6context2,
						*9j*+*'0"Currencies must be different."B2,
						*j**6name2, *j**0nullB2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2
		*QG// --------------------------------------------------------------------2

		*ÿ*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule282 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Â<{
			*åûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ªC
				*Ø<*™«return *õ*4(*Ö*6Rule282 *Òi(*j**6name2, *∂j*≠*®*26*6	nodeIndex*4.*6GetElementsByType2 *pi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0
"SideRate"B2)2, *j**6errorHandler2)*4)2;2
			* «return *µ*4(2
				  *∆*6Rule282 *´i(*j**6name2, *qj*i*e*26*6	nodeIndex*4.*6GetElementsByName2 *-i(*&j**0"currency1SideRate"B2)2, *j**6errorHandler2)2
				*4&amp;2 *ø*6Rule282 *´i(*j**6name2, *qj*i*e*26*6	nodeIndex*4.*6GetElementsByName2 *-i(*&j**0"currency2SideRate"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*¯*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule282 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*à<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*˚Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *í<{
				*§*ò*9*6
XmlElement2		*6rate2	*l= *d*`*!6*	6XPath*4.*6Path2 *9i(*j**6context2, *j**0"rate"B2)2;2
				*Øûif *Å;(*z*4(*6rate2 *	4==2 *0nullB*4)2 *	4||2 *1*6
IsPositive2 *i(*j**6rate2)2)*C *<*ö	continue;2

				*ı*È*·*6errorHandler2 *«i(*j**0"305"B2, *j**6context2,
						*5j*'*#0"The rate must be positive"B2,
						*j**6name2, *9j*2*.*6ToToken2 *i(*j**6rate2)2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*ÿ*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule292 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Â<{
			*åûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ªC
				*Ø<*™«return *õ*4(*Ö*6Rule292 *Òi(*j**6name2, *∂j*≠*®*26*6	nodeIndex*4.*6GetElementsByType2 *pi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0
"SideRate"B2)2, *j**6errorHandler2)*4)2;2
			* «return *µ*4(2
				  *∆*6Rule292 *´i(*j**6name2, *qj*i*e*26*6	nodeIndex*4.*6GetElementsByName2 *-i(*&j**0"currency1SideRate"B2)2, *j**6errorHandler2)2
				*4&amp;2 *ø*6Rule292 *´i(*j**6name2, *qj*i*e*26*6	nodeIndex*4.*6GetElementsByName2 *-i(*&j**0"currency2SideRate"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*œ
*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule292 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ﬂ<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*—Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *Ë<{
				*∞*§*9*6
XmlElement2 	*6forward2 *u= *m*i*!6*	6XPath*4.*6Path2 *Bi(*j**6context2, *"j**0"forwardPoints"B2)2;2
				*ß*õ*9*6
XmlElement2	*6spot2	*p= *h*d*!6*	6XPath*4.*6Path2 *=i(*j**6context2, *j**0
"spotRate"B2)2;2
				*—ûif *£;(*õ*4!*4(*4(*6forward2 *	4!=2 *0nullB*4)2 *4
&amp;&amp;2 *4(*6spot2 *	4==2 *0nullB*4)*4)2)*C *<*ö	continue;2

				*Û*Ê*ﬁ*6errorHandler2 *ƒi(*j**0"305"B2, *j**6context2,
						*Tj*F*B0:"If forwardPoints exists then spotRate should also exist."B2,
						*j**6name2, *j**0nullB2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*⁄*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule302 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Á<{
			*åûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ªC
				*Ø<*™«return *õ*4(*Ö*6Rule302 *Òi(*j**6name2, *∂j*≠*®*26*6	nodeIndex*4.*6GetElementsByType2 *pi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0
"SideRate"B2)2, *j**6errorHandler2)*4)2;2
			*Ã«return *∑*4(2
					  *«*6Rule302 *´i(*j**6name2, *qj*i*e*26*6	nodeIndex*4.*6GetElementsByName2 *-i(*&j**0"currency1SideRate"B2)2, *j**6errorHandler2)2
					*4&amp;2 *ø*6Rule302 *´i(*j**6name2, *qj*i*e*26*6	nodeIndex*4.*6GetElementsByName2 *-i(*&j**0"currency2SideRate"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*œ*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule302 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ﬂ<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*—Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *Á
<{
				*∞*§*9*6
XmlElement2 	*6forward2 *u= *m*i*!6*	6XPath*4.*6Path2 *Bi(*j**6context2, *"j**0"forwardPoints"B2)2;2
				*ß*õ*9*6
XmlElement2	*6spot2	*p= *h*d*!6*	6XPath*4.*6Path2 *=i(*j**6context2, *j**0
"spotRate"B2)2;2
				*§*ó*9*6
XmlElement2	*6rate2	*l= *d*`*!6*	6XPath*4.*6Path2 *9i(*j**6context2, *j**0"rate"B2)2;2

				*ˆûif *»;(*¿*4(*6rate2 *	4==2 *0nullB*4)2 *	4||2 *4(*6forward2 *	4==2 *0nullB*4)2 *	4||2 *4(*6spot2 *	4==2 *0nullB*4)2)*C *<*ö	continue;2

				*ëûif *ﬁ;(*÷*0*6	ToDecimal2 *i(*j**6rate2)*4.*ï*
6Equals*Ñi(*}j*v*3*6	ToDecimal2 *i(*j**6spot2)2 *4+2 *3*6	ToDecimal2 *i(*j**6forward2)2)2)*C
					*<*ö	continue;2

				*í*Ü*˛*6errorHandler2 *‰i(*j**0"305"B2, *j**6context2,
						*Rj*D*@08"Sum of spotRate and forwardPoints does not equal rate."B2,
						*j**6name2, *9j*2*.*6ToToken2 *i(*j**6rate2)2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*¸*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule312 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*â<{
			*éûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ºC
				*∞<*´«return *ú*4(*Ü*6Rule312 *Úi(*j**6name2, *∑j*Æ*©*26*6	nodeIndex*4.*6GetElementsByType2 *qi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"SideRates"B2)2, *j**6errorHandler2)*4)2;2

			*Ï«return *◊*4(2
					  *∑*6Rule312 *£i(*j**6name2, *ij*a*]*26*6	nodeIndex*4.*6GetElementsByName2 *%i(*j**0"sideRates"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*ä*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule312 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ö<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*åÄforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *£<{
				*Ø*£*9*6
XmlElement2 	*6baseCcy2	*t= *l*h*!6*	6XPath*4.*6Path2 *Ai(*j**6context2, *!j**0"baseCurrency"B2)2;2
				*”*«*9*6
XmlElement2	*6ccy12	*õ= *í*ç*!6*	6XPath*4.*6Path2 *fi(*j**6context2, *'j**0"currency1SideRate"B2, *j**0
"currency"B2)2;2
				*‘*«*9*6
XmlElement2	*6ccy22	*õ= *í*ç*!6*	6XPath*4.*6Path2 *fi(*j**6context2, *'j**0"currency2SideRate"B2, *j**0
"currency"B2)2;2

				*€ûif *≠;(*•*4(*6baseCcy2 *	4==2 *0nullB*4)2 *	4||2 *4(*6ccy12 *	4==2 *0nullB*4)2 *	4||2 *4(*6ccy22 *	4==2 *0nullB*4)2 *4||2
					*4(*4!*Q*6IsSameCurrency2 *3i(*j**6baseCcy2, *j**6ccy12)2 *4
&amp;&amp;2 *4!*N*6IsSameCurrency2 *3i(*j**6baseCcy2, *j**6ccy22)*4)2)*C *<*ö	continue;2

				*¢*ï*ç*6errorHandler2 *Ûi(*j**0"305"B2, *j**6context2,
						*^j*P*L0D"The base currency must be different from the side rate currencies."B2,
						*j**6name2, *<j*5*1*6ToToken2 *i(*j**6baseCcy2)2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*ˇ*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule322 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*å<{
			*èûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*æC
				*≤<*≠«return *û*4(*à*6Rule322 *Ùi(*j**6name2, *πj*∞*´*26*6	nodeIndex*4.*6GetElementsByType2 *si(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, * j**0"TermDeposit"B2)2, *j**6errorHandler2)*4)2;2
			*Ó«return *Ÿ*4(2
					  *π*6Rule322 *•i(*j**6name2, *kj*c*_*26*6	nodeIndex*4.*6GetElementsByName2 *'i(* j**0"termDeposit"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*™*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule322 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*∫<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*¨
Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *√	<{
				*∂*™*9*6
XmlElement2	*6payer2	 *}= *u*q*!6*	6XPath*4.*6Path2 *Ji(*j**6context2, **j*#*0"initialPayerReference"B2)2;2
				*Ω*∞*9*6
XmlElement2	*6receiver2 *Ä= *x*t*!6*	6XPath*4.*6Path2 *Mi(*j**6context2, *-j*&*"0"initialReceiverReference"B2)2;2

				*µûif *à;(*Ä*4(*6payer2 *	4==2 *0nullB*4)2 *	4||2 *4(*6receiver2 *	4==2 *0nullB*4)2)*C *<*ö	continue;2
				*ùûif *;(*Ë*‡*6NotEqual2 * i(*dj*S*O*)6*	6payer*4.*6GetAttribute2 * i(*j**0"href"B2)2,
							  *]j*V*R*,6*6receiver*4.*6GetAttribute2 * i(*j**0"href"B2)2)2)*C *<*ö	continue;2
				*Æ*°*ô*6errorHandler2 *ˇi(*j**0"305"B2, *j**6context2,
						*Lj*>*:02"The initial payer and receiver must be different"B2,
						*j**6name2, *Zj*S*O*)6*	6payer*4.*6GetAttribute2 * i(*j**0"href"B2)2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*ˇ*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule332 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*å<{
			*èûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*æC
				*≤<*≠«return *û*4(*à*6Rule332 *Ùi(*j**6name2, *πj*∞*´*26*6	nodeIndex*4.*6GetElementsByType2 *si(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, * j**0"TermDeposit"B2)2, *j**6errorHandler2)*4)2;2
			*Ó«return *Ÿ*4(2
					  *π*6Rule332 *•i(*j**6name2, *kj*c*_*26*6	nodeIndex*4.*6GetElementsByName2 *'i(* j**0"termDeposit"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*˜*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule332 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*à
<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*˙Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *ë<{
				*™*û*9*6
XmlElement2	*6start2	 *q= *i*e*!6*	6XPath*4.*6Path2 *>i(*j**6context2, *j**0"startDate"B2)2;2
				*Ø*£*9*6
XmlElement2	*6maturity2 *t= *l*h*!6*	6XPath*4.*6Path2 *Ai(*j**6context2, *!j**0"maturityDate"B2)2;2
				*‹ûif *Æ;(*¶*4(*6start2 *	4==2 *0nullB*4)2 *	4||2 *4(*6maturity2 *	4==2 *0nullB*4)2 *4||2
					*ê*6Less2 *i(*:j*2*.*6ToDate2 *i(*j**	6start2)2, *<j*5*1*6ToDate2 *i(*j**6maturity2)2)2)*C *<*ö	continue;2

				*è*Ç*˙*6errorHandler2 *‡i(*j**0"305"B2, *j**6context2,
						*Jj*<*800"The maturity date must be after the start date"B2,
						*j**6name2, *=j*6*2*6ToToken2 *i(*j**6maturity2)2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2
		*PG// --------------------------------------------------------------------2
		*ˇ*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule342 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*å<{
			*èûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*æC
				*≤<*≠«return *û*4(*à*6Rule342 *Ùi(*j**6name2, *πj*∞*´*26*6	nodeIndex*4.*6GetElementsByType2 *si(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, * j**0"TermDeposit"B2)2, *j**6errorHandler2)*4)2;2
			*Ó«return *Ÿ*4(2
					  *π*6Rule342 *•i(*j**6name2, *kj*c*_*26*6	nodeIndex*4.*6GetElementsByName2 *'i(* j**0"termDeposit"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*±	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule342 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*¡<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*¥Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 * <{
				*À*ø*9*6
XmlElement2	*6amount2	*ë= *à*É*!6*	6XPath*4.*6Path2 *\i(*j**6context2, *j**0"principal"B2, *j**0"amount"B2)2;2
				*≤ûif *Ö;(*~*4(*6amount2 *	4==2 *0nullB*4)2 *	4||2 *3*6
IsPositive2 *i(*j**
6amount2)2)*C *<*ö	continue;2
				*É*˜*Ô*6errorHandler2 *’i(*j**0"305"B2, *j**6context2,
						*Aj*3*/0'"The principal amount must be positive"B2,
						*j**6name2, *;j*4*0*6ToToken2 *i(*j**
6amount2)2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*ˇ*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule352 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ç<{
			*êûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*æC
				*≤<*≠«return *û*4(*à*6Rule352 *Ùi(*j**6name2, *πj*∞*´*26*6	nodeIndex*4.*6GetElementsByType2 *si(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, * j**0"TermDeposit"B2)2, *j**6errorHandler2)*4)2;2

			*Ó«return *Ÿ*4(2
					  *π*6Rule352 *•i(*j**6name2, *kj*c*_*26*6	nodeIndex*4.*6GetElementsByName2 *'i(* j**0"termDeposit"B2)2, *j**6errorHandler2)*4)2;2
		}2
		*Ö	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule352 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ï<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*áÄforeach *Q(*G*@*9*6
XmlElement2	*6context2 *Vin **6list2)2 *û<{
				*©*ú*9*6
XmlElement2	*6rate2	*q= *i*e*!6*	6XPath*4.*6Path2 *>i(*j**6context2, *j**0"fixedRate"B2)2;2

				*Øûif *Å;(*z*4(*6rate2 *	4==2 *0nullB*4)2 *	4||2 *1*6
IsPositive2 *i(*j**6rate2)2)*C *<*ö	continue;2

				*¸*Ô*Á*6errorHandler2 *Õi(*j**0"305"B2, *j**6context2,
						*;j*-*)0!"The fixed rate must be positive"B2,
						*j**6name2, *9j*2*.*6ToToken2 *i(*j**6rate2)2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*Ú*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule362 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ˇ<{
			*âûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*∏C
				*¨<*ß«return *ò*4(*Ç*6Rule362 *Ói(*j**6name2, *≥j*™*•*26*6	nodeIndex*4.*6GetElementsByType2 *mi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"Trade"B2)2, *j**6errorHandler2)*4)2;2
			*Á«return *“*4(2
				  *≥*6Rule362 *üi(*j**6name2, *ej*]*Y*26*6	nodeIndex*4.*6GetElementsByName2 *!i(*j**0"trade"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*©*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule362 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*∫<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*¨
Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *¬	<{
				*‘*»*9*6
XmlElement2	*6	tradeDate2	 *ñ= *ç*à*!6*	6XPath*4.*6Path2 *ai(*j**6context2, *!j**0"tradeHeader"B2, *j**0"tradeDate"B2)2;2
				*Ö*˘*9*6
XmlElement2	*6
expiryDate2	 *∆= *Ω*∏*!6*	6XPath*4.*6Path2 *êi(*j**6context2, *)j*!*0"fxAverageRateOption"B2, *$j**0"expiryDateTime"B2, *j**0"expiryDate"B2)2;2
				*ºûif *é;(*Ü*4(*6	tradeDate2 *	4==2 *0nullB*4)2 *	4||2 *4(*6
expiryDate2 *	4==2 *0nullB*4)2)*C *<*ö	continue;2

				*’ûif *ß;(*ü*ó*6Less2 *Öi(*>j*6*2*6ToDate2 *i(*j**6	tradeDate2)2, *>j*7*3*6ToDate2 * i(*j**6
expiryDate2)2)2)*C *<*ö	continue;2

				*à*˚*Û*6errorHandler2 *Ÿi(*j**0"305"B2, *j**6context2,
						*Aj*3*/0'"Expiry date must be after trade date."B2,
						*j**6name2, *?j*8*4*6ToToken2 * i(*j**6
expiryDate2)2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2
		*QG// --------------------------------------------------------------------2

		*Û*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule372 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Ä<{
			*äûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*∏C
				*¨<*ß«return *ò*4(*Ç*6Rule372 *Ói(*j**6name2, *≥j*™*•*26*6	nodeIndex*4.*6GetElementsByType2 *mi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"Trade"B2)2, *j**6errorHandler2)*4)2;2

			*Á«return *“*4(2
				  *≥*6Rule372 *üi(*j**6name2, *ej*]*Y*26*6	nodeIndex*4.*6GetElementsByName2 *!i(*j**0"trade"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*¶*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule372 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*∂<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*®
Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *ø	<{
				*‘*»*9*6
XmlElement2	*6	tradeDate2	 *ñ= *ç*à*!6*	6XPath*4.*6Path2 *ai(*j**6context2, *!j**0"tradeHeader"B2, *j**0"tradeDate"B2)2;2
				*Ç*ı*9*6
XmlElement2	*6
expiryDate2	 *¬= *π*¥*!6*	6XPath*4.*6Path2 *åi(*j**6context2, *%j**0"fxBarrierOption"B2, *$j**0"expiryDateTime"B2, *j**0"expiryDate"B2)2;2

				*ºûif *é;(*Ü*4(*6	tradeDate2 *	4==2 *0nullB*4)2 *	4||2 *4(*6
expiryDate2 *	4==2 *0nullB*4)2)*C *<*ö	continue;2

				*’ûif *ß;(*ü*ó*6Less2 *Öi(*>j*6*2*6ToDate2 *i(*j**6	tradeDate2)2, *>j*7*3*6ToDate2 * i(*j**6
expiryDate2)2)2)*C *<*ö	continue;2

				*à*˚*Û*6errorHandler2 *Ÿi(*j**0"305"B2, *j**6context2,
						*Aj*3*/0'"Expiry date must be after trade date."B2,
						*j**6name2, *?j*8*4*6ToToken2 * i(*j**6
expiryDate2)2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*Û*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule382 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Ä<{
			*äûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*∏C
				*¨<*ß«return *ò*4(*Ç*6Rule382 *Ói(*j**6name2, *≥j*™*•*26*6	nodeIndex*4.*6GetElementsByType2 *mi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"Trade"B2)2, *j**6errorHandler2)*4)2;2

			*Á«return *“*4(2
				  *≥*6Rule382 *üi(*j**6name2, *ej*]*Y*26*6	nodeIndex*4.*6GetElementsByName2 *!i(*j**0"trade"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*§*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule382 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*¥<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*¶
Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *Ω	<{
				*‘*»*9*6
XmlElement2	*6	tradeDate2	 *ñ= *ç*à*!6*	6XPath*4.*6Path2 *ai(*j**6context2, *!j**0"tradeHeader"B2, *j**0"tradeDate"B2)2;2
				*Å*ı*9*6
XmlElement2	*6
expiryDate2	 *¬= *π*¥*!6*	6XPath*4.*6Path2 *åi(*j**6context2, *%j**0"fxDigitalOption"B2, *$j**0"expiryDateTime"B2, *j**0"expiryDate"B2)2;2
				*ªûif *é;(*Ü*4(*6	tradeDate2 *	4==2 *0nullB*4)2 *	4||2 *4(*6
expiryDate2 *	4==2 *0nullB*4)2)*C *<*ö	continue;2
				*’ûif *ß;(*ü*ó*6Less2 *Öi(*>j*6*2*6ToDate2 *i(*j**6	tradeDate2)2, *>j*7*3*6ToDate2 * i(*j**6
expiryDate2)2)2)*C *<*ö	continue;2

				*à*˚*Û*6errorHandler2 *Ÿi(*j**0"305"B2, *j**6context2,
						*Aj*3*/0'"Expiry date must be after trade date."B2,
						*j**6name2, *?j*8*4*6ToToken2 * i(*j**6
expiryDate2)2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*Ú*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule392 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ˇ<{
			*âûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*∏C
				*¨<*ß«return *ò*4(*Ç*6Rule392 *Ói(*j**6name2, *≥j*™*•*26*6	nodeIndex*4.*6GetElementsByType2 *mi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"Trade"B2)2, *j**6errorHandler2)*4)2;2
			*Á«return *“*4(2
				  *≥*6Rule392 *üi(*j**6name2, *ej*]*Y*26*6	nodeIndex*4.*6GetElementsByName2 *!i(*j**0"trade"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*◊*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule392 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Á<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*ŸÄforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *<{
				*”*«*9*6
XmlElement2	*6	tradeDate2 *ñ= *ç*à*!6*	6XPath*4.*6Path2 *ai(*j**6context2, *!j**0"tradeHeader"B2, *j**0"tradeDate"B2)2;2
				*”*«*9*6
XmlElement2	*6	valueDate2 *ñ= *ç*à*!6*	6XPath*4.*6Path2 *ai(*j**6context2, *!j**0"fxSingleLeg"B2, *j**0"valueDate"B2)2;2
				*›*—*9*6
XmlElement2	*6
value1Date2 *ü= *ñ*ë*!6*	6XPath*4.*6Path2 *ji(*j**6context2, *!j**0"fxSingleLeg"B2, *'j* *0"currency1ValueDate"B2)2;2
				*ﬁ*—*9*6
XmlElement2	*6
value2Date2 *ü= *ñ*ë*!6*	6XPath*4.*6Path2 *ji(*j**6context2, *!j**0"fxSingleLeg"B2, *'j* *0"currency2ValueDate"B2)2;2

				*ˆûif *7;(*0*6	tradeDate2 *	4!=2 *0nullB2)*ÆC *¶<{
					*Éûif *7;(*0*6	valueDate2 *	4!=2 *0nullB2)*∑C *Ø<{
						*’ûif *¶;(*û*ñ*6Less2 *Ñi(*>j*6*2*6ToDate2 *i(*j**6	tradeDate2)2, *=j*6*2*6ToDate2 *i(*j**6	valueDate2)2)2)*C *<*ö	continue;2
						*å*˝*ı*6errorHandler2 *€i(*j**0"305"B2, *j**6context2
,
								*Bj*2*.0&"value date must be after trade date."B2
,
								*j**6name2, *>j*7*3*6ToToken2 *i(*j**6	valueDate2)2)2;2

						*:*-*6result2 *4=2 *0falseB2;2
					}2
					*àûif *8;(*1*6
value1Date2 *	4!=2 *0nullB2)*∫C *≤<{
						*◊ûif *ß;(*ü*ó*6Less2 *Öi(*>j*6*2*6ToDate2 *i(*j**6	tradeDate2)2, *>j*7*3*6ToDate2 * i(*j**6
value1Date2)2)2)*C *<*ö	continue;2

						*ç*˛*ˆ*6errorHandler2 *‹i(*j**0"305"B2, *j**6context2
,
								*Bj*2*.0&"value1date must be after trade date."B2
,
								*j**6name2, *?j*8*4*6ToToken2 * i(*j**6
value1Date2)2)2;2

						*:*-*6result2 *4=2 *0falseB2;2
					}2

					*áûif *8;(*1*6
value2Date2 *	4!=2 *0nullB2)*∫C *≤<{
						*◊ûif *ß;(*ü*ó*6Less2 *Öi(*>j*6*2*6ToDate2 *i(*j**6	tradeDate2)2, *>j*7*3*6ToDate2 * i(*j**6
value2Date2)2)2)*C *<*ö	continue;2

						*ç*˛*ˆ*6errorHandler2 *‹i(*j**0"305"B2, *j**6context2
,
								*Bj*2*.0&"value2date must be after trade date."B2
,
								*j**6name2, *?j*8*4*6ToToken2 * i(*j**6
value2Date2)2)2;2

						*:*-*6result2 *4=2 *0falseB2;2
					}2
				}2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*Û*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule402 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Ä<{
			*äûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*∏C
				*¨<*ß«return *ò*4(*Ç*6Rule402 *Ói(*j**6name2, *≥j*™*•*26*6	nodeIndex*4.*6GetElementsByType2 *mi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"Trade"B2)2, *j**6errorHandler2)*4)2;2

			*Á«return *“*4(2
				  *≥*6Rule402 *üi(*j**6name2, *ej*]*Y*26*6	nodeIndex*4.*6GetElementsByName2 *!i(*j**0"trade"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*‹*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule402 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*Ï<{
			*K*@*9*6bool2		*6result2	*= **0trueB2;2

			*ﬁÄforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *Ù<{
				*‘*»*9*6
XmlElement2	*6	tradeDate2 	*ñ= *ç*à*!6*	6XPath*4.*6Path2 *ai(*j**6context2, *!j**0"tradeHeader"B2, *j**0"tradeDate"B2)2;2
				*–*ƒ*9*6XmlNodeList2	*6legs2	  	*î= *ã*Ü*"6*	6XPath*4.*	6Paths2 *^i(*j**6context2, *j**0"fxSwap"B2, * j**0"fxSingleLeg"B2)2;2
				*ΩÄforeach *M(*C*<*9*6
XmlElement2 *
6leg2 *Vin **6legs2)2 *⁄<{
					*´*û*9*6
XmlElement2	*6	valueDate2 	*m= *e*a*!6*	6XPath*4.*6Path2 *:i(*j**6leg2, *j**0"valueDate"B2)2;2
					*µ*®*9*6
XmlElement2	*6
value1Date2 	*v= *n*j*!6*	6XPath*4.*6Path2 *Ci(*j**6leg2, *'j* *0"currency1ValueDate"B2)2;2
					*∞*®*9*6
XmlElement2	*6
value2Date2 	*v= *n*j*!6*	6XPath*4.*6Path2 *Ci(*j**6leg2, *'j* *0"currency2ValueDate"B2)2;2
*≥ûif *7;(*0*6	tradeDate2 *	4!=2 *0nullB2)*ÎC *„<{
*Èûif *7;(*0*6	valueDate2 *	4!=2 *0nullB2)*¢C *ö<	{
							*÷ûif *¶;(*û*ñ*6Less2 *Ñi(*>j*6*2*6ToDate2 *i(*j**6	tradeDate2)2, *=j*6*2*6ToDate2 *i(*j**6	valueDate2)2)2)*C *<*ö	continue;2
							*˙*Ú*Í*6errorHandler2 *–i(*j**0"305"B2, *j**6leg2,
*Cj*2*.0&"value date must be after trade date."B2,
									*j**6name2, *>j*7*3*6ToToken2 *i(*j**6	valueDate2)2)2;2
*5*-*6result2 *4=2 *0falseB2;2
}2
*ıûif *8;(*1*6
value1Date2 *	4!=2 *0nullB2)*≠C *•<	{
							*◊ûif *ß;(*ü*ó*6Less2 *Öi(*>j*6*2*6ToDate2 *i(*j**6	tradeDate2)2, *>j*7*3*6ToDate2 * i(*j**6
value1Date2)2)2)*C *<*ö	continue;2
							*Ñ*¸*Ù*6errorHandler2 *⁄i(*j**0"305"B2, *j**6leg2,
									*Cj*2*.0&"value1date must be after trade date."B2,
									*j**6name2, *?j*8*4*6ToToken2 * i(*j**6
value1Date2)2)2;2
*5*-*6result2 *4=2 *0falseB2;2
}2
*ˆûif *8;(*1*6
value2Date2 *	4!=2 *0nullB2)*≠C *•<	{
							*◊ûif *ß;(*ü*ó*6Less2 *Öi(*>j*6*2*6ToDate2 *i(*j**6	tradeDate2)2, *>j*7*3*6ToDate2 * i(*j**6
value2Date2)2)2)*C *<*ö	continue;2
							*Ñ*¸*Ù*6errorHandler2 *⁄i(*j**0"305"B2, *j**6leg2,
									*Cj*2*.0&"value2date must be after trade date."B2,
									*j**6name2, *?j*8*4*6ToToken2 * i(*j**6
value2Date2)2)2;2
*5*-*6result2 *4=2 *0falseB2;2
}2
}2
}2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*†	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule412 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*≠<{
			*≥ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*·C
*Ÿ<*‘«return *≈*4(2
					  *é*6Rule412 *Úi(*j**6name2, *∑j*Æ*©*26*6	nodeIndex*4.*6GetElementsByType2 *qi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FXBarrier"B2)2, *j**6errorHandler2)2
					*4&amp;2 *Ü*6Rule412 *Úi(*j**6name2, *∑j*Æ*©*26*6	nodeIndex*4.*6GetElementsByType2 *qi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"FxBarrier"B2)2, *j**6errorHandler2)*4)2;2

			*Î«return *÷*4(2
				  *∑*6Rule412 *£i(*j**6name2, *ij*a*]*26*6	nodeIndex*4.*6GetElementsByName2 *%i(*j**0"fxBarrier"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*á	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule412 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ó<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*äÄforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *†<{
				*™*û*9*6
XmlElement2	*6rate2	*s= *k*g*!6*	6XPath*4.*6Path2 *@i(*j**6context2, * j**0"triggerRate"B2)2;2
				*Øûif *Å;(*z*4(*6rate2 *	4==2 *0nullB*4)2 *	4||2 *1*6
IsPositive2 *i(*j**6rate2)2)*C *<*ö	continue;2

				*˝*Ò*È*6errorHandler2 *œi(*j**0"305"B2, *j**6context2,
						*=j*/*+0#"The trigger rate must be positive"B2,
						*j**6name2, *9j*2*.*6ToToken2 *i(*j**6rate2)2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*æ	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule422 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*À<{
			*«ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ıC
*Ì<*Ë«return *Ÿ*4(2
					  *ò*6Rule422 *¸i(*j**6name2, *¡j*∏*≥*26*6	nodeIndex*4.*6GetElementsByType2 *{i(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *(j*!*0"FXAverageRateOption"B2)2, *j**6errorHandler2)2
					*4&amp;2 *ê*6Rule422 *¸i(*j**6name2, *¡j*∏*≥*26*6	nodeIndex*4.*6GetElementsByType2 *{i(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *(j*!*0"FxAverageRateOption"B2)2, *j**6errorHandler2)*4)2;2

			*ı«return *‡*4(2
				  *¡*6Rule422 *≠i(*j**6name2, *sj*k*g*26*6	nodeIndex*4.*6GetElementsByName2 */i(*(j*!*0"fxAverageRateOption"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*®*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule422 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*∏<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*´Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *¡<{
				*Ê*⁄*9*6XmlNodeList2	*6nodes2	*¨= *£*û*"6*	6XPath*4.*	6Paths2 *vi(*j**6context2, *0j*(*$0"averageRateObservationDate"B2, *$j**0"observationDate"B2)2;2
				*]*R*9*6int2			*6limit2	*+= *#*6*	6nodes*4.*	6Count2;2
				*Å*v*9*6*6Date2 *>[]2		*6dates2	*@= *8*
4new2 *(6*6Date2 *>[**	6limit2]2;2
				*Õùfor *†(*?*8*9*6int2 *6count2 *= **00B 2;2 *2;*+*6count2 *4&lt;2 *	6limit2;2 *	**4++*	6count2)2
					*ó<*í*ç*,6*6dates2 *>[**	6count2]2 *4=2 *N*6ToDate2 *;i(*4j*-*)6*6nodes2 *>[**	6count2]2)2;2
				*„ùfor *ø(*?*8*9*6int2 *6outer2 *= **00B 2;2 *V;*O*6outer2 *4&lt;2 *4(*6limit2 *4-2 *01B *4)2;2 *	**4++*	6outer2)2 *é<{
					*Äùfor *≥(*W*P*9*6int2 *6inner2 *+= *#*6outer2 *4+2 *01B 2;2 *2;*+*6inner2 *4&lt;2 *	6limit2;2 *	**4++*	6inner2)2 *∫<{
						*Ùûif *î;(*å*Ñ*6Equal2 *ri(*5j*-*)6*6dates2 *>[**	6outer2]2, *4j*-*)6*6dates2 *>[**	6inner2]2)2)*»C
							*π<*¥*Ø*ß*6errorHandler2 *çi(*j**0"305"B2, *>j*-*)6*6nodes2 *>[**	6inner2]2,
									*9j*(*$0"Duplicate observation date"B2,
									*j**6name2, *Zj*S*O*6ToToken2 *;i(*4j*-*)6*6nodes2 *>[**	6inner2]2)2)2;2

						*5*-*6result2 *4=2 *0falseB2;2
}2
}2
				*3*+*6dates2 *4=2 *0nullB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*æ	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule432 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*À<{
			*«ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ıC
*Ì<*Ë«return *Ÿ*4(2
					  *ò*6Rule432 *¸i(*j**6name2, *¡j*∏*≥*26*6	nodeIndex*4.*6GetElementsByType2 *{i(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *(j*!*0"FXAverageRateOption"B2)2, *j**6errorHandler2)2
					*4&amp;2 *ê*6Rule432 *¸i(*j**6name2, *¡j*∏*≥*26*6	nodeIndex*4.*6GetElementsByType2 *{i(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *(j*!*0"FxAverageRateOption"B2)2, *j**6errorHandler2)*4)2;2

			*ı«return *‡*4(2
				  *¡*6Rule432 *≠i(*j**6name2, *sj*k*g*26*6	nodeIndex*4.*6GetElementsByName2 */i(*(j*!*0"fxAverageRateOption"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*“*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule432 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*‚	<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*’Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *Î<{
				*”*«*9*6
XmlElement2	*6ccy12	*õ= *í*ç*!6*	6XPath*4.*6Path2 *fi(*j**6context2, *'j**0"putCurrencyAmount"B2, *j**0
"currency"B2)2;2
				*‘*»*9*6
XmlElement2	*6ccy22	*ú= *ì*é*!6*	6XPath*4.*6Path2 *gi(*j**6context2, *(j* *0"callCurrencyAmount"B2, *j**0
"currency"B2)2;2
				*ìûif *Â;(*›*4(*6ccy12 *	4==2 *0nullB*4)2 *	4||2 *4(*6ccy22 *	4==2 *0nullB*4)2 *	4||2 *4!*K*6IsSameCurrency2 *0i(*j**6ccy12, *j**6ccy22)2)*C *<*ö	continue;2

				*‰*ÿ*–*6errorHandler2 *∂i(*j**0"305"B2, *j**6context2,
						*Fj*8*40,"Put and call currencies must be different."B2,
						*j**6name2, *j**0nullB2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*æ	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule442 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*À<{
			*«ûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ıC
*Ì<*Ë«return *Ÿ*4(2
					  *ò*6Rule442 *¸i(*j**6name2, *¡j*∏*≥*26*6	nodeIndex*4.*6GetElementsByType2 *{i(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *(j*!*0"FXAverageRateOption"B2)2, *j**6errorHandler2)2
					*4&amp;2 *ê*6Rule442 *¸i(*j**6name2, *¡j*∏*≥*26*6	nodeIndex*4.*6GetElementsByType2 *{i(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *(j*!*0"FxAverageRateOption"B2)2, *j**6errorHandler2)*4)2;2

			*ı«return *‡*4(2
				  *¡*6Rule442 *≠i(*j**6name2, *sj*k*g*26*6	nodeIndex*4.*6GetElementsByName2 */i(*(j*!*0"fxAverageRateOption"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*™*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule442 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*∫<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*≠Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *√<{
				*¥*®*9*6
XmlElement2	*6buyer2	 *{= *s*o*!6*	6XPath*4.*6Path2 *Hi(*j**6context2, *(j*!*0"buyerPartyReference"B2)2;2
				*∂*™*9*6
XmlElement2	*6seller2	 *|= *t*p*!6*	6XPath*4.*6Path2 *Ii(*j**6context2, *)j*"*0"sellerPartyReference"B2)2;2
				*ﬁ*“*9*6
XmlElement2	*6payer2	 *§= *õ*ñ*!6*	6XPath*4.*6Path2 *oi(*j**6context2, *%j**0"fxOptionPremium"B2, *(j*!*0"payerPartyReference"B2)2;2
				*„*◊*9*6
XmlElement2	*6receiver2 *ß= *û*ô*!6*	6XPath*4.*6Path2 *ri(*j**6context2, *%j**0"fxOptionPremium"B2, *+j*$* 0"receiverPartyReference"B2)2;2
				*¡ûif *î;(*å*4(*6buyer2 *	4==2 *0nullB*4)2 *	4||2 *4(*6seller2 *	4==2 *0nullB*4)2 *4||2
					*4(*6payer2 *	4==2 *0nullB*4)2 *	4||2 *4(*6receiver2 *	4==2 *0nullB*4)2)*C *<*ö	continue;2
				*Çûif *‘;(*Ã*‘*6Equal2 *æi(*[j*S*O*)6*	6buyer*4.*6GetAttribute2 * i(*j**0"href"B2)2, *Zj*S*O*)6*	6payer*4.*6GetAttribute2 * i(*j**0"href"B2)2)2 *4
&amp;&amp;2
					*’*6Equal2 *¬i(*\j*T*P**6*
6seller*4.*6GetAttribute2 * i(*j**0"href"B2)2, *]j*V*R*,6*6receiver*4.*6GetAttribute2 * i(*j**0"href"B2)2)2)*C *<*ö	continue;2

				*ˇ*Ú*Í*6errorHandler2 *–i(*j**0"305"B2, *j**6context2,
						*`j*R*N0F"Premium payer and receiver don't match with option buyer and seller."B2,
						*j**6name2, *j**0nullB2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*≤	*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule452 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*ø<{
			*øûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ÌC
*Â<*‡«return *—*4(2
					  *î*6Rule452 *¯i(*j**6name2, *Ωj*¥*Ø*26*6	nodeIndex*4.*6GetElementsByType2 *wi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *$j**0"FXDigitalOption"B2)2, *j**6errorHandler2)2
					*4&amp;2 *å*6Rule452 *¯i(*j**6name2, *Ωj*¥*Ø*26*6	nodeIndex*4.*6GetElementsByType2 *wi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *$j**0"FxDigitalOption"B2)2, *j**6errorHandler2)*4)2;2

			*Ò«return *‹*4(2
				  *Ω*6Rule452 *©i(*j**6name2, *oj*g*c*26*6	nodeIndex*4.*6GetElementsByName2 *+i(*$j**0"fxDigitalOption"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*ù*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule452 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*≠<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*†Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *∑<{
				*¥*®*9*6
XmlElement2	*6buyer2	 *{= *s*o*!6*	6XPath*4.*6Path2 *Hi(*j**6context2, *(j*!*0"buyerPartyReference"B2)2;2
				*∂*™*9*6
XmlElement2	*6seller2	 *|= *t*p*!6*	6XPath*4.*6Path2 *Ii(*j**6context2, *)j*"*0"sellerPartyReference"B2)2;2
				*ﬁ*“*9*6
XmlElement2	*6payer2	 *§= *õ*ñ*!6*	6XPath*4.*6Path2 *oi(*j**6context2, *%j**0"fxOptionPremium"B2, *(j*!*0"payerPartyReference"B2)2;2
				*„*◊*9*6
XmlElement2	*6receiver2 *ß= *û*ô*!6*	6XPath*4.*6Path2 *ri(*j**6context2, *%j**0"fxOptionPremium"B2, *+j*$* 0"receiverPartyReference"B2)2;2
				*¡ûif *î;(*å*4(*6buyer2 *	4==2 *0nullB*4)2 *	4||2 *4(*6seller2 *	4==2 *0nullB*4)2 *4||2
					*4(*6payer2 *	4==2 *0nullB*4)2 *	4||2 *4(*6receiver2 *	4==2 *0nullB*4)2)*C *<*ö	continue;2
				*ˆûif *»;(*¿*Œ*6Equal2 *∏i(*Xj*P*L*&6*	6buyer*4.*6GetAttribute* i(*j**0"href"B2)2, *Wj*P*L*&6*	6payer*4.*6GetAttribute* i(*j**0"href"B2)2)2 *4
&amp;&amp;2
					*œ*6Equal2 *ºi(*Yj*Q*M*'6*
6seller*4.*6GetAttribute* i(*j**0"href"B2)2, *Zj*S*O*)6*6receiver*4.*6GetAttribute* i(*j**0"href"B2)2)2)*C *<*ö	continue;2

				*ˇ*Ú*Í*6errorHandler2 *–i(*j**0"305"B2, *j**6context2,
						*`j*R*N0F"Premium payer and receiver don't match with option buyer and seller."B2,
						*j**6name2, *j**0nullB2)2;2

				*5*-*6result2 *4=2 *0falseB2;2
}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*˚*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule462 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*à<{
			*çûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ºC
				*∞<*´«return *ú*4(*Ü*6Rule462 *Úi(*j**6name2, *∑j*Æ*©*26*6	nodeIndex*4.*6GetElementsByType2 *qi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"SideRates"B2)2, *j**6errorHandler2)*4)2;2
			*Ï«return *◊*4(2
					  *∑*6Rule462 *£i(*j**6name2, *ij*a*]*26*6	nodeIndex*4.*6GetElementsByName2 *%i(*j**0"sideRates"B2)2, *j**6errorHandler2)*4)2;2
		}2

		*ë*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule462 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*°
<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*î	Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *™<{
				*Ÿ*Õ*9*6
XmlElement2	*6basis2	*†= *ó*í*!6*	6XPath*4.*6Path2 *ki(*j**6context2, *'j**0"currency1SideRate"B2, *"j**0"sideRateBasis"B2)2;2
				*ﬁûif *∞;(*®*4(*6basis2 *	4==2 *0nullB*4)2 *4||2
					*/*6ToToken2 *i(*j**	6basis2)*4.**6ToUpper2 *i()*4.*J*6Equals2 *4i(*-j*&*"0"CURRENCY1PERBASECURRENCY"B2)2 *4||2
					*/*6ToToken2 *i(*j**	6basis2)*4.**6ToUpper2 *i()*4.*G*6Equals2 *4i(*-j*&*"0"BASECURRENCYPERCURRENCY1"B2)2)*C *<*ö	continue;2

				*©*ù*ï*6errorHandler2 *˚i(*j**0"305"B2, *j**6context2,
						*hj*Z*V0N"Side rate basis for currency1 should not be expressed in terms of currency2."B2,
						*j**6name2, *:j*3*/*6ToToken2 *i(*j**	6basis2)2)2;2
				*5*-*6result2 *4=2 *0falseB2;2
}2

			*3«return **4(*
6result*4)2;2
		}2

		*PG// --------------------------------------------------------------------2
		*˚*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule472 *§e(*'f**9*
6string2 *6name2, */f*'*9*6	NodeIndex2 *6	nodeIndex2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*â<{
			*éûif *>;(*7*06*6	nodeIndex*4.*6HasTypeInformation2)*ºC
				*∞<*´«return *ú*4(*Ü*6Rule472 *Úi(*j**6name2, *∑j*Æ*©*26*6	nodeIndex*4.*6GetElementsByType2 *qi(*Jj*B*>*6DetermineNamespace2 *i(*j**6	nodeIndex2)2, *j**0"SideRates"B2)2, *j**6errorHandler2)*4)2;2

			*Ï«return *◊*4(2
					  *∑*6Rule472 *£i(*j**6name2, *ij*a*]*26*6	nodeIndex*4.*6GetElementsByName2 *%i(*j**0"sideRates"B2)2, *j**6errorHandler2)*4)2;2
		}2
		*ï*ÿprivate2 *ÿstatic2 *9*6bool2 *6Rule472 *°e(*'f**9*
6string2 *6name2, *,f*$*9*6XmlNodeList2 *6list2, *>f*7*!9*6ValidationErrorHandler2 *6errorHandler2)2
		*•
<{
			*J*@*9*6bool2		*6result2	*= **0trueB2;2
			*ò	Äforeach *Q(*G*@*9*6
XmlElement2 *6context2 *Vin **6list2)2 *Ø<{
				*⁄*Õ*9*6
XmlElement2	*6basis2	*†= *ó*í*!6*	6XPath*4.*6Path2 *ki(*j**6context2, *'j**0"currency2SideRate"B2, *"j**0"sideRateBasis"B2)2;2

				*ﬁûif *∞;(*®*4(*6basis2 *	4==2 *0nullB*4)2 *4||2
					*/*6ToToken2 *i(*j**	6basis2)*4.**6ToUpper2 *i()*4.*J*6Equals2 *4i(*-j*&*"0"CURRENCY2PERBASECURRENCY"B2)2 *4||2
					*/*6ToToken2 *i(*j**	6basis2)*4.**6ToUpper2 *i()*4.*G*6Equals2 *4i(*-j*&*"0"BASECURRENCYPERCURRENCY2"B2)2)*C *<*ö	continue;2

				*™*ù*ï*6errorHandler2 *˚i(*j**0"305"B2, *j**6context2,
						*hj*Z*V0N"Side rate basis for currency2 should not be expressed in terms of currency1."B2,
						*j**6name2, *:j*3*/*6ToToken2 *i(*j**	6basis2)2)2;2

				*8*-*6result2 *4=2 *0falseB2;2
			}2
			*3«return **4(*
6result*4)2;2
		}2

		*QG// --------------------------------------------------------------------2

		*/// &lt;summary&gt;2
		*TK/// Generates a set of dates according to schedule defined by a start date,2
		*F=/// an end date, an interval, roll convention and a calendar.2
		*/// &lt;/summary&gt;2
		*D;/// &lt;param name="start"&gt;The start date.&lt;/param&gt;2
		*@7/// &lt;param name="end"&gt;The end date.&lt;/param&gt;2
		*aX/// &lt;param name="frequency"&gt;The frequency of the schedule (e.g. 6M).&lt;/param&gt;2
		*h_/// &lt;param name="roll"&gt;The date roll convention or &lt;c&gt;null&lt;/c&gt;.&lt;/param&gt;2
		*h_/// &lt;param name="calendar"&gt;The holiday calendar or &lt;c&gt;null&lt;/c&gt;.&lt;/param&gt;2
		*VM/// &lt;returns&gt;An array of calculated and adjusted dates.&lt;/returns&gt;2
		*æ*ÿprivate2 *ÿstatic2 *9*6*6Date2 *>[]2 *6GenerateSchedule2 *‰e(*&f**9*6Date2 *	6start2, *'f**9*6Date2 *6end2,
			*.f*&*9*6Interval2 *6	frequency2, *)f*!*9*6DateRoll2 *6roll2, *,f*%*9*6Calendar2 *6calendar2)2
		*Ò<{
			*H*>*9*6Date2		*6current2 *= **	6start2;2
			*i*_*9*6	ArrayList2	*6found2	*4= *,*
4new2 **6	ArrayList2 *i()2;2
			*;*1*9*6*6Date2 *>[]2		*	6dates2;2
			*ç	õwhile *T;(*J*C*6Less2 *2i(*j**6current2, *j**6end2)2)2 *¢<{
				*1*%*9*6Date2		*6adjusted2;2

				*≠ûif *2;(*+*6roll2 *	4!=2 *0nullB2)*üC
					*ã<*Ü*Å*6adjusted2 *4=2 *_*"6*6roll*4.*
6Adjust2 *7i(*j**6calendar2, *j**6current2)2;2
				*ED
else
					*5<*1*-*6adjusted2 *4=2 *6current2;2

				*—ûif *^;(*W*4!*I*%6*	6found*4.*6Contains2 *i(*j**6adjusted2)2)*_C
					*S<*O*K*D* 6*	6found*4.*6Add2 *i(*j**6adjusted2)2;2

				*ﬁûif *a;(*Z*'6*6	frequency*4.*
6Period2 *	4==2 *6*
6Period*4.*6TERM2)*ËC *›<{
					*œûif *T;(*M*F*6Equal2 *4i(*j**6current2, *j**	6start2)2)*EC
						*0<*,*(*6current2 *4=2 *6end2;2
					* Delse
						*<*ôbreak;2
				}2
*ÅD
else
					*q<*m*i*6current2 *4=2 *H*#6*6current*4.*6Plus2 *i(*j**6	frequency2)2;2
}2

			*±*¶*û*#6*	6found*4.*
6CopyTo2 *ui(*nj*g*6dates2  *4=2 *
4new2 *>6*6Date2 *->[*&*6*	6found*4.*	6Count2]2)2;2
			*0«return **4(*	6dates*4)2;2
}2
}
}
:
test.cs0.9.5