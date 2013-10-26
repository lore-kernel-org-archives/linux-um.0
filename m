MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <526AE051.5020809@gmx.de>
References: <526AD08D.10506@gmx.de>
	<CAMuHMdX+GtHDB5r6-oXyehbemqS36rVE=Agpi0w-6TcCPQotZQ@mail.gmail.com>
	<526AE051.5020809@gmx.de>
Date: Sat, 26 Oct 2013 09:56:28 +0200
Message-ID: <CAMuHMdWotLn5NwtjxL57YVK_X_N1gb2xxB4qd+sciUTJokourQ@mail.gmail.com>
Subject: Re: [uml-devel] RFC: Shouldn't "./linux --version" always print the
 the git commit id
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kbuild <linux-kbuild@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Oct 25, 2013 at 11:19 PM, Toralf F=C3=B6rster <toralf.foerster@gmx.=
de> wrote:
> On 10/25/2013 10:18 PM, Geert Uytterhoeven wrote:
>> On Fri, Oct 25, 2013 at 10:11 PM, Toralf F=C3=B6rster <toralf.foerster@g=
mx.de> wrote:
>>> Just realized today the fact, that v3.11 reports just the tag and not
>>> "tag-g<commit id>"

Actually it's "<tag>-<number>-<commit id>", with <number> indicating the
number of commits on top of the tag.

>>
>> You don't have CONFIG_LOCALVERSION_AUTO=3Dy in your .config?
>>
>> Gr{oetje,eeting}s,
>>
> I do :
> tfoerste@n22 ~/devel/linux $ ./linux --showconfig | grep AUTO
> CONFIG_LOCALVERSION_AUTO=3Dy
>
> pls look here :
>
>
> $ ./linux --version
> 3.11.0-00001-g65984ff-dirty
>
> versus
>
> $ git checkout HEAD~1
> Previous HEAD position was 65984ff... um: hostfs: Fix writeback
> HEAD is now at 6e46645... Linux 3.11
>
> $ make -j4 ARCH=3Dum CC=3D"ccache gcc"
> ...
>
> $ ./linux --version
> 3.11.0

If there are no additional commits on top of the tag, no number and commit
ID are printed. I guess the rationale is that tags are global, hence presen=
t
in all clones, so there's no need to tell what commit ID the tag correspond=
s
to.

> which correlates to
>
> $ git describe
> v3.11
>
> $ git describe --long
> v3.11-0-g6e46645

This is not UML-specific. If you want to change this, you have to involve
the kbuild people (CC added).

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

