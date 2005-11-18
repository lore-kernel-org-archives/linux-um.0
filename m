Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed0Vh-00025E-Cn for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:18:13 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ed0Ve-0005nN-ND
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:18:13 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<20051118031257.GA14537@ccure.user-mode-linux.org>
	<200511180048.06213.rob@landley.net>
In-Reply-To: <200511180048.06213.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200511180826.53596.blaisorblade@yahoo.it>
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
Date: Fri, 18 Nov 2005 08:26:53 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Jeff Dike <jdike@addtoit.com>

On Friday 18 November 2005 07:48, Rob Landley wrote:
> On Thursday 17 November 2005 21:12, Jeff Dike wrote:
> > On Thu, Nov 17, 2005 at 04:51:33PM -0600, Rob Landley wrote:
> > > find . -name asm

> > This all looks the same as I have here, except for the asm-i386 thing,
> > which I don't think matters.  ldt.h seems to be at the center of this,
> > so can you check the following:
> >  asm-i386/ldt.h contains a struct user_desc

> Yup.

> >  asm-um includes asm/arch/ldt.h

> There's no asm subdirectory under asm-um.

Jeff meant that inside asm-um you should have a "arch" symlink to=20
"../asm-i386", and that include/asm/arch/ldt.h should exist (in the source =

tree root).

> >  asm-um/ldt.h contains a typedef of uml_ldt_t

> asm-um/ldt.h is a 0 byte file.

Damnit! Do rm on it and things will work (Makefiles will create a symlink t=
o=20
ldt-$(SUBARCH) in its place). We had this problem in the past, and exactly =

for a mis-formed patch with quilt.

> >  mmu-skas.h includes asm-um/ldt.h

> The one in arch/um/include/skas includes asm/ldt.h
> The one in arch/um/kernel/skas/include is a 0 byte file.

I suppose that's a rename from something in the patchset... and that the fi=
le=20
is not properly deleted (I hope this one shouldn't create problems).

Damn it again! Je-eff? I remember quilt can be taught to do it!

> > Also, generate a .i for the C file that's being built and check that
> > the definitions are getting pulled in.  There may be an easier way to
> > do this, but I

I do make ARCH=3Dum $path.i is supposed to work. I recently fixed it (shoul=
d be=20
upstream) up for userspace files (along with other extensions - .lst, .s an=
d=20
so on) . Before, obviously, I did as you do.

> >=A0=A0=A0=A0=A0=A0=A0=A0turn on V=3D1
> >=A0=A0=A0=A0=A0=A0=A0=A0cd obj
> >=A0=A0=A0=A0=A0=A0=A0=A0paste the gcc command into an xterm
> >=A0=A0=A0=A0=A0=A0=A0=A0edit it as follows
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0the -o -c foo.o is repla=
ced by -E
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0add > x.i at the end

> The line that's going boing is

> gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
> -fno-common -ffreestanding -O2     -fomit-frame-pointer  -D__arch_um__
> -DSUBARCH=3D\"i386\" -Iarch/um/include
> -I/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/inclu=
de
> -I/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/inclu=
de
>/skas -Dvmap=3Dkernel_vmap -Din6addr_loopback=3Dkernel_in6addr_loopback
> -Derrno=3Dkernel_errno -Dsigprocmask=3Dkernel_sigprocmask  -U__i386__ -Ui=
386
> -mpreferred-stack-boundary=3D2 -D_LARGEFILE64_SOURCE    -nostdinc
> -isystem /usr/lib/gcc-lib/i486-linux/3.3.5/include -D__KERNEL__ -Iinclude
> -Iinclude2
> -I/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include
> -include include/linux/autoconf.h -S -o
> arch/um/kernel-offsets.s
> /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/sys-i38=
6/
>kernel-offsets.c

> I don't even have to add V=3D1 to get it, that sucker isn't run through a
> prettification macro.  However, whey you say "-o -c foo.o", I can't find
> that to replace it with -E.  Do you mean the "-S -o kernel-offsets.s" bit?

In this case yes - Jeff thought the build would stop when building a "foo.o=
",=20
but it's stopping earlier than he expected.

--=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

=09

=09
	=09
___________________________________=20
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB=20
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_idv28&alloc_id=16845&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
