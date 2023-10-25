Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57D2C25B6B
	for <linux-um@archiver.kernel.org>; Wed, 25 Oct 2023 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:
	To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pxQpUgMArBkmqa0CXIojYIR3JIwRAe03I85Nv9PSBmk=; b=l3SHRVavmE43dYA7KdvfjT/0ID
	yHHewsprg329jJ7FrycGyMGxfAHVWXb/eUga1WJyd+V03LeHVbjysi6RoG9tcKH+mgSX+wTEUXUC1
	DF79RyCWHDwBfUoqQhwKwAZxLHyUpB//4W6bDHzgiKHJjFn1SDGfj95mSHvzFkxrBAFA4DZZ/MBKM
	+J/p8HyD0BH++lY1TDeORqMvRN7XOdvRMWEffw4zu9zDvr8RUwxdQlagR2ZWDM/dB3R6bomu1Oc81
	N2wpzuym1Sb440T1b0akB5J/SErbCjC88A2LNxqLHaHMooKBPU8KC/HFr2cjEXbrPaorpZr/UHG96
	0Ubsle6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvZFT-00BiDv-21;
	Wed, 25 Oct 2023 08:28:19 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvZFR-00BiCw-0F
	for linux-um@lists.infradead.org;
	Wed, 25 Oct 2023 08:28:18 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so6810a12.1
        for <linux-um@lists.infradead.org>; Wed, 25 Oct 2023 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698222492; x=1698827292; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QBXsrnp2HzldLoRgomhyPDqYwpSAM86MlLmpn445CbI=;
        b=hOlkf7HzoisS8sGIlaHAsl1wPtkhvhFXlkXlAucA56gaRciaHUWh8uLB09r2lHl0zt
         ZOK6n/moS24DCbac3LVrN1C80OXJOTtekldaIMYWyO8DZZjj2L0v7Wu8OrDglX5BBPDM
         powA8opZ3mI69n7ACjHPm2MxZB3nNLthacv0RBcW490UlneY2Hta7Je255lbFwCiKWoX
         I/8N3l3VEEtQFZcU2D4PiUu5OjoNkcOt4aPN7bKf2IdkG66xTV9xoNYQBQ3+Z7UOjVQj
         +Eh2TSBdJeRvYjZDso7xWRAdCJyJvafkAO3waWJNxZOj6ilNCRK2UqfFpxB+qdgXD7wb
         unag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698222492; x=1698827292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBXsrnp2HzldLoRgomhyPDqYwpSAM86MlLmpn445CbI=;
        b=AKHEiU1QshT+2Q/SLubKtQVKgQBd0bTzrNJoDVVHh349/qgPxeVBOsS2q9woaE3hIi
         KlnWIvC1gfBTiPYXnHkpZBrltD0elYPq/rhCQyZGNyRsJDunzUrcOEdVg5nx0P71LWxq
         9R9XGxI+lH2Y3mf0O1zLJ4WrQkhh6NiLVlY8BtSAr16EyM5ObwAzx7dZyIJxStaZ4dfK
         C4HZA1ZEXgHnGmR/R2tcaTggQvmVc6TFKjmGkalOXIwz8jnGxD7RnOJCf7IA8SzBROWV
         qTzJw0bCMEAYXRnCE2FyTZ4emdTxAPwKHYtup0QpPhswe1IJm1IRGLoo6gLdGMWyFs25
         UMuw==
X-Gm-Message-State: AOJu0YzJjRwBt85/Ie9aqTiuOH+4JDDFTSImoUhda6t/mNAF046DoR6n
	XSDKQWA61TThCTemNxRDK1HBQmzDXx8qIZ3n5+4P2w==
X-Google-Smtp-Source: AGHT+IEGWYWNiIaqzN0vKzJIergvl6YCOlgENn+C6j4e2PoYyktLfG6YdN6lCeAVIv9hI2dGc+44QeqOJT29mHIu4wQ=
X-Received: by 2002:aa7:c0cf:0:b0:540:f047:29f8 with SMTP id
 j15-20020aa7c0cf000000b00540f04729f8mr18579edp.0.1698222491756; Wed, 25 Oct
 2023 01:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231020092159.2486063-1-michal.winiarski@intel.com> <20231020092159.2486063-3-michal.winiarski@intel.com>
In-Reply-To: <20231020092159.2486063-3-michal.winiarski@intel.com>
From: David Gow <davidgow@google.com>
Date: Wed, 25 Oct 2023 16:28:00 +0800
Message-ID: <CABVgOS=yMiadnA=tWWWJ6WgOAHvWSNJXcXCh9jxeb3qyDM0J0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: kunit: Add clang UML coverage example
To: =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
Cc: llvm@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-doc@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, Tom Rix <trix@redhat.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Richard Weinberger <richard@nod.at>, Jonathan Corbet <corbet@lwn.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_012817_138402_B21288F0 
X-CRM114-Status: GOOD (  22.76  )
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
Content-Type: multipart/mixed; boundary="===============0206016460863314397=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--===============0206016460863314397==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006607530608863c35"

--0000000000006607530608863c35
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Oct 2023 at 17:22, Micha=C5=82 Winiarski
<michal.winiarski@intel.com> wrote:
>
> LLVM-based toolchain is using a different set of tools for coverage.
> Add an example that produces output in lcov format.
>
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---

This looks good to me, minus a couple of very, very minor typos, and
the fact that this whole section could probably do with some tidying
up. We'll deal with that separately, though.

UML folks: do you want to take this via the UML branch (alongside
patch 1), or should we take one or both of them via KUnit? (Or, this
could go via the docs tree, too, I suppose.) There shouldn't be any
merge conflicts on our side.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/kunit/running_tips.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentati=
on/dev-tools/kunit/running_tips.rst
> index 766f9cdea0fa..9f69c122dee7 100644
> --- a/Documentation/dev-tools/kunit/running_tips.rst
> +++ b/Documentation/dev-tools/kunit/running_tips.rst
> @@ -139,6 +139,17 @@ If your installed version of gcc doesn't work, you c=
an tweak the steps:
>         $ ./tools/testing/kunit/kunit.py run --make_options=3DCC=3D/usr/b=
in/gcc-6
>         $ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/ --gcov-=
tool=3D/usr/bin/gcov-6
>
> +Alternatively, LLVM-based toolchain can also be used:

Nit: should this be "an LLVM-based toolchain" or "LLVM-based toolchains"?

> +
> +.. code-block:: bash
> +
> +       # Build with LLVM and append coverage options to the current conf=
ig
> +       $ $ ./tools/testing/kunit/kunit.py run --make_options LLVM=3D1 --=
kunitconfig=3D.kunit/ --kunitconfig=3Dtools/testing/kunit/configs/coverage_=
uml.config

I'm not a big fan of the --kunitconfig=3D.kunit/ bit here, but since
we're doing it in the gcc version above, let's leave it for now for
consistency.

Also, Nit: two '$' starting the line.


> +       $ llvm-profdata merge -sparse default.profraw -o default.profdata
> +       $ llvm-cov export --format=3Dlcov .kunit/vmlinux -instr-profile d=
efault.profdata > coverage.info
> +       # The coverage.info file is in lcov-compatible format and it can =
be used to e.g. generate HTML report
> +       $ genhtml -o /tmp/coverage_html coverage.info
> +
>
>  Running tests manually
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> 2.42.0
>

--0000000000006607530608863c35
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAk
APQo7UrF/Ip75RUpS/LcNrsGP4Wv1t/Yb+9hJ5yRQDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEwMjUwODI4MTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAmw5BZlv9DCxXCRgOAbi0
F4NRFNwyGJuieziG3TxDcMuJ8plZXTi6AOMT4U6EBLIFdhQoCgvnD0oNyg2AWHClpVG6M4nKqadK
gjXkC6LVxbIXURMH7wNgB+HhwjsIMUg99LAJ+SbQYPcO3a97eyw0Nr22rMDtntXCA8hZ+5EuTRVq
OxciqD/bl9VXCtQka7ADDgWrjHPSy9ugt3Y8lxNoegsghG6b5lAhbsClpoczZ0HQj5Fvsgn/rSyB
PRvlG232jRwzh8JeFK0WJjhlmReVPdOLsU8/FPewqIlRghFx5afpii+mmoWBpjspzPrMbnOhBVqM
iQOzmDH3ecbXXUHEOQ==
--0000000000006607530608863c35--


--===============0206016460863314397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============0206016460863314397==--

