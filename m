Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMIt5-0007A2-Nq for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Apr 2005 21:57:03 -0700
Received: from zproxy.gmail.com ([64.233.162.197])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DMIt4-0006e1-58 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Apr 2005 21:57:03 -0700
Received: by zproxy.gmail.com with SMTP id 40so2216653nzk
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 14 Apr 2005 21:56:55 -0700 (PDT)
Message-ID: <cbec11ac0504142156705d0113@mail.gmail.com>
From: Ian McDonald <imcdnzl@gmail.com>
Reply-To: Ian McDonald <imcdnzl@gmail.com>
Subject: Re: [uml-devel] Problems with UML on Debian Sarge 64 host
In-Reply-To: <200504142307.11927.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
References: <cbec11ac0504132125779afc07@mail.gmail.com>
	<200504142307.11927.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 15 Apr 2005 16:56:55 +1200
Content-Transfer-Encoding: quoted-printable
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Comments inline

On 15/04/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> On Thursday 14 April 2005 06:25, Ian McDonald wrote:
> > Hi there,
>=20
> > In my continuing saga (which some are becoming familiar with) to get
> > UML 2.6.x working at all I have been given access to another machine
> > to develop on and my old machine is going to disappear.
>=20
> > This machine is Debian Sarge with gcc 3.3.5 on an AMD64 with 32 bit
> > userspace although 64 bit compiles can also occur.
>=20
> > I am doing all my UML builds with ARCH=3Dum SUBARCH=3Di386 at this poin=
t in
> > time.
>=20
> > The problem is that my bootup dies very early on and this is the total
> > output: Checking for /proc/mm...not found
> > Checking PROT_EXEC mmap in /tmp...OK
> > tracing thread pid =3D 20981
> > OP_FORK failed to attach pid
>=20
> > I suspect that this is something to do with my mixed 32/64 bit
> > environment but I am not sure... Can anybody shed some light on this?
>=20
> I've seen that *sometimes* too on 64-bit envs., tried doing a "setarch i3=
86
> linux" or something like that, to force a 32-bit emulation?
>=20
setarch isn't on this machine and I can't find the equivalent command for s=
arge.
>=20
> Tried disabling the ptrace proxy in compilation, as the first thing?

Tried that and no difference. Note that 2.6.11.x with bs4 doesn't
compile with this option showing unless you set FRAME_POINTER to n.
You get an error such as:
kernel/built-in.o(.text+0x83f4): In function `profile_tick':
kernel/profile.c:387: undefined reference to `profile_pc'

The only way I could find to set this option to n was hacking the
autoconf.h file...

So still no 32 bit UML... will try 64 bit (once I get access to the 64
bit compiler) and see if I can get that to work....


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
