Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bz5t7-0004jI-1b for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Aug 2004 20:52:53 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1Bz5t5-0000It-Eg
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Aug 2004 20:52:52 -0700
Message-Id: <200408230454.i7N4soOV006652@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] sysemu
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
Date: Mon, 23 Aug 2004 00:54:50 -0400
To: LaurentVivier@wanadoo.fr
Cc: user-mode-linux-devel@lists.sourceforge.net

Call me a lamer, but I only now got around to looking at the sysemu
patch in detail.

As it stands, it can't be merged into mainline because it adds two
instructions to the system call fast path.  This is the sort of thing
that make Linus and others go ballistic.

The duplication of syscall_trace as syscall_emulate is also pretty
ugly.

Below, see a patch which tweaks things to eliminate both problems.
Now, PT_SCEMU is set in conjunction with PT_TRACESYS, rather than
one or the other, but not both, being set.

This means that the PT_TRACESYS test in entry.S covers both cases, and
the fast path is unchanged.

The other change was to make syscall_trace return zero or non-zero,
according as it should run the system call or immediately return.
This adds a line to syscall_trace and eliminates syscall_emulate.

The updated patch is 83 lines of diff rather than the original 128.

I've run it with both a little test case, and a tt mode UML.  The getpid()
benchmark there showed little improvement (~1-2%), surprisingly.  I'm going
to profile to see what's going on there.

Have a look and see if it looks reasonable.

				Jeff

diff -Naur linux-2.4.22-1.2197.nptl/arch/i386/kernel/entry.S linux-2.4.22-1.2197.nptl-sysemu/arch/i386/kernel/entry.S
--- linux-2.4.22-1.2197.nptl/arch/i386/kernel/entry.S	2004-07-01 15:04:41.000000000 -0400
+++ linux-2.4.22-1.2197.nptl-sysemu/arch/i386/kernel/entry.S	2004-08-21 12:02:25.000000000 -0400
@@ -240,7 +240,9 @@
 	ALIGN
 tracesys:
 	movl $-ENOSYS,EAX(%esp)
-	call SYMBOL_NAME(syscall_trace)
+	call SYMBOL_NAME(syscall_trace) # non-zero return from syscall_trace
+	cmpl $0, %eax			# means that the system call was
+	jne ret_from_sys_call		# nullified
 	movl ORIG_EAX(%esp),%eax
 	cmpl $(NR_syscalls),%eax
 	jae tracesys_exit
diff -Naur linux-2.4.22-1.2197.nptl/arch/i386/kernel/ptrace.c linux-2.4.22-1.2197.nptl-sysemu/arch/i386/kernel/ptrace.c
--- linux-2.4.22-1.2197.nptl/arch/i386/kernel/ptrace.c	2004-07-01 15:04:37.000000000 -0400
+++ linux-2.4.22-1.2197.nptl-sysemu/arch/i386/kernel/ptrace.c	2004-08-21 12:05:12.000000000 -0400
@@ -351,6 +351,7 @@
 		  }
 		  break;
 
+	case PTRACE_SCEMU: /* continue and replace next syscall */
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		long tmp;
@@ -360,6 +361,8 @@
 			break;
 		if (request == PTRACE_SYSCALL)
 			child->ptrace |= PT_TRACESYS;
+		else if (request == PTRACE_SCEMU)
+			child->ptrace |= PT_TRACESYS | PT_SCEMU;
 		else
 			child->ptrace &= ~PT_TRACESYS;
 		child->exit_code = data;
@@ -396,7 +399,7 @@
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
-		child->ptrace &= ~PT_TRACESYS;
+		child->ptrace &= ~(PT_TRACESYS | PT_SCEMU);
 		if ((child->ptrace & PT_DTRACE) == 0) {
 			/* Spurious delayed TF traps may occur */
 			child->ptrace |= PT_DTRACE;
@@ -512,7 +515,7 @@
 	return ret;
 }
 
-asmlinkage void syscall_trace(void)
+asmlinkage int syscall_trace(void)
 {
 	if ((current->ptrace & (PT_PTRACED|PT_TRACESYS)) !=
 						(PT_PTRACED|PT_TRACESYS))
@@ -534,4 +537,7 @@
 		current->exit_code = 0;
 	}
 	recalc_sigpending();
+
+	/* 1 if nullifying the syscall, 0 if running it */
+	return(current->ptrace & PT_SCEMU);
 }
diff -Naur linux-2.4.22-1.2197.nptl/include/linux/ptrace.h linux-2.4.22-1.2197.nptl-sysemu/include/linux/ptrace.h
--- linux-2.4.22-1.2197.nptl/include/linux/ptrace.h	2004-07-01 15:05:23.000000000 -0400
+++ linux-2.4.22-1.2197.nptl-sysemu/include/linux/ptrace.h	2004-08-21 12:05:16.000000000 -0400
@@ -22,6 +22,7 @@
 #define PTRACE_DETACH		0x11
 
 #define PTRACE_SYSCALL		  24
+#define PTRACE_SCEMU		  31
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
diff -Naur linux-2.4.22-1.2197.nptl/include/linux/sched.h linux-2.4.22-1.2197.nptl-sysemu/include/linux/sched.h
--- linux-2.4.22-1.2197.nptl/include/linux/sched.h	2004-07-01 15:05:23.000000000 -0400
+++ linux-2.4.22-1.2197.nptl-sysemu/include/linux/sched.h	2004-08-21 11:59:18.000000000 -0400
@@ -573,6 +573,8 @@
 #define PT_TRACE_VFORK_DONE 0x00000100
 #define PT_TRACE_EXIT   0x00000200
 #define PT_DTRACE	0x00000400      /* delayed trace (used on m68k, i386) */
+#define PT_SCEMU	0x00000800	/* syscall emulation for UML */
+
 
 #define is_dumpable(tsk)    ((tsk)->task_dumpable && (tsk)->mm && (tsk)->mm->dumpable)
 



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
