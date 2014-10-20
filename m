MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1413731653.2991.24.camel@localhost.localdomain>
References: <1413731653.2991.24.camel@localhost.localdomain>
Date: Mon, 20 Oct 2014 09:15:48 +0200
Message-ID: <CAMuHMdUR1z-ko=uvcy9rSiimW3fnSyaaXy70bU2tLUZUw73VKQ@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH v3 3/3] um: enable trace irqflags support
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Oct 19, 2014 at 5:14 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -251,6 +251,9 @@ static struct notifier_block panic_exit_notifier = {
>
>  void uml_finishsetup(void)
>  {
> +#ifdef CONFIG_LOCKDEP
> +       lockdep_init();
> +#endif

The #ifdef is not needed. include/linux/lockdep.h provides a dummy
definition if !CONFIG_LOCKDEP.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

