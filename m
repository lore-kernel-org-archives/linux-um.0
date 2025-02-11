Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28DCC0219D
	for <linux-um@archiver.kernel.org>; Tue, 11 Feb 2025 09:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5JENigUrfzBBZLhQUAekfJuSn50v9tbpsZV3StBw/I8=; b=hI8B/MFUw4Qf2raCMNZcEIQTrN
	j/BrDmjXQTTJ11YEnbuxhIdsQ5U5ETR8xBpRgdnh3Z1CwJ6iUeLwx1pnWsriXNLGh3Jenx7T9Cv1Y
	8nlv2OYneoPBtzi187yyu07LQKqI8SMeqNtGeLzcZFVTOyKb76uNU9YGyNWjYLRWnMAAEMF2O5o/z
	Y04g6SQCQ/qK/2iYvSKliEzyO1mMOKrki+jrADgPsTUdgDcL1GSREwnqCOKurCIN2HHS6pGH4ecpS
	d0TF47i+8c2kt6htCgcKhnHgnYdxzEZn49omj5lNL8uy/zH3cTvCAcXcFYiijBBHsk3mV1OGj2Py2
	hphbLWeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thmpK-00000003EZQ-2tvx;
	Tue, 11 Feb 2025 09:45:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thmpJ-00000003EYw-0o9V
	for linux-um@lists.infradead.org;
	Tue, 11 Feb 2025 09:45:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BB66F5C0450
	for <linux-um@lists.infradead.org>; Tue, 11 Feb 2025 09:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2AEC4CEE4
	for <linux-um@lists.infradead.org>; Tue, 11 Feb 2025 09:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739267108;
	bh=TEIGhxaUGI1Ch0iRLAsquvf+IbizuWIMupKqf+DJGxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C1LTG0ooUZOdimnGuXhiNYOefueMslV3i7o+W8QdDIhVNXF6UTDXakEZ8TNYX+q5x
	 lVyTC1SHxiU57uO+nzy4J9g7VzmmUAt6UN30rTvORrFy8cha999sm37lRre7loyPCu
	 S11Ve3JSAVPljFmZKqnlItf9Ryj+4I1TbPEUsWyDcO/hn3qag7vWze9IRozjuoSkel
	 G8RqNnGHNPhFDpUuMzoMKSRsnGc/FHvP08RJZFR9jVXlPwj3YZH28hkBncZ9eAfvI1
	 5MPJZMcOTJwcED5e0o6/BZQ703gzBUV3UXBdAIkHBdqy2iZKQfu0mrVfMYC/wkKsBk
	 EcqdsEep/cBUg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5450d56199cso1713761e87.1
        for <linux-um@lists.infradead.org>; Tue, 11 Feb 2025 01:45:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkLP3YwDhvmycceDn1b5GZIZANNDgTn+/+dMWrYpE7zgENRkeTvZRCOl9P2B3X3DGV3CydrZcpgQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzG3rOXYsWLURWLjIoTWq0y0A28MBduPXXjl2iv/+XuqhTIqRIJ
	K2PsSn0LxcfeK3O5+ZN5SzsweZv34V4fbsfTOEbDafqyDPMlun8VYO8UbengYAr01oJGHLxZeq3
	lW51QgF9IC/k+k1URQ4lnfofBkgk=
X-Google-Smtp-Source: AGHT+IF6XwIqkJ39zHWGHM0UWjL3iYehWiVzR3d1VUmFeuhbDWBXdIje0bEMCWuMHQr9arz59/vIQAFS2v1AebUG9PM=
X-Received: by 2002:a05:6512:b18:b0:545:f90:2771 with SMTP id
 2adb3069b0e04-54511c0f535mr821015e87.3.1739267106753; Tue, 11 Feb 2025
 01:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20241218115126.264342-1-mic@digikod.net>
In-Reply-To: <20241218115126.264342-1-mic@digikod.net>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 11 Feb 2025 18:44:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATuekKKAtp7W+vzwEmaPW52YzPzqTfrJNKpXPV1kGhR8g@mail.gmail.com>
X-Gm-Features: AWEUYZlxs5ljAxmQ5fnQIyTDHuO4EjtuB_ANQXA3Mw46Hy-lJAVDttQsZXAYmK0
Message-ID: <CAK7LNATuekKKAtp7W+vzwEmaPW52YzPzqTfrJNKpXPV1kGhR8g@mail.gmail.com>
Subject: Re: [PATCH v1] kbuild: Allow building of samples with UML
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_014509_318221_4B61EA7F 
X-CRM114-Status: GOOD (  17.27  )
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

On Wed, Dec 18, 2024 at 8:51=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> It's useful to build samples/* with UML and the only blocker is the
> artificial incompatibility with CONFIG_HEADERS_INSTALL.
>
> Allow the headers_install target with ARCH=3Dum, which then allow buildin=
g
> samples (and tests using them) with UML too:
>
>   printf 'CONFIG_SAMPLES=3Dy\nCONFIG_HEADERS_INSTALL=3Dy\nCONFIG_SAMPLE_L=
ANDLOCK=3Dy\n' >.config
>   make ARCH=3Dum olddefconfig headers_install
>   make ARCH=3Dum samples/landlock/
>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Richard Weinberger <richard@nod.at>
> Fixes: 1b620d539ccc ("kbuild: disable header exports for UML in a straigh=
tforward way")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  Makefile          | 1 -
>  lib/Kconfig.debug | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index e5b8a8832c0c..6e2cce16a2a3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1355,7 +1355,6 @@ hdr-inst :=3D -f $(srctree)/scripts/Makefile.header=
sinst obj
>
>  PHONY +=3D headers
>  headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archs=
cripts
> -       $(if $(filter um, $(SRCARCH)), $(error Headers not exportable for=
 UML))
>         $(Q)$(MAKE) $(hdr-inst)=3Dinclude/uapi
>         $(Q)$(MAKE) $(hdr-inst)=3Darch/$(SRCARCH)/include/uapi
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f3d723705879..fac1208f48e4 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -473,7 +473,6 @@ config READABLE_ASM
>
>  config HEADERS_INSTALL
>         bool "Install uapi headers to usr/include"
> -       depends on !UML
>         help
>           This option will install uapi headers (headers exported to user=
-space)
>           into the usr/include directory for use during the kernel build.
> --
> 2.47.1
>

This patch was not even compile-tested.

Apply this patch.
Enable CONFIG_HEADERS_INSTALL and CONFIG_UAPI_HEADERS_TEST.
"make ARCH=3Dum" and see the errors.

The reason is obvious, UML is a kernel. No such userspace.

--=20
Best Regards
Masahiro Yamada

