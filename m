MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20101118114143.GB23698@cs.unibo.it>
References: <20101118114143.GB23698@cs.unibo.it>
Date: Sun, 21 Nov 2010 10:35:32 +0100
Message-ID: <AANLkTimYG1jLwJ2tWLonFcoMWaQtaR9RG7HWJDbdE4cS@mail.gmail.com>
Subject: Re: [uml-devel] user-mode-linux-devel@lists.sourceforge.net, Jeff
 Dike <jdike@addtoit.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Nov 18, 2010 at 12:41, Renzo Davoli <renzo@cs.unibo.it> wrote:
> Dear User-Mode Linux developers,
>
> FOSDEM accepted my proposal for a devroom about
> "new challenges in virtualization".
>
> I think this devroom can be also a meeting point for
> user-mode-linux developers to discuss the future
> of the project.
> I have added an item to the topic list:
> * user-mode-linux: dead or alive?
>
> I think it is alive and healthy and it can benefit from
> new virtualization supports in the kernel, optimized
> ptrace tags and utrace-based modules.
> I am sure you have many other ideas.

Personally, I like UML because
  - It's easy to get it running,
  - I can run it without needing root access, so I can run it on any
Linux machine I have an account on[*],
  - I can use it to do things that are limited to root-only, e.g.
      * create device nodes on file system images,
      * run wireshark to analyze network communication.
  - I even use it to debug/develop code for the Amiga Zorro bus, by
adding a fake bus with fake devices ;-)

[*] That's the major annoyance of coLinux: you need to be administrator.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds

