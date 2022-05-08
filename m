Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-02.nifty.com ([210.131.2.81])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nnlfr-00AsnO-Lo
 for linux-um@lists.infradead.org; Sun, 08 May 2022 18:30:33 +0000
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 248IU6qL008759
 for <linux-um@lists.infradead.org>; Mon, 9 May 2022 03:30:06 +0900
Received: by mail-pf1-f169.google.com with SMTP id 204so7680090pfx.3
 for <linux-um@lists.infradead.org>; Sun, 08 May 2022 11:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220505072244.1155033-1-masahiroy@kernel.org>
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 9 May 2022 03:28:55 +0900
Message-ID: <CAK7LNAQg2JG2DAuRJmNLryDh_o_PoFUXnJ+6C=-AE+NXZy9pTg@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] kbuild: yet another series of cleanups (modpost, 
 LTO, MODULE_REL_CRCS)
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
Cc: clang-built-linux <clang-built-linux@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Schier a <nicolas@fjasle.eu>, Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-um@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook <keescook@chromium.org>

On Thu, May 5, 2022 at 4:24 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> This is the third batch of cleanups in this development cycle.
>
> Major changes in v3:
>
>  - Generate symbol CRCs as C code, and remove CONFIG_MODULE_REL_CRCS.
>
> Major changes in v2:
>
>  - V1 did not work with CONFIG_MODULE_REL_CRCS.
>    I fixed this for v2.
>
>  - Reflect some review comments in v1
>
>  - Refactor the code more
>
>  - Avoid too long argument error
>
>
> Masahiro Yamada (15):
>   modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
>   modpost: change the license of EXPORT_SYMBOL to bool type
>   modpost: merge add_{intree_flag,retpoline,staging_flag} to add_header
>   modpost: move *.mod.c generation to write_mod_c_files()
>   kbuild: generate a list of objects in vmlinux
>   kbuild: record symbol versions in *.cmd files
>   modpost: extract symbol versions from *.cmd files
>   kbuild: link symbol CRCs at final link, removing
>     CONFIG_MODULE_REL_CRCS
>   kbuild: stop merging *.symversions
>   genksyms: adjust the output format to modpost
>   kbuild: do not create *.prelink.o for Clang LTO or IBT
>   modpost: simplify the ->is_static initialization
>   modpost: use hlist for hash table implementation
>   kbuild: make built-in.a rule robust against too long argument error
>   kbuild: make *.mod rule robust against too long argument error


Only 03-06 were applied.

I will send v4 for the rest.
(I rewrote the static EXPORT checks).

>
>  arch/powerpc/Kconfig         |   1 -
>  arch/s390/Kconfig            |   1 -
>  arch/um/Kconfig              |   1 -
>  include/asm-generic/export.h |  22 +-
>  include/linux/export.h       |  30 +--
>  include/linux/symversion.h   |  13 +
>  init/Kconfig                 |   4 -
>  kernel/module.c              |  10 +-
>  scripts/Kbuild.include       |   4 +
>  scripts/Makefile.build       | 118 +++------
>  scripts/Makefile.lib         |   7 -
>  scripts/Makefile.modfinal    |   5 +-
>  scripts/Makefile.modpost     |   9 +-
>  scripts/genksyms/genksyms.c  |  18 +-
>  scripts/link-vmlinux.sh      |  46 ++--
>  scripts/mod/file2alias.c     |   2 -
>  scripts/mod/list.h           |  52 ++++
>  scripts/mod/modpost.c        | 449 ++++++++++++++++++++---------------
>  scripts/mod/modpost.h        |   2 +
>  19 files changed, 402 insertions(+), 392 deletions(-)
>  create mode 100644 include/linux/symversion.h
>
> --
> 2.32.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20220505072244.1155033-1-masahiroy%40kernel.org.



-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

