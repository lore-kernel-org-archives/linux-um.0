MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <52517109.90605@gmx.de>
References: <524C6643.2040209@gmx.de>
	<CAFLxGvwiH7L4oAW8tw6FyeGczg+rKjUDCdkLKdegy9yX==2cMA@mail.gmail.com>
	<524DBD5D.1040203@gmx.de>
	<524DBFBB.1050002@nod.at>
	<524DC278.3020106@gmx.de>
	<524DC394.6030406@nod.at>
	<524DC675.4020201@gmx.de>
	<524E57BA.805@nod.at>
	<52517109.90605@gmx.de>
Date: Sun, 6 Oct 2013 20:38:19 +0200
Message-ID: <CAMuHMdXrU0e_6AxvdboMkDs+N+tSWD+b8ou92j28c0vsq2eQQA@mail.gmail.com>
Subject: Re: [uml-devel] BUG: soft lockup for a user mode linux image
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: Richard Weinberger <richard@nod.at>, UML devel <user-mode-linux-devel@lists.sourceforge.net>, trinity@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Oct 6, 2013 at 4:17 PM, Toralf F=C3=B6rster <toralf.foerster@gmx.de=
> wrote:
> The UML stopped here :
> ...
>                 if (unlikely(task_ratelimit =3D=3D 0)) {
>                         period =3D max_pause;
>                         pause =3D max_pause;
>                         BUG_ON(pause < 0);
>                         goto pause;
>                 }
>                 BUG_ON(pages_dirtied < 0);
>                 BUG_ON(task_ratelimit < 0);
>                 period =3D HZ * pages_dirtied / task_ratelimit;
>                 BUG_ON(period < 0);         <----------------------here

So pages_dirtied becomes that big compared to task_ratelimit (both are
"unsigned long"), that period (which is "long", just like "pause") overflow=
s
into a negative number.

This is indeed much more likely to happen on 32-bit.

> The back trace is :

> #9  0x08411c64 in balance_dirty_pages (pages_dirtied=3D9, mapping=3D<opti=
mized out>) at mm/page-writeback.c:1471

But here pages_dirtied is only 9??

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

