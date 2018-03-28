MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAD=GYpatpGo=6mwhkw+RCQX=TNxX9jyfsq67srFc6+FhYtxaWg@mail.gmail.com>
References: <CAD=GYpatpGo=6mwhkw+RCQX=TNxX9jyfsq67srFc6+FhYtxaWg@mail.gmail.com>
Date: Wed, 28 Mar 2018 15:11:29 +0200
Message-ID: <CAMuHMdU0jYx+NdZWdZpSwWZkBNvBDJ14trvM8B49h4st_7RkgA@mail.gmail.com>
Subject: Re: [uml-devel] UML hangs with hrtimer test module
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Joel Fernandes <agnel.joel@gmail.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Mar 28, 2018 at 12:28 PM, Joel Fernandes <agnel.joel@gmail.com> wrote:
>         while(release_now == 0);

while (release_now == 0)
        cpu_relax();

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

