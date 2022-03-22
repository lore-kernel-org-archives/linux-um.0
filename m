Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWoNQ-00CT4u-5t
 for linux-um@lists.infradead.org; Tue, 22 Mar 2022 23:57:25 +0000
Received: by mail-wm1-x336.google.com with SMTP id
 123-20020a1c1981000000b0038b3616a71aso60846wmz.4
 for <linux-um@lists.infradead.org>; Tue, 22 Mar 2022 16:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220322173547.677760-1-nathan@kernel.org>
In-Reply-To: <20220322173547.677760-1-nathan@kernel.org>
From: David Gow <davidgow@google.com>
Date: Wed, 23 Mar 2022 07:57:06 +0800
Message-ID: <CABVgOSmnE3Q4QR9SfRquXqD-K4faOdyPN+KR-nWAtgCkdc=KYA@mail.gmail.com>
Subject: Re: [PATCH] um: Fix filtering '-mno-global-merge'
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3497183063588086517=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Nathan Chancellor <nathan@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Nick Desaulniers <ndesaulniers@google.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev

--===============3497183063588086517==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000077197805dad75fe0"

--00000000000077197805dad75fe0
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 23, 2022 at 1:39 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> When booting a clang compiled UML kernel, the kernel panics when trying
> to run init:
>
>   wait_stub_done : failed to wait for SIGTRAP, pid = 651294, n = 651294, errno = 0, status = 0xb7f
>   Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>
> After the commit in Fixes, many flags from KBUILD_CFLAGS do not appear
> in USER_CFLAGS, likely due to USER_CFLAGS initially being a recursive
> variable ("VAR =") then being switched to a simple ("VAR :=") variable.
> For example, diffing arch/x86/um/.ptrace_user.o.cmd shows flags such as
> '-Os' and '-fno-delete-null-pointer-checks' getting dropped, which both
> impact code generation.
>
> Rework the filtering to use filter-out instead of patsubst, which allows
> all the patterns that USER_CFLAGS cares about to be excluded in one
> command and ensures all flags from KBUILD_CFLAGS are transferred over to
> USER_CFLAGS properly, which resolves the boot issue noted above.
>
> Fixes: 6580c5c18fb3 ("um: clang: Strip out -mno-global-merge from USER_CFLAGS")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Thanks. I was able to reproduce the panic here, and this indeed fixes it.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  arch/um/Makefile | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 320b09cd513c..d202f501e9e1 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -70,15 +70,11 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
>
>  KBUILD_AFLAGS += $(ARCH_INCLUDE)
>
> -USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
> +USER_CFLAGS = $(filter-out $(KERNEL_DEFINES) -I% -mno-global-merge,$(KBUILD_CFLAGS)) \
>                 $(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
>                 -D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
>                 -idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
>
> -ifdef CONFIG_CC_IS_CLANG
> -USER_CFLAGS := $(patsubst -mno-global-merge,,$(USER_CFLAGS))
> -endif
> -
>  #This will adjust *FLAGS accordingly to the platform.
>  include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
>
>
> base-commit: 82017457957a550d7d00dde419435dd74a890887
> --
> 2.35.1
>

--00000000000077197805dad75fe0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAFB5XJs46lHhs45dlgv
lPcwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjAyMDcy
MDA0MDZaFw0yMjA4MDYyMDA0MDZaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC0RBy/38QAswohnM4+BbSvCjgfqx6l
RZ05OpnPrwqbR8foYkoeQ8fvsoU+MkOAQlzaA5IaeOc6NZYDYl7PyNLLSdnRwaXUkHOJIn09IeqE
9aKAoxWV8wiieIh3izFAHR+qm0hdG+Uet3mU85dzScP5UtFgctSEIH6Ay6pa5E2gdPEtO5frCOq2
PpOgBNfXVa5nZZzgWOqtL44txbQw/IsOJ9VEC8Y+4+HtMIsnAtHem5wcQJ+MqKWZ0okg/wYl/PUj
uaq2nM/5+Waq7BlBh+Wh4NoHIJbHHeGzAxeBcOU/2zPbSHpAcZ4WtpAKGvp67PlRYKSFXZvbORQz
LdciYl8fAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKbSiBVQ
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC6
iaWlptQ9s+DHKHLZIPFox3aFqc9KLh2ROvU2yhs2HTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAzMjIyMzU3MThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAp2T3MIG9GDfZpbu5418m
H0HLqWFJ+8aNEwUius0BPBNsiQZ4JfEbhpSciha9THvc86EsbH797JGEfMfegfjoNYYYclCGfWnI
4XdauyNDSxyy02kT0NKYtzSoxVGZcuxjyUwYI70VSG3Ms52FiZhThva18Kfw3rvC0ox2Lmf0/gqb
+5AF2dA2W5hytPhfOBbdV8XQKoBEsyqbebFI4OTc6c0F5yTHedxy09QgRteND1Im9UnegsPx5HRA
H0U0IQesVqqVgQBQAhw6fPrcZLQnZIi2WEeAuMCgBLKJrxtbO3VJMSVi1GDo1jNUkVH5h/GElOGM
o6U5OdIjSjrZWluSRg==
--00000000000077197805dad75fe0--


--===============3497183063588086517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============3497183063588086517==--


