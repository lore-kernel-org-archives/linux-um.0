MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20170331224157.12922-1-richard@nod.at>
References: <20170331224157.12922-1-richard@nod.at>
Date: Sat, 1 Apr 2017 14:58:08 +0200
Message-ID: <CAMuHMdWghRdE6JCQQLuLqO=cCa8igVdZ1FXHm3jUGVASQKoG7A@mail.gmail.com>
Subject: Re: [PATCH] um: Fix PTRACE_POKEUSER on x86_64
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Richard Weinberger <richard@nod.at>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, stable <stable@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Richard,

On Sat, Apr 1, 2017 at 12:41 AM, Richard Weinberger <richard@nod.at> wrote:
> This is broken since ever but sadly nobody noticed.
> Recent versions of GDB set DR_CONTROL unconditionally and
> UML dies due to a heap corruption. It turns out that
> the PTRACE_POKEUSER was copy&pasted from i386 and assumes
> that addresses are 4 bytes long.
>
> Fix that by using 8 as address size in the calculation.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: jie cao <cj3054@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/x86/um/ptrace_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
> index a5c9910d234f..09a085bde0d4 100644
> --- a/arch/x86/um/ptrace_64.c
> +++ b/arch/x86/um/ptrace_64.c
> @@ -125,7 +125,7 @@ int poke_user(struct task_struct *child, long addr, long data)
>         else if ((addr >= offsetof(struct user, u_debugreg[0])) &&
>                 (addr <= offsetof(struct user, u_debugreg[7]))) {
>                 addr -= offsetof(struct user, u_debugreg[0]);
> -               addr = addr >> 2;
> +               addr = addr >> 3;

While at it:

        addr >>= 3;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

