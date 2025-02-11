Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BF7C0219B
	for <linux-um@archiver.kernel.org>; Tue, 11 Feb 2025 11:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=cenfD160RgLV2OxEavrtkQxvHnwEBdsH7VV83wnnuCw=; b=QaRZIgT7NMRMWuJqR2Y3pLAi27
	ygL8TZC/IXVWxUf3dkq6lYXDa6prb0kotWQKU320U6Gjis/c9XM72/L/SxiVkHpEeTTRlE5rgTOlq
	dYXwJRc+/3MG7oxByAjdQFE/7ImSJp+1LrigBolsIFPU7W1m2w6zIgnvcC76NP3AX1LuLU9YcfFtE
	Pb87pwpMejayE3zL4mb5+HUFh4BCsQTuNDhI+wBFAdTZoSIvlkTO5CzEeHoPRau2MSc/utDSM5A7+
	pw8TRQpOspyRuG++7QeW9ab5I8mx6CkO26/4hZ2LR2RTknhPaiojLBQ4AYaeOxueY7s1kEFyzXegv
	Cq9bqGyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tho1I-00000003SKz-2fJ9;
	Tue, 11 Feb 2025 11:01:36 +0000
Received: from mail.avm.de ([212.42.244.119])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thnqS-00000003QC4-1Fjn
	for linux-um@lists.infradead.org;
	Tue, 11 Feb 2025 10:50:26 +0000
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.52.1)
	(envelope-from <n.schier@avm.de>)
	id 67ab2b6b-72a9-7f0000032729-7f00000191e0-1
	for <multiple-recipients>; Tue, 11 Feb 2025 11:50:19 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 11 Feb 2025 11:50:19 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 22A86807B2;
	Tue, 11 Feb 2025 11:50:19 +0100 (CET)
Received: from l-nschier-z2.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:7792::1])
	by buildd.core.avm.de (Postfix) with ESMTP id 130D418B43E;
	Tue, 11 Feb 2025 11:50:19 +0100 (CET)
Received: from nicolas by l-nschier-z2.ads.avm.de with local (Exim 4.98)
	(envelope-from <n.schier@avm.de>)
	id 1thnqM-000000058pF-29Ha;
	Tue, 11 Feb 2025 11:50:18 +0100
Date: Tue, 11 Feb 2025 11:50:18 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Nicolas Schier <nicolas@fjasle.eu>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Subject: Re: [PATCH v1] kbuild: Allow building of samples with UML
Message-ID: <20250211-efficient-pink-dolphin-dcfd4d@l-nschier-z2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATuekKKAtp7W+vzwEmaPW52YzPzqTfrJNKpXPV1kGhR8g@mail.gmail.com>
X-purgate-ID: 149429::1739271019-CC7B9F3E-2FB39A69/0/0
X-purgate-type: clean
X-purgate-size: 2663
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_025024_483865_3F2B4433 
X-CRM114-Status: GOOD (  21.10  )
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

On Tue, Feb 11, 2025 at 06:44:30PM +0900, Masahiro Yamada wrote:
> On Wed, Dec 18, 2024 at 8:51 PM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > It's useful to build samples/* with UML and the only blocker is the
> > artificial incompatibility with CONFIG_HEADERS_INSTALL.
> >
> > Allow the headers_install target with ARCH=um, which then allow building
> > samples (and tests using them) with UML too:
> >
> >   printf 'CONFIG_SAMPLES=y\nCONFIG_HEADERS_INSTALL=y\nCONFIG_SAMPLE_LANDLOCK=y\n' >.config
> >   make ARCH=um olddefconfig headers_install
> >   make ARCH=um samples/landlock/
> >
> > Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nicolas Schier <nicolas@fjasle.eu>
> > Cc: Richard Weinberger <richard@nod.at>
> > Fixes: 1b620d539ccc ("kbuild: disable header exports for UML in a straightforward way")
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  Makefile          | 1 -
> >  lib/Kconfig.debug | 1 -
> >  2 files changed, 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index e5b8a8832c0c..6e2cce16a2a3 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1355,7 +1355,6 @@ hdr-inst := -f $(srctree)/scripts/Makefile.headersinst obj
> >
> >  PHONY += headers
> >  headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archscripts
> > -       $(if $(filter um, $(SRCARCH)), $(error Headers not exportable for UML))
> >         $(Q)$(MAKE) $(hdr-inst)=include/uapi
> >         $(Q)$(MAKE) $(hdr-inst)=arch/$(SRCARCH)/include/uapi
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index f3d723705879..fac1208f48e4 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -473,7 +473,6 @@ config READABLE_ASM
> >
> >  config HEADERS_INSTALL
> >         bool "Install uapi headers to usr/include"
> > -       depends on !UML
> >         help
> >           This option will install uapi headers (headers exported to user-space)
> >           into the usr/include directory for use during the kernel build.
> > --
> > 2.47.1
> >
> 
> This patch was not even compile-tested.
> 
> Apply this patch.
> Enable CONFIG_HEADERS_INSTALL and CONFIG_UAPI_HEADERS_TEST.
> "make ARCH=um" and see the errors.
> 
> The reason is obvious, UML is a kernel. No such userspace.

oh, I sorry.  I should have seen that when reviewing, but confused
myself as I missed the UAPI_HEADERS_TEST and just looked at a
"successful" run of 'make headers_install'.

Kind regards,
Nicolas

