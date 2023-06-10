Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADFFC7EE2E
	for <linux-um@archiver.kernel.org>; Sat, 10 Jun 2023 08:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:
	To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gAgEPg2vZFZXsEhm5bOcNEQVieWr14ImysX3bz7HpX0=; b=JcSSyNunGvBEpWXuetaZxO0Bt+
	+2rLegBp04Cts24a1BuFZrP7k1zSSPSI9UlZ1PlWYr4736DCo5SI9l21I8zwA7zU5yMZCeJIL6Uku
	ElpwlipwBBIF5Fstk/372vBuQ2qq4kn9gvXz9BS4g826w1LafJKiUV8u92I0KgX4h5w3cz06Uun0A
	vHYTbvtGV4mLAtQXZDNsfQaNq1hhpTdX5+7fyk7V19EeIetFoDL311WPgW02szIeRC81mFA8uqMHY
	bjrQM8bjN94eptHBL0LkVQbWIyXYrnMb5xmd8jNlWKfIV+8c8f8Kavjp5abmdZFp/J+3k9+A15rJc
	+I2REwNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7u3i-00FYMo-0E;
	Sat, 10 Jun 2023 08:34:54 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7u3f-00FYKX-0c
	for linux-um@lists.infradead.org;
	Sat, 10 Jun 2023 08:34:52 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f7359a3b78so32875e9.0
        for <linux-um@lists.infradead.org>; Sat, 10 Jun 2023 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686386087; x=1688978087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1dDHGngJKdCCbqxubSgBlzE22Q06ArUoK3D48Sptack=;
        b=Q6cftgLr9/uNByVvzJTWhksNIOGCo+/8Qp5XOa4K7lcvdY7tY05cZRQpfFOQkKWLXH
         0mkWFvqIAENq5z9YAyeyWoxIaqzPpJ/ihxENLsSN8fuqlPLMhJc9T4FesI7hZJvi0R4v
         KrU3CHkXNzldgR7qVELvg9Si4DNw98DpiJv7Qv6N/xZ/+TwWF5tz2PmHuPehKaHc47On
         pg0O+el91Y0i0i2MijmqLaPMoDVubPbjYbXjicU+vdNZhhVRDR89A+ezeVCwqu6AJNac
         au7VXEU4L7YUiKaWP134ItANaezesfaL27Qrf3cvctfWSTgRZyozfDLLHi9/ROQyMtQu
         PSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686386087; x=1688978087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dDHGngJKdCCbqxubSgBlzE22Q06ArUoK3D48Sptack=;
        b=lpXZRsAe16kar7BxTLfsj5T/FeWD11MtZeVFfk+EBD10ZieCMZu4VTQXNqJffX6a26
         NmKzyJP0ZjkAf6e7ONvZlE9AREIZ8jE0b1uPO/1nYJSQFYCKJayihbNSXhclfwIsVQGL
         YHyaOs30L34YlJv9w//y5O5tqsUhGB/hKm+FEvGP61s8PTRRpNAGVezKkyX2L7nZwicx
         DwyApZvCNAOFZDfGMyuG+q6EUVn+2GK61fe3xKCXotgWOXbG8bRCVpVkDGv8wUpZPG/t
         oOvBakdJIcruLhKe4i5uqJ54m99szgUOAMpGNOicazMHw7bZgTXbtMEnaE2fJgJJIGwZ
         omIw==
X-Gm-Message-State: AC+VfDx50a9DKrgT4HNFmiCKZod6TlNIur+e2H1bxkS7SNXAPt2e74gk
	e32CB39IYt9RUIPOzYG0J7x+Dm3tF5XmXtp6O/AFJw==
X-Google-Smtp-Source: ACHHUZ5pF1IX+3A2WJS0Sqk4i+FqnR9aJpUoYxFhwSfU1/r0xr2ZKYJJ1nO/4OnKllSg0n/yb6zZ5v/r8ZX94hkXtjI=
X-Received: by 2002:a05:600c:82c9:b0:3f7:ba55:d03b with SMTP id
 eo9-20020a05600c82c900b003f7ba55d03bmr75932wmb.2.1686386087134; Sat, 10 Jun
 2023 01:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com>
In-Reply-To: <20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com>
From: David Gow <davidgow@google.com>
Date: Sat, 10 Jun 2023 16:34:35 +0800
Message-ID: <CABVgOS=X1=NC9ad+WV4spFFh4MBHLodhcyQ=Ks=6-FpXrbRTdA@mail.gmail.com>
Subject: Re: [PATCH] x86: Fix build of UML with KASAN
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Frederic Weisbecker <frederic@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, kernel@axis.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230610_013451_233694_74CE3B15 
X-CRM114-Status: GOOD (  26.36  )
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
Content-Type: multipart/mixed; boundary="===============6216585097344340472=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--===============6216585097344340472==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b2cdbd05fdc25b43"

--000000000000b2cdbd05fdc25b43
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Jun 2023 at 19:19, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Building UML with KASAN fails since commit 69d4c0d32186 ("entry, kasan,
> x86: Disallow overriding mem*() functions") with the following errors:
>
>  $ tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
>  ...
>  ld: mm/kasan/shadow.o: in function `memset':
>  shadow.c:(.text+0x40): multiple definition of `memset';
>  arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
>  ld: mm/kasan/shadow.o: in function `memmove':
>  shadow.c:(.text+0x90): multiple definition of `memmove';
>  arch/x86/lib/memmove_64.o:(.noinstr.text+0x0): first defined here
>  ld: mm/kasan/shadow.o: in function `memcpy':
>  shadow.c:(.text+0x110): multiple definition of `memcpy';
>  arch/x86/lib/memcpy_64.o:(.noinstr.text+0x0): first defined here
>
> If I'm reading that commit right, the !GENERIC_ENTRY case is still
> supposed to be allowed to override the mem*() functions, so use weak
> aliases in that case.
>
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---

Thanks: I stumbled into this the other day and ran out of time to debug it.

I've tested that it works here.

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  arch/x86/lib/memcpy_64.S  | 4 ++++
>  arch/x86/lib/memmove_64.S | 4 ++++
>  arch/x86/lib/memset_64.S  | 4 ++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
> index 8f95fb267caa7..5dc265b36ef0b 100644
> --- a/arch/x86/lib/memcpy_64.S
> +++ b/arch/x86/lib/memcpy_64.S
> @@ -40,7 +40,11 @@ SYM_TYPED_FUNC_START(__memcpy)
>  SYM_FUNC_END(__memcpy)
>  EXPORT_SYMBOL(__memcpy)
>
> +#ifdef CONFIG_GENERIC_ENTRY
>  SYM_FUNC_ALIAS(memcpy, __memcpy)
> +#else
> +SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
> +#endif
>  EXPORT_SYMBOL(memcpy)
>
>  SYM_FUNC_START_LOCAL(memcpy_orig)
> diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
> index 02661861e5dd9..3b1a02357fb29 100644
> --- a/arch/x86/lib/memmove_64.S
> +++ b/arch/x86/lib/memmove_64.S
> @@ -215,5 +215,9 @@ SYM_FUNC_START(__memmove)
>  SYM_FUNC_END(__memmove)
>  EXPORT_SYMBOL(__memmove)
>
> +#ifdef CONFIG_GENERIC_ENTRY
>  SYM_FUNC_ALIAS(memmove, __memmove)
> +#else
> +SYM_FUNC_ALIAS_WEAK(memmove, __memmove)
> +#endif
>  EXPORT_SYMBOL(memmove)
> diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
> index 7c59a704c4584..fe27538a355db 100644
> --- a/arch/x86/lib/memset_64.S
> +++ b/arch/x86/lib/memset_64.S
> @@ -40,7 +40,11 @@ SYM_FUNC_START(__memset)
>  SYM_FUNC_END(__memset)
>  EXPORT_SYMBOL(__memset)
>
> +#ifdef CONFIG_GENERIC_ENTRY
>  SYM_FUNC_ALIAS(memset, __memset)
> +#else
> +SYM_FUNC_ALIAS_WEAK(memset, __memset)
> +#endif
>  EXPORT_SYMBOL(memset)
>
>  SYM_FUNC_START_LOCAL(memset_orig)
>
> ---
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
> change-id: 20230609-uml-kasan-2392dd4c3858
>
> Best regards,
> --
> Vincent Whitchurch <vincent.whitchurch@axis.com>
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20230609-uml-kasan-v1-1-5fac8d409d4f%40axis.com.

--000000000000b2cdbd05fdc25b43
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDC
NJZiAn+hqgx8mUgE5tg/WFkF12p49W1JGVkocyRU8zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA2MTAwODM0NDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAaGi/kY9fzj3sRA/YOKO3
T+vr4wZhbAN4UWnpT5WKKFg2mv5CXN8VSjpQhkaat3JmiVnJQTyMAhpqUgS+fy19Pu7lXLja9bWd
J02Xxg59ebAX7o75EzTPgdGkpJJ4OXsrO/8WSZwlkR/Wobhb0NRjzeo2XwX/ryvgMT//mkVw1ff4
kdRF5Ix5kXT3Eq+6RjlDrAXVKj0kMW/nmDnLHtTUaFASh2oiZK6AmPdHT09PlQaESZjdV6vLuYLD
Cc9D5s/CBTPQt3bDO+/YnT3rNjtQvoHiJq0ffja7coR2CE1QBZ8Ot7ykdIxJ87bw+CpBfC8nN9Zk
BPY/Ed6ApQJIg4Sh8g==
--000000000000b2cdbd05fdc25b43--


--===============6216585097344340472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============6216585097344340472==--

