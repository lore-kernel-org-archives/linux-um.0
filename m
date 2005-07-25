Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dx7gb-0002ti-FZ	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Jul 2005 11:28:21 -0700
Received: from wproxy.gmail.com ([64.233.184.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1Dx7gZ-0006Yy-TM
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Jul 2005 11:28:21 -0700
Received: by wproxy.gmail.com with SMTP id 37so1017440wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 25 Jul 2005 11:28:09 -0700 (PDT)
Message-ID: <838f7c5005072511283b6b2d41@mail.gmail.com>
From: ashwin tanugula <ashwin.tanugula@gmail.com>
Reply-To: ashwin tanugula <ashwin.tanugula@gmail.com>
In-Reply-To: <838f7c5005072412315f9113fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
References: <838f7c50050720115954d28b25@mail.gmail.com>
	 <200507210037.24819.blaisorblade@yahoo.it>
	 <838f7c5005072412315f9113fe@mail.gmail.com>
Subject: [uml-devel] NEW compile errors for UMLPPC
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
Date: Mon, 25 Jul 2005 14:28:09 -0400
Content-Transfer-Encoding: quoted-printable
To: Blaisorblade <blaisorblade@yahoo.it>, jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Hi,
I think those errors came due to the inclusion of
include/asm/processor-i386.h. I remover that inclusion and included
the structure arch_thread in processor-generic.h, which removed the
previous errors.

Now I am getting the following errors
- Show quoted text -


root@slemieux:/home/ashwin/Desktop/ashwin/linux-2.6.0-test9 # make
linux ARCH=3Dum  CHK     include/linux/version.h
 UPD     include/linux/version.h
 SYMLINK include/asm -> include/asm-um
 HOSTCC  scripts/genksyms/genksyms.o
 SHIPPED scripts/genksyms/lex.c
 SHIPPED scripts/genksyms/parse.h
 SHIPPED scripts/genksyms/keywords.c
 HOSTCC  scripts/genksyms/lex.o
 SHIPPED scripts/genksyms/parse.c
 HOSTCC  scripts/genksyms/parse.o
 HOSTLD  scripts/genksyms/genksyms
 HOSTCC  scripts/split-include
 HOSTCC  scripts/conmakehash
 HOSTCC  scripts/docproc
 HOSTCC  scripts/kallsyms
 CC      scripts/empty.o
 HOSTCC  scripts/mk_elfconfig
 MKELF   scripts/elfconfig.h
 HOSTCC  scripts/file2alias.o
 HOSTCC  scripts/modpost.o
 HOSTLD  scripts/modpost
 HOSTCC  scripts/pnmtologo
 HOSTCC  scripts/bin2c
 SPLIT   include/linux/autoconf.h -> include/config/*
sed 's/ CONFIG/ UML_CONFIG/'
/home/ashwin/Desktop/ashwin/linux-2.6.0-test9/include/linux/autoconf.h
> arch/um/include/uml-config.h
make -f scripts/Makefile.build obj=3Darch/um/util
gcc -o arch/um/util/mk_task_user.o -c arch/um/util/mk_task_user.c
 CC      arch/um/util/mk_task_kern.o
In file included from include/asm/processor.h:13,
                from include/asm/thread_info.h:11,
                from include/linux/thread_info.h:21,
                from include/linux/spinlock.h:12,
                from include/linux/capability.h:45,
                from include/linux/sched.h:7,
                from arch/um/util/mk_task_kern.c:1:
include/asm/processor-generic.h:118: warning: `struct user' declared
inside parameter list
include/asm/processor-generic.h:118: warning: its scope is only this
definition or declaration, which is probably not what you want
In file included from include/asm/arch/semaphore.h:21,
                from include/asm/semaphore.h:4,
                from include/linux/sched.h:18,
                from arch/um/util/mk_task_kern.c:1:
include/linux/wait.h:83: warning: `regparm' attribute directive ignored
include/linux/wait.h:84: warning: `regparm' attribute directive ignored
include/linux/wait.h:85: warning: `regparm' attribute directive ignored
include/linux/wait.h:107: warning: `regparm' attribute directive ignored
include/linux/wait.h:108: warning: `regparm' attribute directive ignored
include/linux/wait.h:109: warning: `regparm' attribute directive ignored
include/linux/wait.h:228: warning: `regparm' attribute directive ignored
include/linux/wait.h:229: warning: `regparm' attribute directive ignored
include/linux/wait.h:231: warning: `regparm' attribute directive ignored
include/linux/wait.h:232: warning: `regparm' attribute directive ignored
include/linux/wait.h:238: warning: `regparm' attribute directive ignored
include/linux/wait.h:240: warning: `regparm' attribute directive ignored
include/linux/wait.h:242: warning: `regparm' attribute directive ignored
In file included from include/linux/rwsem.h:25,
                from include/asm/arch/semaphore.h:22,
                from include/asm/semaphore.h:4,
                from include/linux/sched.h:18,
                from arch/um/util/mk_task_kern.c:1:
include/linux/rwsem-spinlock.h:55: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:56: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:57: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:58: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:59: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:60: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:61: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:62: warning: `regparm' attribute
directive ignored
In file included from include/linux/sched.h:23,
- Show quoted text -
                from arch/um/util/mk_task_kern.c:1:
include/linux/smp.h:33: warning: `regparm' attribute directive ignored
In file included from include/linux/sched.h:29,
                from arch/um/util/mk_task_kern.c:1:
include/linux/completion.h:30: warning: `regparm' attribute directive ignor=
ed
include/linux/completion.h:31: warning: `regparm' attribute directive ignor=
ed
include/linux/completion.h:32: warning: `regparm' attribute directive ignor=
ed
In file included from include/linux/sched.h:30,
                from arch/um/util/mk_task_kern.c:1:
include/linux/pid.h:36: warning: `regparm' attribute directive ignored
include/linux/pid.h:38: warning: `regparm' attribute directive ignored
include/linux/pid.h:43: warning: `regparm' attribute directive ignored
include/linux/pid.h:49: warning: `regparm' attribute directive ignored
include/linux/pid.h:52: warning: `regparm' attribute directive ignored
In file included from include/linux/slab.h:15,
                from include/linux/percpu.h:4,
                from include/linux/sched.h:31,
                from arch/um/util/mk_task_kern.c:1:
include/linux/gfp.h:66: warning: `regparm' attribute directive ignored
include/linux/gfp.h:80: warning: `regparm' attribute directive ignored
include/linux/gfp.h:81: warning: `regparm' attribute directive ignored
include/linux/gfp.h:89: warning: `regparm' attribute directive ignored
include/linux/gfp.h:90: warning: `regparm' attribute directive ignored
include/linux/gfp.h:91: warning: `regparm' attribute directive ignored
include/linux/gfp.h:92: warning: `regparm' attribute directive ignored
In file included from include/linux/percpu.h:4,
                from include/linux/sched.h:31,
                from arch/um/util/mk_task_kern.c:1:
include/linux/slab.h:103: warning: `regparm' attribute directive ignored
In file included from arch/um/util/mk_task_kern.c:1:
include/linux/sched.h:175: warning: `regparm' attribute directive ignored
In file included from include/linux/aio.h:5,
                from include/linux/sched.h:183,
                from arch/um/util/mk_task_kern.c:1:
include/linux/workqueue.h:55: warning: `regparm' attribute directive ignored
include/linux/workqueue.h:56: warning: `regparm' attribute directive ignored
include/linux/workqueue.h:57: warning: `regparm' attribute directive ignored
include/linux/workqueue.h:59: warning: `regparm' attribute directive ignored
include/linux/workqueue.h:60: warning: `regparm' attribute directive ignored
In file included from include/linux/sched.h:183,
                from arch/um/util/mk_task_kern.c:1:
include/linux/aio.h:143: warning: `regparm' attribute directive ignored
include/linux/aio.h:144: warning: `regparm' attribute directive ignored
include/linux/aio.h:145: warning: `regparm' attribute directive ignored
include/linux/aio.h:146: warning: `regparm' attribute directive ignored
include/linux/aio.h:147: warning: `regparm' attribute directive ignored
include/linux/aio.h:149: warning: `regparm' attribute directive ignored
include/linux/aio.h:151: warning: `regparm' attribute directive ignored
include/linux/aio.h:156: warning: `regparm' attribute directive ignored
In file included from arch/um/util/mk_task_kern.c:1:
include/linux/sched.h:574: warning: `regparm' attribute directive ignored
include/linux/sched.h:575: warning: `regparm' attribute directive ignored
include/linux/sched.h:576: warning: `regparm' attribute directive ignored
include/linux/sched.h:577: warning: `regparm' attribute directive ignored
include/linux/sched.h:578: warning: `regparm' attribute directive ignored
include/linux/sched.h:668: warning: `regparm' attribute directive ignored
include/linux/sched.h:743: warning: `regparm' attribute directive ignored
include/linux/sched.h:871: warning: `regparm' attribute directive ignored
gcc -o arch/um/util/mk_task arch/um/util/mk_task_user.o
arch/um/util/mk_task_kern.o
gcc -c arch/um/util/mk_constants_user.c -o arch/um/util/mk_constants_user.o
gcc -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs
-O2 -fno-strict-aliasing -fno-common -U__powerpc__ -Upowerpc
-D__arch_um__ -DSUBARCH=3D\"ppc\" -D_LARGEFILE64_SOURCE
-Iarch/um/include -Derrno=3Dkernel_errno
-Dsigprocmask=3Dkernel_sigprocmask
-I/home/ashwin/Desktop/ashwin/linux-2.6.0-test9/arch/um/kernel/tt/include
-fomit-frame-pointer  -c arch/um/util/mk_constants_kern.c -o
arch/um/util/mk_constants_kern.o
In file included from include/asm/processor.h:13,
                from include/asm/thread_info.h:11,
                from include/linux/thread_info.h:21,
                from include/linux/spinlock.h:12,
                from include/linux/time.h:27,
                from arch/um/util/mk_constants_kern.c:3:
include/asm/processor-generic.h:118: warning: `struct user' declared
inside parameter list
include/asm/processor-generic.h:118: warning: its scope is only this
definition or declaration, which is probably not what you want
gcc -o arch/um/util/mk_constants arch/um/util/mk_constants_user.o
arch/um/util/mk_constants_kern.o
 CHK     arch/um/include/task.h
 CHK     arch/um/include/kern_constants.h
 CC      init/main.o
In file included from include/asm/processor.h:13,
                from include/asm/thread_info.h:11,
                from include/linux/thread_info.h:21,
                from include/linux/spinlock.h:12,
                from include/linux/capability.h:45,
                from include/linux/sched.h:7,
                from include/linux/module.h:10,
                from init/main.c:15:
include/asm/processor-generic.h:118: warning: `struct user' declared
inside parameter list
include/asm/processor-generic.h:118: warning: its scope is only this
definition or declaration, which is probably not what you want
In file included from include/asm/arch/semaphore.h:21,
                from include/asm/semaphore.h:4,
                from include/linux/sched.h:18,
                from include/linux/module.h:10,
                from init/main.c:15:
include/linux/wait.h:83: warning: `regparm' attribute directive ignored
include/linux/wait.h:84: warning: `regparm' attribute directive ignored
include/linux/wait.h:85: warning: `regparm' attribute directive ignored
include/linux/wait.h:107: warning: `regparm' attribute directive ignored
include/linux/wait.h:108: warning: `regparm' attribute directive ignored
include/linux/wait.h:109: warning: `regparm' attribute directive ignored
include/linux/wait.h:228: warning: `regparm' attribute directive ignored
include/linux/wait.h:229: warning: `regparm' attribute directive ignored
include/linux/wait.h:231: warning: `regparm' attribute directive ignored
include/linux/wait.h:232: warning: `regparm' attribute directive ignored
include/linux/wait.h:238: warning: `regparm' attribute directive ignored
include/linux/wait.h:240: warning: `regparm' attribute directive ignored
include/linux/wait.h:242: warning: `regparm' attribute directive ignored
In file included from include/linux/rwsem.h:25,
                from include/asm/arch/semaphore.h:22,
                from include/asm/semaphore.h:4,
                from include/linux/sched.h:18,
                from include/linux/module.h:10,
                from init/main.c:15:
include/linux/rwsem-spinlock.h:55: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:56: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:57: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:58: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:59: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:60: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:61: warning: `regparm' attribute
directive ignored
include/linux/rwsem-spinlock.h:62: warning: `regparm' attribute
directive ignored
In file included from include/linux/sched.h:23,
                from include/linux/module.h:10,
                from init/main.c:15:
include/linux/smp.h:33: warning: `regparm' attribute directive ignored
In file included from include/linux/sched.h:29,
                from include/linux/module.h:10,
                from init/main.c:15:
include/linux/completion.h:30: warning: `regparm' attribute directive ignor=
ed
include/linux/completion.h:31: warning: `regparm' attribute directive ignor=
ed
include/linux/completion.h:32: warning: `regparm' attribute directive ignor=
ed
In file included from include/linux/sched.h:30,
                from include/linux/module.h:10,
                from init/main.c:15:
include/linux/pid.h:36: warning: `regparm' attribute directive ignored
include/linux/pid.h:38: warning: `regparm' attribute directive ignored
include/linux/pid.h:43: warning: `regparm' attribute directive ignored
include/linux/pid.h:49: warning: `regparm' attribute directive ignored
include/linux/pid.h:52: warning: `regparm' attribute directive ignored
In file included from include/linux/slab.h:15,
                from include/linux/percpu.h:4,
                from include/linux/sched.h:31,
                from include/linux/module.h:10,
                from init/main.c:15:
include/linux/gfp.h:66: warning: `regparm' attribute directive ignored
include/linux/gfp.h:80: warning: `regparm' attribute directive ignored
include/linux/gfp.h:81: warning: `regparm' attribute directive ignored
include/linux/gfp.h:89: warning: `regparm' attribute directive ignored
include/linux/gfp.h:90: warning: `regparm' attribute directive ignored
include/linux/gfp.h:91: warning: `regparm' attribute directive ignored
include/linux/gfp.h:92: warning: `regparm' attribute directive ignored
In file included from include/linux/percpu.h:4,
                from include/linux/sched.h:31,
                from include/linux/module.h:10,
                from init/main.c:15:
include/linux/slab.h:103: warning: `regparm' attribute directive ignored
In file included from include/linux/module.h:10,
                from init/main.c:15:
include/linux/sched.h:175: warning: `regparm' attribute directive ignored
In file included from include/linux/aio.h:5,
                from include/linux/sched.h:183,
                from include/linux/module.h:10,
                from init/main.c:15:
include/linux/workqueue.h:55: warning: `regparm' attribute directive ignored
include/linux/workqueue.h:56: warning: `regparm' attribute directive ignored
include/linux/workqueue.h:57: warning: `regparm' attribute directive ignored
include/linux/workqueue.h:59: warning: `regparm' attribute directive ignored
include/linux/workqueue.h:60: warning: `regparm' attribute directive ignored
In file included from include/linux/sched.h:183,
                from include/linux/module.h:10,
                from init/main.c:15:
include/linux/aio.h:143: warning: `regparm' attribute directive ignored
include/linux/aio.h:144: warning: `regparm' attribute directive ignored
include/linux/aio.h:145: warning: `regparm' attribute directive ignored
include/linux/aio.h:146: warning: `regparm' attribute directive ignored
include/linux/aio.h:147: warning: `regparm' attribute directive ignored
include/linux/aio.h:149: warning: `regparm' attribute directive ignored
include/linux/aio.h:151: warning: `regparm' attribute directive ignored
include/linux/aio.h:156: warning: `regparm' attribute directive ignored
In file included from include/linux/module.h:10,
                from init/main.c:15:
include/linux/sched.h:574: warning: `regparm' attribute directive ignored
include/linux/sched.h:575: warning: `regparm' attribute directive ignored
include/linux/sched.h:576: warning: `regparm' attribute directive ignored
include/linux/sched.h:577: warning: `regparm' attribute directive ignored
include/linux/sched.h:578: warning: `regparm' attribute directive ignored
include/linux/sched.h:668: warning: `regparm' attribute directive ignored
include/linux/sched.h:743: warning: `regparm' attribute directive ignored
include/linux/sched.h:871: warning: `regparm' attribute directive ignored
In file included from include/asm/hardirq.h:4,
                from include/asm-generic/local.h:7,
                from include/asm/arch/local.h:4,
                from include/asm/local.h:4,
                from include/linux/module.h:19,
                from init/main.c:15:
include/asm/arch/hardirq.h:82:1: warning: "irq_enter" redefined
In file included from include/asm/hw_irq.h:5,
                from include/asm/arch/system.h:11,
                from include/asm/system.h:6,
                from include/linux/spinlock.h:17,
                from include/linux/capability.h:45,
                from include/linux/sched.h:7,
                from include/linux/module.h:10,
                from init/main.c:15:
include/asm/archparam.h:34:1: warning: this is the location of the
previous definition
In file included from include/asm/hardirq.h:4,
                from include/asm-generic/local.h:7,
                from include/asm/arch/local.h:4,
                from include/asm/local.h:4,
                from include/linux/module.h:19,
                from init/main.c:15:
include/asm/arch/hardirq.h:91:1: warning: "irq_exit" redefined
In file included from include/asm/hw_irq.h:5,
                from include/asm/arch/system.h:11,
                from include/asm/system.h:6,
                from include/linux/spinlock.h:17,
                from include/linux/capability.h:45,
                from include/linux/sched.h:7,
                from include/linux/module.h:10,
                from init/main.c:15:
include/asm/archparam.h:35:1: warning: this is the location of the
previous definition
In file included from include/linux/dcache.h:10,
                from include/linux/fs.h:17,
                from include/linux/proc_fs.h:6,
                from init/main.c:16:
include/linux/rcupdate.h:131: warning: `regparm' attribute directive ignored
In file included from include/linux/bootmem.h:7,
                from init/main.c:29:
include/asm/pgtable.h: In function `pte_file':
include/asm/pgtable.h:277: error: request for member `pte_low' in
something not a structure or union
In file included from include/linux/skbuff.h:26,
                from include/linux/security.h:34,
                from init/main.c:34:
include/linux/mm.h: At top level:
include/linux/mm.h:230: warning: `regparm' attribute directive ignored
include/linux/mm.h:430: warning: `regparm' attribute directive ignored
include/linux/mm.h:431: warning: `regparm' attribute directive ignored
include/linux/mm.h:432: warning: `regparm' attribute directive ignored
In file included from include/asm/arch/highmem.h:26,
                from include/asm/highmem.h:6,
                from include/linux/highmem.h:14,
                from include/linux/skbuff.h:27,
                from include/linux/security.h:34,
                from init/main.c:34:
include/linux/interrupt.h:99: warning: `regparm' attribute directive ignored
include/linux/interrupt.h:100: warning: `regparm' attribute directive ignor=
ed
include/linux/interrupt.h:171: warning: `regparm' attribute directive ignor=
ed
include/linux/interrupt.h:179: warning: `regparm' attribute directive ignor=
ed
In file included from include/asm/highmem.h:6,
                from include/linux/highmem.h:14,
                from include/linux/skbuff.h:27,
                from include/linux/security.h:34,
                from init/main.c:34:
include/asm/arch/highmem.h: In function `kmap_atomic':
include/asm/arch/highmem.h:89: error: `CONFIG_HIGHMEM_START'
undeclared (first use in this function)
include/asm/arch/highmem.h:89: error: (Each undeclared identifier is
reported only once
include/asm/arch/highmem.h:89: error: for each function it appears in.)
include/asm/arch/highmem.h: In function `kunmap_atomic':
include/asm/arch/highmem.h:106: error: `CONFIG_HIGHMEM_START'
undeclared (first use in this function)
include/asm/arch/highmem.h: In function `kmap_atomic_to_page':
include/asm/arch/highmem.h:128: error: `CONFIG_HIGHMEM_START'
undeclared (first use in this function)
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2


Thanks,
Ashwin


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
