Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcNT6-00076D-QO for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 05:36:56 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EcNT6-0002JE-4d
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 05:36:56 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jAGFAg1I011760
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 16 Nov 2005 10:10:42 -0500
From: Rob Landley <rob@landley.net>
References: <20051109133558.513facef.akpm@osdl.org>
	<20051109150141.0bcbf9e3.akpm@osdl.org>
	<Pine.LNX.4.64.0511091547160.4627@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511091547160.4627@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160736.44659.rob@landley.net>
Subject: [uml-devel] Re: merge status
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
Date: Wed, 16 Nov 2005 07:36:44 -0600
To: user-mode-linux-devel@lists.sourceforge.net

Linus said this:

> I think one reason -mm has worked so damn well (apart from you being "The
> Calmest Man on Earth"(tm)) is because it's essentially been that buffer
> for anything non-trivial. Sometimes the "n+2" has been a lot more than
> "n+2" in fact, and that's often good.
>
> (And at the same time, -mm has enough visibility that it doesn't drive
> developers crazy even when the "n+2" ends up being "n+5" or somethiing).
>
> I'd _hope_ that the same kind of situation could work for some of the
> majos subsystem git trees too: where the maintainer tree is well enough
> known that it gets sufficient coverage for that area that a "+2" approach
> for merging into the default kernel is practical.
>
> I also think it certainly _should_ be possible for the big areas that have
> well-defined target audiences.

And so I thought a bit about what that tree would be for UML (-mm?  -bb?) and 
decided "it's gotta be Jeff's tree as defined by 
user-mode-linux.sf.net/patches.html", so I grabbed the big rolled up tarball 
there that applies on top of 2.6.15-rc1:
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.15-rc1/patches.tar

And applied them all (in series order) with a for loop.

I used the following mini-config (using the new mechanism where if you put a 
mini-config in the file "allno.config" and run "make ARCH=um allnoconfig", 
you get a config with just this switched on, plus any required dependencies.  
Neat, eh?)

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

The build broke on the first file it tried to compile:

  CHK     include/linux/version.h
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

So I re-extracted 2.6.15-rc1, modified the for loop to apply them one at a 
time and build between each one, and ran that.

The build broke in a different way, after the very first patch 
(fix-stub-syscall6):

  CHK     usr/initramfs_list
  CC      arch/um/kernel/skas/clone.o
arch/um/kernel/skas/clone.c: In function `stub_clone_handler':
arch/um/kernel/skas/clone.c:35: error: aggregate value used where an integer 
was expected
make[2]: *** [arch/um/kernel/skas/clone.o] Error 1
make[1]: *** [arch/um/kernel/skas] Error 2
make: *** [arch/um/kernel] Error 2

So my question is: has anybody actually tried this patch series, and if so, 
_how_?  Am I doing something wrong?  (Building on ubuntu Horny Hedgehog with 
gcc 3.3.5)

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
