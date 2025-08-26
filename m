Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACA4CA0FE7
	for <linux-um@archiver.kernel.org>; Tue, 26 Aug 2025 01:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lf0RRyVLXxZA0rd9NMG8zW8kzFDO8nThOhsfKLP33mo=; b=K6eV0hM+cT8rBhDMrPqPXAnyq6
	tZXSU0K8fo5vCWyhOkX7HCIMn+7xC3TF4aOXXEo796/jiLnlDQRnSWEdcNNR6avW9HLVX16xQxaxQ
	HfszJWc3DW6/u1toUmGlEzXQ13CVDwWez1jyhJYCeURWGhXQvt6OTU5ZP6Rrisz7u1ty7lGFDHDwH
	2xCqS9t2XdfpFOK/z4T/zicuHG5JmxJbWwl+8exqWh/Bl09MzDlLDoUNZ8sxYzD6ghWzhtvSHYdQl
	Lb8H4PPMU82rWgEmSKbYl7rJZh20/BVOvhEWLfk1GOb9a3N9omjxqEgtRh/a2hznZUoMy/l6Z5w4c
	h3O9zohw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqidm-0000000AIJH-1oZ6;
	Tue, 26 Aug 2025 01:38:26 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqidk-0000000AIIe-1Pyz
	for linux-um@lists.infradead.org;
	Tue, 26 Aug 2025 01:38:25 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2445806e03cso58905785ad.1
        for <linux-um@lists.infradead.org>; Mon, 25 Aug 2025 18:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756172303; x=1756777103; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lf0RRyVLXxZA0rd9NMG8zW8kzFDO8nThOhsfKLP33mo=;
        b=yeD81+7Gx/hLuUcSPHrdr59QzV1B2+07gvtZEf1ul00Gbm+JLGcvMYpFjv7zEngGJX
         TOvtmUSVXUEOMlLQUkjXOv5LYLI2vfu9OKpPHVdbbB5I3HLKX102kridn69vc7YDfDed
         aLyRNgAmBMfQhR0jlw3pqw0Eup3afohRyIJRnJJHnnu/7YmOZocAWfh7lwJQSOYK3me9
         AP+/+OWEnE56sRKaqQPhK5Bi+u26q2LfTYulYCbxr6Dy3yxdBH7F71nW6plgUYOk4D5o
         KAkQvljKPgWj9ZElvl5VSDzBpbKT2ddAFkz3n0av+Yur3BxhewKOWWxrkK793IEtoakZ
         O6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756172303; x=1756777103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lf0RRyVLXxZA0rd9NMG8zW8kzFDO8nThOhsfKLP33mo=;
        b=J/jJtOOaHkROuaY3QSx/qte1NB2/yGxu69ef13JXhe10825tqD5IVjpdUnV/dPVnn2
         dhBnJpgFzAe9ZyOj8+LxUg8GodOXDBp797gGL+2lCBiq76nrFKK5GyYG9YOQ3jcrcy8p
         D/K+Zf+pq//1X7vzoUfJdcQFFSb4jIJDW66SPUtArj4JpMmQC5TaEZ5D6aHSZ7BptBSZ
         eaiNZt6FgRFr7wjC3XjE3/xaFSNRatMqqdAk3p+96sNZRucQ4tHK4mGUUjcfhs1kZk4X
         TVdDiyNzAVGQnfnh81Bk5r+/mQcd8pGFiI4jsBodskFvru22prbtuYhCFo/+LS77XJ1o
         JbHg==
X-Forwarded-Encrypted: i=1; AJvYcCXgmxzcYs3uVZ8OP/z+sJMBjJ4simiYmFtZyRQULVrbtWJMXdexLpQ1XWDZ18Bsc4cNdD2XtDZZsg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVXnfzrm7YBkSfhQwDJ1RXUuZql0cfXx8/BVZf9WMxcP9tfAoZ
	b0q7/dKbnsGslE0v9itQgSSscyCB6vhs2tHUTNCrjn669KYy+6LtAvih4Qp89i/jHyTJUQabjJF
	T4K51a75QcteDrM+BK0OAuUpx9uGjAZ49Vjtw58nx
X-Gm-Gg: ASbGncvkXCzRCZHfBY/b43T9HPdKeaphmhfCg9yG+oODYGsTLAYQUE8Cf1CiUH+xS5K
	29TgooZLmmeV3xrqMXY55dqTrQuMqCkiQQrV/YIiQ3JIsR4Jt2HvwYedgzdDbc0rLjgMRZ0DIVO
	5MnYrh4bz/FPaMIEHwtlFMQ4PDoQOJ3ntcrHNS/3xgLFlEDxxN9F0kJpWuy3Kda+WqJIBWhq9U/
	1WlTt1CmSs+
X-Google-Smtp-Source: AGHT+IF5/61I4XwZ/vyS07+EaWHZ4Fq0osHGUkL4sWnZXvln1liKe/SWCO0zbzJoVRiXSB3WxcjUl+4cuyofOvP7o5s=
X-Received: by 2002:a17:903:246:b0:245:f7a8:bc68 with SMTP id
 d9443c01a7336-2462efbdcddmr170812525ad.57.1756172302616; Mon, 25 Aug 2025
 18:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250825212031.111027-1-briannorris@chromium.org>
In-Reply-To: <20250825212031.111027-1-briannorris@chromium.org>
From: David Gow <davidgow@google.com>
Date: Tue, 26 Aug 2025 09:38:08 +0800
X-Gm-Features: Ac12FXwHhnvEdYizKzz9_FSPwRdLEkJkn9ajTHPE2BmbVh7Mebbnl6TJogbignA
Message-ID: <CABVgOS=rbrs_bnXb4pJ8iEh5pgfGJ3F1ofzwG7YEYdfx48-TdA@mail.gmail.com>
Subject: Re: [PATCH] um: Support SPARSE_IRQ
To: Brian Norris <briannorris@chromium.org>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sinan Nalkaya <sardok@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004ceb34063d3abab6"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_183824_402924_DF46C5E2 
X-CRM114-Status: GOOD (  29.43  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--0000000000004ceb34063d3abab6
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 05:20, Brian Norris <briannorris@chromium.org> wrote:
>
> From: Sinan Nalkaya <sardok@gmail.com>
>
> Motivation: IRQ KUnit tests are going to require CONFIG_SPARSE_IRQ [1] in
> order to:
> (a) reliably allocate additional (fake) IRQs and
> (b) ensure we can test managed affinity, which is only supported with
>     SPARSE_IRQ.
>
> It seems that the only thing necessary for ARCH=um is to tell the genirq
> core to skip over our preallocated NR_IRQS.
>
> Tested with:
>
>   $ ./tools/testing/kunit/kunit.py run
>   [...]
>   [13:55:58] Testing complete. Ran 676 tests: passed: 646, skipped: 30
>   [...]
>
> This comparse with pre-patch results:
>
>     Ran 672 tests: passed: 644, skipped: 28
>
> i.e., we no longer skip tests that 'depend on SPARSE_IRQ', and existing
> tests all pass.
>
> [1]
> [PATCH v2 4/6] genirq/test: Depend on SPARSE_IRQ
> https://lore.kernel.org/all/CABVgOSngoD0fh1WEkUCEwSdk0Joypo3dA_Y_SjW+K=nVDnZs3Q@mail.gmail.com/
>
> Signed-off-by: Sinan Nalkaya <sardok@gmail.com>
> [Brian: Adapted Sinan's patch; rewrote commit message]
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---

Thanks -- this seems to work well here. I can confirm the KUnit tests
pass (including with 32-bit builds), and nothing I've tested has
failed so far.

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David

> This is adapted from Sinan's work at:
> [PATCH 1/1] um: Fix broken IRQs if SPARSE_IRQ is selected
> https://lore.kernel.org/all/1360193940-31504-1-git-send-email-sardok@gmail.com/
>
> Place any blame for errors on me of course.
>
> I'm not much of a UML developer, although I've been developing KUnit
> tests which default to running on ARCH=um.
>
> I also can't quite tell if MAY_HAVE_SPARSE_IRQ or SPARSE_IRQ is a better
> 'select' target. Almost every other architecture uses 'select
> SPARSE_IRQ', with the one exception of arch/csky. For my purposes, it's
> better to 'select SPARSE_IRQ', for consistency with other ARCH'es, and
> to make it easier for KUnit builds to get it. But I'm less sure if there
> are good reasons to want to make it user-(un)selectable.
>
>  arch/um/Kconfig      | 1 +
>  arch/um/kernel/irq.c | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 9083bfdb7735..8161cc5ae6f7 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -38,6 +38,7 @@ config UML
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_SYSCALL_TRACEPOINTS
>         select THREAD_INFO_IN_TASK
> +       select SPARSE_IRQ
>
>  config MMU
>         bool
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index 0dfaf96bb7da..d59a5a0f7fbf 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -691,6 +691,13 @@ void __init init_IRQ(void)
>         os_setup_epoll();
>  }
>
> +#ifdef CONFIG_SPARSE_IRQ
> +int __init arch_probe_nr_irqs(void)
> +{
> +       return NR_IRQS;
> +}
> +#endif
> +
>  void sigchld_handler(int sig, struct siginfo *unused_si,
>                      struct uml_pt_regs *regs, void *mc)
>  {
> --
> 2.51.0.261.g7ce5a0a67e-goog
>

--0000000000004ceb34063d3abab6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg2iqp08WW+0tai/AkQk6KxQHTxQDl
hNxRtgVzjF35o5AwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
ODI2MDEzODIzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAhIINc2F/Ut4nakZrIe+eCQM1TlM3E7JPNVlTMaUNo3VX4vzYLVyqFfoW5+HEDUl6
jyQbq99G+R9BD2/ZFd20Y/iOezEeIzKkDtZqt6vx/qfoqa2nmqjy5dhxXSLeR7VEt4SoYSruYFL5
5UStVLBwIaqhTd1RgIGv4iTwznNNmZ5Bvz6l4CZr8CKKrY1lgbanUgmnD4Mwgnt/2v4BRtdKB+7l
mNQMsz8xzyemnKQmr7PEvs34w2CYDr7GC7tQYf+grxejDUZvo0kMS+eZ22B7IKzRRlZFNxH4wn1r
z9Jrx0ky3/+vw1kJr4QG4lKpv7V6V+qYPjYa00Fr5/m837K4xw==
--0000000000004ceb34063d3abab6--

