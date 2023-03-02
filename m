Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B1AC6FA8E
	for <linux-um@archiver.kernel.org>; Thu,  2 Mar 2023 08:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:
	To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h2R65SsUG0OLkIUmSicYxPf8056gGQMDatkHgQm4MXU=; b=bQMOedMc0XGdEzPD8xkZp4tNtC
	meX59qQTAArXWdi/eBT3QhrUKwi9n8vRiTE5j5uMt33uBdrcuu8cTLpx589/j0ACathiZS8NZaZG5
	iSAgh1Q+yfY1SGyrycYKm1gZGKsr2psdMBpOlSuJY184RJLhAUiSJDs14J83ZjZnb8dIueskgkvzc
	lxmbnNlT+9f4rC3jxWoV0T9W4tRaxXKA8HlI3viEi6qMFicICdbHf+cM36rid0C/HXJlqXDf2FJHW
	MkZWUDrc5nQH27Pjg8BnBhNZjjjDKApw2GeMN26ogfgaL7gAn1P5djhtzmsv2zuttWOhTmkgzU7qU
	VM9t8SMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXe4v-001Etr-BT; Thu, 02 Mar 2023 08:14:17 +0000
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXe4s-001ErJ-2S
	for linux-um@lists.infradead.org; Thu, 02 Mar 2023 08:14:15 +0000
Received: by mail-vs1-xe2c.google.com with SMTP id o2so21636119vss.8
        for <linux-um@lists.infradead.org>; Thu, 02 Mar 2023 00:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677744847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9vLA2iDX+f5C2MP5komqh24Nju1GPCc0I88tHcRbjFE=;
        b=MWDpLJe9e3QNDR5W/C10oLyLbWfWIkZD06QycxIpWSwJXZtErZZ8XcSpZz/N45lAHH
         xYnA4bm8ybdGEfaiPkf/T7Sh+C09iUIHxcwSyxvwLMEpuedSu5TQ1dTtKtAqSlPcWuTt
         GG3E42zb6IiejRCw62wHFwfE43JwtgP2clSymmH0qXajZN9dP4mjwSyHBYaw/d43CVd2
         3LRjv1uQNZUJVF1jAJlp0SG5igApiIfqsaS7Rf2iP+PY1AaU5GndkeYPE+LKU5wIs4Px
         j1kcoNdfGj9XPWDFTxPhneL+dDdQYSheR5RsufeAbgwyCWENCMto5k631Sj/r5tyFVWB
         lu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677744847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vLA2iDX+f5C2MP5komqh24Nju1GPCc0I88tHcRbjFE=;
        b=UkKFY0pAbnD1tisdhvksaoXFurAlXvgIthayb4YiLfZ+RVHuepp2dFgm50OayLcC4J
         0GSGRZAh7qGMzSrQtpQgnfNaZ3XVFpF1SYfZGrWWudOosA9bZkEQ20Mj7oRAo/a5MbkC
         GlJuvG90HN0KbFCDf57X86NNJXXQiCuGiGXB/5V6N8F4OwDc4exXuKMdUOsKOkyRWgbu
         XHP4RBWFOZN/S4CSusyNUhf6sg3Bx+yjRb67O6EwvCRfimu/aQg6JQiMaUWyxNhlDtxa
         Kxg3gPxWZ7pqghNPCM+O0d6JsP51JDgXCH3dPDuLNayLGwLwmw69ypCfhZDl3F4v9HCC
         npqg==
X-Gm-Message-State: AO0yUKV88M1p3FpC4M5ThcHNr1pVFTNYzkG6weo96XtVnJS1NeZy5Pbj
	1rvpEj/0XIzKq4NP5bocs6OQOJTouEIedVFRGqG/hg==
X-Google-Smtp-Source: AK7set+eo05sdidE0iL7vRNRctC8Kzb5aINrjn8iUyRsSTBfKC7KHzh5BN+ZIpYkcfrr9iEzBzhiQG+RzBhvC94luMg=
X-Received: by 2002:a67:cd05:0:b0:414:2d02:6c96 with SMTP id
 u5-20020a67cd05000000b004142d026c96mr6109677vsl.7.1677744847283; Thu, 02 Mar
 2023 00:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org>
In-Reply-To: <20230302013822.1808711-1-sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Thu, 2 Mar 2023 16:13:55 +0800
Message-ID: <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_001414_187861_58BAD054 
X-CRM114-Status: GOOD (  36.22  )
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
Content-Type: multipart/mixed; boundary="===============5958437039596059987=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--===============5958437039596059987==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ab2cf405f5e6693f"

--000000000000ab2cf405f5e6693f
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
>
> This patch series adds unit tests for the clk fixed rate basic type and
> the clk registration functions that use struct clk_parent_data. To get
> there, we add support for loading a DTB into the UML kernel that's
> running the unit tests along with probing platform drivers to bind to
> device nodes specified in DT.
>
> With this series, we're able to exercise some of the code in the common
> clk framework that uses devicetree lookups to find parents and the fixed
> rate clk code that scans devicetree directly and creates clks. Please
> review.
>

Thanks Stephen -- this is really neat!

This works well here, and I love all of the tests for the
KUnit/device-tree integration as well.

I'm still looking through the details of it (alas, I've mostly lived
in x86-land, so my device-tree knowledge is, uh, spotty to say the
least), but apart from possibly renaming some things or similarly
minor tweaks, I've not got any real suggestions thus far.

I do wonder whether we'll want, on the KUnit side, to have some way of
supporting KUnit device trees on non-UML architecctures (e.g., if we
need to test something architecture-specific, or on a big-endian
platform, etc), but I think that's a question for the future, rather
than something that affects this series.

Similarly, I wonder if there's something we could do with device tree
overlays, in order to make it possible for tests to swap nodes in and
out for testing.

I don't think either of those ideas should block this from getting in though.

> I Cced everyone to all the patches so they get the full context. I'm
> hoping I can take the whole pile through the clk tree as they almost all
> depend on each other. In the future I imagine it will be easy to add
> more test nodes to the clk.dtsi file and not need to go across various
> maintainer trees like this series does.

That seems pretty sensible to me. I expect there'll be a few minor
conflicts on the KUnit side (there are a bunch of small
lib/kunit/Makefile changes in 6.3, and there's a plan to do some more
serious changes to the kunit_resource API at some point, though I have
my doubts they'll all hit in 6.4), but I doubt they'll cause too much
strife.

Cheers,
-- David

>
> Stephen Boyd (8):
>   dt-bindings: Add linux,kunit binding
>   of: Enable DTB loading on UML for KUnit tests
>   kunit: Add test managed platform_device/driver APIs
>   clk: Add test managed clk provider/consumer APIs
>   dt-bindings: kunit: Add fixed rate clk consumer test
>   clk: Add KUnit tests for clk fixed rate basic type
>   dt-bindings: clk: Add KUnit clk_parent_data test
>   clk: Add KUnit tests for clks registered with struct clk_parent_data
>
>  .../clock/linux,clk-kunit-parent-data.yaml    |  47 ++
>  .../kunit/linux,clk-kunit-fixed-rate.yaml     |  35 ++
>  .../bindings/kunit/linux,kunit.yaml           |  24 +
>  arch/um/kernel/dtb.c                          |  29 +-
>  drivers/clk/.kunitconfig                      |   3 +
>  drivers/clk/Kconfig                           |   7 +
>  drivers/clk/Makefile                          |   6 +
>  drivers/clk/clk-fixed-rate_test.c             | 296 ++++++++++++
>  drivers/clk/clk-kunit.c                       | 204 ++++++++
>  drivers/clk/clk-kunit.h                       |  28 ++
>  drivers/clk/clk_test.c                        | 456 +++++++++++++++++-
>  drivers/of/Kconfig                            |  26 +
>  drivers/of/Makefile                           |   1 +
>  drivers/of/kunit/.kunitconfig                 |   4 +
>  drivers/of/kunit/Makefile                     |   4 +
>  drivers/of/kunit/clk.dtsi                     |  30 ++
>  drivers/of/kunit/kunit.dtsi                   |   9 +
>  drivers/of/kunit/kunit.dtso                   |   4 +
>  drivers/of/kunit/uml_dtb_test.c               |  55 +++
>  include/kunit/platform_driver.h               |  15 +
>  lib/kunit/Makefile                            |   6 +
>  lib/kunit/platform_driver-test.c              | 107 ++++
>  lib/kunit/platform_driver.c                   | 207 ++++++++
>  23 files changed, 1599 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/linux,clk-kunit-parent-data.yaml
>  create mode 100644 Documentation/devicetree/bindings/kunit/linux,clk-kunit-fixed-rate.yaml
>  create mode 100644 Documentation/devicetree/bindings/kunit/linux,kunit.yaml
>  create mode 100644 drivers/clk/clk-fixed-rate_test.c
>  create mode 100644 drivers/clk/clk-kunit.c
>  create mode 100644 drivers/clk/clk-kunit.h
>  create mode 100644 drivers/of/kunit/.kunitconfig
>  create mode 100644 drivers/of/kunit/Makefile
>  create mode 100644 drivers/of/kunit/clk.dtsi
>  create mode 100644 drivers/of/kunit/kunit.dtsi
>  create mode 100644 drivers/of/kunit/kunit.dtso
>  create mode 100644 drivers/of/kunit/uml_dtb_test.c
>  create mode 100644 include/kunit/platform_driver.h
>  create mode 100644 lib/kunit/platform_driver-test.c
>  create mode 100644 lib/kunit/platform_driver.c
>
>
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>

--000000000000ab2cf405f5e6693f
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCZ
WaucD0NMjqOIX/IMKoUJSNguWt3ohrR3VskZhSO4ozAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMDIwODE0MDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAkKhR147ibw/Y/5t4aVdv
my6ZP/2qL+aRhFp2DDXIclXZkiNm74sswMSGVhENlYvOsqDQueHA9q2WWlCc1hRhZPjqinBrASq2
1F9kkWUfRoS1xqb32Fq21cfC49mPWJc/dBzS8mf0DuzIoFhlW6uR9uAA+94sUo7DisSGAiffY5Oi
eWDSCPbnbwH1K0XA3lrV9mnLy5X2JsqN5LWdwUfL12zmRIvsJhgrZlvOzuVfwQNlrHV7Jf4SR9y3
DPhbhHhZA+uczwPIz1UuPg9Sg+0Sa0JTPk4L+0cJcfIdPVo+YUODIDqdeoRuT5jtjoM2DJp5EGBD
EDhF2YHampLaXjk6Dw==
--000000000000ab2cf405f5e6693f--


--===============5958437039596059987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============5958437039596059987==--

