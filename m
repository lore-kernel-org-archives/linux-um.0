Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWvsL-008K5u-MJ
 for linux-um@lists.infradead.org; Thu, 15 Apr 2021 06:53:19 +0000
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 13F6qf7B006383
 for <linux-um@lists.infradead.org>; Thu, 15 Apr 2021 15:52:41 +0900
Received: by mail-pj1-f42.google.com with SMTP id
 j6-20020a17090adc86b02900cbfe6f2c96so12155826pjv.1
 for <linux-um@lists.infradead.org>; Wed, 14 Apr 2021 23:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210414192657.17764-1-rdunlap@infradead.org>
In-Reply-To: <20210414192657.17764-1-rdunlap@infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 15 Apr 2021 15:52:03 +0900
Message-ID: <CAK7LNARSK2YspYvKkUKTp-aG2nqKnvdMr7B_6Am-u1-mt2XBNg@mail.gmail.com>
Subject: Re: [PATCH] uml: fix W=1 missing-include-dirs warnings
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Marek <michal.lkml@markovi.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

On Thu, Apr 15, 2021 at 4:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Currently when using "W=1" with UML builds, there are over 700 warnings
> like so:
>
>   CC      arch/um/drivers/stderr_console.o
> cc1: warning: ./arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
>
> but arch/um/ does not have include/uapi/ at all, so don't
> include arch/um/include/uapi/ in USERINCLUDE for UML.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: linux-um@lists.infradead.org
> ---
>  Makefile |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> Option 2: change the setting of USERINCLUDE. This could alter
>         (a) build times and
>         (b) which header files get used: if there are multiple
>             header files named foobar.h in the $(USERINCLUDE)
>             subdirectories, this Option changes the order in which
>             they would be found.
>
> - linux-next-20210413.orig/Makefile
> + linux-next-20210413/Makefile
> @@ -501,13 +501,16 @@ LDFLAGS_vmlinux =
>
>  # Use USERINCLUDE when you must reference the UAPI directories only.
>  USERINCLUDE    := \
> -               -I$(srctree)/arch/$(SRCARCH)/include/uapi \
>                 -I$(objtree)/arch/$(SRCARCH)/include/generated/uapi \
>                 -I$(srctree)/include/uapi \
>                 -I$(objtree)/include/generated/uapi \
>                  -include $(srctree)/include/linux/compiler-version.h \
>                  -include $(srctree)/include/linux/kconfig.h
>
> +ifneq ($(ARCH),um)
> +USERINCLUDE    += -I$(srctree)/arch/$(SRCARCH)/include/uapi
> +endif
> +
>  # Use LINUXINCLUDE when you must reference the include/ directory.
>  # Needed to be compatible with the O= option
>  LINUXINCLUDE    := \
>
> Option 3: modify scripts/Makefile.extrawarn not to set
>         -Wmissing-include-dirs for arch=um. I think that this is not
>         a good idea: it could cause valid problem reports not to be
>         reported.
>
> Option 4: simply mkdir arch/um/include/uapi
>         That's what I did first, just as a test, and it works.


I like Option 4.

But, you cannot do "mkdir -p arch/um/include/uapi" at build-time
because the build system should not touch the source tree(, which
might be read-only)
for O= building.

How about adding

  arch/um/include/uapi/asm/Kbuild,

which is just having a SPDX one-liner?












>
> --- linux-next-20210413.orig/Makefile
> +++ linux-next-20210413/Makefile
> @@ -500,6 +500,15 @@ AFLAGS_KERNEL      =
>  LDFLAGS_vmlinux =
>
>  # Use USERINCLUDE when you must reference the UAPI directories only.
> +# Note: arch/um/ does not have an include/uapi/ subdir.
> +ifeq ($(ARCH),um)
> +USERINCLUDE    := \
> +               -I$(objtree)/arch/$(SRCARCH)/include/generated/uapi \
> +               -I$(srctree)/include/uapi \
> +               -I$(objtree)/include/generated/uapi \
> +                -include $(srctree)/include/linux/compiler-version.h \
> +                -include $(srctree)/include/linux/kconfig.h
> +else
>  USERINCLUDE    := \
>                 -I$(srctree)/arch/$(SRCARCH)/include/uapi \
>                 -I$(objtree)/arch/$(SRCARCH)/include/generated/uapi \
> @@ -507,6 +516,7 @@ USERINCLUDE    := \
>                 -I$(objtree)/include/generated/uapi \
>                  -include $(srctree)/include/linux/compiler-version.h \
>                  -include $(srctree)/include/linux/kconfig.h
> +endif
>
>  # Use LINUXINCLUDE when you must reference the include/ directory.
>  # Needed to be compatible with the O= option



-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

