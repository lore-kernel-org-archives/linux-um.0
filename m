Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D26Y7-0003rV-HI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Feb 2005 03:43:55 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D26Y5-0003l9-Vf for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Feb 2005 03:43:55 -0800
Message-ID: <4215D4F2.4030906@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] latest cross-build patch break UML build, when using -j2
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
Date: Fri, 18 Feb 2005 12:43:46 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Using the latest incrementals (Feb, 17),
I tried to build UML kernel by typing:
    make clean ARCH=um
    make -j2 vmlinux ARCH=um

Make stops on the following error:

   CHK     arch/um/user-offsets.h
   UPD     arch/um/user-offsets.h
   CHK     arch/um/include/user_constants.h
   HOSTCC  arch/um/sys-i386/util/mk_sc
   HOSTCC  arch/um/kernel/skas/util/mk_ptregs-i386.o
   HOSTLD  arch/um/kernel/skas/util/mk_ptregs
gcc -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O2     -fno-omit-frame-pointer -g -U__i386__ -Ui386 
-D__arch_um__ -DSUBARCH=\"i386\" -Iarch/um/include  -I/usr/src/tmp/linux-2.6.11-rc3-mm2/arch/um/kernel/tt/include 
-I/usr/src/tmp/linux-2.6.11-rc3-mm2/arch/um/kernel/skas/include -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask -fno-unit-at-a-time -D_LARGEFILE64_SOURCE 
    -nostdinc -isystem /usr/lib/gcc-lib/i586-suse-linux/3.3.3/include -D__KERNEL__ -Iinclude  -S -o arch/um/kernel-offsets.s arch/um/sys-i386/kernel-offsets.c
In file included from include/asm/ptrace.h:9,
                  from include/asm/processor-generic.h:14,
                  from include/asm/processor.h:41,
                  from include/asm/thread_info.h:12,
                  from include/linux/thread_info.h:21,
                  from include/linux/spinlock.h:12,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/um/sys-i386/kernel-offsets.c:3:
arch/um/include/sysdep/ptrace.h:17:23: sysdep/sc.h: No such file or directory
arch/um/include/sysdep/ptrace.h:34:25: skas_ptregs.h: No such file or directory
In file included from include/asm/ptrace.h:9,
                  from include/asm/processor-generic.h:14,
                  from include/asm/processor.h:41,
                  from include/asm/thread_info.h:12,
                  from include/linux/thread_info.h:21,
                  from include/linux/spinlock.h:12,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/um/sys-i386/kernel-offsets.c:3:
arch/um/include/sysdep/ptrace.h:74: error: `HOST_FRAME_SIZE' undeclared here (not in a function)
arch/um/include/sysdep/ptrace.h:75: error: `HOST_FP_SIZE' undeclared here (not in a function)
arch/um/include/sysdep/ptrace.h:76: error: `HOST_XFP_SIZE' undeclared here (not in a function)
make: *** [arch/um/kernel-offsets.s] Error 1


When using "make vmlinux ARCH=um", UML kernel is built successfully.

Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
