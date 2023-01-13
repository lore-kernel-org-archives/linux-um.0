Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1904C54EBE
	for <linux-um@archiver.kernel.org>; Fri, 13 Jan 2023 06:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:
	To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DLOVy/B1nfZfPcA6ZiNxtxGpBNAl5d7xm+/CsFZszjQ=; b=l1W2+Ty14V4EbHn1MBv+gDjlG7
	bnU9tkMO5mGUAU3vQzqWIbZbYlIKJeD/D+cqBIMQFTvvyn7Dm2o0dDaoptrORwprLJEI8PqW/TeAT
	CHJbPg9zBQgvgdl2kj1I6kjJtHk+0wAkontr0wy/rho+9eRqAnR67zgKEzUXge/cofQAI/b84Kao+
	58uTBulNEFrmaLCmBdsBJQczQNXmJ8eCGHhtH8L3RQ6XNN9wZkZ3P3UiPNjOXu/ClwYmT5Y46BgPw
	oOn65d2o6cCDYJJn39wXEsGWecE+Bfzi3wiryCJD8ceM52SDlbsbX84PM78iqY9JJIBlTYliS7Szg
	IwALmMyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGDnQ-000rrT-0Q; Fri, 13 Jan 2023 06:44:12 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGDnM-000rqe-Um
	for linux-um@lists.infradead.org; Fri, 13 Jan 2023 06:44:10 +0000
Received: by mail-vk1-xa30.google.com with SMTP id w72so9819786vkw.7
        for <linux-um@lists.infradead.org>; Thu, 12 Jan 2023 22:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DsXL4nqS9Mt3AygFOmvmx3BBjqc9Gvp28oqJ5/bh7tY=;
        b=bvWrov9cPeRl1Ghv5wtc34rytsWAsMdi/peeXIVLzSmYUPH28jdaqME+NYFNg2WBm0
         HNbpQsKfmsOZYGZ8REvHur6qiAaoI/SP029RHxOOlnKz1sfXKIh0vXIzrmye92teCrYi
         BqTloOR/RIQm0e2DOUsICMm81RoVl7rXBv/8dOdTd6UUCRtjhrB2PCug4AqOR+H1rTvH
         NqZoI0/9K00/xjXTJmnBjqEfMj6lf3lfDq676Gr58i9cI42QKC1dndPyo74JXT5pC+ng
         EzhoYFjk/B3+28VSzFUkcagGipX57EdxhjHwDkUetDCSdTflLA2SG8wZwPk0rjg1XsrL
         wwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsXL4nqS9Mt3AygFOmvmx3BBjqc9Gvp28oqJ5/bh7tY=;
        b=MWHWzdS40Da4bAN1oOOS+RnGV7pG2uEh8ZgnqTbfcLYCevAMrAQGx7FKdkDDaDYxYl
         6zjEmTQt6TX7lG2CX12NEXfEgjyIzpU9vMN0l0G8f3UQ1HgnOoyGnBQ9KuUryvgMKW2K
         JkcTHz0rFzhAu8HKUgyD0mtYisiaqTpoSIP+FYvO85wHAIt1E6XgmYwwZx0Sm/GUIUQ3
         dhsibwbX+RYR1u/ch75K8P9PBrDQSN43dhwYHlLYw3obS7OEp+A0gKRf887NfMD4q5gq
         p8ZOM0AkmJJrQP2TwKJyNEF3HwOvFSCOil/rtgROT+QVZwC7l2yzwndXDB4lhKh07Dkd
         k6Bw==
X-Gm-Message-State: AFqh2krLeQF/5yP/ukSDrj0JzyG3nh3Aq9JZf7w9B9SVSXweOeIFZm9I
	fg7u4+yU30dZY53L4fjvYud/8xGXjl4bd+h5TSOmlg==
X-Google-Smtp-Source: AMrXdXukU/QxfwcgwYi1CqD1H7junTd7uSAZWTn7sjGoQGq/I7hk46P4JjFteV2TWUgZhFGXl3GEp8sjhPiUmhwhit8=
X-Received: by 2002:ac5:c94e:0:b0:3d5:7054:8ac4 with SMTP id
 s14-20020ac5c94e000000b003d570548ac4mr7427533vkm.37.1673592243887; Thu, 12
 Jan 2023 22:44:03 -0800 (PST)
MIME-Version: 1.0
References: <20230112-um-v1-0-6bec9e97ad13@pefoley.com> <20230112-um-v1-4-6bec9e97ad13@pefoley.com>
In-Reply-To: <20230112-um-v1-4-6bec9e97ad13@pefoley.com>
From: David Gow <davidgow@google.com>
Date: Fri, 13 Jan 2023 14:43:52 +0800
Message-ID: <CABVgOSkrceefKtaodBJ714o6KtyH0K8oxhUex5QyFz85vd_ykA@mail.gmail.com>
Subject: Re: [PATCH 4/4] um: Use CFLAGS_vmlinux
To: Peter Foley <pefoley2@pefoley.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_224409_033811_EC401F55 
X-CRM114-Status: GOOD (  21.80  )
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
Content-Type: multipart/mixed; boundary="===============8591051711936438864=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--===============8591051711936438864==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000037afbd05f21f8ffe"

--00000000000037afbd05f21f8ffe
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Jan 2023 at 12:49, Peter Foley <pefoley2@pefoley.com> wrote:
>
> link-vmlinux.sh doesn't use LDFLAGS_vmlinux when linking the kernel for
> UML. Move the LDFLAGS_EXESTACK options into CFLAGS_vmlinux so they're
> actually respected.
>
> e.g.
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: warning: .tmp_vmlinux.kallsyms3.o: missing .note.GNU-stack section implies executable stack
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions
> ---

Thanks very much for fixing this -- the LDFLAGS/CFLAGS fun here always
trips me up!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  arch/um/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index f1d4d67157be..93dfb23bd263 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -139,11 +139,10 @@ ifeq ($(CONFIG_LD_IS_BFD),y)
>  LDFLAGS_EXECSTACK += $(call ld-option,--no-warn-rwx-segments)
>  endif
>
> -LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS),-Wl,$(opt))
> +LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS) $(LDFLAGS_EXECSTACK),-Wl,$(opt))
>
>  # Used by link-vmlinux.sh which has special support for um link
>  export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
> -export LDFLAGS_vmlinux := $(LDFLAGS_EXECSTACK)
>
>  # When cleaning we don't include .config, so we don't include
>  # TT or skas makefiles and don't clean skas_ptregs.h.
>
> --
> 2.39.0
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um

--00000000000037afbd05f21f8ffe
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCC
9JWrKXIRVrx/qrTMRABCLmyNZl5B/BdNAxr/ZSzIqDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMTMwNjQ0MDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAuP7+QFT9RJFA/KqmQk7T
ORWPQfJSKVu657d5n0tZT1B0nBIt1Uv8jxPgByZKZu1hPF1M0gbYXwo2xAlX+EA8kR3+NybjdtkC
HEn6dre7WXjBeZ97sUd4CADMrtYcljsmMagkPV6qz4h0EN6Cxnmi0RPlRHhheiSLXT1PoDwovB0B
owwEWtLDpX3Zx6f5iJc+3uKyiYWfeWghnGIQzDRsnn4+2zd3FTc7kXuk6Mc/ZdUG/Wd6duJoC+H5
gpXbPVles8zt2cSou4Ac+iSXPs/rT7zO1gUBiWp6rngEYcaALYLC64lq3FRwr4iSDlRraG6Emw6B
ynUC6mcjgvcaKbg5OQ==
--00000000000037afbd05f21f8ffe--


--===============8591051711936438864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============8591051711936438864==--

