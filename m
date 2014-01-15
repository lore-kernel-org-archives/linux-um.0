MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1389814553-19861-1-git-send-email-richard@nod.at>
References: <52D6B591.3070707@infradead.org>
	<1389814553-19861-1-git-send-email-richard@nod.at>
Date: Wed, 15 Jan 2014 21:03:48 +0100
Message-ID: <CAMuHMdVkpd9W_sg2g4uztRVORddmOtuUW+ofweRhOmKcsi6XyA@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: Include generic barrier.h
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Richard Weinberger <richard@nod.at>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Randy Dunlap <rdunlap@infradead.org>, Linux-Next <linux-next@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Jan 15, 2014 at 8:35 PM, Richard Weinberger <richard@nod.at> wrote:
> --- a/arch/um/include/asm/Kbuild
> +++ b/arch/um/include/asm/Kbuild
> @@ -4,3 +4,4 @@ generic-y += ftrace.h pci.h io.h param.h delay.h mutex.h current.h exec.h
>  generic-y += switch_to.h clkdev.h
>  generic-y += trace_clock.h
>  generic-y += preempt.h
> +generic-y += barrier.h

Please use insertion sort instead of append, so Stephen doesn't have to
extend his patch "arch: Re-sort some Kbuild files to hopefully help avoid
some conflicts" for arch/um/include/asm/Kbuild.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

