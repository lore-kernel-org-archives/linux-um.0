Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC5FC678D5
	for <linux-um@archiver.kernel.org>; Sat,  4 Mar 2023 04:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:
	To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGymjFDLLvSKNXSCwgC6J2FTPowYo0cU8LveZqvn/lk=; b=PlV5tH9madjY5TSXhHhUdeZvxW
	l1HUcL0Qjj16TLBwj0BNxMCf5h2amciTKthPhmBYQQ8EfarMzZwSjz09AbOp4yUf+jC43U2yQ0oy/
	5hFIdMZEGsTJ9ttIIwgHZvln/NOeD3161LsE+SzN1WB1koQ4xzCZOLBAGuCBrryl8aRGsj3qbkFwM
	RaOKYJU3bGaYNvLL/INnPAawPaBvuM30CHvYMpGCx4Q8pDbg4eK8qrIYbhibj4CU7AN1HG1jczr6L
	99pPEyKlKli2YKat7K1y/Z4sknr+DjdGkvzmyWphK4ZM+39LbyZmjUcw29d0AHPYzAGz5jAjAyytd
	X2QaoLJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYJca-008I3i-16; Sat, 04 Mar 2023 04:35:48 +0000
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYJcW-008I36-Gs
	for linux-um@lists.infradead.org; Sat, 04 Mar 2023 04:35:46 +0000
Received: by mail-ua1-x936.google.com with SMTP id p2so3056361uap.1
        for <linux-um@lists.infradead.org>; Fri, 03 Mar 2023 20:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677904536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pNWI8GMioFfQpv8zMzOv/iwiIjch+0nLSqCfnhRjd6M=;
        b=Tm1T796EvRPOQNGtVEXvsYrYIKGLTXVnstAnE4h4o6snsU5IAueD/8R842zrZJ5BDe
         g/hmmBnegkkid4oZfPvMH2Y1FDGUEarVATkz0Z4XhLFbEoIPYpj8La24h+09Cd9jtEsT
         1LvCmfB1aoP7awfrgTxaGRJdpbjAKZvfIWGjm+MrsQJDuo3C2snM53jpIznmjr+4EKrq
         YP5ikXkPTgFJBkrO574J4XBVHDLw218qfv9U8LYtBIDYHuIj5yB1wJl0ylzyU4UARKto
         VNk/g0pIxCvaJpSZqpQcvbRkCdfS8juIsFY4zr3gJxbZ/FRxVkbdCfQ1wbLz+byiep+i
         +nZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677904536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNWI8GMioFfQpv8zMzOv/iwiIjch+0nLSqCfnhRjd6M=;
        b=akerXzM9OPmBX7WyUwDdXAdXPRz0+CSo/XWS4xlLj9beA4d1ieTabdThaeV0w6aSvV
         6nGqx0WwrJPZpknnxzv6G7+Kt5YC/ulft1/LuNwL2Srjtt0FBzE7DdXawW+ecpJ/ZxQ5
         Lbi5K5jgz2H+xSrV6DYQqlkeFqkSaDbf1aoSQEC0/m3VZhoYRNH6tvr9ABHbtG53MgMF
         uekjZmJ+pKm4BVuVaIYu/+c2NVVWVR4G5GjSttSFPgng/ptrPx6HtW86JGThYhaotxND
         o2EoV6L7A7Q5GQdP9ov2fmo9AvHFyk0zstYeOepVGEL4WmXXLlqIBjKyvoLzr2IYB9AE
         9t7Q==
X-Gm-Message-State: AO0yUKVE6Vmh0jK8ZFGG2UmYRXwqufI0XKc9a/Vq2/++NcgVBZJwoU6k
	FdJyxW1p68guEhvxOAPZxXJl44Mwzxqc0jKCN8gtVA==
X-Google-Smtp-Source: AK7set8RBh/l0kmI7s7aqMsfsVqupkN4B936BZub1XfTIOJLHLVi1Oy2vH3ABuJV+Gi+vr1g1tdbiYT/QWWqnCazrW4=
X-Received: by 2002:a1f:e305:0:b0:401:95ec:8e17 with SMTP id
 a5-20020a1fe305000000b0040195ec8e17mr2737050vkh.2.1677904536220; Fri, 03 Mar
 2023 20:35:36 -0800 (PST)
MIME-Version: 1.0
References: <6df2ecef9011d85654a82acd607fdcbc93ad593c.camel@huaweicloud.com>
In-Reply-To: <6df2ecef9011d85654a82acd607fdcbc93ad593c.camel@huaweicloud.com>
From: David Gow <davidgow@google.com>
Date: Sat, 4 Mar 2023 12:35:24 +0800
Message-ID: <CABVgOSm1t3_mcUUu0A8eG-zAA4q0d-dmi6Ceb3TFtoUt1i3gTQ@mail.gmail.com>
Subject: Re: Cannot compile UML in Ubuntu 20.04.5 anymore
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_203544_627766_FCFF37ED 
X-CRM114-Status: GOOD (  20.84  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9212946363950898482=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--===============9212946363950898482==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000de6a3e05f60b9760"

--000000000000de6a3e05f60b9760
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Mar 2023 at 16:37, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> Hi
>
> it looks like one recent commit causes the kernel build to break.
>
>   GEN     scripts/gdb/linux/constants.py
> In file included from /usr/include/stdlib.h:1013,
>                  from arch/um/os-Linux/helper.c:6:
> /usr/include/x86_64-linux-gnu/bits/stdlib-float.h: In function =E2=80=98a=
tof=E2=80=99:
> /usr/include/x86_64-linux-gnu/bits/stdlib-float.h:26:1: error: SSE regist=
er return with SSE disabled
>    26 | {
>       | ^
>   CC      init/noinitramfs.o
>
> It works again by reverting commit 884981867947 ("rust: arch/um:
> Disable FP/SIMD instruction to match x86").
>
> $ cat /proc/cpuinfo
>
> [...]
>
> processor       : 31
> vendor_id       : AuthenticAMD
> cpu family      : 23
> model           : 49
> model name      : AMD Ryzen Threadripper PRO 3955WX 16-Cores
>
> Thanks
>
> Roberto
>

Yup, this is definitely caused by 884981867947 ("rust: arch/um:
Disable FP/SIMD instruction to match x86").

It looks like GCC fixed this upstream in GCC 11:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99652

Equally though, not having this change breaks older versions of LLVM,
so I think it's best to not totally revert it.

Something like this should work:
---
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index d2e95d1d4db7..1aa64846e539 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -3,9 +3,14 @@ core-y +=3D arch/x86/crypto/

#
# Disable SSE and other FP/SIMD instructions to match normal x86
+# This is required to work around issues in older LLVM versions, but break=
s
+# GCC versions < 11. See:
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99652
#
+ifeq ($(CONFIG_CC_IS_CLANG),y)
KBUILD_CFLAGS +=3D -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
KBUILD_RUSTFLAGS +=3D
-Ctarget-feature=3D-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
+endif

ifeq ($(CONFIG_X86_32),y)
START :=3D 0x8048000
---

Though the more correct solution would be to just check
gcc-min-version || clang. That probably requires a bit more
makefile-fu to do cleanly, though.

Cheers,
-- David

--000000000000de6a3e05f60b9760
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
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDH
NGzCH+ZfkQYjXBiLn/zOaw/vgIGCkYvV4wC2VSSdoDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMDQwNDM1MzZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEArcCVnBO+Ho48DtldZU47
cUd0Yc4Ue5fTz0YHjTy7bYhsIw6XQJJwwLRg8fdDpLYZFAlUyvUadSnAKtyysX2vwliiLinky219
HyDoxHICbHQQdpE188iaowaNsFVw//Vrs+yHn8RtbsZrNbW6DV5FH7ia26XxiVW2VjZ4RBrlC0Dl
9Z3xAvwBOidUayDjjjYtB7ODAYJ0zSwY0CpEVnugHcypYhbXOJ+gOuOrOEm11la+5mEEQZ17u8aK
G2EWZRxUVLtduuteBUv4iPg4xvIf2JSHDbDCdsVnrh84PawHhrQMOb5TT/LoRqukWxjdrkZKX9K8
46A9uE59XGJvMEaoDA==
--000000000000de6a3e05f60b9760--


--===============9212946363950898482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============9212946363950898482==--

