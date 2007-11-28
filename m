Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxQEk-00046X-9U for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 08:58:10 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxQEi-0002tf-C5
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 08:58:10 -0800
In-reply-to: <20071128160501.GA7986@elte.hu> (message from Ingo Molnar on Wed, 
	28 Nov 2007 17:05:01 +0100)
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128125030.GB21791@elte.hu>
	<E1IxMfh-0006fN-HQ@dorka.pomaz.szeredi.hu>
	<20071128150840.GB5518@c2.user-mode-linux.org>
	<E1IxOzn-00075w-Gq@dorka.pomaz.szeredi.hu>
	<20071128154152.GA742@elte.hu>
	<E1IxPKU-00079S-UH@dorka.pomaz.szeredi.hu>
	<20071128160501.GA7986@elte.hu>
Message-Id: <E1IxQEX-0007Ji-TV@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Nov 2007 17:57:57 +0100
Subject: Re: [uml-devel] -rt doesn't compile for UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: mingo@elte.hu
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> so you can define irqs_off_flags to always-0 and you should be able to 
> get pretty good traces still. It should have no functional impact.

OK, managed to make it compile, but then something goes wrong in
tracer_alloc_bootmem().

Jeff?

(attaching patch, which goes on top of
latency-tracer-v2.6.24-rc2-git5-combo.patch, which goes on top of
2.6.24-rc3)

Miklos



#0  0xffffe410 in __kernel_vsyscall ()
#1  0xf7e498f5 in raise () from /lib/libc.so.6
#2  0xf7e4b1e1 in abort () from /lib/libc.so.6
#3  0x0806ba54 in os_dump_core () at arch/um/os-Linux/util.c:147
#4  0x0805d009 in panic_exit (self=0x8239594, unused1=0, unused2=0x8250360)
    at arch/um/kernel/um_arch.c:370
#5  0x080927d7 in notifier_call_chain (nl=0x824032c, val=0, v=0x8250360, nr_to_call=-1,
    nr_calls=0x0) at kernel/notifier.c:69
#6  0x080928b8 in __atomic_notifier_call_chain (nh=0x824031c, val=0, v=0x8250360,
    nr_to_call=-1, nr_calls=0x0) at kernel/notifier.c:158
#7  0x080928ee in atomic_notifier_call_chain (nh=0x824031c, val=0, v=0x8250360)
    at kernel/notifier.c:167
#8  0x08077e17 in panic (fmt=0x81f82b6 "Out of memory") at kernel/panic.c:101
#9  0x0804f6d0 in __alloc_bootmem (size=33554432, align=128, goal=4294967295)
    at mm/bootmem.c:442
#10 0x0804ea0d in tracer_alloc_bootmem (size=33554432) at kernel/latency_trace.c:2690
#11 0x0804ea78 in init_tracer () at kernel/latency_trace.c:2718
#12 0x08049668 in start_kernel () at init/main.c:590
#13 0x0804b00b in start_kernel_proc (unused=0x0) at arch/um/kernel/skas/process.c:40
#14 0x08069672 in run_kernel_thread (fn=0x804afda <start_kernel_proc>, arg=0x0,
    jmp_ptr=0x823922c) at arch/um/os-Linux/process.c:264
#15 0x0805a22d in new_thread_handler () at arch/um/kernel/process.c:153
#16 0x00000000 in ?? ()



----------------
Index: linux/include/asm-um/rtc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/asm-um/rtc.h	2007-11-28 17:41:42.000000000 +0100
@@ -0,0 +1 @@
+/* stub for the latency tracer */
Index: linux/include/asm-um/irqflags.h
===================================================================
--- linux.orig/include/asm-um/irqflags.h	2007-11-28 17:36:21.000000000 +0100
+++ linux/include/asm-um/irqflags.h	2007-11-28 17:41:42.000000000 +0100
@@ -1,6 +1,9 @@
 #ifndef __UM_IRQFLAGS_H
 #define __UM_IRQFLAGS_H
 
-/* Empty for now */
+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+	return 0;
+}
 
 #endif
Index: linux/kernel/latency_trace.c
===================================================================
--- linux.orig/kernel/latency_trace.c	2007-11-28 17:41:35.000000000 +0100
+++ linux/kernel/latency_trace.c	2007-11-28 17:55:20.000000000 +0100
@@ -26,6 +26,7 @@
 #include <asm/unistd.h>
 #include <asm/asm-offsets.h>
 #include <asm/rtc.h>
+#include <asm/irqflags.h>
 #include <linux/stacktrace.h>
 
 #ifndef DEFINE_RAW_SPINLOCK
@@ -59,6 +60,8 @@ static unsigned long notrace cycles_to_u
 	delta = mulhwu(tb_to_us, delta);
 #elif defined(CONFIG_ARM)
 	delta = mach_cycles_to_usecs(delta);
+#elif defined(CONFIG_UML)
+	/* Dunno */
 #else
 	#error Implement cycles_to_usecs.
 #endif
@@ -655,7 +658,7 @@ again:
 	entry->cpu = cpu;
 #endif
 	entry->flags = (irqs_off() ? TRACE_FLAG_IRQS_OFF : 0) |
-		(irqs_disabled_flags(flags) ? TRACE_FLAG_IRQS_HARD_OFF : 0)|
+		(raw_irqs_disabled_flags(flags) ? TRACE_FLAG_IRQS_HARD_OFF : 0)|
 		((pc & HARDIRQ_MASK) ? TRACE_FLAG_HARDIRQ : 0) |
 		((pc & SOFTIRQ_MASK) ? TRACE_FLAG_SOFTIRQ : 0) |
 		(need_resched() ? TRACE_FLAG_NEED_RESCHED : 0) |
@@ -786,6 +789,7 @@ void notrace trace_special_sym(void)
 	if (!trace_enabled || !stackframe_tracing)
 		return;
 
+#ifndef CONFIG_UML
 	trace.entries = entries;
 	trace.skip = 3;
 	trace.max_entries = STACK_ENTRIES;
@@ -802,6 +806,7 @@ void notrace trace_special_sym(void)
 					entries[1], entries[2], entries[3]);
 	___trace(TRACE_SPECIAL_SYM, entries[4], 0,
 					entries[5], entries[6], entries[7]);
+#endif
 }
 
 EXPORT_SYMBOL(trace_special_sym);

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
