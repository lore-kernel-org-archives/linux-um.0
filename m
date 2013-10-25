Return-Path: <toralf.foerster@gmx.de>
Message-ID: <526AE051.5020809@gmx.de>
Date: Fri, 25 Oct 2013 23:19:13 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <526AD08D.10506@gmx.de> <CAMuHMdX+GtHDB5r6-oXyehbemqS36rVE=Agpi0w-6TcCPQotZQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX+GtHDB5r6-oXyehbemqS36rVE=Agpi0w-6TcCPQotZQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [uml-devel] RFC: Shouldn't "./linux --version" always print the
 the git commit id
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 10/25/2013 10:18 PM, Geert Uytterhoeven wrote:
> Hi Toralf,
> 
> On Fri, Oct 25, 2013 at 10:11 PM, Toralf Förster <toralf.foerster@gmx.de> wrote:
>> Just realized today the fact, that v3.11 reports just the tag and not
>> "tag-g<commit id>"
> 
> You don't have CONFIG_LOCALVERSION_AUTO=y in your .config?
> 
> Gr{oetje,eeting}s,
> 
I do :
tfoerste@n22 ~/devel/linux $ ./linux --showconfig | grep AUTO
CONFIG_LOCALVERSION_AUTO=y



pls look here :


$ ./linux --version
3.11.0-00001-g65984ff-dirty

versus

$ git checkout HEAD~1
Previous HEAD position was 65984ff... um: hostfs: Fix writeback
HEAD is now at 6e46645... Linux 3.11

$ make -j4 ARCH=um CC="ccache gcc"
...

$ ./linux --version
3.11.0


which correlates to

$ git describe
v3.11

$ git describe --long
v3.11-0-g6e46645


>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
MfG/Sincerely
Toralf Förster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

