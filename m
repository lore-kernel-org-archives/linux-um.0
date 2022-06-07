Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx2.uni-rostock.de ([139.30.22.72])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyXW9-0077Zq-61
	for linux-um@lists.infradead.org; Tue, 07 Jun 2022 11:37:03 +0000
Message-ID: <aca42356-757d-1475-84a0-6835a90538ba@uni-rostock.de>
Date: Tue, 7 Jun 2022 13:36:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] um: read multiple msg from virtio slave request fd
Content-Language: de-DE
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
References: <20220601153722.181427-1-benjamin.beichler@uni-rostock.de>
 <360edf352f888f4607e0411df8a994aa087e9db4.camel@sipsolutions.net>
 <679ce219-d6f8-88a3-2aef-9de506b624ad@uni-rostock.de>
 <4310108d-9cf9-645b-48cf-f8d0b979f96e@uni-rostock.de>
In-Reply-To: <4310108d-9cf9-645b-48cf-f8d0b979f96e@uni-rostock.de>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4788137415914303298=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, jdike@addtoit.com, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

--===============4788137415914303298==
Content-Language: de-DE
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha-256; boundary="------------ms030401070709030108000409"

--------------ms030401070709030108000409
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Sorry for the cluttered HTML-Email, I hoped I trained my thunderbird to 
do the right thing, but it didn't.

Am 07.06.2022 um 13:32 schrieb Benjamin Beichler:
> Am 02.06.2022 um 10:32 schrieb Benjamin Beichler:
>> Am 01.06.2022 um 19:13 schrieb Johannes Berg: 
>>>
>>> prefer to keep the + on the previous line.
>>>
>> It slightly hits the 80 column restriction, but I would also prefer 
>> not to break. :-D
>
> Now I got your hint, and made it this way in the v2.
>
>>> That said, my attempt at rebasing this made it all fail completely,
>>> maybe you have better luck :)
> Actually, because of your patch I needed to change my logic a bit 
> (especially need to handle EAGAIN properly), which slowed me down a 
> bit, but now it does the right thing.

-- 
M.Sc. Benjamin Beichler

Universit=C3=A4t Rostock, Fakult=C3=A4t f=C3=BCr Informatik und Elektrotechnik
Institut f=C3=BCr Angewandte Mikroelektronik und Datentechnik

University of Rostock, Department of CS and EE
Institute of Applied Microelectronics and CE

Richard-Wagner-Stra=C3=9Fe 31
18119 Rostock
Deutschland/Germany

phone: +49 (0) 381 498 - 7278
email: Benjamin.Beichler@uni-rostock.de
www: http://www.imd.uni-rostock.de/

--------------ms030401070709030108000409
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EKcwggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWsMIIElKADAgECAgcbY7rQHiw9MA0GCSqGSIb3DQEBCwUAMIGVMQswCQYD
VQQGEwJERTFFMEMGA1UEChM8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hl
biBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLEwdERk4tUEtJMS0wKwYDVQQDEyRE
Rk4tVmVyZWluIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IDIwHhcNMTYwNTI0MTEzODQwWhcN
MzEwMjIyMjM1OTU5WjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ07eRxH3h+Gy8Zp1xCeOdfZojDbchwFfylf
S2jxrRnWTOFrG7ELf6Gr4HuLi9gtzm6IOhDuV+UefwRRNuu6cG1joL6WLkDh0YNMZj0cZGnl
m6Stcq5oOVGHecwX064vXWNxSzl660Knl5BpBb+Q/6RAcL0D57+eGIgfn5mITQ5HjUhfZZkQ
0tkqSe3BuS0dnxLLFdM/fx5ULzquk1enfnjK1UriGuXtQX1TX8izKvWKMKztFwUkP7agCwf9
TRqaA1KgNpzeJIdl5Of6x5ZzJBTN0OgbaJ4YWa52fvfRCng8h0uwN89Tyjo4EPPLR22MZD08
WkVKusqAfLjz56dMTM0CAwEAAaOCAgUwggIBMBIGA1UdEwEB/wQIMAYBAf8CAQEwDgYDVR0P
AQH/BAQDAgEGMCkGA1UdIAQiMCAwDQYLKwYBBAGBrSGCLB4wDwYNKwYBBAGBrSGCLAEBBDAd
BgNVHQ4EFgQUazqYi/nyU4na4K2yMh4JH+iqO3QwHwYDVR0jBBgwFoAUk+PYMiba1fFKpZFK
4OpL4qIMz+EwgY8GA1UdHwSBhzCBhDBAoD6gPIY6aHR0cDovL2NkcDEucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDBAoD6gPIY6aHR0cDovL2NkcDIu
cGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDCB3QYIKwYB
BQUHAQEEgdAwgc0wMwYIKwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1T
ZXJ2ZXIvT0NTUDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSgYIKwYBBQUHMAKGPmh0dHA6Ly9j
ZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtZzItY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0
MA0GCSqGSIb3DQEBCwUAA4IBAQCBeEWkTqR/DlXwCbFqPnjMaDWpHPOVnj/z+N9rOHeJLI21
rT7H8pTNoAauusyosa0zCLYkhmI2THhuUPDVbmCNT1IxQ5dGdfBi5G5mUcFCMWdQ5UnnOR7L
n8qGSN4IFP8VSytmm6A4nwDO/afr0X9XLchMX9wQEZc+lgQCXISoKTlslPwQkgZ7nu7YRrQb
tQMMONncsKk/cQYLsgMHM8KNSGMlJTx6e1du94oFOO+4oK4v9NsH1VuEGMGpuEvObJAaguS5
Pfp38dIfMwK/U+d2+dwmJUFvL6Yb+qQTkPp8ftkLYF3sv8pBoGH7EUkp2KgtdRXYShjqFu9V
NCIaE40GMIIF3TCCBMWgAwIBAgIMJLUFOr7DT1PAbUHrMA0GCSqGSIb3DQEBCwUAMIGNMQsw
CQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRz
Y2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQD
DBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBMB4XDTIxMDUwNzE4MzIxMloXDTI0MDUw
NjE4MzIxMlowbjELMAkGA1UEBhMCREUxHTAbBgNVBAoMFFVuaXZlcnNpdGFldCBSb3N0b2Nr
MREwDwYDVQQEDAhCZWljaGxlcjERMA8GA1UEKgwIQmVuamFtaW4xGjAYBgNVBAMMEUJlbmph
bWluIEJlaWNobGVyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2b8u90iXRBjH
yBjGxC1OB7LXQfzdDYQ7JSdKvmpmyJKFuljDEIy5yYzjRHee0+Kf5DhrSgshWuvYAD1sIqQF
WlM38YTJRtwq9NF6yCdZQgxwaR8qUplUw72d/PCqD+KjFyj8scb32EOclVXY9UpEYeGp1BnG
66o9Oewbk4rdHqeYDt/9VDPZOmi5YYtXUfwITZ/A6LpgGYf+NDQHRWcmG5thbvcXVYvSOwrm
vZnf8ZW4GbMsTorXWKFqx3gntf5VmY/xZ7XH4mE1V9gtNAo5XaTpj9g3ncJel1jEMtii1DeH
/tnP5ICo6GabZhyUfRo0vYGQhBGYqRm5vMowdqJ38wIDAQABo4ICWTCCAlUwPgYDVR0gBDcw
NTAPBg0rBgEEAYGtIYIsAQEEMBAGDisGAQQBga0hgiwBAQQIMBAGDisGAQQBga0hgiwCAQQI
MAkGA1UdEwQCMAAwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDAdBgNVHQ4EFgQUVUQ/tNKbRqzbUgK5NMo8iU5mwfswHwYDVR0jBBgwFoAUazqYi/ny
U4na4K2yMh4JH+iqO3QwKwYDVR0RBCQwIoEgQmVuamFtaW4uQmVpY2hsZXJAdW5pLXJvc3Rv
Y2suZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5aHR0cDovL2NkcDEucGNhLmRmbi5kZS9kZm4t
Y2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2FjcmwuY3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2Eu
ZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEB
BIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVy
L09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2Jh
bC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAyLnBj
YS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZI
hvcNAQELBQADggEBACOufP2NVgvUwvjvP2WPeIHDEVtJ/+s/Mj0LWp5soBW7NigeBcLIuEk0
2SCxCrfhn2KP9UtQbVecIbJ1swZDyLvhth/fFarUy0oVjkljW3C9v5Ahsl+XGt0vuykJjyz5
KDlioNEAG3aMrfeWA/wAMJLDZ62xGHJZR94PgiFtyMpuxfMHy0INKPaxLjS6xDESL8ecqHTq
Q53DDAPudkZg7aUllBEufBk4aS3mBO1Gl2kOXR/1om14+7fKMxiQCbpaPiJH9VA0txBJfnfk
KeFTOAf9OdtZ77WWZTEA9JLLrcG9l44WJt7DM5Ui38NC/ZBprX4IVDhOdoIgv5uWUVTHVIwx
ggQLMIIEBwIBATCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQQIMJLUF
Or7DT1PAbUHrMA0GCWCGSAFlAwQCAQUAoIICPTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA2MDcxMTM2NTVaMC8GCSqGSIb3DQEJBDEiBCArh5zdafCM
WSjbvewbIyWnJLYiSiFNl2EvnZ1ZyspFTjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQB
KjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMC
AgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGvBgkrBgEEAYI3EAQxgaEwgZ4wgY0xCzAJ
BgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNj
aGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsMB0RGTi1QS0kxJTAjBgNVBAMM
HERGTi1WZXJlaW4gR2xvYmFsIElzc3VpbmcgQ0ECDCS1BTq+w09TwG1B6zCBsQYLKoZIhvcN
AQkQAgsxgaGggZ4wgY0xCzAJBgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVyIEZvZXJk
ZXJ1bmcgZWluZXMgRGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsM
B0RGTi1QS0kxJTAjBgNVBAMMHERGTi1WZXJlaW4gR2xvYmFsIElzc3VpbmcgQ0ECDCS1BTq+
w09TwG1B6zANBgkqhkiG9w0BAQEFAASCAQBGE0AeOyO9lH/yh2YUaBJf4By+2rmUNHN1E46o
yCyhjSyzfqzyHPBx2d0LzIIaHUtlK7zBnqBY/20wCWe8qsNZc7YGgHXAqPv3z48SSYRq/WRE
nRymw3GrCNctoSKF2jv38F37n96PLQwpAlfVQZx9v/AHP11WR2aE26nQrUOJvgL589u4rGjD
q/fQu2SWSkwOA/uJKMlLBcG2uSSoNMa00ZdHEeIR0S+LtWHN9Pj5qqp/DHqq2SXyngtlht2E
46YI7bkYQEdSwZlQ7Ic3xMMG6dlpXAM2oHNTeKD/vXvAKAiqIpNvNbZzxfrbjJGF6Kr1iMAq
CenapRWzTvFAgzdtAAAAAAAA
--------------ms030401070709030108000409--



--===============4788137415914303298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============4788137415914303298==--



