Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] compile errors for UMLPPC
References: <838f7c50050720115954d28b25@mail.gmail.com>
In-Reply-To: <838f7c50050720115954d28b25@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507210037.24819.blaisorblade@yahoo.it>
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
Date: Thu, 21 Jul 2005 00:37:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net, ashwin tanugula <ashwin.tanugula@gmail.com>
Cc: user-mode-linux-user@lists.sourceforge.net

On Wednesday 20 July 2005 20:59, ashwin tanugula wrote:
> Hi,
> I am working on the UML/PPC port and I got the following errors. Can
> anybody tell me how to solve the ptrace_link and ptrace_unlink errors
> in linux/ptrace.h file?
Well, you should add, before the offending lines, the inclusion of the missing 
header which is needed for that code.

I.e. if that's using a member of task_struct, then you need to include the 
definition of task_struct, which is in <linux/sched.h>.

If that is already included, then it means that you have a ciclic dependency 
chain; for instance, sched.h includes ptrace.h at its beginning, before 
declaring task_struct, and then ptrace.h includes sched.h because it needs 
it; but the content of sched.h is going to be skipped because of the "double 
inclusion" guard (_LINUX_SCHED_H will have already been defined).

> root@slemieux:/home/ashwin/Desktop/ashwin/linux-2.6.0-test9 # make linux
> ARCH=um CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   SYMLINK include/asm -> include/asm-um
>   HOSTCC  scripts/genksyms/genksyms.o
>   SHIPPED scripts/genksyms/lex.c
>   SHIPPED scripts/genksyms/parse.h
>   SHIPPED scripts/genksyms/keywords.c
>   HOSTCC  scripts/genksyms/lex.o
>   SHIPPED scripts/genksyms/parse.c
>   HOSTCC  scripts/genksyms/parse.o
>   HOSTLD  scripts/genksyms/genksyms
>   HOSTCC  scripts/split-include
>   HOSTCC  scripts/conmakehash
>   HOSTCC  scripts/docproc
>   HOSTCC  scripts/kallsyms
>   CC      scripts/empty.o
>   HOSTCC  scripts/mk_elfconfig
>   MKELF   scripts/elfconfig.h
>   HOSTCC  scripts/file2alias.o
>   HOSTCC  scripts/modpost.o
>   HOSTLD  scripts/modpost
>   HOSTCC  scripts/pnmtologo
>   HOSTCC  scripts/bin2c
>   SPLIT   include/linux/autoconf.h -> include/config/*
> sed 's/ CONFIG/ UML_CONFIG/'
> /home/ashwin/Desktop/ashwin/linux-2.6.0-test9/include/linux/autoconf.h
>
> > arch/um/include/uml-config.h
>
> make -f scripts/Makefile.build obj=arch/um/util
> gcc -o arch/um/util/mk_task_user.o -c arch/um/util/mk_task_user.c
>   CC      arch/um/util/mk_task_kern.o
> In file included from include/asm/arch/user.h:7,
>                  from include/asm/processor-i386.h:20,
>                  from include/asm/processor-generic.h:17,
>                  from include/asm/processor.h:11,
>                  from include/asm/thread_info.h:11,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/spinlock.h:12,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:7,
>                  from arch/um/util/mk_task_kern.c:1:
> include/linux/ptrace.h: In function `ptrace_link':
> include/linux/ptrace.h:88: error: dereferencing pointer to incomplete type
> include/linux/ptrace.h: In function `ptrace_unlink':
> include/linux/ptrace.h:93: error: dereferencing pointer to incomplete type
> In file included from include/asm/arch/semaphore.h:21,
>                  from include/asm/semaphore.h:4,
>                  from include/linux/sched.h:18,
>                  from arch/um/util/mk_task_kern.c:1:
> include/linux/wait.h: At top level:
> include/linux/wait.h:83: warning: `regparm' attribute directive ignored
> include/linux/wait.h:84: warning: `regparm' attribute directive ignored
> include/linux/wait.h:85: warning: `regparm' attribute directive ignored
> include/linux/wait.h:107: warning: `regparm' attribute directive ignored
> include/linux/wait.h:108: warning: `regparm' attribute directive ignored
> include/linux/wait.h:109: warning: `regparm' attribute directive ignored
> include/linux/wait.h:228: warning: `regparm' attribute directive ignored
> include/linux/wait.h:229: warning: `regparm' attribute directive ignored
> include/linux/wait.h:231: warning: `regparm' attribute directive ignored
> include/linux/wait.h:232: warning: `regparm' attribute directive ignored
> include/linux/wait.h:238: warning: `regparm' attribute directive ignored
> include/linux/wait.h:240: warning: `regparm' attribute directive ignored
> include/linux/wait.h:242: warning: `regparm' attribute directive ignored
> In file included from include/linux/rwsem.h:25,
>                  from include/asm/arch/semaphore.h:22,
>                  from include/asm/semaphore.h:4,
>                  from include/linux/sched.h:18,
>                  from arch/um/util/mk_task_kern.c:1:
> include/linux/rwsem-spinlock.h:55: warning: `regparm' attribute
> directive ignoredinclude/linux/rwsem-spinlock.h:56: warning: `regparm'
> attribute directive ignoredinclude/linux/rwsem-spinlock.h:57: warning:
> `regparm' attribute directive
> ignoredinclude/linux/rwsem-spinlock.h:58: warning: `regparm' attribute
> directive ignoredinclude/linux/rwsem-spinlock.h:59: warning: `regparm'
> attribute directive ignoredinclude/linux/rwsem-spinlock.h:60: warning:
> `regparm' attribute directive
> ignoredinclude/linux/rwsem-spinlock.h:61: warning: `regparm' attribute
> directive ignoredinclude/linux/rwsem-spinlock.h:62: warning: `regparm'
> attribute directive ignoredIn file included from
> include/linux/sched.h:23,
>                  from arch/um/util/mk_task_kern.c:1:
> include/linux/smp.h:33: warning: `regparm' attribute directive ignored
> In file included from include/linux/sched.h:29,
>                  from arch/um/util/mk_task_kern.c:1:
> include/linux/completion.h:30: warning: `regparm' attribute directive
> ignored include/linux/completion.h:31: warning: `regparm' attribute
> directive ignored include/linux/completion.h:32: warning: `regparm'
> attribute directive ignored In file included from include/linux/sched.h:30,
>                  from arch/um/util/mk_task_kern.c:1:
> include/linux/pid.h:36: warning: `regparm' attribute directive ignored
> include/linux/pid.h:38: warning: `regparm' attribute directive ignored
> include/linux/pid.h:43: warning: `regparm' attribute directive ignored
> include/linux/pid.h:49: warning: `regparm' attribute directive ignored
> include/linux/pid.h:52: warning: `regparm' attribute directive ignored
> In file included from include/linux/slab.h:15,
>                  from include/linux/percpu.h:4,
>                  from include/linux/sched.h:31,
>                  from arch/um/util/mk_task_kern.c:1:
> include/linux/gfp.h:66: warning: `regparm' attribute directive ignored
> include/linux/gfp.h:80: warning: `regparm' attribute directive ignored
> include/linux/gfp.h:81: warning: `regparm' attribute directive ignored
> include/linux/gfp.h:89: warning: `regparm' attribute directive ignored
> include/linux/gfp.h:90: warning: `regparm' attribute directive ignored
> include/linux/gfp.h:91: warning: `regparm' attribute directive ignored
> include/linux/gfp.h:92: warning: `regparm' attribute directive ignored
> In file included from include/linux/percpu.h:4,
>                  from include/linux/sched.h:31,
>                  from arch/um/util/mk_task_kern.c:1:
> include/linux/slab.h:103: warning: `regparm' attribute directive ignored
> In file included from arch/um/util/mk_task_kern.c:1:
> include/linux/sched.h:175: warning: `regparm' attribute directive ignored
> In file included from include/linux/aio.h:5,
>                  from include/linux/sched.h:183,
>                  from arch/um/util/mk_task_kern.c:1:
> include/linux/workqueue.h:55: warning: `regparm' attribute directive
> ignored include/linux/workqueue.h:56: warning: `regparm' attribute
> directive ignored include/linux/workqueue.h:57: warning: `regparm'
> attribute directive ignored include/linux/workqueue.h:59: warning:
> `regparm' attribute directive ignored include/linux/workqueue.h:60:
> warning: `regparm' attribute directive ignored In file included from
> include/linux/sched.h:183,
>                  from arch/um/util/mk_task_kern.c:1:
> include/linux/aio.h:143: warning: `regparm' attribute directive ignored
> include/linux/aio.h:144: warning: `regparm' attribute directive ignored
> include/linux/aio.h:145: warning: `regparm' attribute directive ignored
> include/linux/aio.h:146: warning: `regparm' attribute directive ignored
> include/linux/aio.h:147: warning: `regparm' attribute directive ignored
> include/linux/aio.h:149: warning: `regparm' attribute directive ignored
> include/linux/aio.h:151: warning: `regparm' attribute directive ignored
> include/linux/aio.h:156: warning: `regparm' attribute directive ignored
> In file included from arch/um/util/mk_task_kern.c:1:
> include/linux/sched.h:574: warning: `regparm' attribute directive ignored
> include/linux/sched.h:575: warning: `regparm' attribute directive ignored
> include/linux/sched.h:576: warning: `regparm' attribute directive ignored
> include/linux/sched.h:577: warning: `regparm' attribute directive ignored
> include/linux/sched.h:578: warning: `regparm' attribute directive ignored
> include/linux/sched.h:668: warning: `regparm' attribute directive ignored
> include/linux/sched.h:743: warning: `regparm' attribute directive ignored
> include/linux/sched.h:871: warning: `regparm' attribute directive ignored
> make[1]: *** [arch/um/util/mk_task_kern.o] Error 1
> make: *** [arch/um/util] Error 2
>
> Thanks in advance
>
> --Ashwin
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id492&op=Click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
