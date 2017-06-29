
Ω@ 2dï
namespace )2D6	
return (26	HandCoded24.26FpML24.26
Validation2
6result2ı;
}
		2XG// --------------------------------------------------------------------
		private 2

		2ÿstatic 29 26bool26Rule02 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2é<{
			2ëûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2øC
				2≥<2Æ«return 2ü;24(2â26Rule02 2ıi(2j, 226name2∫j, 2±2¨226 26	nodeIndex24.26GetElementsByType2ti(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2!j)220"ExchangeRate"B2j)226errorHandler24)2Ó«return 
		}2Ÿ;24(
				  2∫26Rule02 2¶i(2j, 226name2lj, 2d2`226 26	nodeIndex24.26GetElementsByName2(i(2!j)220"exchangeRate"B2j)226errorHandler24)2Õ


		2ÿprivate 2ÿstatic 29 26bool26Rule02 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2›<{
			2J
			2@;29		26bool26result	2= 220trueB2–Äforeach 
			2Q( 2G)2@29	26
XmlElement26context 2Vin 226list2Á<{
				2∞
				2§;29 	26
XmlElement26forward 2u= 2m2i2!6 2	6XPath24.26Path2Bi(2j, 226context2"j)220"forwardPoints"B2ß
				2õ;29	26
XmlElement26spot	2p= 2h2d2!6 2	6XPath24.26Path2=i(2j, 226context2j)220
"spotRate"B2–ûif 
				2£;(2õ)24!24(24(26forward 2	4!= 20nullB24) 24
&amp;&amp; 24(26spot 2	4== 20nullB24)24)2C 2<2ö	continue;2Û

				2Ê;2ﬁ26errorHandler 2ƒi(2j, 220"305"B2j,
						226context2Tj,
						2F2B0:"If forwardPoints exists then spotRate should also exist."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2Ä

		2ÿprivate 2ÿstatic 29 26bool26Rule03 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ç<{
			2êûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2øC
				2≥<2Æ«return 2ü;24(2â26Rule03 2ıi(2j, 226name2∫j, 2±2¨226 26	nodeIndex24.26GetElementsByType2ti(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2!j)220"ExchangeRate"B2j)226errorHandler24)2Ó«return 
		}2Ÿ;24(
				  2∫26Rule03 2¶i(2j, 226name2lj, 2d2`226 26	nodeIndex24.26GetElementsByName2(i(2!j)220"exchangeRate"B2j)226errorHandler24)2œ

		2ÿprivate 2ÿstatic 29 26bool26Rule03 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ﬂ<{
			2J
			2@;29		26bool26result	2= 220trueB2“Äforeach 
			2Q( 2G)2@29	26
XmlElement26context 2Vin 226list2È
<{
				2∞
				2§;29 	26
XmlElement26forward 2u= 2m2i2!6 2	6XPath24.26Path2Bi(2j, 226context2"j)220"forwardPoints"B2ß
				2õ;29	26
XmlElement26spot	2p= 2h2d2!6 2	6XPath24.26Path2=i(2j, 226context2j)220
"spotRate"B2£
				2ó;29	26
XmlElement26rate	2l= 2d2`2!6 2	6XPath24.26Path29i(2j, 226context2j)220"rate"B2ıûif 
				2»;(2¿)24(26rate 2	4== 20nullB24) 2	4|| 24(26forward 2	4== 20nullB24) 2	4|| 24(26spot 2	4== 20nullB24)2C 2<2ö	continue;2îûif 

				2·;(2Ÿ)2026	ToDecimal 2i(2j)226rate24.2ò26Equals 2Ñi(2}j)2v23 26	ToDecimal 2i(2j)226spot24+ 2326	ToDecimal 2i(2j)226forward2C
					2<2ö	continue;2ì

				2Ü;2˛26errorHandler 2‰i(2j, 220"305"B2j,
						226context2Rj,
						2D2@08"Sum of spotRate and forwardPoints does not equal rate."B2j, 226name29j)222.26ToToken 2i(2j)226rate25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2Ä

		2ÿprivate 2ÿstatic 29 26bool26Rule04 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ç<{
			2êûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2øC
				2≥<2Æ«return 2ü;24(2â26Rule04 2ıi(2j, 226name2∫j, 2±2¨226 26	nodeIndex24.26GetElementsByType2ti(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2!j)220"ExchangeRate"B2j)226errorHandler24)2Ó«return 
		}2Ÿ;24(
				  2∫26Rule04 2¶i(2j, 226name2lj, 2d2`226 26	nodeIndex24.26GetElementsByName2(i(2!j)220"exchangeRate"B2j)226errorHandler24)2ù

		2ÿprivate 2ÿstatic 29 26bool26Rule04 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2≠<{
			2K

			2@;29		26bool26result	2= 220trueB2üÄforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2∂<{
				2”
				2«;29 	26
XmlElement26baseCcy 2ó= 2é2â2!6 2	6XPath24.26Path2bi(2j, 226context2j, 220"sideRates"B2!j)220"baseCurrency"B2’
				2…;29	26
XmlElement26ccy1	2ù= 2î2è2!6 2	6XPath24.26Path2hi(2j, 226context2(j, 2 20"quotedCurrencyPair"B2j)220"currency1"B2÷

				2…;29	26
XmlElement26ccy2	2ù= 2î2è2!6 2	6XPath24.26Path2hi(2j, 226context2(j, 2 20"quotedCurrencyPair"B2j)220"currency2"B2ˆûif 

				2»;(2¿)24(26baseCcy 2	4== 20nullB24) 2	4|| 24(26ccy2 2	4== 20nullB24) 2	4|| 24(26ccy2 2	4== 20nullB24)2C 2<2ö	continue;2©ûif 
}2©;(2°)2H 26Equal 23i(2j, 226baseCcy2j)226ccy12	4|| 2E26Equal 23i(2j, 226baseCcy2j)226ccy22ÓC 2Ê<{
					2°
2ô;2ë26errorHandler 2˜i(2j, 220"305"B2j	,
							226context2aj	,
							2R2N0F"The side rate base currency must not be one of the trade currencies."B2j, 226name2<j)252126ToToken 2i(2j)226baseCcy25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2Ä

		2ÿprivate 2ÿstatic 29 26bool26Rule05 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ç<{
			2êûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2øC
				2≥<2Æ«return 2ü;24(2â26Rule05 2ıi(2j, 226name2∫j, 2±2¨226 26	nodeIndex24.26GetElementsByType2ti(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2!j)220"ExchangeRate"B2j)226errorHandler24)2Ó«return 
		}2Ÿ;24(
				  2∫26Rule05 2¶i(2j, 226name2lj, 2d2`226 26	nodeIndex24.26GetElementsByName2(i(2!j)220"exchangeRate"B2j)226errorHandler24)2∞

		2ÿprivate 2ÿstatic 29 26bool26Rule05 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2¿<{
			2K

			2@;29		26bool26result	2= 220trueB2≤
Äforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2…	<{
				2’
				2…;29	26
XmlElement26ccy		2ù= 2î2è2!6 2	6XPath24.26Path2hi(2j, 226context2(j, 2 20"quotedCurrencyPair"B2j)220"currency1"B2˜
				2Î;29 	26
XmlElement26ccy1 	2Ω= 2¥2Ø2!6 2	6XPath24.26Path2ái(2j, 226context2j, 220"sideRates"B2'j, 220"currency1SideRate"B2j)220
"currency"B2Äûif 
				2”;(2À)24(2
6ccy 2	4== 20nullB24) 2	4|| 24(26ccy1 2	4== 20nullB24) 2	4|| 2A26Equal 2/i(2j, 226ccy2j)226ccy12C 2<2ö	continue;2∞

				2£;2õ26errorHandler 2Åi(2j, 220"305"B2j,
						226context2êj,
						2Å2&0"The side rate currency1 '" B24+ 21 26ToToken 2i(2j)226ccy124+
						240)"' must be the same as trade currency1 '" B24+ 20 26ToToken 2i(2j)226ccy24+ 20"'."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2Ä

		2ÿprivate 2ÿstatic 29 26bool26Rule06 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ç<{
			2êûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2øC
				2≥<2Æ«return 2ü;24(2â26Rule06 2ıi(2j, 226name2∫j, 2±2¨226 26	nodeIndex24.26GetElementsByType2ti(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2!j)220"ExchangeRate"B2j)226errorHandler24)2Ó«return 
		}2Ÿ;24(
				  2∫26Rule06 2¶i(2j, 226name2lj, 2d2`226 26	nodeIndex24.26GetElementsByName2(i(2!j)220"exchangeRate"B2j)226errorHandler24)2≤

		2ÿprivate 2ÿstatic 29 26bool26Rule06 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2¬<{
			2K

			2@;29		26bool26result	2= 220trueB2¥
Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2 	<{
				2’
				2…;29	26
XmlElement26ccy		2ù= 2î2è2!6 2	6XPath24.26Path2hi(2j, 226context2(j, 2 20"quotedCurrencyPair"B2j)220"currency2"B2˜
				2Î;29 	26
XmlElement26ccy1 	2Ω= 2¥2Ø2!6 2	6XPath24.26Path2ái(2j, 226context2j, 220"sideRates"B2'j, 220"currency2SideRate"B2j)220
"currency"B2Åûif 

				2”;(2À)24(2
6ccy 2	4== 20nullB24) 2	4|| 24(26ccy1 2	4== 20nullB24) 2	4|| 2A26Equal 2/i(2j, 226ccy2j)226ccy12C 2<2ö	continue;2∞

				2£;2õ26errorHandler 2Åi(2j, 220"305"B2j,
						226context2êj,
						2Å2&0"The side rate currency2 '" B24+ 21 26ToToken 2i(2j)226ccy124+
						240)"' must be the same as trade currency2 '" B24+ 20 26ToToken 2i(2j)226ccy24+ 20"'."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2∏	

		2ÿprivate 2ÿstatic 29 26bool26Rule07 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2≈<{
			2√ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ÒC
2È<2‰«return 2’;24(
					  2ñ
					26Rule07 2˙i(2j, 226name2øj, 2∂2±226 26	nodeIndex24.26GetElementsByType2yi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2&j)220"FXAmericanTrigger"B2j)226errorHandler24&amp; 2é26Rule07 2˙i(2j, 226name2øj, 2∂2±226 26	nodeIndex24.26GetElementsByType2yi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2&j)220"FxAmericanTrigger"B2j)226errorHandler24)2Û«return 
		}2ﬁ;24(
				  2ø26Rule07 2´i(2j, 226name2qj, 2i2e226 26	nodeIndex24.26GetElementsByName2-i(2&j)220"fxAmericanTrigger"B2j)226errorHandler24)2à	

		2ÿprivate 2ÿstatic 29 26bool26Rule07 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ò<{
			2J
			2@;29		26bool26result	2= 220trueB2ãÄforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2°<{
				2´
				2ü;29		26
XmlElement26rate	2s= 2k2g2!6 2	6XPath24.26Path2@i(2j, 226context2 j)220"triggerRate"B2Øûif 

				2Å;(2z)24(26rate 2	4== 20nullB24) 2	4|| 2126
IsPositive 2i(2j)226rate2C 2<2ö	continue;2˝
				2Ò;2È26errorHandler 2œi(2j, 220"305"B2j,
						226context2=j,
						2/2+0#"The trigger rate must be positive"B2j, 226name29j)222.26ToToken 2i(2j)226rate25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2∏	

		2ÿprivate 2ÿstatic 29 26bool26Rule08 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2≈<{
			2√ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ÒC
2È<2‰«return 2’;24(
					  2ñ
					26Rule08 2˙i(2j, 226name2øj, 2∂2±226 26	nodeIndex24.26GetElementsByType2yi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2&j)220"FXAmericanTrigger"B2j)226errorHandler24&amp; 2é26Rule08 2˙i(2j, 226name2øj, 2∂2±226 26	nodeIndex24.26GetElementsByType2yi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2&j)220"FxAmericanTrigger"B2j)226errorHandler24)2Û«return 
		}2ﬁ;24(
				  2ø26Rule08 2´i(2j, 226name2qj, 2i2e226 26	nodeIndex24.26GetElementsByName2-i(2&j)220"fxAmericanTrigger"B2j)226errorHandler24)2Ì

		2ÿprivate 2ÿstatic 29 26bool26Rule08 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2˝	<{
			2J
			2@;29		26bool26result	2= 220trueB2Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2Ü<{
				2¥
				2®;29	26
XmlElement26start	2|= 2t2p2!6 2	6XPath24.26Path2Ii(2j, 226context2)j)2"20"observationStartDate"B2±
				2•;29	26
XmlElement26end		2z= 2r2n2!6 2	6XPath24.26Path2Gi(2j, 226context2'j)2 20"observationEndDate"B2Ÿûif 

				2´;(2£)24(26start 2	4== 20nullB24) 2	4|| 24(2
6end 2	4== 20nullB24) 24||
					2í26LessOrEqual 2zi(2:j, 222.26ToDate 2i(2j)22	6start27j)202,26ToDate 2i(2j)226end2C 2<2ö	continue;2˚
				2Ô;2Á26errorHandler 2Õi(2j, 220"305"B2j,
						226context2]j,
						2O2K0C"The observationStartDate must not be after the observationEndDate"B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2Â	

		2ÿprivate 2ÿstatic 29 26bool26Rule09 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2Ú<{
			2„ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ëC
2â<2Ñ«return 2ı;24(
					  2¶
					26Rule09 2äi(2j, 226name2œj, 2∆2¡226 26	nodeIndex24.26GetElementsByType2ài(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex25j)2.2*0""FXAverageRateObservationSchedule"B2j)226errorHandler24&amp; 2û26Rule09 2äi(2j, 226name2œj, 2∆2¡226 26	nodeIndex24.26GetElementsByType2ài(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex25j)2.2*0""FxAverageRateObservationSchedule"B2j)226errorHandler24)2Ä«return 
		}2Î;24(
				  2Ã26Rule09 2∏i(2j, 226name2~j, 2v2r226 26	nodeIndex24.26GetElementsByName2:i(23j)2,2(0 "averageRateObservationSchedule"B2j)226errorHandler24)2Ì

		2ÿprivate 2ÿstatic 29 26bool26Rule09 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2˝	<{
			2J
			2@;29		26bool26result	2= 220trueB2Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2Ü<{
				2¥
				2®;29	26
XmlElement26start	2|= 2t2p2!6 2	6XPath24.26Path2Ii(2j, 226context2)j)2"20"observationStartDate"B2±
				2•;29	26
XmlElement26end		2z= 2r2n2!6 2	6XPath24.26Path2Gi(2j, 226context2'j)2 20"observationEndDate"B2Ÿûif 

				2´;(2£)24(26start 2	4== 20nullB24) 2	4|| 24(2
6end 2	4== 20nullB24) 24||
					2í26LessOrEqual 2zi(2:j, 222.26ToDate 2i(2j)22	6start27j)202,26ToDate 2i(2j)226end2C 2<2ö	continue;2˚
				2Ô;2Á26errorHandler 2Õi(2j, 220"305"B2j,
						226context2]j,
						2O2K0C"The observationStartDate must not be after the observationEndDate"B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2Â	

		2ÿprivate 2ÿstatic 29 26bool26Rule10 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2Ú<{
			2„ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ëC
2â<2Ñ«return 2ı;24(
					  2¶
					26Rule10 2äi(2j, 226name2œj, 2∆2¡226 26	nodeIndex24.26GetElementsByType2ài(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex25j)2.2*0""FXAverageRateObservationSchedule"B2j)226errorHandler24&amp; 2û26Rule10 2äi(2j, 226name2œj, 2∆2¡226 26	nodeIndex24.26GetElementsByType2ài(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex25j)2.2*0""FxAverageRateObservationSchedule"B2j)226errorHandler24)2Ä«return 
		}2Î;24(
				  2Ã26Rule10 2∏i(2j, 226name2~j, 2v2r226 26	nodeIndex24.26GetElementsByName2:i(23j)2,2(0 "averageRateObservationSchedule"B2j)226errorHandler24)2≥

		2ÿprivate 2ÿstatic 29 26bool26Rule10 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2√<{
			2J
			2@;29		26bool26result	2= 220trueB2∂Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2Ã
<{
				2¥
				2®;29	26
XmlElement26start	2|= 2t2p2!6 2	6XPath24.26Path2Ii(2j, 226context2)j)2"20"observationStartDate"B2±
				2•;29	26
XmlElement26end		2z= 2r2n2!6 2	6XPath24.26Path2Gi(2j, 226context2'j)2 20"observationEndDate"B2º
				2∞;29	26
XmlElement26period	2Ç= 2z2v2!6 2	6XPath24.26Path2Oi(2j, 226context2/j)2(2$0"calculationPeriodFrequency"B2◊ûif 
				2™;(2¢)24(26start 2	4== 20nullB24) 2	4|| 24(2
6end 2	4== 20nullB24) 2	4|| 24(26period 2	4== 20nullB24) 24||
						2326
ToInterval 2i(2j)22
6period24.2ê26DividesDates2zi(2:j, 222.26ToDate 2i(2j)22	6start27j)202,26ToDate 2i(2j)226end2C 2<2ö	continue;2Ñ
				2¯;226errorHandler 2÷i(2j, 220"305"B2j,
						226context2fj,
						2X2T0L"The observation period is not a multiple of the calculationPeriodFrequency"B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2æ	

		2ÿprivate 2ÿstatic 29 26bool26Rule11 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2À<{
			2«ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ıC
2Ì<2Ë«return 2Ÿ;24(
					  2ò
					26Rule11 2¸i(2j, 226name2¡j, 2∏2≥226 26	nodeIndex24.26GetElementsByType2{i(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2(j)2!20"FXAverageRateOption"B2j)226errorHandler24&amp; 2ê26Rule11 2¸i(2j, 226name2¡j, 2∏2≥226 26	nodeIndex24.26GetElementsByType2{i(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2(j)2!20"FxAverageRateOption"B2j)226errorHandler24)2ı«return 
		}2‡;24(
				  2¡26Rule11 2≠i(2j, 226name2sj, 2k2g226 26	nodeIndex24.26GetElementsByName2/i(2(j)2!20"fxAverageRateOption"B2j)226errorHandler24)2ú

		2ÿprivate 2ÿstatic 29 26bool26Rule11 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2¨<{
			2J
			2@;29		26bool26result	2= 220trueB2üÄforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2µ<{
				2Ÿ
				2Õ;29	26XmlNodeList26nodes	2ü= 2ñ2ë2"6 2	6XPath24.2	6Paths2ii(2j, 226context2#j, 220"observedRates"B2$j)220"observationDate"B2]
				2R;29			26int26limit	2+= 2#262	6nodes24.2	6Count2Ç

				2v;29		2626Date 2>[]26dates	2@= 282
4new 2(626Date 2>[2]2	6limit2Œùfor 

				2†(
					2? 28;29 26int26count 2= 2200B 22; 2+;26count 24&lt; 2	6limit2	)224++2	6count2ó<2í2ç;2,6 26dates 2>[2]2	6count24= 2N26ToDate 2;i(24j)2-2)626nodes 2>[2]2	6count2‚ùfor 
				2ø( 2? 28;29 26int26outer 2= 2200B 2V; 2O;26outer 24&lt; 24(26limit 24- 201B 24)2	)224++2	6outer2ç<{
					2ˇùfor 
}2≥( 2W 2P;29 26int26inner 2+= 2#26outer 24+ 201B 22; 2+;26inner 24&lt; 2	6limit2	)224++2	6inner2π<{
						2Ûûif 
						2î;(2å)2Ñ26Equal 2ri(25j, 2-2)626dates 2>[2]2	6outer24j)2-2)626dates 2>[2]2	6inner2»C
							2π<2¥2Ø;2ß26errorHandler 2çi(2j, 220"305"B2>j,
									2-2)626nodes 2>[2]2	6inner29j,
									2(2$0"Duplicate observation date"B2j, 226name2Zj)2S2O26ToToken 2;i(24j)2-2)626nodes 2>[2]2	6inner25
}2-;26result 24= 20falseB23
}2+;26dates 24= 20nullB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2æ	

		2ÿprivate 2ÿstatic 29 26bool26Rule12 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2À<{
			2«ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ıC
2Ì<2Ë«return 2Ÿ;24(
					  2ò
					26Rule12 2¸i(2j, 226name2¡j, 2∏2≥226 26	nodeIndex24.26GetElementsByType2{i(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2(j)2!20"FXAverageRateOption"B2j)226errorHandler24&amp; 2ê26Rule12 2¸i(2j, 226name2¡j, 2∏2≥226 26	nodeIndex24.26GetElementsByType2{i(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2(j)2!20"FxAverageRateOption"B2j)226errorHandler24)2ı«return 
		}2‡;24(
				  2¡26Rule12 2≠i(2j, 226name2sj, 2k2g226 26	nodeIndex24.26GetElementsByName2/i(2(j)2!20"fxAverageRateOption"B2j)226errorHandler24)2˝

		2ÿprivate 2ÿstatic 29 26bool26Rule12 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ç<{
			2J
			2@;29		26bool26result	2= 220trueB2ÄÄforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2ñ<{
				2¬
				2∂;29	26
XmlElement26schedule	2Ü= 2~2z2!6 2	6XPath24.26Path2Si(2j, 226context23j)2,2(0 "averageRateObservationSchedule"B2cûif 

				26;(2/)26schedule 2	4== 20nullB2C 2<2ö	continue;2µ
				2©;29	26
XmlElement26start	2}= 2u2q2!6 2	6XPath24.26Path2Ji(2j, 226schedule2)j)2"20"observationStartDate"B2≤
				2¶;29	26
XmlElement26end		2{= 2s2o2!6 2	6XPath24.26Path2Hi(2j, 226schedule2'j)2 20"observationEndDate"B2ª
				2Ø;29	26
XmlElement26freq	2É= 2{2w2!6 2	6XPath24.26Path2Pi(2j, 226schedule2/j)2(2$0"calculationPeriodFrequency"B2´

				2û;29	26
XmlElement26roll	2s= 2k2g2!6 2	6XPath24.26Path2@i(2j, 226freq2#j)220"rollConvention"B2µûif 

				2á;(2ˇ)24(26start 2	4== 20nullB24) 2	4|| 24(2
6end 2	4== 20nullB24) 2	4|| 24(26freq 2	4== 20nullB24) 2	4|| 24(26roll 2	4== 20nullB24)2C 2<2ö	continue;2ƒ

				2∑;29 	2626Date 2>[]26dates	2Ä= 2˜2Ú26GenerateSchedule 2‘i(2:j, 222.26ToDate 2i(2j)22	6start2>j,
						202,26ToDate 2i(2j)226end2=j, 252126
ToInterval 2i(2j)226freq2yj, 2q2m2'6 26DateRoll24.26ForName2@i(29j)222.26ToToken 2i(2j)226roll2j)220nullB2⁄

				2Õ;29	26XmlNodeList26nodes	2ü= 2ñ2ë2"6 2	6XPath24.2	6Paths2ii(2j, 226context2#j, 220"observedRates"B2$j)220"observationDate"B2ıÄforeach 
				2S( 2I)2B29 26
XmlElement26observed 2Vin 22	6nodes2â<{
					2q
					2e;29		26Date26date 	 2== 252126ToDate 2i(2j)226observed2L
					2@;29		26bool26found 2= 220falseB2∫Äforeach 

					2J( 2@)2929 26Date26match 2Vin 22	6dates2’<{
						2∆ûif 
					}2Q;(2J)2C26Equal 21i(2j, 226date2j)22	6match2`C 2Y<	{
							29
							2+;26found 24= 20trueB2ôbreak;
}2˝ûif 
}2;(2)24!2	6found2ŒC 2∆<{
						2Ä
						2Ú;2Í26errorHandler 2–i(2j, 220"305"B2 j
,
								226observed2∂j
,
								2•20"Observation date '" B24+ 25 26ToToken 2i(2j)226observed24+	
								2-0%"' does not match with the schedule."B2j, 226name2=j)262226ToToken 2i(2j)226observed25
}2-;26result 24= 20falseB23
}2+;26dates 24= 20nullB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2æ	

		2ÿprivate 2ÿstatic 29 26bool26Rule13 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2À<{
			2«ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ıC
2Ì<2Ë«return 2Ÿ;24(
					  2ò
					26Rule13 2¸i(2j, 226name2¡j, 2∏2≥226 26	nodeIndex24.26GetElementsByType2{i(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2(j)2!20"FXAverageRateOption"B2j)226errorHandler24&amp; 2ê26Rule13 2¸i(2j, 226name2¡j, 2∏2≥226 26	nodeIndex24.26GetElementsByType2{i(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2(j)2!20"FxAverageRateOption"B2j)226errorHandler24)2ı«return 
		}2‡;24(
				  2¡26Rule13 2≠i(2j, 226name2sj, 2k2g226 26	nodeIndex24.26GetElementsByName2/i(2(j)2!20"fxAverageRateOption"B2j)226errorHandler24)2ç

		2ÿprivate 2ÿstatic 29 26bool26Rule13 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ù<{
			2J
			2@;29		26bool26result	2= 220trueB2êÄforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2¶<{
				2È
				2›;29	26XmlNodeList26schedule	2¨= 2£2û2"6 2	6XPath24.2	6Paths2vi(2j, 226context20j, 2(2$0"averageRateObservationDate"B2$j)220"observationDate"B2–
				2ƒ;29			26int26limit		2õ= 2í2çB2B;2> ?24(26schedule 2	4!= 20nullB24)20C 2) 2"626schedule24.2	6Count2D: 2200B 2[ûif 

				2.;(2')26limit 2	4== 200B 2C 2<2ö	continue;2Ç

				2v;29		2626Date 2>[]26dates	2@= 282
4new 2(626Date 2>[2]2	6limit2—ùfor 

				2†(
					2? 28;29 26int26count 2= 2200B 22; 2+;26count 24&lt; 2	6limit2	)224++2	6count2ö<2ï2ê;2,6 26dates 2>[2]2	6count24= 2Q26ToDate 2>i(27j)202,626schedule 2>[2]2	6count2⁄

				2Õ;29	26XmlNodeList26nodes	2ü= 2ñ2ë2"6 2	6XPath24.2	6Paths2ii(2j, 226context2#j, 220"observedRates"B2$j)220"observationDate"B2í
Äforeach 
				2S( 2I)2B29 26
XmlElement26observed 2Vin 22	6nodes2¶	<{
					2q
					2e;29		26Date26date 	 2== 252126ToDate 2i(2j)226observed2L
					2@;29		26bool26found 2= 220falseB2ƒùfor 
					2≤( 2? 28;29 26int26match 2= 2200B 2I; 2B;26match 24&lt; 2 62	6dates24.2
6Length2	)224++2	6match2˚<{
						2Ïûif 
					}2q;(2j)2c26Equal 2Qi(2j, 226date24j)2-2)626dates 2>[2]2	6match2fC 2_<	{
							29
							2+;26found 24= 20trueB2ôbreak;
						}2êûif 
}2;(2)24!2	6found2·C 2Ÿ<{
						2é

						2ˇ;2˜26errorHandler 2›i(2j, 220"305"B2 j
,
								226observed2√j
,
								2≤20"Observation date '" B24+ 25 26ToToken 2i(2j)226observed24+	
								2:02"' does not match with a defined observationDate."B2j, 226name2=j)262226ToToken 2i(2j)226observed2:
					}2-;26result 24= 20falseB23
}2+;26dates 24= 20nullB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2†	

		2ÿprivate 2ÿstatic 29 26bool26Rule14 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2≠<{
			2≥ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2·C
2Ÿ<2‘«return 2≈;24(
					  2é
					26Rule14 2Úi(2j, 226name2∑j, 2Æ2©226 26	nodeIndex24.26GetElementsByType2qi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FXBarrier"B2j)226errorHandler24&amp; 2Ü26Rule14 2Úi(2j, 226name2∑j, 2Æ2©226 26	nodeIndex24.26GetElementsByType2qi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FxBarrier"B2j)226errorHandler24)2Î«return 
		}2÷;24(
				  2∑26Rule14 2£i(2j, 226name2ij, 2a2]226 26	nodeIndex24.26GetElementsByName2%i(2j)220"fxBarrier"B2j)226errorHandler24)2Ì

		2ÿprivate 2ÿstatic 29 26bool26Rule14 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2˝	<{
			2J
			2@;29		26bool26result	2= 220trueB2Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2Ü<{
				2¥
				2®;29	26
XmlElement26start	2|= 2t2p2!6 2	6XPath24.26Path2Ii(2j, 226context2)j)2"20"observationStartDate"B2±
				2•;29	26
XmlElement26end		2z= 2r2n2!6 2	6XPath24.26Path2Gi(2j, 226context2'j)2 20"observationEndDate"B2Ÿûif 

				2´;(2£)24(26start 2	4== 20nullB24) 2	4|| 24(2
6end 2	4== 20nullB24) 24||
					2í26LessOrEqual 2zi(2:j, 222.26ToDate 2i(2j)22	6start27j)202,26ToDate 2i(2j)226end2C 2<2ö	continue;2˚
				2Ô;2Á26errorHandler 2Õi(2j, 220"305"B2j,
						226context2]j,
						2O2K0C"The observationStartDate must not be after the observationEndDate"B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2≤	

		2ÿprivate 2ÿstatic 29 26bool26Rule15 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ø<{
			2øûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ÌC
2Â<2‡«return 2—;24(
					  2î
					26Rule15 2¯i(2j, 226name2Ωj, 2¥2Ø226 26	nodeIndex24.26GetElementsByType2wi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2$j)220"FXBarrierOption"B2j)226errorHandler24&amp; 2å26Rule15 2¯i(2j, 226name2Ωj, 2¥2Ø226 26	nodeIndex24.26GetElementsByType2wi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2$j)220"FxBarrierOption"B2j)226errorHandler24)2Ò«return 
		}2‹;24(
				  2Ω26Rule15 2©i(2j, 226name2oj, 2g2c226 26	nodeIndex24.26GetElementsByName2+i(2$j)220"fxBarrierOption"B2j)226errorHandler24)2Å	

		2ÿprivate 2ÿstatic 29 26bool26Rule15 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ë<{
			2J
			2@;29		26bool26result	2= 220trueB2ÑÄforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2ö<{
				2ß
				2õ;29	26
XmlElement26rate	2p= 2h2d2!6 2	6XPath24.26Path2=i(2j, 226context2j)220
"spotRate"B2Øûif 

				2Å;(2z)24(26rate 2	4== 20nullB24) 2	4|| 2126
IsPositive 2i(2j)226rate2C 2<2ö	continue;2˙
				2Ó;2Ê26errorHandler 2Ãi(2j, 220"305"B2j,
						226context2:j,
						2,2(0 "The spot rate must be positive"B2j, 226name29j)222.26ToToken 2i(2j)226rate25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2≤	

		2ÿprivate 2ÿstatic 29 26bool26Rule16 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ø<{
			2øûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ÌC
2Â<2‡«return 2—;24(
					  2î
					26Rule16 2¯i(2j, 226name2Ωj, 2¥2Ø226 26	nodeIndex24.26GetElementsByType2wi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2$j)220"FXDigitalOption"B2j)226errorHandler24&amp; 2å26Rule16 2¯i(2j, 226name2Ωj, 2¥2Ø226 26	nodeIndex24.26GetElementsByType2wi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2$j)220"FxDigitalOption"B2j)226errorHandler24)2Ò«return 
		}2‹;24(
				  2Ω26Rule16 2©i(2j, 226name2oj, 2g2c226 26	nodeIndex24.26GetElementsByName2+i(2$j)220"fxDigitalOption"B2j)226errorHandler24)2Ä	

		2ÿprivate 2ÿstatic 29 26bool26Rule16 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ê<{
			2J
			2@;29		26bool26result	2= 220trueB2ÉÄforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2ö<{
				2ß
				2õ;29	26
XmlElement26rate	2p= 2h2d2!6 2	6XPath24.26Path2=i(2j, 226context2j)220
"spotRate"B2Øûif 

				2Å;(2z)24(26rate 2	4== 20nullB24) 2	4|| 2126
IsPositive 2i(2j)226rate2C 2<2ö	continue;2˙
				2Ó;2Ê26errorHandler 2Ãi(2j, 220"305"B2j,
						226context2:j,
						2,2(0 "The spot rate must be positive"B2j, 226name29j)222.26ToToken 2i(2j)226rate25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2ª	

		2ÿprivate 2ÿstatic 29 26bool26Rule17 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2»<{
			2∆ûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2ıC
				2È<2‰«return 2’;24(
					  2ñ
					26Rule17 2˙i(2j, 226name2øj, 2∂2±226 26	nodeIndex24.26GetElementsByType2yi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2&j)220"FXEuropeanTrigger"B2j)226errorHandler24&amp; 2é26Rule17 2˙i(2j, 226name2øj, 2∂2±226 26	nodeIndex24.26GetElementsByType2yi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2&j)220"FxEuropeanTrigger"B2j)226errorHandler24)2Û«return 
		}2ﬁ;24(
				  2ø26Rule17 2´i(2j, 226name2qj, 2i2e226 26	nodeIndex24.26GetElementsByName2-i(2&j)220"fxEuropeanTrigger"B2j)226errorHandler24)2ä	

		2ÿprivate 2ÿstatic 29 26bool26Rule17 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ö<{
			2K

			2@;29		26bool26result	2= 220trueB2åÄforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2¢<{
				2´

				2û;29	26
XmlElement26rate	2s= 2k2g2!6 2	6XPath24.26Path2@i(2j, 226context2 j)220"triggerRate"B2Øûif 

				2Å;(2z)24(26rate 2	4== 20nullB24) 2	4|| 2126
IsPositive 2i(2j)226rate2C 2<2ö	continue;2˛

				2Ò;2È26errorHandler 2œi(2j, 220"305"B2j,
						226context2=j,
						2/2+0#"The trigger rate must be positive"B2j, 226name29j)222.26ToToken 2i(2j)226rate25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2ö	

		2ÿprivate 2ÿstatic 29 26bool26Rule18 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ß<{
			2´ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ŸC
2—<2Ã«return 2Ω;24(
					  2ä
					26Rule18 2Ói(2j, 226name2≥j, 2™2•226 26	nodeIndex24.26GetElementsByType2mi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FXLeg"B2j)226errorHandler24&amp; 2Ç26Rule18 2Ói(2j, 226name2≥j, 2™2•226 26	nodeIndex24.26GetElementsByType2mi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FxLeg"B2j)226errorHandler24)2Ì«return 
		}2ÿ;24(
				  2π26Rule18 2•i(2j, 226name2kj, 2c2_226 26	nodeIndex24.26GetElementsByName2'i(2 j)220"fxSingleLeg"B2j)226errorHandler24)2˚

		2ÿprivate 2ÿstatic 29 26bool26Rule18 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ã<{
			2K

			2@;29		26bool26result	2= 220trueB2˝Äforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2î<{
				2‚
				2÷;29	26
XmlElement26ccy1Pay	2ß= 2û2ô2!6 2	6XPath24.26Path2ri(2j, 226context2(j, 2 20"exchangedCurrency1"B2(j)2!20"payerPartyReference"B2Â
				2Ÿ;29	26
XmlElement26ccy1Rec	2™= 2°2ú2!6 2	6XPath24.26Path2ui(2j, 226context2(j, 2 20"exchangedCurrency1"B2+j)2$2 0"receiverPartyReference"B2‚
				2÷;29	26
XmlElement26ccy2Pay	2ß= 2û2ô2!6 2	6XPath24.26Path2ri(2j, 226context2(j, 2 20"exchangedCurrency2"B2(j)2!20"payerPartyReference"B2Ê

				2Ÿ;29	26
XmlElement26ccy2Rec	2™= 2°2ú2!6 2	6XPath24.26Path2ui(2j, 226context2(j, 2 20"exchangedCurrency2"B2+j)2$2 0"receiverPartyReference"B2∆ûif 

				2ò;(2ê)24(26ccy1Pay 2	4== 20nullB24) 2	4|| 24(26ccy1Rec 2	4== 20nullB24) 24||
					24(26ccy2Pay 2	4== 20nullB24) 2	4|| 24(26ccy2Rec 2	4== 20nullB24)2C 2<2ö	continue;2˙ûif 

				2Ã;(2ƒ)2“ 26Equal 2ºi(2Zj, 2R2N2(626ccy1Pay24.26GetAttribute2 i(2j)220"href"B2Yj)2R2N2(626ccy2Rec24.26GetAttribute2 i(2j)220"href"B24
&amp;&amp;
					2œ26Equal 2ºi(2Zj, 2R2N2(626ccy2Pay24.26GetAttribute2 i(2j)220"href"B2Yj)2R2N2(626ccy1Rec24.26GetAttribute2 i(2j)220"href"B2C 2<2ö	continue;2Ô

				2‚;2⁄26errorHandler 2¿i(2j, 220"305"B2j,
						226context2Pj,
						2B2>06"Exchanged currency payers and receivers don't match."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2ù	

		2ÿprivate 2ÿstatic 29 26bool26Rule19 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2™<{
			2Æûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2›C
				2—<2Ã«return 2Ω;24(
					  2ä
					26Rule19 2Ói(2j, 226name2≥j, 2™2•226 26	nodeIndex24.26GetElementsByType2mi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FXLeg"B2j)226errorHandler24&amp; 2Ç26Rule19 2Ói(2j, 226name2≥j, 2™2•226 26	nodeIndex24.26GetElementsByType2mi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FxLeg"B2j)226errorHandler24)2Ì«return 
		}2ÿ;24(
				  2π26Rule19 2•i(2j, 226name2kj, 2c2_226 26	nodeIndex24.26GetElementsByName2'i(2 j)220"fxSingleLeg"B2j)226errorHandler24)2û

		2ÿprivate 2ÿstatic 29 26bool26Rule19 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2Æ
<{
			2K

			2@;29		26bool26result	2= 220trueB2†	Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2∂<{
				2˙
				2Ó;29	26
XmlElement26ccy1	2¬= 2π2¥2!6 2	6XPath24.26Path2åi(2j, 226context2(j, 2 20"exchangedCurrency1"B2#j, 220"paymentAmount"B2j)220
"currency"B2˚

				2Ó;29	26
XmlElement26ccy2	2¬= 2π2¥2!6 2	6XPath24.26Path2åi(2j, 226context2(j, 2 20"exchangedCurrency2"B2#j, 220"paymentAmount"B2j)220
"currency"B2ìûif 

				2Â;(2›)24(26ccy1 2	4== 20nullB24) 2	4|| 24(26ccy2 2	4== 20nullB24) 2	4|| 24!2K26IsSameCurrency 20i(2j, 226ccy12j)226ccy22C 2<2ö	continue;2·
				2’;2Õ26errorHandler 2≥i(2j, 220"305"B2j,
						226context2Cj,
						25210)"Exchanged currencies must be different."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2PG// --------------------------------------------------------------------
		2ö	

		2ÿprivate 2ÿstatic 29 26bool26Rule20 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ß<{
			2´ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ŸC
2—<2Ã«return 2Ω;24(
					  2ä
					26Rule20 2Ói(2j, 226name2≥j, 2™2•226 26	nodeIndex24.26GetElementsByType2mi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FXLeg"B2j)226errorHandler24&amp; 2Ç26Rule20 2Ói(2j, 226name2≥j, 2™2•226 26	nodeIndex24.26GetElementsByType2mi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FxLeg"B2j)226errorHandler24)2Ì«return 
		}2ÿ;24(
				  2π26Rule20 2•i(2j, 226name2kj, 2c2_226 26	nodeIndex24.26GetElementsByName2'i(2 j)220"fxSingleLeg"B2j)226errorHandler24)2Ë

		2ÿprivate 2ÿstatic 29 26bool26Rule20 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2¯	<{
			2J
			2@;29		26bool26result	2= 220trueB2ÎÄforeach 

			2Q( 2G)2@29	26
XmlElement26context 2Vin 226list2Å<{
				2≤
				2¶;29	26
XmlElement26date1	2z= 2r2n2!6 2	6XPath24.26Path2Gi(2j, 226context2'j)2 20"currency1ValueDate"B2≤
				2¶;29	26
XmlElement26date2	2z= 2r2n2!6 2	6XPath24.26Path2Gi(2j, 226context2'j)2 20"currency2ValueDate"B2⁄ûif 

				2¨;(2§)24(26date1 2	4== 20nullB24) 2	4|| 24(26date2 2	4== 20nullB24) 24||
					2ë26NotEqual 2|i(2:j, 222.26ToDate 2i(2j)22	6date129j)222.26ToDate 2i(2j)22	6date22C 2<2ö	continue;2ˆ
				2Í;2‚26errorHandler 2»i(2j, 220"305"B2j,
						226context2Xj,
						2J2F0>"currency1ValueDate and currency2ValueDate must be different."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2ö	

		2ÿprivate 2ÿstatic 29 26bool26Rule21 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ß<{
			2´ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ŸC
2—<2Ã«return 2Ω;24(
					  2ä
					26Rule21 2Ói(2j, 226name2≥j, 2™2•226 26	nodeIndex24.26GetElementsByType2mi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FXLeg"B2j)226errorHandler24&amp; 2Ç26Rule21 2Ói(2j, 226name2≥j, 2™2•226 26	nodeIndex24.26GetElementsByType2mi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FxLeg"B2j)226errorHandler24)2Ì«return 
		}2ÿ;24(
				  2π26Rule21 2•i(2j, 226name2kj, 2c2_226 26	nodeIndex24.26GetElementsByName2'i(2 j)220"fxSingleLeg"B2j)226errorHandler24)2⁄


		2ÿprivate 2ÿstatic 29 26bool26Rule21 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2Í<{
			2J
			2@;29		26bool26result	2= 220trueB2›Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2Û<{
				2¥
				2®;29	26
XmlElement26ndf		2}= 2u2q2!6 2	6XPath24.26Path2Ji(2j, 226context2*j)2#20"nonDeliverableForward"B2”
				2«;29	26
XmlElement26fwd		2õ= 2í2ç2!6 2	6XPath24.26Path2fi(2j, 226context2"j, 220"exchangeRate"B2"j)220"forwardPoints"B2Æûif 

				2Ä;(2y)24(2
6ndf 2	4== 20nullB24) 2	4|| 24(2
6fwd 2	4!= 20nullB24)2C 2<2ö	continue;2Ò
				2Â;2›26errorHandler 2√i(2j, 220"305"B2j,
						226context2Sj,
						2E2A09"Non-deliverable forward does not specify forwardPoints."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2˛


		2ÿprivate 2ÿstatic 29 26bool26Rule22 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ã	<{
			2∑ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ÂC
2›<2ÿ«return 2…;24(
					  2ê
					26Rule22 2Ùi(2j, 226name2πj, 2∞2´226 26	nodeIndex24.26GetElementsByType2si(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2 j)220"FXOptionLeg"B2j)226errorHandler24&amp; 2à26Rule22 2Ùi(2j, 226name2πj, 2∞2´226 26	nodeIndex24.26GetElementsByType2si(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2 j)220"FxOptionLeg"B2j)226errorHandler24)2≈«return 
		}2∞;24(
				  2√
				26Rule22 2®i(2j, 226name2nj, 2f2b226 26	nodeIndex24.26GetElementsByName2*i(2#j)220"fxSimpleOption"B2j)226errorHandler24&amp; 2Ω26Rule22 2©i(2j, 226name2oj, 2g2c226 26	nodeIndex24.26GetElementsByName2+i(2$j)220"fxBarrierOption"B2j)226errorHandler24)2ù
		2ÿprivate 2ÿstatic 29 26bool26Rule22 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2Æ<{
			2J
			2@;29		26bool26result	2= 220trueB2°Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2∑<{
				2¥
				2®;29	26
XmlElement26buyer	 2{= 2s2o2!6 2	6XPath24.26Path2Hi(2j, 226context2(j)2!20"buyerPartyReference"B2∂
				2™;29	26
XmlElement26seller	 2|= 2t2p2!6 2	6XPath24.26Path2Ii(2j, 226context2)j)2"20"sellerPartyReference"B2ﬁ
				2“;29	26
XmlElement26payer	 2§= 2õ2ñ2!6 2	6XPath24.26Path2oi(2j, 226context2%j, 220"fxOptionPremium"B2(j)2!20"payerPartyReference"B2„
				2◊;29	26
XmlElement26receiver 2ß= 2û2ô2!6 2	6XPath24.26Path2ri(2j, 226context2%j, 220"fxOptionPremium"B2+j)2$2 0"receiverPartyReference"B2¬ûif 

				2î;(2å)24(26buyer 2	4== 20nullB24) 2	4|| 24(26seller 2	4== 20nullB24) 24||
					24(26payer 2	4== 20nullB24) 2	4|| 24(26receiver 2	4== 20nullB24)2C 2<2ö	continue;2ˆûif 

				2»;(2¿)2Œ 26Equal 2∏i(2Xj, 2P2L2&62	6buyer24.26GetAttribute2 i(2j)220"href"B2Wj)2P2L2&62	6payer24.26GetAttribute2 i(2j)220"href"B24
&amp;&amp;
					2œ26Equal 2ºi(2Yj, 2Q2M2'62
6seller24.26GetAttribute2 i(2j)220"href"B2Zj)2S2O2)626receiver24.26GetAttribute2 i(2j)220"href"B2C 2<2ö	continue;2˛
				2Ú;2Í26errorHandler 2–i(2j, 220"305"B2j,
						226context2`j,
						2R2N0F"Premium payer and receiver don't match with option buyer and seller."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2˛


		2ÿprivate 2ÿstatic 29 26bool26Rule23 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ã	<{
			2∑ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ÂC
2›<2ÿ«return 2…;24(
					  2ê
					26Rule23 2Ùi(2j, 226name2πj, 2∞2´226 26	nodeIndex24.26GetElementsByType2si(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2 j)220"FXOptionLeg"B2j)226errorHandler24&amp; 2à26Rule23 2Ùi(2j, 226name2πj, 2∞2´226 26	nodeIndex24.26GetElementsByType2si(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2 j)220"FxOptionLeg"B2j)226errorHandler24)2≈«return 
		}2∞;24(
				  2√
				26Rule23 2®i(2j, 226name2nj, 2f2b226 26	nodeIndex24.26GetElementsByName2*i(2#j)220"fxSimpleOption"B2j)226errorHandler24&amp; 2Ω26Rule23 2©i(2j, 226name2oj, 2g2c226 26	nodeIndex24.26GetElementsByName2+i(2$j)220"fxBarrierOption"B2j)226errorHandler24)2“

		2ÿprivate 2ÿstatic 29 26bool26Rule23 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2‚	<{
			2J
			2@;29		26bool26result	2= 220trueB2’Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2Î<{
				2”
				2«;29	26
XmlElement26ccy1	2õ= 2í2ç2!6 2	6XPath24.26Path2fi(2j, 226context2'j, 220"putCurrencyAmount"B2j)220
"currency"B2‘
				2»;29	26
XmlElement26ccy2	2ú= 2ì2é2!6 2	6XPath24.26Path2gi(2j, 226context2(j, 2 20"callCurrencyAmount"B2j)220
"currency"B2ìûif 

				2Â;(2›)24(26ccy1 2	4== 20nullB24) 2	4|| 24(26ccy2 2	4== 20nullB24) 2	4|| 24!2K26IsSameCurrency 20i(2j, 226ccy12j)226ccy22C 2<2ö	continue;2‰
				2ÿ;2–26errorHandler 2∂i(2j, 220"305"B2j,
						226context2Fj,
						28240,"Put and call currencies must be different."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2¨	

		2ÿprivate 2ÿstatic 29 26bool26Rule24 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2π<{
			2ªûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ÈC
2·<2‹«return 2Õ;24(
					  2í
					26Rule24 2ˆi(2j, 226name2ªj, 2≤2≠226 26	nodeIndex24.26GetElementsByType2ui(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2"j)220"FXStrikePrice"B2j)226errorHandler24&amp; 2ä26Rule24 2ˆi(2j, 226name2ªj, 2≤2≠226 26	nodeIndex24.26GetElementsByType2ui(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2"j)220"FxStrikePrice"B2j)226errorHandler24)2Ô«return 
		}2⁄;24(
				  2ª26Rule24 2ßi(2j, 226name2mj, 2e2a226 26	nodeIndex24.26GetElementsByName2)i(2"j)220"fxStrikePrice"B2j)226errorHandler24)2¯

		2ÿprivate 2ÿstatic 29 26bool26Rule24 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2à<{
			2J
			2@;29		26bool26result	2= 220trueB2˚Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2ë<{
				2£
				2ó;29	26
XmlElement26rate	2l= 2d2`2!6 2	6XPath24.26Path29i(2j, 226context2j)220"rate"B2Øûif 

				2Å;(2z)24(26rate 2	4== 20nullB24) 2	4|| 2126
IsPositive 2i(2j)226rate2C 2<2ö	continue;2ı
				2È;2·26errorHandler 2«i(2j, 220"305"B2j,
						226context25j,
						2'2#0"The rate must be positive"B2j, 226name29j)222.26ToToken 2i(2j)226rate25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2ó	

		2ÿprivate 2ÿstatic 29 26bool26Rule25 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2§<{
			2≠ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2€C
2”<2Œ«return 2ø;24(
					  2ã
					26Rule25 2Ôi(2j, 226name2¥j, 2´2¶226 26	nodeIndex24.26GetElementsByType2ni(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FXSwap"B2j)226errorHandler24&amp; 2É26Rule25 2Ôi(2j, 226name2¥j, 2´2¶226 26	nodeIndex24.26GetElementsByType2ni(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FxSwap"B2j)226errorHandler24)2Ë«return 
		}2”;24(
				  2¥26Rule25 2†i(2j, 226name2fj, 2^2Z226 26	nodeIndex24.26GetElementsByName2"i(2j)220"fxSwap"B2j)226errorHandler24)2Ω

		2ÿprivate 2ÿstatic 29 26bool26Rule25 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2Õ<{
			2J
			2@;29		26bool26result	2= 220trueB2¿Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2÷<{
				2¨
				2†;29	26XmlNodeList26legs	2t= 2l2h2"6 2	6XPath24.2	6Paths2@i(2j, 226context2 j)220"fxSingleLeg"B2Åûif 

				2T;(2M)2/ 26Count 2i(2j)226legs24&gt;= 202B 2C 2<2ö	continue;2ﬂ
				2”;2À26errorHandler 2±i(2j, 220"305"B2j,
						226context2Aj,
						232/0'"FX swaps must have at least two legs."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2ó	

		2ÿprivate 2ÿstatic 29 26bool26Rule26 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2§<{
			2≠ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2€C
2”<2Œ«return 2ø;24(
					  2ã
					26Rule26 2Ôi(2j, 226name2¥j, 2´2¶226 26	nodeIndex24.26GetElementsByType2ni(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FXSwap"B2j)226errorHandler24&amp; 2É26Rule26 2Ôi(2j, 226name2¥j, 2´2¶226 26	nodeIndex24.26GetElementsByType2ni(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FxSwap"B2j)226errorHandler24)2Ë«return 
		}2”;24(
				  2¥26Rule26 2†i(2j, 226name2fj, 2^2Z226 26	nodeIndex24.26GetElementsByName2"i(2j)220"fxSwap"B2j)226errorHandler24)2‰

		2ÿprivate 2ÿstatic 29 26bool26Rule26 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2Ù<{
			2J
			2@;29		26bool26result	2= 220trueB2Á
Äforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2˛	<{
				2¨
				2†;29	26XmlNodeList26legs	2t= 2l2h2"6 2	6XPath24.2	6Paths2@i(2j, 226context2 j)220"fxSingleLeg"B2}ûif 
				2Q;(2J)2/ 26Count 2i(2j)226legs2	4!= 202B 2C 2<2ö	continue;2Ê
				2⁄;29 	26
XmlElement26date1	2¨= 2£2û2!6 2	6XPath24.26Path2wi(2Pj, 2H2)6 26legs 2>[2]200B 2	4as 26
XmlElement2j)220"valueDate"B2Á

				2⁄;29 	26
XmlElement26date2	2¨= 2£2û2!6 2	6XPath24.26Path2wi(2Pj, 2H2)6 26legs 2>[2]201B 2	4as 26
XmlElement2j)220"valueDate"B2œûif 

				2°;(2ô)2ë26NotEqual 2|i(2:j, 222.26ToDate 2i(2j)22	6date129j)222.26ToDate 2i(2j)22	6date22C 2<2ö	continue;2Á

				2⁄;2“26errorHandler 2∏i(2j, 220"305"B2j,
						226context2Hj,
						2:260."FX swaps legs must settle on different days."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2å

		2ÿprivate 2ÿstatic 29 26bool26Rule27 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ô<{
			2ñûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2≈C
				2π<2¥«return 2•;24(2è26Rule27 2˚i(2j, 226name2¿j, 2∑2≤226 26	nodeIndex24.26GetElementsByType2zi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2'j)2 20"QuotedCurrencyPair"B2j)226errorHandler24)2Ù«return 
		}2ﬂ;24(
				  2¿26Rule27 2¨i(2j, 226name2rj, 2j2f226 26	nodeIndex24.26GetElementsByName2.i(2'j)2 20"quotedCurrencyPair"B2j)226errorHandler24)2Ó

		2ÿprivate 2ÿstatic 29 26bool26Rule27 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ˇ<{
			2K

			2@;29		26bool26result	2= 220trueB2ÒÄforeach 
			2Q( 2G)2@29	26
XmlElement26context 2Vin 226list2à<{
				2®
				2ú;29	26
XmlElement26ccy1	2q= 2i2e2!6 2	6XPath24.26Path2>i(2j, 226context2j)220"currency1"B2®
				2ú;29	26
XmlElement26ccy2	2q= 2i2e2!6 2	6XPath24.26Path2>i(2j, 226context2j)220"currency2"B2ìûif 

				2Â;(2›)24(26ccy1 2	4== 20nullB24) 2	4|| 24(26ccy2 2	4== 20nullB24) 2	4|| 24!2K26IsSameCurrency 20i(2j, 226ccy12j)226ccy22C 2<2ö	continue;2ÿ

				2À;2√26errorHandler 2©i(2j, 220"305"B2j,
						226context29j,
						2+2'0"Currencies must be different."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2ÿ

		2ÿprivate 2ÿstatic 29 26bool26Rule28 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2Â<{
			2åûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2ªC
				2Ø<2™«return 2õ;24(2Ö26Rule28 2Òi(2j, 226name2∂j, 2≠2®226 26	nodeIndex24.26GetElementsByType2pi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220
"SideRate"B2j)226errorHandler24)2 «return 
		}2µ;24(
				  2∆
				26Rule28 2´i(2j, 226name2qj, 2i2e226 26	nodeIndex24.26GetElementsByName2-i(2&j)220"currency1SideRate"B2j)226errorHandler24&amp; 2ø26Rule28 2´i(2j, 226name2qj, 2i2e226 26	nodeIndex24.26GetElementsByName2-i(2&j)220"currency2SideRate"B2j)226errorHandler24)2¯

		2ÿprivate 2ÿstatic 29 26bool26Rule28 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2à<{
			2J
			2@;29		26bool26result	2= 220trueB2˚Äforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2í<{
				2§
				2ò;29		26
XmlElement26rate	2l= 2d2`2!6 2	6XPath24.26Path29i(2j, 226context2j)220"rate"B2Øûif 

				2Å;(2z)24(26rate 2	4== 20nullB24) 2	4|| 2126
IsPositive 2i(2j)226rate2C 2<2ö	continue;2ı
				2È;2·26errorHandler 2«i(2j, 220"305"B2j,
						226context25j,
						2'2#0"The rate must be positive"B2j, 226name29j)222.26ToToken 2i(2j)226rate25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2ÿ

		2ÿprivate 2ÿstatic 29 26bool26Rule29 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2Â<{
			2åûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2ªC
				2Ø<2™«return 2õ;24(2Ö26Rule29 2Òi(2j, 226name2∂j, 2≠2®226 26	nodeIndex24.26GetElementsByType2pi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220
"SideRate"B2j)226errorHandler24)2 «return 
		}2µ;24(
				  2∆
				26Rule29 2´i(2j, 226name2qj, 2i2e226 26	nodeIndex24.26GetElementsByName2-i(2&j)220"currency1SideRate"B2j)226errorHandler24&amp; 2ø26Rule29 2´i(2j, 226name2qj, 2i2e226 26	nodeIndex24.26GetElementsByName2-i(2&j)220"currency2SideRate"B2j)226errorHandler24)2œ


		2ÿprivate 2ÿstatic 29 26bool26Rule29 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ﬂ<{
			2K

			2@;29		26bool26result	2= 220trueB2—Äforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2Ë<{
				2∞
				2§;29 	26
XmlElement26forward 2u= 2m2i2!6 2	6XPath24.26Path2Bi(2j, 226context2"j)220"forwardPoints"B2ß
				2õ;29	26
XmlElement26spot	2p= 2h2d2!6 2	6XPath24.26Path2=i(2j, 226context2j)220
"spotRate"B2—ûif 

				2£;(2õ)24!24(24(26forward 2	4!= 20nullB24) 24
&amp;&amp; 24(26spot 2	4== 20nullB24)24)2C 2<2ö	continue;2Û

				2Ê;2ﬁ26errorHandler 2ƒi(2j, 220"305"B2j,
						226context2Tj,
						2F2B0:"If forwardPoints exists then spotRate should also exist."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2⁄

		2ÿprivate 2ÿstatic 29 26bool26Rule30 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2Á<{
			2åûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2ªC
				2Ø<2™«return 2õ;24(2Ö26Rule30 2Òi(2j, 226name2∂j, 2≠2®226 26	nodeIndex24.26GetElementsByType2pi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220
"SideRate"B2j)226errorHandler24)2Ã«return 
		}2∑;24(
					  2«
					26Rule30 2´i(2j, 226name2qj, 2i2e226 26	nodeIndex24.26GetElementsByName2-i(2&j)220"currency1SideRate"B2j)226errorHandler24&amp; 2ø26Rule30 2´i(2j, 226name2qj, 2i2e226 26	nodeIndex24.26GetElementsByName2-i(2&j)220"currency2SideRate"B2j)226errorHandler24)2œ

		2ÿprivate 2ÿstatic 29 26bool26Rule30 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ﬂ<{
			2K

			2@;29		26bool26result	2= 220trueB2—Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2Á
<{
				2∞
				2§;29 	26
XmlElement26forward 2u= 2m2i2!6 2	6XPath24.26Path2Bi(2j, 226context2"j)220"forwardPoints"B2ß
				2õ;29	26
XmlElement26spot	2p= 2h2d2!6 2	6XPath24.26Path2=i(2j, 226context2j)220
"spotRate"B2§

				2ó;29	26
XmlElement26rate	2l= 2d2`2!6 2	6XPath24.26Path29i(2j, 226context2j)220"rate"B2ˆûif 

				2»;(2¿)24(26rate 2	4== 20nullB24) 2	4|| 24(26forward 2	4== 20nullB24) 2	4|| 24(26spot 2	4== 20nullB24)2C 2<2ö	continue;2ëûif 

				2ﬁ;(2÷)2026	ToDecimal 2i(2j)226rate24.2ï2
6Equals2Ñi(2}j)2v23 26	ToDecimal 2i(2j)226spot24+ 2326	ToDecimal 2i(2j)226forward2C
					2<2ö	continue;2í
				2Ü;2˛26errorHandler 2‰i(2j, 220"305"B2j,
						226context2Rj,
						2D2@08"Sum of spotRate and forwardPoints does not equal rate."B2j, 226name29j)222.26ToToken 2i(2j)226rate25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2¸

		2ÿprivate 2ÿstatic 29 26bool26Rule31 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2â<{
			2éûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ºC
				2∞<2´«return 2ú;24(2Ü26Rule31 2Úi(2j, 226name2∑j, 2Æ2©226 26	nodeIndex24.26GetElementsByType2qi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"SideRates"B2j)226errorHandler24)2Ï«return 
		}2◊;24(
					  2∑26Rule31 2£i(2j, 226name2ij, 2a2]226 26	nodeIndex24.26GetElementsByName2%i(2j)220"sideRates"B2j)226errorHandler24)2ä

		2ÿprivate 2ÿstatic 29 26bool26Rule31 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ö<{
			2K

			2@;29		26bool26result	2= 220trueB2åÄforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2£<{
				2Ø
				2£;29 	26
XmlElement26baseCcy	2t= 2l2h2!6 2	6XPath24.26Path2Ai(2j, 226context2!j)220"baseCurrency"B2”
				2«;29	26
XmlElement26ccy1	2õ= 2í2ç2!6 2	6XPath24.26Path2fi(2j, 226context2'j, 220"currency1SideRate"B2j)220
"currency"B2‘

				2«;29	26
XmlElement26ccy2	2õ= 2í2ç2!6 2	6XPath24.26Path2fi(2j, 226context2'j, 220"currency2SideRate"B2j)220
"currency"B2€ûif 

				2≠;(2•)24(26baseCcy 2	4== 20nullB24) 2	4|| 24(26ccy1 2	4== 20nullB24) 2	4|| 24(26ccy2 2	4== 20nullB24) 24||
					24(24!2Q 26IsSameCurrency 23i(2j, 226baseCcy2j)226ccy124
&amp;&amp; 24!2N26IsSameCurrency 23i(2j, 226baseCcy2j)226ccy224)2C 2<2ö	continue;2¢

				2ï;2ç26errorHandler 2Ûi(2j, 220"305"B2j,
						226context2^j,
						2P2L0D"The base currency must be different from the side rate currencies."B2j, 226name2<j)252126ToToken 2i(2j)226baseCcy25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2ˇ

		2ÿprivate 2ÿstatic 29 26bool26Rule32 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2å<{
			2èûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2æC
				2≤<2≠«return 2û;24(2à26Rule32 2Ùi(2j, 226name2πj, 2∞2´226 26	nodeIndex24.26GetElementsByType2si(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2 j)220"TermDeposit"B2j)226errorHandler24)2Ó«return 
		}2Ÿ;24(
					  2π26Rule32 2•i(2j, 226name2kj, 2c2_226 26	nodeIndex24.26GetElementsByName2'i(2 j)220"termDeposit"B2j)226errorHandler24)2™

		2ÿprivate 2ÿstatic 29 26bool26Rule32 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2∫<{
			2K

			2@;29		26bool26result	2= 220trueB2¨
Äforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2√	<{
				2∂
				2™;29	26
XmlElement26payer	 2}= 2u2q2!6 2	6XPath24.26Path2Ji(2j, 226context2*j)2#20"initialPayerReference"B2Ω

				2∞;29	26
XmlElement26receiver 2Ä= 2x2t2!6 2	6XPath24.26Path2Mi(2j, 226context2-j)2&2"0"initialReceiverReference"B2µûif 
				2à;(2Ä)24(26payer 2	4== 20nullB24) 2	4|| 24(26receiver 2	4== 20nullB24)2C 2<2ö	continue;2ùûif 
				2;(2Ë)2‡26NotEqual 2 i(2dj,
							  2S2O2)6 2	6payer24.26GetAttribute2 i(2j)220"href"B2]j)2V2R2,6 26receiver24.26GetAttribute2 i(2j)220"href"B2C 2<2ö	continue;2Æ

				2°;2ô26errorHandler 2ˇi(2j, 220"305"B2j,
						226context2Lj,
						2>2:02"The initial payer and receiver must be different"B2j, 226name2Zj)2S2O2)6 2	6payer24.26GetAttribute2 i(2j)220"href"B25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2ˇ

		2ÿprivate 2ÿstatic 29 26bool26Rule33 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2å<{
			2èûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2æC
				2≤<2≠«return 2û;24(2à26Rule33 2Ùi(2j, 226name2πj, 2∞2´226 26	nodeIndex24.26GetElementsByType2si(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2 j)220"TermDeposit"B2j)226errorHandler24)2Ó«return 
		}2Ÿ;24(
					  2π26Rule33 2•i(2j, 226name2kj, 2c2_226 26	nodeIndex24.26GetElementsByName2'i(2 j)220"termDeposit"B2j)226errorHandler24)2˜
		2ÿprivate 2ÿstatic 29 26bool26Rule33 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2à
<{
			2K

			2@;29		26bool26result	2= 220trueB2˙Äforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2ë<{
				2™
				2û;29	26
XmlElement26start	 2q= 2i2e2!6 2	6XPath24.26Path2>i(2j, 226context2j)220"startDate"B2Ø
				2£;29	26
XmlElement26maturity 2t= 2l2h2!6 2	6XPath24.26Path2Ai(2j, 226context2!j)220"maturityDate"B2‹ûif 

				2Æ;(2¶)24(26start 2	4== 20nullB24) 2	4|| 24(26maturity 2	4== 20nullB24) 24||
					2ê26Less 2i(2:j, 222.26ToDate 2i(2j)22	6start2<j)252126ToDate 2i(2j)226maturity2C 2<2ö	continue;2è

				2Ç;2˙26errorHandler 2‡i(2j, 220"305"B2j,
						226context2Jj,
						2<2800"The maturity date must be after the start date"B2j, 226name2=j)262226ToToken 2i(2j)226maturity25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2PG// --------------------------------------------------------------------
		2ˇ

		2ÿprivate 2ÿstatic 29 26bool26Rule34 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2å<{
			2èûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2æC
				2≤<2≠«return 2û;24(2à26Rule34 2Ùi(2j, 226name2πj, 2∞2´226 26	nodeIndex24.26GetElementsByType2si(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2 j)220"TermDeposit"B2j)226errorHandler24)2Ó«return 
		}2Ÿ;24(
					  2π26Rule34 2•i(2j, 226name2kj, 2c2_226 26	nodeIndex24.26GetElementsByName2'i(2 j)220"termDeposit"B2j)226errorHandler24)2±	

		2ÿprivate 2ÿstatic 29 26bool26Rule34 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2¡<{
			2J
			2@;29		26bool26result	2= 220trueB2¥Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2 <{
				2À
				2ø;29	26
XmlElement26amount	2ë= 2à2É2!6 2	6XPath24.26Path2\i(2j, 226context2j, 220"principal"B2j)220"amount"B2≤ûif 
				2Ö;(2~)24(26amount 2	4== 20nullB24) 2	4|| 2326
IsPositive 2i(2j)22
6amount2C 2<2ö	continue;2É
				2˜;2Ô26errorHandler 2’i(2j, 220"305"B2j,
						226context2Aj,
						232/0'"The principal amount must be positive"B2j, 226name2;j)242026ToToken 2i(2j)22
6amount25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2ˇ
		2ÿprivate 2ÿstatic 29 26bool26Rule35 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ç<{
			2êûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2æC
				2≤<2≠«return 2û;24(2à26Rule35 2Ùi(2j, 226name2πj, 2∞2´226 26	nodeIndex24.26GetElementsByType2si(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2 j)220"TermDeposit"B2j)226errorHandler24)2Ó«return 
		}2Ÿ;24(
					  2π26Rule35 2•i(2j, 226name2kj, 2c2_226 26	nodeIndex24.26GetElementsByName2'i(2 j)220"termDeposit"B2j)226errorHandler24)2Ö	

		2ÿprivate 2ÿstatic 29 26bool26Rule35 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ï<{
			2K

			2@;29		26bool26result	2= 220trueB2áÄforeach 
			2Q( 2G)2@29	26
XmlElement26context 2Vin 226list2û<{
				2©

				2ú;29	26
XmlElement26rate	2q= 2i2e2!6 2	6XPath24.26Path2>i(2j, 226context2j)220"fixedRate"B2Øûif 

				2Å;(2z)24(26rate 2	4== 20nullB24) 2	4|| 2126
IsPositive 2i(2j)226rate2C 2<2ö	continue;2¸

				2Ô;2Á26errorHandler 2Õi(2j, 220"305"B2j,
						226context2;j,
						2-2)0!"The fixed rate must be positive"B2j, 226name29j)222.26ToToken 2i(2j)226rate25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2Ú

		2ÿprivate 2ÿstatic 29 26bool26Rule36 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ˇ<{
			2âûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2∏C
				2¨<2ß«return 2ò;24(2Ç26Rule36 2Ói(2j, 226name2≥j, 2™2•226 26	nodeIndex24.26GetElementsByType2mi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"Trade"B2j)226errorHandler24)2Á«return 
		}2“;24(
				  2≥26Rule36 2üi(2j, 226name2ej, 2]2Y226 26	nodeIndex24.26GetElementsByName2!i(2j)220"trade"B2j)226errorHandler24)2©
		2ÿprivate 2ÿstatic 29 26bool26Rule36 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2∫<{
			2K

			2@;29		26bool26result	2= 220trueB2¨
Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2¬	<{
				2‘
				2»;29	26
XmlElement26	tradeDate	 2ñ= 2ç2à2!6 2	6XPath24.26Path2ai(2j, 226context2!j, 220"tradeHeader"B2j)220"tradeDate"B2Ö
				2˘;29	26
XmlElement26
expiryDate	 2∆= 2Ω2∏2!6 2	6XPath24.26Path2êi(2j, 226context2)j, 2!20"fxAverageRateOption"B2$j, 220"expiryDateTime"B2j)220"expiryDate"B2ºûif 

				2é;(2Ü)24(26	tradeDate 2	4== 20nullB24) 2	4|| 24(26
expiryDate 2	4== 20nullB24)2C 2<2ö	continue;2’ûif 

				2ß;(2ü)2ó26Less 2Öi(2>j, 262226ToDate 2i(2j)226	tradeDate2>j)272326ToDate 2 i(2j)226
expiryDate2C 2<2ö	continue;2à

				2˚;2Û26errorHandler 2Ÿi(2j, 220"305"B2j,
						226context2Aj,
						232/0'"Expiry date must be after trade date."B2j, 226name2?j)282426ToToken 2 i(2j)226
expiryDate25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2Û

		2ÿprivate 2ÿstatic 29 26bool26Rule37 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2Ä<{
			2äûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2∏C
				2¨<2ß«return 2ò;24(2Ç26Rule37 2Ói(2j, 226name2≥j, 2™2•226 26	nodeIndex24.26GetElementsByType2mi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"Trade"B2j)226errorHandler24)2Á«return 
		}2“;24(
				  2≥26Rule37 2üi(2j, 226name2ej, 2]2Y226 26	nodeIndex24.26GetElementsByName2!i(2j)220"trade"B2j)226errorHandler24)2¶

		2ÿprivate 2ÿstatic 29 26bool26Rule37 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2∂<{
			2K

			2@;29		26bool26result	2= 220trueB2®
Äforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2ø	<{
				2‘
				2»;29	26
XmlElement26	tradeDate	 2ñ= 2ç2à2!6 2	6XPath24.26Path2ai(2j, 226context2!j, 220"tradeHeader"B2j)220"tradeDate"B2Ç

				2ı;29	26
XmlElement26
expiryDate	 2¬= 2π2¥2!6 2	6XPath24.26Path2åi(2j, 226context2%j, 220"fxBarrierOption"B2$j, 220"expiryDateTime"B2j)220"expiryDate"B2ºûif 

				2é;(2Ü)24(26	tradeDate 2	4== 20nullB24) 2	4|| 24(26
expiryDate 2	4== 20nullB24)2C 2<2ö	continue;2’ûif 

				2ß;(2ü)2ó26Less 2Öi(2>j, 262226ToDate 2i(2j)226	tradeDate2>j)272326ToDate 2 i(2j)226
expiryDate2C 2<2ö	continue;2à

				2˚;2Û26errorHandler 2Ÿi(2j, 220"305"B2j,
						226context2Aj,
						232/0'"Expiry date must be after trade date."B2j, 226name2?j)282426ToToken 2 i(2j)226
expiryDate25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2Û

		2ÿprivate 2ÿstatic 29 26bool26Rule38 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2Ä<{
			2äûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2∏C
				2¨<2ß«return 2ò;24(2Ç26Rule38 2Ói(2j, 226name2≥j, 2™2•226 26	nodeIndex24.26GetElementsByType2mi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"Trade"B2j)226errorHandler24)2Á«return 
		}2“;24(
				  2≥26Rule38 2üi(2j, 226name2ej, 2]2Y226 26	nodeIndex24.26GetElementsByName2!i(2j)220"trade"B2j)226errorHandler24)2§

		2ÿprivate 2ÿstatic 29 26bool26Rule38 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2¥<{
			2K

			2@;29		26bool26result	2= 220trueB2¶
Äforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2Ω	<{
				2‘
				2»;29	26
XmlElement26	tradeDate	 2ñ= 2ç2à2!6 2	6XPath24.26Path2ai(2j, 226context2!j, 220"tradeHeader"B2j)220"tradeDate"B2Å
				2ı;29	26
XmlElement26
expiryDate	 2¬= 2π2¥2!6 2	6XPath24.26Path2åi(2j, 226context2%j, 220"fxDigitalOption"B2$j, 220"expiryDateTime"B2j)220"expiryDate"B2ªûif 
				2é;(2Ü)24(26	tradeDate 2	4== 20nullB24) 2	4|| 24(26
expiryDate 2	4== 20nullB24)2C 2<2ö	continue;2’ûif 

				2ß;(2ü)2ó26Less 2Öi(2>j, 262226ToDate 2i(2j)226	tradeDate2>j)272326ToDate 2 i(2j)226
expiryDate2C 2<2ö	continue;2à

				2˚;2Û26errorHandler 2Ÿi(2j, 220"305"B2j,
						226context2Aj,
						232/0'"Expiry date must be after trade date."B2j, 226name2?j)282426ToToken 2 i(2j)226
expiryDate25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2Ú

		2ÿprivate 2ÿstatic 29 26bool26Rule39 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ˇ<{
			2âûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2∏C
				2¨<2ß«return 2ò;24(2Ç26Rule39 2Ói(2j, 226name2≥j, 2™2•226 26	nodeIndex24.26GetElementsByType2mi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"Trade"B2j)226errorHandler24)2Á«return 
		}2“;24(
				  2≥26Rule39 2üi(2j, 226name2ej, 2]2Y226 26	nodeIndex24.26GetElementsByName2!i(2j)220"trade"B2j)226errorHandler24)2◊

		2ÿprivate 2ÿstatic 29 26bool26Rule39 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2Á<{
			2K

			2@;29		26bool26result	2= 220trueB2ŸÄforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2<{
				2”
				2«;29	26
XmlElement26	tradeDate 2ñ= 2ç2à2!6 2	6XPath24.26Path2ai(2j, 226context2!j, 220"tradeHeader"B2j)220"tradeDate"B2”
				2«;29	26
XmlElement26	valueDate 2ñ= 2ç2à2!6 2	6XPath24.26Path2ai(2j, 226context2!j, 220"fxSingleLeg"B2j)220"valueDate"B2›
				2—;29	26
XmlElement26
value1Date 2ü= 2ñ2ë2!6 2	6XPath24.26Path2ji(2j, 226context2!j, 220"fxSingleLeg"B2'j)2 20"currency1ValueDate"B2ﬁ

				2—;29	26
XmlElement26
value2Date 2ü= 2ñ2ë2!6 2	6XPath24.26Path2ji(2j, 226context2!j, 220"fxSingleLeg"B2'j)2 20"currency2ValueDate"B2ˆûif 
}27;(20)26	tradeDate 2	4!= 20nullB2ÆC 2¶<{
					2Éûif 
					27;(20)26	valueDate 2	4!= 20nullB2∑C 2Ø<{
						2’ûif 
						2¶;(2û)2ñ26Less 2Ñi(2>j, 262226ToDate 2i(2j)226	tradeDate2=j)262226ToDate 2i(2j)226	valueDate2C 2<2ö	continue;2å

						2˝;2ı26errorHandler 2€i(2j, 220"305"B2j
,
								226context2Bj
,
								222.0&"value date must be after trade date."B2j, 226name2>j)272326ToToken 2i(2j)226	valueDate2:
					}2-;26result 24= 20falseB2àûif 

					28;(21)26
value1Date 2	4!= 20nullB2∫C 2≤<{
						2◊ûif 

						2ß;(2ü)2ó26Less 2Öi(2>j, 262226ToDate 2i(2j)226	tradeDate2>j)272326ToDate 2 i(2j)226
value1Date2C 2<2ö	continue;2ç

						2˛;2ˆ26errorHandler 2‹i(2j, 220"305"B2j
,
								226context2Bj
,
								222.0&"value1date must be after trade date."B2j, 226name2?j)282426ToToken 2 i(2j)226
value1Date2:
					}2-;26result 24= 20falseB2áûif 
				}28;(21)26
value2Date 2	4!= 20nullB2∫C 2≤<{
						2◊ûif 

						2ß;(2ü)2ó26Less 2Öi(2>j, 262226ToDate 2i(2j)226	tradeDate2>j)272326ToDate 2 i(2j)226
value2Date2C 2<2ö	continue;2ç

						2˛;2ˆ26errorHandler 2‹i(2j, 220"305"B2j
,
								226context2Bj
,
								222.0&"value2date must be after trade date."B2j, 226name2?j)282426ToToken 2 i(2j)226
value2Date2:
					}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2Û

		2ÿprivate 2ÿstatic 29 26bool26Rule40 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2Ä<{
			2äûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2∏C
				2¨<2ß«return 2ò;24(2Ç26Rule40 2Ói(2j, 226name2≥j, 2™2•226 26	nodeIndex24.26GetElementsByType2mi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"Trade"B2j)226errorHandler24)2Á«return 
		}2“;24(
				  2≥26Rule40 2üi(2j, 226name2ej, 2]2Y226 26	nodeIndex24.26GetElementsByName2!i(2j)220"trade"B2j)226errorHandler24)2‹

		2ÿprivate 2ÿstatic 29 26bool26Rule40 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2Ï<{
			2K

			2@;29		26bool26result	2= 220trueB2ﬁÄforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2Ù<{
				2‘
				2»;29	26
XmlElement26	tradeDate 	2ñ= 2ç2à2!6 2	6XPath24.26Path2ai(2j, 226context2!j, 220"tradeHeader"B2j)220"tradeDate"B2–
				2ƒ;29	26XmlNodeList26legs	  	2î= 2ã2Ü2"6 2	6XPath24.2	6Paths2^i(2j, 226context2j, 220"fxSwap"B2 j)220"fxSingleLeg"B2ΩÄforeach 
}2M( 2C)2<29 26
XmlElement2
6leg 2Vin 226legs2⁄<{
					2´
					2û;29	26
XmlElement26	valueDate 	2m= 2e2a2!6 2	6XPath24.26Path2:i(2j, 226leg2j)220"valueDate"B2µ
					2®;29	26
XmlElement26
value1Date 	2v= 2n2j2!6 2	6XPath24.26Path2Ci(2j, 226leg2'j)2 20"currency1ValueDate"B2∞
2®;29	26
XmlElement26
value2Date 	2v= 2n2j2!6 2	6XPath24.26Path2Ci(2j, 226leg2'j)2 20"currency2ValueDate"B2≥ûif 
}27;(20)26	tradeDate 2	4!= 20nullB2ÎC 2„<{
2Èûif 
27;(20)26	valueDate 2	4!= 20nullB2¢C 2ö<	{
							2÷ûif 
							2¶;(2û)2ñ26Less 2Ñi(2>j, 262226ToDate 2i(2j)226	tradeDate2=j)262226ToDate 2i(2j)226	valueDate2C 2<2ö	continue;2˙
2Ú;2Í26errorHandler 2–i(2j, 220"305"B2j,
226leg2Cj,
									222.0&"value date must be after trade date."B2j, 226name2>j)272326ToToken 2i(2j)226	valueDate25
}2-;26result 24= 20falseB2ıûif 
28;(21)26
value1Date 2	4!= 20nullB2≠C 2•<	{
							2◊ûif 
							2ß;(2ü)2ó26Less 2Öi(2>j, 262226ToDate 2i(2j)226	tradeDate2>j)272326ToDate 2 i(2j)226
value1Date2C 2<2ö	continue;2Ñ
2¸;2Ù26errorHandler 2⁄i(2j, 220"305"B2j,
									226leg2Cj,
									222.0&"value1date must be after trade date."B2j, 226name2?j)282426ToToken 2 i(2j)226
value1Date25
}2-;26result 24= 20falseB2ˆûif 
}28;(21)26
value2Date 2	4!= 20nullB2≠C 2•<	{
							2◊ûif 
							2ß;(2ü)2ó26Less 2Öi(2>j, 262226ToDate 2i(2j)226	tradeDate2>j)272326ToDate 2 i(2j)226
value2Date2C 2<2ö	continue;2Ñ
2¸;2Ù26errorHandler 2⁄i(2j, 220"305"B2j,
									226leg2Cj,
									222.0&"value2date must be after trade date."B2j, 226name2?j)282426ToToken 2 i(2j)226
value2Date25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2†	

		2ÿprivate 2ÿstatic 29 26bool26Rule41 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2≠<{
			2≥ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2·C
2Ÿ<2‘«return 2≈;24(
					  2é
					26Rule41 2Úi(2j, 226name2∑j, 2Æ2©226 26	nodeIndex24.26GetElementsByType2qi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FXBarrier"B2j)226errorHandler24&amp; 2Ü26Rule41 2Úi(2j, 226name2∑j, 2Æ2©226 26	nodeIndex24.26GetElementsByType2qi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"FxBarrier"B2j)226errorHandler24)2Î«return 
		}2÷;24(
				  2∑26Rule41 2£i(2j, 226name2ij, 2a2]226 26	nodeIndex24.26GetElementsByName2%i(2j)220"fxBarrier"B2j)226errorHandler24)2á	

		2ÿprivate 2ÿstatic 29 26bool26Rule41 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2ó<{
			2J
			2@;29		26bool26result	2= 220trueB2äÄforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2†<{
				2™
				2û;29	26
XmlElement26rate	2s= 2k2g2!6 2	6XPath24.26Path2@i(2j, 226context2 j)220"triggerRate"B2Øûif 

				2Å;(2z)24(26rate 2	4== 20nullB24) 2	4|| 2126
IsPositive 2i(2j)226rate2C 2<2ö	continue;2˝
				2Ò;2È26errorHandler 2œi(2j, 220"305"B2j,
						226context2=j,
						2/2+0#"The trigger rate must be positive"B2j, 226name29j)222.26ToToken 2i(2j)226rate25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2æ	

		2ÿprivate 2ÿstatic 29 26bool26Rule42 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2À<{
			2«ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ıC
2Ì<2Ë«return 2Ÿ;24(
					  2ò
					26Rule42 2¸i(2j, 226name2¡j, 2∏2≥226 26	nodeIndex24.26GetElementsByType2{i(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2(j)2!20"FXAverageRateOption"B2j)226errorHandler24&amp; 2ê26Rule42 2¸i(2j, 226name2¡j, 2∏2≥226 26	nodeIndex24.26GetElementsByType2{i(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2(j)2!20"FxAverageRateOption"B2j)226errorHandler24)2ı«return 
		}2‡;24(
				  2¡26Rule42 2≠i(2j, 226name2sj, 2k2g226 26	nodeIndex24.26GetElementsByName2/i(2(j)2!20"fxAverageRateOption"B2j)226errorHandler24)2®

		2ÿprivate 2ÿstatic 29 26bool26Rule42 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2∏<{
			2J
			2@;29		26bool26result	2= 220trueB2´Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2¡<{
				2Ê
				2⁄;29	26XmlNodeList26nodes	2¨= 2£2û2"6 2	6XPath24.2	6Paths2vi(2j, 226context20j, 2(2$0"averageRateObservationDate"B2$j)220"observationDate"B2]
				2R;29			26int26limit	2+= 2#262	6nodes24.2	6Count2Å
				2v;29		2626Date 2>[]26dates	2@= 282
4new 2(626Date 2>[2]2	6limit2Õùfor 
				2†(
					2? 28;29 26int26count 2= 2200B 22; 2+;26count 24&lt; 2	6limit2	)224++2	6count2ó<2í2ç;2,6 26dates 2>[2]2	6count24= 2N26ToDate 2;i(24j)2-2)626nodes 2>[2]2	6count2„ùfor 
				2ø( 2? 28;29 26int26outer 2= 2200B 2V; 2O;26outer 24&lt; 24(26limit 24- 201B 24)2	)224++2	6outer2é<{
					2Äùfor 
}2≥( 2W 2P;29 26int26inner 2+= 2#26outer 24+ 201B 22; 2+;26inner 24&lt; 2	6limit2	)224++2	6inner2∫<{
						2Ùûif 

						2î;(2å)2Ñ26Equal 2ri(25j, 2-2)626dates 2>[2]2	6outer24j)2-2)626dates 2>[2]2	6inner2»C
							2π<2¥2Ø;2ß26errorHandler 2çi(2j, 220"305"B2>j,
									2-2)626nodes 2>[2]2	6inner29j,
									2(2$0"Duplicate observation date"B2j, 226name2Zj)2S2O26ToToken 2;i(24j)2-2)626nodes 2>[2]2	6inner25
}2-;26result 24= 20falseB23
}2+;26dates 24= 20nullB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2æ	

		2ÿprivate 2ÿstatic 29 26bool26Rule43 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2À<{
			2«ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ıC
2Ì<2Ë«return 2Ÿ;24(
					  2ò
					26Rule43 2¸i(2j, 226name2¡j, 2∏2≥226 26	nodeIndex24.26GetElementsByType2{i(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2(j)2!20"FXAverageRateOption"B2j)226errorHandler24&amp; 2ê26Rule43 2¸i(2j, 226name2¡j, 2∏2≥226 26	nodeIndex24.26GetElementsByType2{i(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2(j)2!20"FxAverageRateOption"B2j)226errorHandler24)2ı«return 
		}2‡;24(
				  2¡26Rule43 2≠i(2j, 226name2sj, 2k2g226 26	nodeIndex24.26GetElementsByName2/i(2(j)2!20"fxAverageRateOption"B2j)226errorHandler24)2“

		2ÿprivate 2ÿstatic 29 26bool26Rule43 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2‚	<{
			2J
			2@;29		26bool26result	2= 220trueB2’Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2Î<{
				2”
				2«;29	26
XmlElement26ccy1	2õ= 2í2ç2!6 2	6XPath24.26Path2fi(2j, 226context2'j, 220"putCurrencyAmount"B2j)220
"currency"B2‘
				2»;29	26
XmlElement26ccy2	2ú= 2ì2é2!6 2	6XPath24.26Path2gi(2j, 226context2(j, 2 20"callCurrencyAmount"B2j)220
"currency"B2ìûif 

				2Â;(2›)24(26ccy1 2	4== 20nullB24) 2	4|| 24(26ccy2 2	4== 20nullB24) 2	4|| 24!2K26IsSameCurrency 20i(2j, 226ccy12j)226ccy22C 2<2ö	continue;2‰
				2ÿ;2–26errorHandler 2∂i(2j, 220"305"B2j,
						226context2Fj,
						28240,"Put and call currencies must be different."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2æ	

		2ÿprivate 2ÿstatic 29 26bool26Rule44 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2À<{
			2«ûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ıC
2Ì<2Ë«return 2Ÿ;24(
					  2ò
					26Rule44 2¸i(2j, 226name2¡j, 2∏2≥226 26	nodeIndex24.26GetElementsByType2{i(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2(j)2!20"FXAverageRateOption"B2j)226errorHandler24&amp; 2ê26Rule44 2¸i(2j, 226name2¡j, 2∏2≥226 26	nodeIndex24.26GetElementsByType2{i(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2(j)2!20"FxAverageRateOption"B2j)226errorHandler24)2ı«return 
		}2‡;24(
				  2¡26Rule44 2≠i(2j, 226name2sj, 2k2g226 26	nodeIndex24.26GetElementsByName2/i(2(j)2!20"fxAverageRateOption"B2j)226errorHandler24)2™

		2ÿprivate 2ÿstatic 29 26bool26Rule44 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2∫<{
			2J
			2@;29		26bool26result	2= 220trueB2≠Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2√<{
				2¥
				2®;29	26
XmlElement26buyer	 2{= 2s2o2!6 2	6XPath24.26Path2Hi(2j, 226context2(j)2!20"buyerPartyReference"B2∂
				2™;29	26
XmlElement26seller	 2|= 2t2p2!6 2	6XPath24.26Path2Ii(2j, 226context2)j)2"20"sellerPartyReference"B2ﬁ
				2“;29	26
XmlElement26payer	 2§= 2õ2ñ2!6 2	6XPath24.26Path2oi(2j, 226context2%j, 220"fxOptionPremium"B2(j)2!20"payerPartyReference"B2„
				2◊;29	26
XmlElement26receiver 2ß= 2û2ô2!6 2	6XPath24.26Path2ri(2j, 226context2%j, 220"fxOptionPremium"B2+j)2$2 0"receiverPartyReference"B2¡ûif 
				2î;(2å)24(26buyer 2	4== 20nullB24) 2	4|| 24(26seller 2	4== 20nullB24) 24||
					24(26payer 2	4== 20nullB24) 2	4|| 24(26receiver 2	4== 20nullB24)2C 2<2ö	continue;2Çûif 

				2‘;(2Ã)2‘ 26Equal 2æi(2[j, 2S2O2)6 2	6buyer24.26GetAttribute2 i(2j)220"href"B2Zj)2S2O2)6 2	6payer24.26GetAttribute2 i(2j)220"href"B24
&amp;&amp;
					2’26Equal 2¬i(2\j, 2T2P2*6 2
6seller24.26GetAttribute2 i(2j)220"href"B2]j)2V2R2,6 26receiver24.26GetAttribute2 i(2j)220"href"B2C 2<2ö	continue;2ˇ

				2Ú;2Í26errorHandler 2–i(2j, 220"305"B2j,
						226context2`j,
						2R2N0F"Premium payer and receiver don't match with option buyer and seller."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2≤	

		2ÿprivate 2ÿstatic 29 26bool26Rule45 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2ø<{
			2øûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ÌC
2Â<2‡«return 2—;24(
					  2î
					26Rule45 2¯i(2j, 226name2Ωj, 2¥2Ø226 26	nodeIndex24.26GetElementsByType2wi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2$j)220"FXDigitalOption"B2j)226errorHandler24&amp; 2å26Rule45 2¯i(2j, 226name2Ωj, 2¥2Ø226 26	nodeIndex24.26GetElementsByType2wi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2$j)220"FxDigitalOption"B2j)226errorHandler24)2Ò«return 
		}2‹;24(
				  2Ω26Rule45 2©i(2j, 226name2oj, 2g2c226 26	nodeIndex24.26GetElementsByName2+i(2$j)220"fxDigitalOption"B2j)226errorHandler24)2ù

		2ÿprivate 2ÿstatic 29 26bool26Rule45 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2≠<{
			2J
			2@;29		26bool26result	2= 220trueB2†Äforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2∑<{
				2¥
				2®;29	26
XmlElement26buyer	 2{= 2s2o2!6 2	6XPath24.26Path2Hi(2j, 226context2(j)2!20"buyerPartyReference"B2∂
				2™;29	26
XmlElement26seller	 2|= 2t2p2!6 2	6XPath24.26Path2Ii(2j, 226context2)j)2"20"sellerPartyReference"B2ﬁ
				2“;29	26
XmlElement26payer	 2§= 2õ2ñ2!6 2	6XPath24.26Path2oi(2j, 226context2%j, 220"fxOptionPremium"B2(j)2!20"payerPartyReference"B2„
				2◊;29	26
XmlElement26receiver 2ß= 2û2ô2!6 2	6XPath24.26Path2ri(2j, 226context2%j, 220"fxOptionPremium"B2+j)2$2 0"receiverPartyReference"B2¡ûif 
				2î;(2å)24(26buyer 2	4== 20nullB24) 2	4|| 24(26seller 2	4== 20nullB24) 24||
					24(26payer 2	4== 20nullB24) 2	4|| 24(26receiver 2	4== 20nullB24)2C 2<2ö	continue;2ˆûif 

				2»;(2¿)2Œ 26Equal 2∏i(2Xj, 2P2L2&62	6buyer24.26GetAttribute2 i(2j)220"href"B2Wj)2P2L2&62	6payer24.26GetAttribute2 i(2j)220"href"B24
&amp;&amp;
					2œ26Equal 2ºi(2Yj, 2Q2M2'62
6seller24.26GetAttribute2 i(2j)220"href"B2Zj)2S2O2)626receiver24.26GetAttribute2 i(2j)220"href"B2C 2<2ö	continue;2ˇ

				2Ú;2Í26errorHandler 2–i(2j, 220"305"B2j,
						226context2`j,
						2R2N0F"Premium payer and receiver don't match with option buyer and seller."B2j, 226name2j)220nullB25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2˚

		2ÿprivate 2ÿstatic 29 26bool26Rule46 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2à<{
			2çûif 
			2>;(27)20626	nodeIndex24.26HasTypeInformation2ºC
				2∞<2´«return 2ú;24(2Ü26Rule46 2Úi(2j, 226name2∑j, 2Æ2©226 26	nodeIndex24.26GetElementsByType2qi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"SideRates"B2j)226errorHandler24)2Ï«return 
		}2◊;24(
					  2∑26Rule46 2£i(2j, 226name2ij, 2a2]226 26	nodeIndex24.26GetElementsByName2%i(2j)220"sideRates"B2j)226errorHandler24)2ë

		2ÿprivate 2ÿstatic 29 26bool26Rule46 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2°
<{
			2J
			2@;29		26bool26result	2= 220trueB2î	Äforeach 

			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2™<{
				2Ÿ
				2Õ;29	26
XmlElement26basis	2†= 2ó2í2!6 2	6XPath24.26Path2ki(2j, 226context2'j, 220"currency1SideRate"B2"j)220"sideRateBasis"B2ﬁûif 

				2∞;(2®)24(26basis 2	4== 20nullB24) 24||
					2/26ToToken 2i(2j)22	6basis24.226ToUpper 2i()24.2J 26Equals 24i(2-j)2&2"0"CURRENCY1PERBASECURRENCY"B24||
					2/26ToToken 2i(2j)22	6basis24.226ToUpper 2i()24.2G26Equals 24i(2-j)2&2"0"BASECURRENCYPERCURRENCY1"B2C 2<2ö	continue;2©
				2ù;2ï26errorHandler 2˚i(2j, 220"305"B2j,
						226context2hj,
						2Z2V0N"Side rate basis for currency1 should not be expressed in terms of currency2."B2j, 226name2:j)232/26ToToken 2i(2j)22	6basis25
}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2PG// --------------------------------------------------------------------
		2˚
		2ÿprivate 2ÿstatic 29 26bool26Rule47 2§e(
		2'f, 229 2
6string26name2/f, 2'29 26	NodeIndex26	nodeIndex2>f)272!9 26ValidationErrorHandler26errorHandler2â<{
			2éûif 

			2>;(27)20626	nodeIndex24.26HasTypeInformation2ºC
				2∞<2´«return 2ú;24(2Ü26Rule47 2Úi(2j, 226name2∑j, 2Æ2©226 26	nodeIndex24.26GetElementsByType2qi(2Jj, 2B2>26DetermineNamespace 2i(2j)226	nodeIndex2j)220"SideRates"B2j)226errorHandler24)2Ï«return 
		}2◊;24(
					  2∑26Rule47 2£i(2j, 226name2ij, 2a2]226 26	nodeIndex24.26GetElementsByName2%i(2j)220"sideRates"B2j)226errorHandler24)2ï

		2ÿprivate 2ÿstatic 29 26bool26Rule47 2°e(
		2'f, 229 2
6string26name2,f, 2$29 26XmlNodeList26list2>f)272!9 26ValidationErrorHandler26errorHandler2•
<{
			2J
			2@;29		26bool26result	2= 220trueB2ò	Äforeach 
			2Q( 2G)2@29 26
XmlElement26context 2Vin 226list2Ø<{
				2⁄

				2Õ;29	26
XmlElement26basis	2†= 2ó2í2!6 2	6XPath24.26Path2ki(2j, 226context2'j, 220"currency2SideRate"B2"j)220"sideRateBasis"B2ﬁûif 

				2∞;(2®)24(26basis 2	4== 20nullB24) 24||
					2/26ToToken 2i(2j)22	6basis24.226ToUpper 2i()24.2J 26Equals 24i(2-j)2&2"0"CURRENCY2PERBASECURRENCY"B24||
					2/26ToToken 2i(2j)22	6basis24.226ToUpper 2i()24.2G26Equals 24i(2-j)2&2"0"BASECURRENCYPERCURRENCY2"B2C 2<2ö	continue;2™

				2ù;2ï26errorHandler 2˚i(2j, 220"305"B2j,
						226context2hj,
						2Z2V0N"Side rate basis for currency2 should not be expressed in terms of currency1."B2j, 226name2:j)232/26ToToken 2i(2j)22	6basis28
			}2-;26result 24= 20falseB23«return 
		}2;24(2
6result24)2QG// --------------------------------------------------------------------

		2/// &lt;summary&gt;
		2TK/// Generates a set of dates according to schedule defined by a start date,
		2F=/// an end date, an interval, roll convention and a calendar.
		2/// &lt;/summary&gt;
		2D;/// &lt;param name="start"&gt;The start date.&lt;/param&gt;
		2@7/// &lt;param name="end"&gt;The end date.&lt;/param&gt;
		2aX/// &lt;param name="frequency"&gt;The frequency of the schedule (e.g. 6M).&lt;/param&gt;
		2h_/// &lt;param name="roll"&gt;The date roll convention or &lt;c&gt;null&lt;/c&gt;.&lt;/param&gt;
		2h_/// &lt;param name="calendar"&gt;The holiday calendar or &lt;c&gt;null&lt;/c&gt;.&lt;/param&gt;
		2VM/// &lt;returns&gt;An array of calculated and adjusted dates.&lt;/returns&gt;
		2æ
}
}
2ÿprivate 2ÿstatic 29 2626Date 2>[]26GenerateSchedule 2‰e(
		2&f, 229 26Date2	6start2'f,
			229 26Date26end2.f, 2&29 26Interval26	frequency2)f, 2!29 26DateRoll26roll2,f)2%29 26Calendar26calendar2Ò<{
			2H
			2>;29		26Date26current 2= 22	6start2i
			2_;29	26	ArrayList26found	24= 2,2
4new 226	ArrayList 2i()2;
			21;29		2626Date 2>[]2	6dates2ç	õwhile 

			2T;( 2J)2C26Less 22i(2j, 226current2j)226end2¢<{
				21

				2%;29		26Date26adjusted2≠ûif 

				22;(2+)26roll 2	4!= 20nullB2üC
					
				2ã<2Ü2Å;26adjusted 24= 2_2"6 26roll24.2
6Adjust27i(2j, 226calendar2j)226current2ED
else
					25<212-;26adjusted 24= 26current2—ûif 

				2^;(2W)24!2I2%6 2	6found24.26Contains2i(2j)226adjusted2_C
					2S<2O2K;2D2 6 2	6found24.26Add2i(2j)226adjusted2ﬁûif 
}2a;(2Z)2'6 26	frequency24.2
6Period2	4== 262
6Period24.26TERM2ËC 
2›<{
					2œûif 
				}2T;(2M)2F26Equal 24i(2j, 226current2j)22	6start2EC
						
					20<2,2(;26current 24= 26end2 Delse
						2<2ôbreak;2ÅD
else
					2q<2m2i;26current 24= 2H2#6 26current24.26Plus2i(2j)226	frequency2±
			2¶;2û2#6 2	6found24.2
6CopyTo2ui(2nj)2g26dates  24= 2
4new 2>626Date 2->[2&]262	6found24.2	6Count20«return 
}2;24(2	6dates24):
test.cs0.9.5