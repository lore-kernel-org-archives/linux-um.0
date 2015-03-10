MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <54FF0233.602@gmx.de>
References: <54FF0233.602@gmx.de>
Date: Tue, 10 Mar 2015 16:06:43 +0100
Message-ID: <CAMuHMdWNwyQrRYvURxefzevxsPVSFhc5Kph2ziup4+g2j55p0Q@mail.gmail.com>
Subject: Re: [uml-devel] compile error after : make ARCH=um allmodconfig &&
 make ARCH=um linux
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Toralf,

On Tue, Mar 10, 2015 at 3:39 PM, Toralf F=C3=B6rster <toralf.foerster@gmx.d=
e> wrote:
> is this already known ? :

Given the #include was added back in 2007, I'd say yes ;-)

>   CC      arch/um/drivers/vde_kern.o
>   CC      arch/um/drivers/vde_user.o
> arch/um/drivers/vde_user.c:8:24: fatal error: libvdeplug.h: No such file =
or directory
>  #include <libvdeplug.h>
>                         ^

"sudo apt-get install libvdeplug-dev" or the equivalent for your
distro to install
the vdeplug library and its development files.

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

