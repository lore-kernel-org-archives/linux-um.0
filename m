Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fdE8r-0005AK-7A
 for linux-um@lists.infradead.org; Wed, 11 Jul 2018 12:23:19 +0000
Received: from mail-ua0-f178.google.com (mail-ua0-f178.google.com
 [209.85.217.178]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id w6BCM5fl021917
 for <linux-um@lists.infradead.org>; Wed, 11 Jul 2018 21:22:05 +0900
Received: by mail-ua0-f178.google.com with SMTP id q12-v6so16061979ual.2
 for <linux-um@lists.infradead.org>; Wed, 11 Jul 2018 05:22:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180708152004.21679-5-hch@lst.de>
References: <20180708152004.21679-1-hch@lst.de>
 <20180708152004.21679-5-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 11 Jul 2018 21:21:24 +0900
Message-ID: <CAK7LNAT5dzU-SOvqwnDs=bn3WA1_fmDj2abETmoHUdUExVF+WA@mail.gmail.com>
Subject: Re: [PATCH 4/9] kconfig: include common Kconfig files from top-level
 Kconfig
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: Richard Weinberger <richard@nod.at>, Randy Dunlap <rdunlap@infradead.org>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>

2018-07-09 0:19 GMT+09:00 Christoph Hellwig <hch@lst.de>:
> Instead of duplicating the source statements in every architecture just
> do it once in the toplevel Kconfig file.
>
> Note that with this the inclusion of arch/$(SRCARCH/Kconfig moves out of
> the top-level Kconfig into arch/Kconfig so that don't violate ordering
> constraits while keeping a sensible menu structure.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index dd4f3d3e644f..7ab7b148181b 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -168,10 +168,6 @@ config PGTABLE_LEVELS
>         default 3 if X2TLB
>         default 2
>
> -source "init/Kconfig"
> -
> -source "kernel/Kconfig.freezer"
> -
>  menu "System type"
>
>  #
> @@ -553,8 +549,6 @@ endchoice
>
>  endif
>
> -source "arch/sh/mm/Kconfig"


I noticed at least sh is broken
because "arch/sh/mm/Kconfig" is no longer included by anyone.

I am not doing further tests.


Please test *ALL* architectures.

If possible, matrix tests (arch, config-target), where
arch = arm, arm64, ...
config-target = allyesconfig, allnoconfig, alldefconfig, ...


Note:
scripts/diffconf is helpful.

-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

