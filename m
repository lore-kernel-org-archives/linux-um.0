Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPTfr-0006kl-Pp
 for linux-um@lists.infradead.org; Wed, 21 Nov 2018 14:40:17 +0000
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id wALEdoh6027893
 for <linux-um@lists.infradead.org>; Wed, 21 Nov 2018 23:39:51 +0900
Received: by mail-vs1-f49.google.com with SMTP id x1so3355806vsc.10
 for <linux-um@lists.infradead.org>; Wed, 21 Nov 2018 06:39:50 -0800 (PST)
MIME-Version: 1.0
References: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Nov 2018 23:39:13 +0900
Message-ID: <CAK7LNAReYwYAgGfxsHX2uRxXrYizM9C0rmq7V_ck-V+dc+oN4A@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] kbuild: clean-up modversion, TRIM_UNUSED_KSYMS,
 if_changed_rule, etc.
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
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>

On Tue, Nov 20, 2018 at 10:11 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> As a Kbuild maintainer, I always struggle to keep the core makefiles
> clean because people tend to squeeze more and more clutter code into
> the kbuild core in order to do what they want to do.
>
> The biggest step forward in this series is to re-implement
> the build trick of CONFIG_TRIM_UNUSED_KSYMS in a cleaner way.
> scripts/Kbuild.include now looks nice again.
> Also, in my rough estimation, building with CONFIG_TRIM_UNUSED_KSYMS
> became 40-50 % faster.
>
> Besides those, nice cleanups are here and there.
>
> Masahiro Yamada (9):
>   kbuild: let fixdep directly write to .*.cmd files
>   kbuild: remove redundant 'set -e' from filechk_* defines
>   kbuild: remove redundant 'set -e' from sub_cmd_record_mcount
>   kbuild: refactor modversions build rules
>   kbuild: simplify dependency generation for CONFIG_TRIM_UNUSED_KSYMS
>   kbuild: change if_changed_rule for multi-line recipe
>   kbuild: remove trailing semicolon from cmd_* passed to if_changed_rule
>   kbuild: refactor if_changed and if_changed_dep
>   kbuild: remove redundant 'set -e' from cmd_* defines

Series, applied to linux-kbuild.





>  Makefile                     |  13 +++---
>  arch/um/Makefile             |   2 +-
>  include/asm-generic/export.h |  13 +++---
>  include/linux/export.h       |  18 ++++----
>  scripts/Kbuild.include       |  49 +++-----------------
>  scripts/Makefile.build       | 105 ++++++++++++++++++-------------------------
>  scripts/Makefile.lib         |   2 +-
>  scripts/basic/fixdep.c       |  31 ++-----------
>  scripts/gen_ksymdeps.sh      |  25 +++++++++++
>  scripts/package/Makefile     |   1 -
>  10 files changed, 106 insertions(+), 153 deletions(-)
>  create mode 100755 scripts/gen_ksymdeps.sh
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

