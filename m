MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <526AD08D.10506@gmx.de>
References: <526AD08D.10506@gmx.de>
Date: Fri, 25 Oct 2013 22:18:26 +0200
Message-ID: <CAMuHMdX+GtHDB5r6-oXyehbemqS36rVE=Agpi0w-6TcCPQotZQ@mail.gmail.com>
Subject: Re: [uml-devel] RFC: Shouldn't "./linux --version" always print the
 the git commit id
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Toralf,

On Fri, Oct 25, 2013 at 10:11 PM, Toralf F=C3=B6rster <toralf.foerster@gmx.=
de> wrote:
> Just realized today the fact, that v3.11 reports just the tag and not
> "tag-g<commit id>"

You don't have CONFIG_LOCALVERSION_AUTO=3Dy in your .config?

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

