MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <AANLkTinji7n8Hd1Ldci_ruH0r8qglGjC00YQkb-MEwoV@mail.gmail.com>
References: <alpine.DEB.1.10.1001041421450.4942@dr-wily.mit.edu>
	<AANLkTinji7n8Hd1Ldci_ruH0r8qglGjC00YQkb-MEwoV@mail.gmail.com>
Date: Fri, 18 Jun 2010 16:27:31 +0200
Message-ID: <AANLkTilcHe8jnIBcTC_FjLPGxIbuZV3snU4u0FtdoeDi@mail.gmail.com>
Subject: Re: [RESEND][REGRESSION] um: CONFIG_STATIC_LINK=y broken
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: akpm@linux-foundation.org, tabbott@ksplice.com, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Jun 18, 2010 at 15:49, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> Andrew, Linus, Jeff, ... anyone?
> Please apply this patch.
>
> CONFIG_STATIC_LINK is still broken. :(

I wanted to verify Tim's patch, but after enabling CONFIG_STATIC_LINK,
it fails to link
(with or without your patch):

  LD      .tmp_vmlinux1
/usr/lib/gcc/x86_64-linux-gnu/4.4.3/../../../../lib/libc.a(elf-init.o):
In function `__libc_csu_irel':(.text+0xd4): undefined reference to
`__rela_iplt_end'
/usr/lib/gcc/x86_64-linux-gnu/4.4.3/../../../../lib/libc.a(elf-init.o):
In function `__libc_csu_irel':
(.text+0xe5): undefined reference to `__rela_iplt_start'
/usr/lib/gcc/x86_64-linux-gnu/4.4.3/../../../../lib/libc.a(elf-init.o):
In function `__libc_csu_irel':
(.text+0x100): undefined reference to `__rela_iplt_start'
/usr/lib/gcc/x86_64-linux-gnu/4.4.3/../../../../lib/libc.a(elf-init.o):
In function `__libc_csu_irel':
(.text+0x10a): undefined reference to `__rela_iplt_start'
/usr/lib/gcc/x86_64-linux-gnu/4.4.3/../../../../lib/libc.a(elf-init.o):
In function `__libc_csu_irel':
(.text+0x10f): undefined reference to `__rela_iplt_start'
/usr/lib/gcc/x86_64-linux-gnu/4.4.3/../../../../lib/libc.a(elf-init.o):
In function `__libc_csu_irel':
(.text+0x114): undefined reference to `__rela_iplt_start'
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make[3]: *** [.tmp_kallsyms1.S] Error 1
make[2]: *** [sub-make] Error 2
make[1]: *** [all] Error 2
make: *** [all] Error 2

This is 2.6.35-rc3 with the hweight fix.
With CONFIG_STATIC_LINK=3Dn, it works fine.

>
> //richard
> ---------- Forwarded message ----------
> From: Tim Abbott <tabbott@ksplice.com>
> Date: Mon, Jan 4, 2010 at 10:08 PM
> Subject: [REGRESSION] um: CONFIG_STATIC_LINK=3Dy broken
> To: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
> user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org,
> richard -rw- weinberger <richard.weinberger@gmail.com>, Sam Ravnborg
> <sam@ravnborg.org>
>
>
> Hi Linus,
>
> The following patch fixes a regression that I caused in 2.6.32 when
> cleaning up the um architecture's linker scripts.
>
> I've not heard anything from the um maintainers (they have had since
> Richard Weinberger reported that this patch fixed the problem on December
> 22), so I'm sending this to you now (and CCing stable@ since it affects
> 2.6.32).
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Tim Abbott
>
> --
>
> um: remove PAGE_SIZE alignment in linker script causing kernel segfault.
>
> The linker script cleanup that I did in commit
> 5d150a97f9391f5bcd7ba0d59d7a11c3de3cea80 accidentally introduced an
> ALIGN(PAGE_SIZE) when converting to use INIT_TEXT_SECTION; Richard
> Weinberger reported that this causes the kernel to segfault with
> CONFIG_STATIC_LINK=3Dy.
>
> I'm not certain why this extra alignment is a problem, but it seems likel=
y
> it is because previously
>
> __init_begin =3D _stext =3D _text =3D _sinittext
>
> and with the extra ALIGN(PAGE_SIZE), _sinittext becomes different from th=
e
> rest. =C2=A0So there is likely a bug here where something is assuming tha=
t
> _sinittext is the same as one of those other symbols. =C2=A0But reverting=
 the
> accidental change fixes the regression, so it seems worth committing that
> now.
>
> Signed-off-by: Tim Abbott <tabbott@ksplice.com>
> Reported-by: richard -rw- weinberger <richard.weinberger@gmail.com>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: user-mode-linux-devel@lists.sourceforge.net
> ---
> =C2=A0arch/um/kernel/uml.lds.S | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
> index e7a6cca..664f942 100644
> --- a/arch/um/kernel/uml.lds.S
> +++ b/arch/um/kernel/uml.lds.S
> @@ -22,7 +22,7 @@ SECTIONS
> =C2=A0 _text =3D .;
> =C2=A0 _stext =3D .;
> =C2=A0 __init_begin =3D .;
> - =C2=A0INIT_TEXT_SECTION(PAGE_SIZE)
> + =C2=A0INIT_TEXT_SECTION(0)
> =C2=A0 . =3D ALIGN(PAGE_SIZE);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds

