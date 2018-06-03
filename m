Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1526351878-24961-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526351878-24961-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 3 Jun 2018 11:37:21 +0900
Message-ID: <CAK7LNASfiRcPVb0Bs_KWuAL3mtzdQfWwATVLkit8MkXeWtgrRQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] um: vdso: remove unused vdso-syms.lds
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi UML maintainers,

2018-05-15 11:37 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> This file contains symbol values, and was originally linked into
> vmlinux, but I have no idea what it was actually used for.
>
> Since commit 827880ec260b ("x86/um: thin archives build fix"), it is
> not even linked.  Now it is completely orphan, and no problem has
> been reported.  It is a proof that this file was not needed in the
> first place.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> ---


Could you take a look at this patch, please?

Thanks.


> The previous post has gone to the moderator
> due to too many recipients.
> I am resending this.
> I hope this is reaching UML maintainers.
>
>  arch/x86/um/vdso/.gitignore |  1 -
>  arch/x86/um/vdso/Makefile   | 16 ----------------
>  2 files changed, 17 deletions(-)
>
> diff --git a/arch/x86/um/vdso/.gitignore b/arch/x86/um/vdso/.gitignore
> index 9cac6d0..f8b69d8 100644
> --- a/arch/x86/um/vdso/.gitignore
> +++ b/arch/x86/um/vdso/.gitignore
> @@ -1,2 +1 @@
> -vdso-syms.lds
>  vdso.lds
> diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
> index 1000335..426681e 100644
> --- a/arch/x86/um/vdso/Makefile
> +++ b/arch/x86/um/vdso/Makefile
> @@ -53,22 +53,6 @@ $(vobjs): KBUILD_CFLAGS += $(CFL)
>  CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage
>  CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
>
> -targets += vdso-syms.lds
> -extra-$(VDSO64-y)                      += vdso-syms.lds
> -
> -#
> -# Match symbols in the DSO that look like VDSO*; produce a file of constants.
> -#
> -sed-vdsosym := -e 's/^00*/0/' \
> -       -e 's/^\([0-9a-fA-F]*\) . \(VDSO[a-zA-Z0-9_]*\)$$/\2 = 0x\1;/p'
> -quiet_cmd_vdsosym = VDSOSYM $@
> -define cmd_vdsosym
> -       $(NM) $< | LC_ALL=C sed -n $(sed-vdsosym) | LC_ALL=C sort > $@
> -endef
> -
> -$(obj)/%-syms.lds: $(obj)/%.so.dbg FORCE
> -       $(call if_changed,vdsosym)
> -
>  #
>  # The DSO images are built using a special linker script.
>  #
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada

