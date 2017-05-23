Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dDG0s-0007ts-At
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 May 2017 20:02:38 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dDG0q-0002Qf-I4
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 May 2017 20:02:38 +0000
References: <E1dDE2Y-0002Kh-CQ@www17.your-server.de>
	<CAFLxGvxto5SDA+Ty-G7vc_uEf1dmcN7Ea0r3cohgc2eAKz7SWQ@mail.gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <CAFLxGvxto5SDA+Ty-G7vc_uEf1dmcN7Ea0r3cohgc2eAKz7SWQ@mail.gmail.com>
Message-Id: <258BB87F-D99B-46A9-BF57-3711E5AE1AE8@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Tue, 23 May 2017 22:02:26 +0200
Subject: Re: [uml-devel] um: xstate changes breaks my UML setup
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8749445603095712484=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>


--===============8749445603095712484==
Content-Type: multipart/signed; micalg=sha1;
	boundary=Apple-Mail-8D140359-C02A-4AC3-AE85-4EA5902C33E6;
	protocol="application/pkcs7-signature"
Content-Transfer-Encoding: 7bit


--Apple-Mail-8D140359-C02A-4AC3-AE85-4EA5902C33E6
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable


> Am 23.05.2017 um 21:30 schrieb Richard Weinberger <richard.weinberger@gmai=
l.com>:
>=20
> Thomas,
>=20
>> On Tue, May 23, 2017 at 7:56 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
>> Hi,
>>=20
>>=20
>>=20
>> to make UML work again with the latest Fedora Installation I Need to reve=
rt
>> those commits:
>>=20
>> b6024b21fec8367ef961a771cc9dde31f1831965
>>=20
>> a78ff1112263fdd871d3506dbcff44f6f12e8423
>>=20
>>=20
>>=20
>> A reproducer script/config is available here:
>>=20
>> https://github.com/thomasmey/uml/blob/master/fedora-26-install.sh
>=20
> Please start using the CC feature of your mailer. :-)

Damn, I did so, but Windows 10 Mail is just so broken...

>=20
> --=20
> Thanks,
> //richard
>=20
> --------------------------------------------------------------------------=
----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Apple-Mail-8D140359-C02A-4AC3-AE85-4EA5902C33E6
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Disposition: attachment;
	filename=smime.p7s
Content-Transfer-Encoding: base64

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
PeLMnEm7tRjvT6lNp81SDvaRGPbrU4BZ1k/FGHiV+XitX0bypL12DS64bKo8OEgN4IMYYg3dXg9u
+gpn0rc8/l7AUrKUk0IlcvKrnvhNpxQ3xWxr7YeYANUny6Z5XVgLAkgaLmbF6J7Dl1VuAxjTve2S
1k2PNUQ/dnJmNCCR/bjjqTW69An093a5Z7/zrgunfPWQCNXtTtfKkQlPSVplOasg1m47e7uBj4bF
dNvBwZ641Aev4xEKqg9WMMK3Vy03LmbZa0IK48Vg1FP4XDmZeqBRKAooVbb5iQIDAQABo4IBbTCC
AWkwGgYDVR0RBBMwEYEPdGhvbWFzQG0zeTNyLmRlMA4GA1UdDwEB/wQEAwIGwDATBgNVHSUEDDAK
BggrBgEFBQcDBDBCBgNVHR8EOzA5MDegNaAzhjFodHRwOi8vdm9sa3N2ZXJzY2hsdWVzc2VsdW5n
LmRlL2NybC9wcml2YXRlY2EuY3JsMH4GCCsGAQUFBwEBBHIwcDA8BggrBgEFBQcwAoYwaHR0cDov
L3ZvbGtzdmVyc2NobHVlc3NlbHVuZy5kZS9jYS9wcml2YXRlY2EuY3J0MDAGCCsGAQUFBzABhiRo
dHRwOi8vb2NzcC52b2xrc3ZlcnNjaGx1ZXNzZWx1bmcuZGUwFAYDVR0gBA0wCzAJBgcrJA8JAQEB
MB0GA1UdDgQWBBQ6nNQ4hduFPYI2tI0+IcC/wTZSSDAMBgNVHRMBAf8EAjAAMB8GA1UdIwQYMBaA
FEJzCOU+QLR+x4VXEHf9EQ9FhKfdMA0GCSqGSIb3DQEBCwUAA4ICAQCDrepf05Bm93sh+Db4Vgee
W2GweWJDGhHj1vuWowuaXoRgSz0G+QQWs4OBljzU9e6/W63jFrXqCM495tS4LbpcRqNzvN8mVEuF
8mYw9ZM7YG9Nx+Y3Pt7IDrOgWpw8hmEFNAfb8/dTMaMDHkPGYqLOvJA2rgk8rK5eJ2cSZ3TFAc5Z
lz/Tq1PB59Jl/nzIabBo6x7tvhjiqSL/R0fg/oi9nRvevNrCEWe/JjBoOST51HWV/91PaasDLEG/
OFG1lWsy7m0kYx4mHgxlsRVznIE9V1IguNi+1bY2k44mRNscufUNgVezto4JBARIEuLhFgIXQ8Vv
5r0ynhpsDtIfuI/NejqUlenSNe99FssF0GOluZ6qovSLb+f5GcLhcEf8OV0tUaAhEryL5w7rh4Hq
ca1IZ1OxDkTNxgQVOr9qihZhQblH6HWYzi3C2nFvWdVqcQV+ZAppZqF7HD1A23FiFOter5V5CDy8
19dZc9Dwu0MowmVZiOlh2mhPk1ID2vCSGtM2KGq/ZnJH9gnjzN3B0WJg0dmVQdtggCgj4Caq7f4V
tY9K1oIIyIuo6mpjBk+LFtgI+kWdDpsU6fzEyq3PmTW/0/cYzI1kJvUztj+0AHNyCBij4F3Yf3mi
Ob88vCPJPZg6Rhry9hxwX13zHbEE6FfiWRcxWihkwFXmEckbUR5YFDCCBoIwggRqoAMCAQICCA7P
iiLFnseHMA0GCSqGSIb3DQEBCwUAME4xJjAkBgNVBAMMHVZvbGtzdmVyc2NobHVlc3NlbHVuZyBS
b290IENBMRcwFQYDVQQKDA5GcmF1bmhvZmVyIFNJVDELMAkGA1UEBhMCREUwHhcNMTYwNTA5MTQw
OTEzWhcNMjEwNTEwMTQwOTEzWjBRMSkwJwYDVQQDDCBWb2xrc3ZlcnNjaGx1ZXNzZWx1bmcgUHJp
dmF0ZSBDQTEXMBUGA1UECgwORnJhdW5ob2ZlciBTSVQxCzAJBgNVBAYTAkRFMIICIjANBgkqhkiG
9w0BAQEFAAOCAg8AMIICCgKCAgEAzNfyQJBPr3f99kqZCdW9r9U2EKFTXg6IuLh8LWKsZHo8XiRE
BarheOkdxdSKW9FTUEZUdwWk1uwpuDYnIfEcKrTAOiItrdRJc98h2yhD6tlZgSLY/B9Vjw2LQIZZ
WVnsYVvBOxYznfaveDY7HfowbXgERxv30sQqNZP+KhUB3JjQ1pVAVyLZxK+j8a7k1bFH955kkJ6G
+AoTzZzHj5Bn9LUTFvP7RsB2rNPy+GBZ52EvdlqrGEi7JKvM9M8jffA6RZ8OzXS1utng5jWj+efw
Hg5Wr4JC3YZs/TpNogPVyw4vDjCF/RI56mrSUQBXm1IVjuWM8qUhphBR2gRZN0sATWCj8pWG1pLl
Mz02Ddg/AbZ7V9C6MwH4I6nGQ1XxhNSkWSrUQUnXYrOoA8T0IH/6AuY7ukMrj+KLJtTlM1Y+sOXR
Zyk/QFSgVP/5AbT82ErsVZW1q7JDLkaEdwrPDFXQNqfrlIsYI3FYrgB6rVJG3tZ/3LMmFHNQVnTX
hCiy6mUFpogdAl1QxXeNMWAdVLMBBm/iY9IZwtqb9G/Gxt19QmHLpLwyo4nVX1F7Got+yLYzfrLf
0toMk3Kjj7uhlndhpkoeFwDKMioi1dsUn3zxRK6dwaPzkKsphj8ybXFBr3s68A4+xKmaQxR7gcg9
tPKB/pTyC8vtkAl1lfNU14IV2ikCAwEAAaOCAV8wggFbMEkGCCsGAQUFBwEBBD0wOzA5BggrBgEF
BQcwAoYtaHR0cDovL3ZvbGtzdmVyc2NobHVlc3NlbHVuZy5kZS9jYS9yb290Y2EuY3J0MB0GA1Ud
DgQWBBRCcwjlPkC0fseFVxB3/REPRYSn3TASBgNVHRMBAf8ECDAGAQH/AgEAMB8GA1UdIwQYMBaA
FBeNp8XO7dqGdP5+TYW2xuL7R78PMBEGA1UdIAQKMAgwBgYEVR0gADCBlgYDVR0fBIGOMIGLMIGI
oDKgMIYuaHR0cDovL3ZvbGtzdmVyc2NobHVlc3NlbHVuZy5kZS9jcmwvcm9vdGNhLmNybKJSpFAw
TjEmMCQGA1UEAwwdVm9sa3N2ZXJzY2hsdWVzc2VsdW5nIFJvb3QgQ0ExFzAVBgNVBAoMDkZyYXVu
aG9mZXIgU0lUMQswCQYDVQQGEwJERTAOBgNVHQ8BAf8EBAMCAQYwDQYJKoZIhvcNAQELBQADggIB
AFlX5ruAA0T3RL9Z+NQo7syDNwv3n1p1eSIloJlKGkIlHdNUJNxfjvzpLvm1n47sUsbHlZOW7MDK
P2ODo94i5yHKEB2TPQF4NMJBsiH60xQuFQDgKd5nawBOgs1hVJR0ijGlMipwrYwfdNvyrXCHGew0
PDuRcRa53VRR3vE1vxhHYpbyPOdq3s2Q+TfvF3ihr+WkvujnSQocg65bY/Tj4+ARjdt1odI4HzHw
gDPc3SfUPgOEedte23oU8Y2LRpKpb9eHeb0hH32hQ+QOToULISE42ymiG5MOi4hxKUUZrGIK+BQ9
r/dABOsbskFA7j7rL/k5+v2j73oLals47S1BRHsIU3pX7K5XfVnDTVu5vSlLCjEV+C9pqHv0pDB5
fhQb6ZImjWJfkFdvFry+EYbbpogMr+seUytfUmd+8cz05d1ncTUN926iiY6AGxSKCRvHbrtQdVFJ
IX4jlKIpnDg4DH9Xlatlr/K/zNAIxiiNXrQND+UmhEgf2Rb0Ba3whIc9moXGQEjZdrt4qLJjtccq
OcOgvNszFuFIvhzpdH69+twIZtM4fBP1AjVfRxRhhNmAzz701bcAGv2vRgYURHsQ+GoedTGnhgAi
WjwSoIkQlD7mjjB7/ayUWCCbQ4AW0/Wjja2B9ahRQkQwSn3F1eBeuXRHM5Jk54/yq6uT7rnZG93n
MYICwzCCAr8CAQEwXTBRMSkwJwYDVQQDDCBWb2xrc3ZlcnNjaGx1ZXNzZWx1bmcgUHJpdmF0ZSBD
QTEXMBUGA1UECgwORnJhdW5ob2ZlciBTSVQxCzAJBgNVBAYTAkRFAggSgbEVWeufUzAJBgUrDgMC
GgUAoIIBOzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNzA1MjMy
MDAyMjZaMCMGCSqGSIb3DQEJBDEWBBTz1AHKzAbEzn++BVpXqGfXUKuWhTBsBgkrBgEEAYI3EAQx
XzBdMFExKTAnBgNVBAMMIFZvbGtzdmVyc2NobHVlc3NlbHVuZyBQcml2YXRlIENBMRcwFQYDVQQK
DA5GcmF1bmhvZmVyIFNJVDELMAkGA1UEBhMCREUCCBKBsRVZ659TMG4GCyqGSIb3DQEJEAILMV+g
XTBRMSkwJwYDVQQDDCBWb2xrc3ZlcnNjaGx1ZXNzZWx1bmcgUHJpdmF0ZSBDQTEXMBUGA1UECgwO
RnJhdW5ob2ZlciBTSVQxCzAJBgNVBAYTAkRFAggSgbEVWeufUzANBgkqhkiG9w0BAQEFAASCAQA5
H273sP8St8RX6KbYA4K/V2ettkuiwXF6teYNlv1abWGV+Yjb2F4Dkfbl1/+VFH0EKo3+YKmo8I8j
oRueXvDiVJfjPIGypyHSpOCHqvIUMa7DNFB0Kwu34/qsW8vZH+WTtmxcpYa5kpfL4SOkgOfcI+g3
3dG/RQ2yJoSu00SWg1pSPZF6nX1B59pvIo1rPpFF/JYB5VOHPba9TuUS3k4XDTSKEzum0nPUBjnb
DQOIcIosy38vXu3yXrniuBBYPuEe8JZCTLxHtBtQxJ6cOrB+CZ2uY613SxMkZ7xuBisHZgENOQcw
5iRbUpKxKA1pRQ3M6Pq2p8KSaBW/32gaUsQGAAAAAAAA
--Apple-Mail-8D140359-C02A-4AC3-AE85-4EA5902C33E6--


--===============8749445603095712484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============8749445603095712484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============8749445603095712484==--


