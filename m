Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcXNo-00021M-Bt for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 16:12:08 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EcXNm-0005H2-Oz
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 16:12:08 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<20051116221948.GA10366@ccure.user-mode-linux.org>
In-Reply-To: <20051116221948.GA10366@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6q8eDHSByMvP6tr"
Message-Id: <200511161811.38823.rob@landley.net>
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
Date: Wed, 16 Nov 2005 18:11:38 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

--Boundary-00=_6q8eDHSByMvP6tr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 16 November 2005 16:19, Jeff Dike wrote:
> On Wed, Nov 16, 2005 at 11:00:30AM -0600, Rob Landley wrote:
> > Kernel panic - not syncing: get_skas_faultinfo : failed to wait for
> > SIGUSR1/SIGTRAP, pid = 13213, n = 13213, errno = 0, status = 0xb7f
>
> Can you try my latest patchset?
>
>     Jeff

Sure:

tar xvjf linux-2.6.14.tar.bz2
cd linux-2.6.14
bzcat ../patch-2.6.15-rc1.bz2 | patch -p1
tar xvf ../patches.tar
for i in `cat patches/series`; do patch -p1 patches/$i; done
cp ../../system/uml-miniconf allno.config
make ARCH=um allnoconfig
make ARCH=um

...
  CHK     arch/um/include/user_constants.h
  UPD     arch/um/include/user_constants.h
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-um
  SPLIT   include/linux/autoconf.h -> include/config/*
gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
-fno-common -ffreestanding -O2     -fomit-frame-pointer  -D__arch_um__ 
-DSUBARCH=\"i386\" -Iarch/um/include  
-I/home/landley/newbuild/firmware-build/sources/packages/linux-2.6.14/arch/um/include/skas 
-Dvmap=kernel_vmap -Din6addr_loopback=kernel_in6addr_loopback 
-Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask  -U__i386__ -Ui386 
-march=i686 -mpreferred-stack-boundary=2 -D_LARGEFILE64_SOURCE    -nostdinc 
-isystem /usr/lib/gcc-lib/i486-linux/3.3.5/include -D__KERNEL__ -Iinclude  
-include include/linux/autoconf.h -S -o arch/um/kernel-offsets.s 
arch/um/sys-i386/kernel-offsets.c
In file included from include/asm/thread_info.h:12,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:53,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/um/sys-i386/kernel-offsets.c:3:
include/asm/processor.h:19: error: field `tls' has incomplete type
In file included from arch/um/include/um_mmu.h:17,
                 from include/asm/mmu.h:9,
                 from include/linux/sched.h:23,
                 from arch/um/sys-i386/kernel-offsets.c:3:
/home/landley/newbuild/firmware-build/sources/packages/linux-2.6.14/arch/um/include/skas/mmu-skas.h:19: 
error: syntax error before "uml_ldt_t"
/home/landley/newbuild/firmware-build/sources/packages/linux-2.6.14/arch/um/include/skas/mmu-skas.h:19: 
warning: no semicolon at end of struct or union
In file included from include/asm/mmu.h:9,
                 from include/linux/sched.h:23,
                 from arch/um/sys-i386/kernel-offsets.c:3:
arch/um/include/um_mmu.h:25: error: field `skas' has incomplete type
make: *** [arch/um/kernel-offsets.s] Error 1

Rob

--Boundary-00=_6q8eDHSByMvP6tr
Content-Type: text/plain;
  charset="iso-8859-1";
  name="uml-miniconf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-miniconf"

CONFIG_MODE_SKAS=y
CONFIG_BINFMT_ELF=y
CONFIG_HOSTFS=y
CONFIG_SYSCTL=y
CONFIG_STDERR_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_UBD=y
CONFIG_TMPFS=y
CONFIG_SWAP=y
CONFIG_LBD=y
CONFIG_EXT2_FS=y
CONFIG_PROC_FS=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_ZLIB_INFLATE=y

--Boundary-00=_6q8eDHSByMvP6tr--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
