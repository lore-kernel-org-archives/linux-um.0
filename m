Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ecsba-0006fI-HR for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 14:51:46 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ecsba-0002et-5n
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 14:51:46 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<200511161811.38823.rob@landley.net>
	<20051117184038.GB7062@ccure.user-mode-linux.org>
In-Reply-To: <20051117184038.GB7062@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511171651.33764.rob@landley.net>
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
Date: Thu, 17 Nov 2005 16:51:33 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 17 November 2005 12:40, Jeff Dike wrote:
> On Wed, Nov 16, 2005 at 06:11:38PM -0600, Rob Landley wrote:
> > include/asm/processor.h:19: error: field `tls' has incomplete type
>
> This is strange.  It's complaining about not having a struct user_desc,
> which is defined in asm-i386/ldt.h, which is included from
> asm-um/ldt-i386.h through the asm/arch symlink.
>
> Your asm/arch link points to asm-i386, doesn't it?

Let's see.  Grab a fresh patches.tar off the website, cd into the source 
directory of 2.6.15-rc1 that just built but didn't work to give the assembly 
dump from a moment ago, and go:

 for i in `cat patches/series`; do patch -p1 -i patches/$i; done

mkdir ../linux-umlbuild2
make KCONFIG_ALLCONFIG=../../sources/system/uml-miniconf \
        ARCH=um O=../linux-umlbuild2 allnoconfig
cd ../linux-umlbuild2
make ARCH=um

And it dies with:

  SPLIT   include/linux/autoconf.h -> include/config/*
gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
-fno-common -ffreestanding -O2     -fomit-frame-pointer  -D__arch_um__ 
-DSUBARCH=\"i386\" -Iarch/um/include 
-I/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/include  
-I/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/include/skas 
-Dvmap=kernel_vmap -Din6addr_loopback=kernel_in6addr_loopback 
-Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask  -U__i386__ -Ui386 
-march=i686 -mpreferred-stack-boundary=2 -D_LARGEFILE64_SOURCE    -nostdinc 
-isystem /usr/lib/gcc-lib/i486-linux/3.3.5/include -D__KERNEL__ -Iinclude 
-Iinclude2 
-I/home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include -include 
include/linux/autoconf.h -S -o 
arch/um/kernel-offsets.s /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/sys-i386/kernel-offsets.c
In file included from include2/asm/thread_info.h:12,
                 from /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/linux/thread_info.h:21,
                 from /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/linux/spinlock.h:53,
                 from /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/linux/capability.h:45,
                 from /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/linux/sched.h:7,
                 from /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/arch/um/sys-i386/kernel-offsets.c:3:
include/asm/processor.h:19: error: field `tls' has incomplete type

I can send you the tarball of this linux-umlbuild2 directory if you like (it's 
118k).

find . -name asm
./include/asm
./include2/asm

ls -l include/asm include2/asm
lrwxrwxrwx  1 landley landley 72 2005-11-17 16:46 include2/asm 
-> /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/asm-um
lrwxrwxrwx  1 landley landley  6 2005-11-17 16:46 include/asm -> asm-um

ls -l include/asm/arch include2/asm/arch
ls: include2/asm/arch: No such file or directory
lrwxrwxrwx  1 landley landley 74 2005-11-17 16:46 include/asm/arch 
-> /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/asm-i386

I have no idea what the difference between include and include2 is, but it's 
there on the straight -rc1 that built, so I'm assuming it's intentional.

> > error: syntax error before "uml_ldt_t"
>
> uml_ldt_t is clearly typedefed in asm/ldt-i386.h, which is symlinked from
> ldt.h, which is included into mme-skas.h.
>
> Your recipe says you did a completely clean build, but the symptoms look
> to me like you have leftovers from a non-UML or non-UML/i386 build.

I've never done any non-x86 builds on my laptop.  (Only an x86 toolchain 
installed.)  I have done non-UML builds, but this is a clean directory.

gcc -v says:
Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.5/specs
Configured with: ../src/configure -v 
--enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr 
--mandir=/usr/share/man --infodir=/usr/share/info 
--with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared 
--with-system-zlib --enable-nls --without-included-gettext 
--enable-__cxa_atexit --enable-clocale=gnu --enable-debug 
--enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
Thread model: posix
gcc version 3.3.5 (Debian 1:3.3.5-8ubuntu2)

I have noticed that if you do a UML build and then make ARCH=um distclean and 
diff the directory with a freshly extracted tarball, you get all sorts of 
crud left over.  But that's a side issue.  (And another reason to use O=, I 
suppose...)

>     Jeff

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
