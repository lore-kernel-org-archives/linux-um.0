Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNcTn-0001nQ-Le for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 May 2004 11:59:51 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BNcTn-000463-1n for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 May 2004 11:59:51 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0LSoAkHCZqgemXM"
Message-Id: <200405112101.08190.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Patch for 2.6.6
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
Date: Tue, 11 May 2004 21:01:08 +0200
To: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Chua <jeff98@silk.corp.fedex.com>, roland <for_spam@gmx.de>, gboutwel <gboutwel@praize.com>, Jeff Dike <jdike@addtoit.com>



--Boundary-00=_0LSoAkHCZqgemXM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm working on the 2.6.6 patch, and you'll find attached what you need on t=
op=20
of the vanilla kernel. I changed a bit his 2.6.6-0 patch, so I attach the=20
2.6.6-01 patch. The changes just avoid the "fuzz" messages from patch.

So, what to do:

=2Dcreate a 2.6.6 vanilla kernel tree
=2Dapply the patch uml-patch-2.6.6-01.bz2 from:

http://www.user-mode-linux.org/~blaisorblade/patches/uml-patch-2.6.6-01.bz2

(I attached it but the ML refused it because it was too big).

=2Dapply the attached patch-2.6.6-v2

you need no other patches!! The one for 2.6.5 is included!

=2Dbuild as usual.

I've built one UML binary this way (with a minimal configuration, to build =
it=20
quickly), I just have a problem with tty pairs with the root_fs_tomsbrt:=20
maybe it comes from the work done in the kernel in this area and from the=20
particularities of that FS; with my normal slack9.0 FS, it started well and=
=20
is now working and running some little stress tests.

Or better, it stopped at a certain point, did a lot of work,=20
restarted the boot process from the first message and then went just fine. =
I=20
typed "reboot" and it worked perfectly; then I shut it down, and restarted=
=20
it: it worked perfectly.

However, before it started, the same binary gave:
=2D a segmentation fault (not repeatable, sometimes it happened even before)
=2D a panic from tcsetattr with EINTR (it's known, has a XXX in the sources=
 and=20
I sent a working patch time ago)

=46rom here onwards there are the technical details about the patches:

Most of the kludges Jeff Chua did are just workaround, which can be replace=
d=20
with this patch:

=2D-- Makefile.saved      2004-05-11 19:20:02.000000000 +0200
+++ Makefile    2004-05-11 19:20:59.000000000 +0200
@@ -449,6 +449,10 @@

 include $(srctree)/arch/$(ARCH)/Makefile

+# Let architecture Makefiles change CPPFLAGS if needed
+CFLAGS :=3D $(CPPFLAGS) $(CFLAGS)
+AFLAGS :=3D $(CPPFLAGS) $(AFLAGS)
+
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 CFLAGS         +=3D -Os
 else

(apply with patch -l). This undoes a change from the 2.6.6 patch, done for =
I=20
do not know which reason. They probably thought it didn't hurt; it does,=20
indeed. For us it is VERY important (actually, for some kludges we do).

This second change, instead, comes straight from his patch. I've not tested=
=20
it, however I know where it could come from. If he got a running UML with=20
this change, then it means it works, however it needs some more analisys=20
IMHO.

=2D-- ./arch/um/kernel/physmem.c.saved    2004-05-11 19:24:53.000000000 +02=
00
+++ ./arch/um/kernel/physmem.c  2004-05-11 19:25:16.000000000 +0200
@@ -285,7 +285,7 @@
                p =3D &map[i];
                set_page_count(p, 0);
                SetPageReserved(p);
=2D               INIT_LIST_HEAD(&p->list);
+               INIT_LIST_HEAD(&p->lru);
        }

        mem_map =3D map;

Then, inside patch-2.6.6-v1 there is the content of the 2nd version of the=
=20
2.6.5 fix.

=46inally, I had to fix the linker script, to avoid the problem with these =
lines=20
addressed:

=2D-- uml.org/kernel/sched.c      Fri Apr 16 21:23:00 2004
+++ uml/kernel/sched.c  Fri Apr 16 12:19:34 2004
@@ -225,12 +225,14 @@
 #define task_rq(p)             cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)          (cpu_rq(cpu)->curr)

+/*
 extern unsigned long __scheduling_functions_start_here;
 extern unsigned long __scheduling_functions_end_here;
 const unsigned long scheduling_functions_start_here =3D
                        (unsigned long)&__scheduling_functions_start_here;
 const unsigned long scheduling_functions_end_here =3D
                        (unsigned long)&__scheduling_functions_end_here;
+*/

I had to use SCHED_TEXT inside the linker script as the other linking scrip=
ts=20
do from 2.6.6; this provides the definition for __scheduling_functions_*.

And finally this:

 void show_stack(struct task_struct *task, unsigned long *sp)
 {
=2D       if(task)
=2D               show_trace_task(task);
=2D       else
=2D               show_trace(sp);
+       show_trace(sp);
 }

because 2.6.6 deletes show_trace_task from each arch. However the other arc=
hs=20
did never actually use it, while UML does - maybe the proper solution is to=
=20
restore the show_trace_task definition. But why was it unused? Maybe the bu=
g=20
is the fact we use it.

However, I hope it helps.

Bye
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729







--Boundary-00=_0LSoAkHCZqgemXM
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.6.6-v2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.6-v2"

--- linux-2.6.6/arch/um/kernel/physmem.c.saved	2004-05-11 19:24:53.000000000 +0200
+++ linux-2.6.6/arch/um/kernel/physmem.c	2004-05-11 19:25:16.000000000 +0200
@@ -285,7 +285,7 @@
 		p = &map[i];
 		set_page_count(p, 0);
 		SetPageReserved(p);
-		INIT_LIST_HEAD(&p->list);
+		INIT_LIST_HEAD(&p->lru);
 	}
 
 	mem_map = map;
--- linux-2.6.6/arch/um/kernel/sysrq.c.saved	2004-05-11 17:52:41.000000000 +0200
+++ linux-2.6.6/arch/um/kernel/sysrq.c	2004-05-11 19:55:36.000000000 +0200
@@ -46,10 +46,7 @@
 
 void show_stack(struct task_struct *task, unsigned long *sp)
 {
-	if(task)
-		show_trace_task(task);
-	else
-		show_trace(sp);
+	show_trace(sp);
 }
 
 /*
--- linux-2.6.6/arch/um/dyn.lds.S.saved	2004-05-11 17:52:40.000000000 +0200
+++ linux-2.6.6/arch/um/dyn.lds.S	2004-05-11 20:18:36.000000000 +0200
@@ -1,3 +1,5 @@
+#include <asm-generic/vmlinux.lds.h>
+
 OUTPUT_FORMAT(ELF_FORMAT)
 OUTPUT_ARCH(ELF_ARCH)
 ENTRY(_start)
@@ -58,7 +60,9 @@
   } =0x90909090
   .plt            : { *(.plt) }
   .text           : {
-    *(.text .stub .text.* .gnu.linkonce.t.*)
+    *(.text)
+    SCHED_TEXT
+    *(.stub .text.* .gnu.linkonce.t.*)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
   } =0x90909090
--- linux-2.6.6/arch/um/uml.lds.S.saved	2004-05-11 17:52:42.000000000 +0200
+++ linux-2.6.6/arch/um/uml.lds.S	2004-05-11 20:03:10.000000000 +0200
@@ -34,6 +34,7 @@
   .text      :
   {
     *(.text)
+    SCHED_TEXT
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
     *(.gnu.linkonce.t*)
--- linux-2.6.6/Makefile.saved	2004-05-11 19:20:02.000000000 +0200
+++ linux-2.6.6/Makefile	2004-05-11 19:20:59.000000000 +0200
@@ -449,6 +449,10 @@
 
 include $(srctree)/arch/$(ARCH)/Makefile
 
+# Let architecture Makefiles change CPPFLAGS if needed
+CFLAGS := $(CPPFLAGS) $(CFLAGS)
+AFLAGS := $(CPPFLAGS) $(AFLAGS)
+
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 CFLAGS		+= -Os
 else
--- linux/include/asm-um/system-i386.h	2004-02-04 04:43:42.000000000 +0100
+++ uml/linux/include/asm-um/system-i386.h	2004-04-08 00:18:09.621333000 +0200
@@ -2,36 +2,5 @@
 #define __UM_SYSTEM_I386_H
 
 #include "asm/system-generic.h"
-
-static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
-				      unsigned long new, int size)
-{
-	unsigned long prev;
-	switch (size) {
-	case 1:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgb %b1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 2:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 4:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	}
-	return old;
-}
-
-#define cmpxchg(ptr,o,n)\
-	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
-					(unsigned long)(n),sizeof(*(ptr))))
     
 #endif
--- linux/arch/um/Makefile-i386	2004-04-08 00:27:50.031333000 +0200
+++ uml/linux/arch/um/Makefile-i386	2004-04-07 23:22:31.000000000 +0200
@@ -30,7 +30,7 @@
 $(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread 
 	$(call filechk,$@)
 
-$(SYS_UTIL_DIR)/mk_sc: scripts/fixdep include/config/MARKER FORCE ; 
+$(SYS_UTIL_DIR)/mk_sc: scripts/basic/fixdep include/config/MARKER FORCE ; 
 	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
 
 $(SYS_UTIL_DIR)/mk_thread: $(ARCH_SYMLINKS) $(GEN_HEADERS) sys_prepare FORCE ; 

--Boundary-00=_0LSoAkHCZqgemXM--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
