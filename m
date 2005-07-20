Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DvJnk-0001i3-7u	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jul 2005 12:00:16 -0700
Received: from wproxy.gmail.com ([64.233.184.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DvJnj-0008RG-Bj	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jul 2005 12:00:16 -0700
Received: by wproxy.gmail.com with SMTP id i3so1645413wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 20 Jul 2005 12:00:07 -0700 (PDT)
Message-ID: <838f7c50050720115954d28b25@mail.gmail.com>
From: ashwin tanugula <ashwin.tanugula@gmail.com>
Reply-To: ashwin tanugula <ashwin.tanugula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Subject: [uml-devel] compile errors for UMLPPC
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
Date: Wed, 20 Jul 2005 14:59:34 -0400
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Hi,
I am working on the UML/PPC port and I got the following errors. Can
anybody tell me how to solve the ptrace_link and ptrace_unlink errors
in linux/ptrace.h file?

root@slemieux:/home/ashwin/Desktop/ashwin/linux-2.6.0-test9 # make linux AR=
CH=3Dum
  CHK     include/linux/version.h
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
In file included from include/asm/arch/user.h:7,
                 from include/asm/processor-i386.h:20,
                 from include/asm/processor-generic.h:17,
                 from include/asm/processor.h:11,
                 from include/asm/thread_info.h:11,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/um/util/mk_task_kern.c:1:
include/linux/ptrace.h: In function `ptrace_link':
include/linux/ptrace.h:88: error: dereferencing pointer to incomplete type
include/linux/ptrace.h: In function `ptrace_unlink':
include/linux/ptrace.h:93: error: dereferencing pointer to incomplete type
In file included from include/asm/arch/semaphore.h:21,
                 from include/asm/semaphore.h:4,
                 from include/linux/sched.h:18,
                 from arch/um/util/mk_task_kern.c:1:
include/linux/wait.h: At top level:
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
directive ignoredinclude/linux/rwsem-spinlock.h:56: warning: `regparm'
attribute directive ignoredinclude/linux/rwsem-spinlock.h:57: warning:
`regparm' attribute directive
ignoredinclude/linux/rwsem-spinlock.h:58: warning: `regparm' attribute
directive ignoredinclude/linux/rwsem-spinlock.h:59: warning: `regparm'
attribute directive ignoredinclude/linux/rwsem-spinlock.h:60: warning:
`regparm' attribute directive
ignoredinclude/linux/rwsem-spinlock.h:61: warning: `regparm' attribute
directive ignoredinclude/linux/rwsem-spinlock.h:62: warning: `regparm'
attribute directive ignoredIn file included from
include/linux/sched.h:23,
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
make[1]: *** [arch/um/util/mk_task_kern.o] Error 1
make: *** [arch/um/util] Error 2

Thanks in advance

--Ashwin


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
