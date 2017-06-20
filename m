Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dNPWz-0006MH-Ua
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jun 2017 20:13:45 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dNPWx-0007W3-ON
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jun 2017 20:13:45 +0000
References: <1497923806.7300.2.camel@m3y3r.de>
	<98803c66-4a36-a95f-5a1b-51a40de7a3e6@nod.at>
	<1497948550.7300.5.camel@m3y3r.de>
	<25066617-df15-6d21-713c-1ede1e953448@nod.at>
	<1497981874.22112.20.camel@test-lenovo>
	<4d431238-28c7-3680-42f2-f7cf32acbc86@nod.at>
	<2fc7383c-852a-be3c-f934-b125fe9bdba2@nod.at>
	<1497988398.22550.5.camel@test-lenovo>
Mime-Version: 1.0 (1.0)
In-Reply-To: <1497988398.22550.5.camel@test-lenovo>
Message-Id: <D352734E-E991-4338-A5B3-94E840039841@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Tue, 20 Jun 2017 22:13:29 +0200
Subject: Re: [uml-devel] um: PTRACE_SETREGSET failure with XSTATE on
 Kabylake CPU
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2575650874646887000=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>, linux-x86_64@vger.kernel.org


--===============2575650874646887000==
Content-Type: multipart/signed;
	micalg=sha1;
	boundary=Apple-Mail-2F10E768-2CC4-4FD2-8503-BCED45C7038E;
	protocol="application/pkcs7-signature"
Content-Transfer-Encoding: 7bit


--Apple-Mail-2F10E768-2CC4-4FD2-8503-BCED45C7038E
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable


> Am 20.06.2017 um 21:53 schrieb Yu-cheng Yu <yu-cheng.yu@intel.com>:
>=20
>> On Tue, 2017-06-20 at 20:59 +0200, Richard Weinberger wrote:
>> Yu-cheng,
>>=20
>>> Am 20.06.2017 um 20:17 schrieb Richard Weinberger:
>>> Yu-cheng,
>>>=20
>>> Am 20.06.2017 um 20:04 schrieb Yu-cheng Yu:
>>>>>> So to summarize:
>>>>>>=20
>>>>>> - PTRACE_GETREGSET with NT_X86_XSTATE gets 832 and return 832, with n=
o
>>>>>> error.
>>>>>>=20
>>>>>> - PTRACE_SETREGSET get 832 (sizeof struct _xstate) but wants at least=

>>>>>> 1088, otherwise it will fail with -EFAULT (why not -EINVAL?)
>>>>>>=20
>>>>>> Ideas?
>>>>=20
>>>> We considered allowing a partial XSAVE buffer for PTRACE_SETREGSET, but=

>>>> it was that the XSAVE instruction requires a full-size buffer led to
>>>> this choice.  Using a smaller buffer for XSAVE causes a fault.
>>>=20
>>> So, this code is not supposed to work?
>>>=20
>>> iov.iov_base =3D fp_regs;
>>> iov.iov_len =3D sizeof(struct _xstate);
>>> ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov);
>>> ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov);
>>>=20
>>> This is what UML does and on Thomas's new Laptop PTRACE_SETREGSET is fai=
ling.
>>=20
>> Hmm, I think we need to do what gdb does, it uses a buffer of size X86_XS=
TATE_MAX_SIZE.
>=20
> Linux kernel determines XSAVE buffer size from CPUID:
> http://elixir.free-electrons.com/linux/latest/source/arch/x86/kernel/fpu/x=
state.c#L626

Hi,

Is there a user space API to get this value?

>=20
> GDB has a fixed X86_XSTATE_MAX_SIZE of 2688.  That can become an issue.
>=20
> Yu-cheng
>=20
>=20

--Apple-Mail-2F10E768-2CC4-4FD2-8503-BCED45C7038E
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
GgUAoIIBOzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNzA2MjAy
MDEzMjlaMCMGCSqGSIb3DQEJBDEWBBQFaAQ6UxWTkif0WOx1WnYlQqkEEjBsBgkrBgEEAYI3EAQx
XzBdMFExKTAnBgNVBAMMIFZvbGtzdmVyc2NobHVlc3NlbHVuZyBQcml2YXRlIENBMRcwFQYDVQQK
DA5GcmF1bmhvZmVyIFNJVDELMAkGA1UEBhMCREUCCBKBsRVZ659TMG4GCyqGSIb3DQEJEAILMV+g
XTBRMSkwJwYDVQQDDCBWb2xrc3ZlcnNjaGx1ZXNzZWx1bmcgUHJpdmF0ZSBDQTEXMBUGA1UECgwO
RnJhdW5ob2ZlciBTSVQxCzAJBgNVBAYTAkRFAggSgbEVWeufUzANBgkqhkiG9w0BAQEFAASCAQCO
PaGIUUM4rnMHhPVna+6hhZT7kyZ4FXUOrJ035vxQX8HCxdPV5q3I1OcKOFSu06J6/QyFs0GE4PKx
G4o4piN/U5LuN2Pwjn1zGecmiD25CPCfeOr/le1tWIa1W9dtOALI3Mx+26Dke1TZe0YgIRn2PXJs
I5ZqgaQFTqKhcKIucJSO2ah6Zyj5fSZYz4ZAUdG+lsZX3rVGs50w2LH5S2j2iAtSFH5aD1luztAE
bYVqeCpSXtHV7AywrgJACEppyvLAW7uRXCJOUAk1pkuW2sl6X0Fm4MHfTw5TQhE043xnShyG6F5e
kATHMhmTd/H43OBs/qz3rL6tniT9PNICcxjVAAAAAAAA
--Apple-Mail-2F10E768-2CC4-4FD2-8503-BCED45C7038E--


--===============2575650874646887000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============2575650874646887000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2575650874646887000==--


