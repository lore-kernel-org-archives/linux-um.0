Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNdrZ-00047H-Fd for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 May 2004 13:28:29 -0700
Received: from [166.70.202.181] (helo=denlin.zserve.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BNdrY-00034f-NR
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 May 2004 13:28:28 -0700
Message-ID: <40A13765.5010002@muhlesteins.com>
From: Dennis Muhlestein <devel@muhlesteins.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Patch for 2.6.6
References: <200405112032.13202.blaisorblade_spam@yahoo.it>
In-Reply-To: <200405112032.13202.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 11 May 2004 14:28:21 -0600
To: user-mode-linux-devel@lists.sourceforge.net

I got this:

Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n] y
Hunk #1 FAILED at 1.
Hunk #2 FAILED at 19.
2 out of 2 hunks FAILED -- saving rejects to file include/asm-um/irq.h.rej

when applying the first patch.  I tried also with not applying that 
part, and get a compile failure pretty early in the build process.

-Dennis


BlaisorBlade wrote:

>I'm working on the 2.6.6 patch, and you'll find attached what you need on top 
>of the vanilla kernel. I changed a bit his 2.6.6-0 patch, so I attach the 
>2.6.6-01 patch. The changes just avoid the "fuzz" messages from patch.
>
>So, what to do:
>
>-create a 2.6.6 vanilla kernel tree
>-apply the attached uml-patch-2.6.6-01.bz2
>-apply the attached patch-2.6.6-v2
>
>you need no other patches!! The one for 2.6.5 is included!
>
>-build as usual.
>
>I've built one UML this way, I just have a problem with tty pairs with the 
>root_fs_tomsbrt: maybe it comes from the work done in the kernel in this area 
>and from the particularities of that FS; with my normal slack9.0 FS, it 
>started well and is now working and running some little stress tests.
>
>Or better, it stopped at a certain point, did a lot of work, 
>restarted the boot process from the first message and then went just fine. I 
>typed "reboot" and it worked perfectly; then I shut it down, and restarted 
>it: it worked perfectly.
>
>However, before it started, the same binary gave:
>- a segmentation fault (not repeatable, sometimes it happened even before)
>- a panic from tcsetattr with EINTR (it's known, has a XXX in the sources and 
>I sent a working patch time ago)
>
From here onwards there are the technical details about the patches:
>
>Most of the kludges Jeff Chua did are just workaround, which can be replaced 
>with this patch:
>
>--- Makefile.saved      2004-05-11 19:20:02.000000000 +0200
>+++ Makefile    2004-05-11 19:20:59.000000000 +0200
>@@ -449,6 +449,10 @@
>
> include $(srctree)/arch/$(ARCH)/Makefile
>
>+# Let architecture Makefiles change CPPFLAGS if needed
>+CFLAGS := $(CPPFLAGS) $(CFLAGS)
>+AFLAGS := $(CPPFLAGS) $(AFLAGS)
>+
> ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> CFLAGS         += -Os
> else
>
>(apply with patch -l). This undoes a change from the 2.6.6 patch, done for I 
>do not know which reason. They probably thought it didn't hurt; it does, 
>indeed. For us it is VERY important (actually, for some kludges we do).
>
>This second change, instead, comes straight from his patch. I've not tested 
>it, however I know where it could come from. If he got a running UML with 
>this change, then it means it works, however it needs some more analisys 
>IMHO.
>
>--- ./arch/um/kernel/physmem.c.saved    2004-05-11 19:24:53.000000000 +0200
>+++ ./arch/um/kernel/physmem.c  2004-05-11 19:25:16.000000000 +0200
>@@ -285,7 +285,7 @@
>                p = &map[i];
>                set_page_count(p, 0);
>                SetPageReserved(p);
>-               INIT_LIST_HEAD(&p->list);
>+               INIT_LIST_HEAD(&p->lru);
>        }
>
>        mem_map = map;
>
>Then, inside patch-2.6.6-v1 there is the content of the 2nd version of the 
>2.6.5 fix.
>
>Finally, I had to fix the linker script, to avoid the problem with these lines 
>addressed:
>
>--- uml.org/kernel/sched.c      Fri Apr 16 21:23:00 2004
>+++ uml/kernel/sched.c  Fri Apr 16 12:19:34 2004
>@@ -225,12 +225,14 @@
> #define task_rq(p)             cpu_rq(task_cpu(p))
> #define cpu_curr(cpu)          (cpu_rq(cpu)->curr)
>
>+/*
> extern unsigned long __scheduling_functions_start_here;
> extern unsigned long __scheduling_functions_end_here;
> const unsigned long scheduling_functions_start_here =
>                        (unsigned long)&__scheduling_functions_start_here;
> const unsigned long scheduling_functions_end_here =
>                        (unsigned long)&__scheduling_functions_end_here;
>+*/
>
>I had to use SCHED_TEXT inside the linker script as the other linking scripts 
>do from 2.6.6; this provides the definition for __scheduling_functions_*.
>
>And finally this:
>
> void show_stack(struct task_struct *task, unsigned long *sp)
> {
>-       if(task)
>-               show_trace_task(task);
>-       else
>-               show_trace(sp);
>+       show_trace(sp);
> }
>
>because 2.6.6 deletes show_trace_task from each arch. However the other archs 
>did never actually use it, while UML does - maybe the proper solution is to 
>restore the show_trace_task definition. But why was it unused? Maybe the bug 
>is the fact we use it.
>
>However, I hope it helps.
>  
>
>------------------------------------------------------------------------
>
>--- linux-2.6.6/arch/um/kernel/physmem.c.saved	2004-05-11 19:24:53.000000000 +0200
>+++ linux-2.6.6/arch/um/kernel/physmem.c	2004-05-11 19:25:16.000000000 +0200
>@@ -285,7 +285,7 @@
> 		p = &map[i];
> 		set_page_count(p, 0);
> 		SetPageReserved(p);
>-		INIT_LIST_HEAD(&p->list);
>+		INIT_LIST_HEAD(&p->lru);
> 	}
> 
> 	mem_map = map;
>--- linux-2.6.6/arch/um/kernel/sysrq.c.saved	2004-05-11 17:52:41.000000000 +0200
>+++ linux-2.6.6/arch/um/kernel/sysrq.c	2004-05-11 19:55:36.000000000 +0200
>@@ -46,10 +46,7 @@
> 
> void show_stack(struct task_struct *task, unsigned long *sp)
> {
>-	if(task)
>-		show_trace_task(task);
>-	else
>-		show_trace(sp);
>+	show_trace(sp);
> }
> 
> /*
>--- linux-2.6.6/arch/um/dyn.lds.S.saved	2004-05-11 17:52:40.000000000 +0200
>+++ linux-2.6.6/arch/um/dyn.lds.S	2004-05-11 20:18:36.000000000 +0200
>@@ -1,3 +1,5 @@
>+#include <asm-generic/vmlinux.lds.h>
>+
> OUTPUT_FORMAT(ELF_FORMAT)
> OUTPUT_ARCH(ELF_ARCH)
> ENTRY(_start)
>@@ -58,7 +60,9 @@
>   } =0x90909090
>   .plt            : { *(.plt) }
>   .text           : {
>-    *(.text .stub .text.* .gnu.linkonce.t.*)
>+    *(.text)
>+    SCHED_TEXT
>+    *(.stub .text.* .gnu.linkonce.t.*)
>     /* .gnu.warning sections are handled specially by elf32.em.  */
>     *(.gnu.warning)
>   } =0x90909090
>--- linux-2.6.6/arch/um/uml.lds.S.saved	2004-05-11 17:52:42.000000000 +0200
>+++ linux-2.6.6/arch/um/uml.lds.S	2004-05-11 20:03:10.000000000 +0200
>@@ -34,6 +34,7 @@
>   .text      :
>   {
>     *(.text)
>+    SCHED_TEXT
>     /* .gnu.warning sections are handled specially by elf32.em.  */
>     *(.gnu.warning)
>     *(.gnu.linkonce.t*)
>--- linux-2.6.6/Makefile.saved	2004-05-11 19:20:02.000000000 +0200
>+++ linux-2.6.6/Makefile	2004-05-11 19:20:59.000000000 +0200
>@@ -449,6 +449,10 @@
> 
> include $(srctree)/arch/$(ARCH)/Makefile
> 
>+# Let architecture Makefiles change CPPFLAGS if needed
>+CFLAGS := $(CPPFLAGS) $(CFLAGS)
>+AFLAGS := $(CPPFLAGS) $(AFLAGS)
>+
> ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> CFLAGS		+= -Os
> else
>--- linux/include/asm-um/system-i386.h	2004-02-04 04:43:42.000000000 +0100
>+++ uml/linux/include/asm-um/system-i386.h	2004-04-08 00:18:09.621333000 +0200
>@@ -2,36 +2,5 @@
> #define __UM_SYSTEM_I386_H
> 
> #include "asm/system-generic.h"
>-
>-static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
>-				      unsigned long new, int size)
>-{
>-	unsigned long prev;
>-	switch (size) {
>-	case 1:
>-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgb %b1,%2"
>-				     : "=a"(prev)
>-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
>-				     : "memory");
>-		return prev;
>-	case 2:
>-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
>-				     : "=a"(prev)
>-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
>-				     : "memory");
>-		return prev;
>-	case 4:
>-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
>-				     : "=a"(prev)
>-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
>-				     : "memory");
>-		return prev;
>-	}
>-	return old;
>-}
>-
>-#define cmpxchg(ptr,o,n)\
>-	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
>-					(unsigned long)(n),sizeof(*(ptr))))
>     
> #endif
>--- linux/arch/um/Makefile-i386	2004-04-08 00:27:50.031333000 +0200
>+++ uml/linux/arch/um/Makefile-i386	2004-04-07 23:22:31.000000000 +0200
>@@ -30,7 +30,7 @@
> $(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread 
> 	$(call filechk,$@)
> 
>-$(SYS_UTIL_DIR)/mk_sc: scripts/fixdep include/config/MARKER FORCE ; 
>+$(SYS_UTIL_DIR)/mk_sc: scripts/basic/fixdep include/config/MARKER FORCE ; 
> 	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
> 
> $(SYS_UTIL_DIR)/mk_thread: $(ARCH_SYMLINKS) $(GEN_HEADERS) sys_prepare FORCE ; 
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
