Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <20170524010858.16134-1-f.fainelli@gmail.com> <d2f4abc4-3d79-45e8-661a-25a244c836e4@nod.at>
Mime-Version: 1.0 (1.0)
In-Reply-To: <d2f4abc4-3d79-45e8-661a-25a244c836e4@nod.at>
Content-Type: multipart/signed;
        micalg=sha1;
        boundary=Apple-Mail-696E1C9E-6415-4ABB-818E-0CF0AF9CA853;
        protocol="application/pkcs7-signature"
Content-Transfer-Encoding: 7bit
Message-Id: <2A62A3A3-13BD-48D2-B210-98B45B7F7666@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: [PATCH] um: Allow building and running on older hosts
Date: Wed, 24 May 2017 11:03:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, elicooper@gmx.com, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


--Apple-Mail-696E1C9E-6415-4ABB-818E-0CF0AF9CA853
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable


> Am 24.05.2017 um 09:01 schrieb Richard Weinberger <richard@nod.at>:
>=20
> CC'ing Thomas. We is also facing issues with these commits.
>=20
>> Am 24.05.2017 um 03:08 schrieb Florian Fainelli:
>> Commit a78ff1112263 ("um: add extended processor state save/restore
>> support") and b6024b21fec8 ("um: extend fpstate to _xstate to support
>> YMM registers") forced the use of the x86 FP _xstate and
>> PTRACE_GETREGSET/SETREGSET. On older hosts, we would neither be able to
>> build UML nor run it anymore with these two commits applied because we
>> don't have definitions for struct _xstate nor these two ptrace requests.
>>=20
>> We can determine at build time which fp context structure to check
>> against, just like we can keep using the old i387 fp save/restore if
>> PTRACE_GETRESET/SETREGSET are not defined.
>>=20
>> Fixes: a78ff1112263 ("um: add extended processor state save/restore suppo=
rt")
>> Fixes: b6024b21fec8 ("um: extend fpstate to _xstate to support YMM regist=
ers")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> arch/x86/um/os-Linux/registers.c | 13 +++++++++----
>> arch/x86/um/user-offsets.c       |  4 ++++
>> 2 files changed, 13 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/regi=
sters.c
>> index 00f54a91bb4b..502bd642e5c2 100644
>> --- a/arch/x86/um/os-Linux/registers.c
>> +++ b/arch/x86/um/os-Linux/registers.c
>> @@ -26,13 +26,14 @@ int save_i387_registers(int pid, unsigned long *fp_re=
gs)
>>=20
>> int save_fp_registers(int pid, unsigned long *fp_regs)
>> {
>> -    struct iovec iov;
>> -
>>    if (have_xstate_support) {
>> +#ifdef PTRACE_GETREGSET
>> +        struct iovec iov;

Is this okay, in C90? Won't this give an error once the thing is defined?

>>        iov.iov_base =3D fp_regs;
>>        iov.iov_len =3D sizeof(struct _xstate);
>>        if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
>>            return -errno;
>> +#endif
>>        return 0;
>>    } else {
>>        return save_i387_registers(pid, fp_regs);
>> @@ -48,13 +49,15 @@ int restore_i387_registers(int pid, unsigned long *fp=
_regs)
>>=20
>> int restore_fp_registers(int pid, unsigned long *fp_regs)
>> {
>> -    struct iovec iov;
>> -
>>    if (have_xstate_support) {
>> +#ifdef PTRACE_SETREGSET
>> +        struct iovec iov;
>> +
>>        iov.iov_base =3D fp_regs;
>>        iov.iov_len =3D sizeof(struct _xstate);
>>        if (ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
>>            return -errno;
>> +#endif
>>        return 0;
>>    } else {
>>        return restore_i387_registers(pid, fp_regs);
>> @@ -127,8 +130,10 @@ void arch_init_registers(int pid)
>>=20
>>    iov.iov_base =3D &fp_regs;
>>    iov.iov_len =3D sizeof(struct _xstate);
>> +#ifdef PTRACE_GETREGSET
>>    if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) =3D=3D 0)
>>        have_xstate_support =3D 1;

So why keep have_xstate_support when all branches that test for it are now p=
re compiler conditionals?

>> +#endif
>> }
>> #endif
>>=20
>> diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
>> index cb3c22370cf5..8af0fb5d2780 100644
>> --- a/arch/x86/um/user-offsets.c
>> +++ b/arch/x86/um/user-offsets.c
>> @@ -50,7 +50,11 @@ void foo(void)
>>    DEFINE(HOST_GS, GS);
>>    DEFINE(HOST_ORIG_AX, ORIG_EAX);
>> #else
>> +#if defined(PTRACE_GETREGSET) && defined(PTRACE_SETREGSET)
>>    DEFINE(HOST_FP_SIZE, sizeof(struct _xstate) / sizeof(unsigned long));
>> +#else
>> +    DEFINE(HOST_FP_SIZE, sizeof(struct _fpstate) / sizeof(unsigned long)=
);
>> +#endif
>>    DEFINE_LONGS(HOST_BX, RBX);
>>    DEFINE_LONGS(HOST_CX, RCX);
>>    DEFINE_LONGS(HOST_DI, RDI);
>>=20

--Apple-Mail-696E1C9E-6415-4ABB-818E-0CF0AF9CA853
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
GgUAoIIBOzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNzA1MjQw
OTAzNTFaMCMGCSqGSIb3DQEJBDEWBBScs1GgTTxUxRXPSnc26n3lh9bq1zBsBgkrBgEEAYI3EAQx
XzBdMFExKTAnBgNVBAMMIFZvbGtzdmVyc2NobHVlc3NlbHVuZyBQcml2YXRlIENBMRcwFQYDVQQK
DA5GcmF1bmhvZmVyIFNJVDELMAkGA1UEBhMCREUCCBKBsRVZ659TMG4GCyqGSIb3DQEJEAILMV+g
XTBRMSkwJwYDVQQDDCBWb2xrc3ZlcnNjaGx1ZXNzZWx1bmcgUHJpdmF0ZSBDQTEXMBUGA1UECgwO
RnJhdW5ob2ZlciBTSVQxCzAJBgNVBAYTAkRFAggSgbEVWeufUzANBgkqhkiG9w0BAQEFAASCAQAy
pZgSI1/JZ+WKS4xgy6k4rgwErQMqyn1Z2z2a0m/kvw8ah88Y2x5xQWzyI8Gj37u4zkPrzyTCHNYA
qe5Ht0xuWic36Kxp2Bc41etZ0gl2H8Ej7MFEAwVV7tmlv60oaczb8GT8PiQLzSU9tOmSR3GuDE4q
ap12GmUzDzpxlzAZXj+DtgrEIg0dqkTUd1t+eNNd7OwS+nzHagwakSQV3FhSDrlTFPkml0NBRAEv
eY8iKKV26b/WSkU5qfJ+KeJsvbCDobNFeCCCOIqL9m2B2H9ZCZ4reCQJNCtf1GiqK9OR3zdDstSL
0b8YI7rcHI1ddc4NUQFEy/wnCWB3sqk9jQUXAAAAAAAA
--Apple-Mail-696E1C9E-6415-4ABB-818E-0CF0AF9CA853--

