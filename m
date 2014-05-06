MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1399144364-30696-2-git-send-email-richard@nod.at>
References: <1399144364-30696-1-git-send-email-richard@nod.at>
	<1399144364-30696-2-git-send-email-richard@nod.at>
Date: Tue, 6 May 2014 14:03:12 +0200
Message-ID: <CAMuHMdU8p+4v56OV=09VCjpvm5eE97DgoDd7aA7HoZB2Fa-Fvg@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH 2/2] um: Ensure that nobody remaps the stub vma
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Richard Weinberger <richard@nod.at>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Richard,

On Sat, May 3, 2014 at 9:12 PM, Richard Weinberger <richard@nod.at> wrote:
> @@ -90,6 +91,9 @@ static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
>         struct host_vm_op *last;
>         int fd, ret = 0;
>
> +       if ((virt >= STUB_START) && (virt < STUB_END))
> +               return -EINVAL;
> +

As you have this exact same check in three different places, I think it's worth
splitting it off in a helper function.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

