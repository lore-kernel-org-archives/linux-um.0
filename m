Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed02j-00013o-0N for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 22:48:17 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ed02i-00078e-Lr
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 22:48:17 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<200511171651.33764.rob@landley.net>
	<20051118031257.GA14537@ccure.user-mode-linux.org>
In-Reply-To: <20051118031257.GA14537@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200511180048.06213.rob@landley.net>
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
Date: Fri, 18 Nov 2005 00:48:06 -0600
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Thursday 17 November 2005 21:12, Jeff Dike wrote:
> On Thu, Nov 17, 2005 at 04:51:33PM -0600, Rob Landley wrote:
> > find . -name asm
> > ./include/asm
> > ./include2/asm
> >
> > ls -l include/asm include2/asm
> > lrwxrwxrwx  1 landley landley 72 2005-11-17 16:46 include2/asm
> > ->
> > /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/asm-um
> > lrwxrwxrwx  1 landley landley  6 2005-11-17 16:46 include/asm -> asm-um
> >
> > ls -l include/asm/arch include2/asm/arch
> > ls: include2/asm/arch: No such file or directory
> > lrwxrwxrwx  1 landley landley 74 2005-11-17 16:46 include/asm/arch
> > ->
> > /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/asm-i=
38
> >6
>
> This all looks the same as I have here, except for the asm-i386 thing,
> which I don't think matters.  ldt.h seems to be at the center of this,
> so can you check the following:
>  asm-i386/ldt.h contains a struct user_desc

Yup.

>  asm-um includes asm/arch/ldt.h

There's no asm subdirectory under asm-um.

>  asm-um/ldt.h contains a typedef of uml_ldt_t

asm-um/ldt.h is a 0 byte file.

>  mmu-skas.h includes asm-um/ldt.h

The one in arch/um/include/skas includes asm/ldt.h
The one in arch/um/kernel/skas/include is a 0 byte file.

> Also, generate a .i for the C file that's being built and check that
> the definitions are getting pulled in.  There may be an easier way to
> do this, but I
>=A0=A0=A0=A0=A0=A0=A0=A0turn on V=3D1
>=A0=A0=A0=A0=A0=A0=A0=A0cd obj
>=A0=A0=A0=A0=A0=A0=A0=A0paste the gcc command into an xterm
>=A0=A0=A0=A0=A0=A0=A0=A0edit it as follows
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0the -o -c foo.o is replace=
d by -E
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0add > x.i at the end

The line that's going boing is

gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing=20
-fno-common -ffreestanding -O2     -fomit-frame-pointer  -D__arch_um__=20
-DSUBARCH=3D\"i386\" -Iarch/um/include=20
-I/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/include=
 =20
-I/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/include=
/skas=20
-Dvmap=3Dkernel_vmap -Din6addr_loopback=3Dkernel_in6addr_loopback=20
-Derrno=3Dkernel_errno -Dsigprocmask=3Dkernel_sigprocmask  -U__i386__ -Ui38=
6=20
-mpreferred-stack-boundary=3D2 -D_LARGEFILE64_SOURCE    -nostdinc=20
-isystem /usr/lib/gcc-lib/i486-linux/3.3.5/include -D__KERNEL__ -Iinclude=20
-Iinclude2=20
-I/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include -includ=
e=20
include/linux/autoconf.h -S -o=20
arch/um/kernel-offsets.s /home/landley/newbuild/firmware-build/tmpdir/linux=
-2.6.14/arch/um/sys-i386/kernel-offsets.c


I don't even have to add V=3D1 to get it, that sucker isn't run through a=20
prettification macro.  However, whey you say "-o -c foo.o", I can't find th=
at=20
to replace it with -E.  Do you mean the "-S -o kernel-offsets.s" bit?

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_idv28&alloc_id=16845&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
