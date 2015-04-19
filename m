MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <55325CA3.8060506@gmx.de>
References: <55325CA3.8060506@gmx.de>
Date: Sun, 19 Apr 2015 14:25:32 +0200
Message-ID: <CAMuHMdWeN38RwpxR6xzGpcMBaxjUP9+R6dPn6L-3hBEtGcTqqw@mail.gmail.com>
Subject: Re: [uml-devel] UML specific or just a generic 4.0.x glitch :
 kernel/time/Kconfig:157:warning: range is invalid ?
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, Apr 18, 2015 at 3:31 PM, Toralf F=C3=B6rster <toralf.foerster@gmx.d=
e> wrote:
> tfoerste@t44 ~/devel/linux $ make ARCH=3Dum linux -j3
> scripts/kconfig/conf  --silentoldconfig arch/x86/um/Kconfig
> kernel/time/Kconfig:157:warning: range is invalid

This is not UML-specific. It happens on all UP-only architectures, which
includes UML since commit 28fa468f5316 ("um: Remove broken SMP support").

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

