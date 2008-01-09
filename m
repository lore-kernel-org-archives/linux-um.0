Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCj7W-00055h-RY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 14:09:58 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCj7V-0007wH-Qt
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 14:09:58 -0800
Received: from c2.user-mode-linux.org (littleton.addtoit.com [198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id m09M9pek000396
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 9 Jan 2008 17:09:52 -0500
Received: from c2.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by c2.user-mode-linux.org (8.14.1/8.13.8) with ESMTP id m09M9phd009304
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 9 Jan 2008 17:09:51 -0500
Date: Wed, 9 Jan 2008 17:09:51 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080109220951.GA9109@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 3/9] SKAS4 - Host SIGSEGV siginfo_t extensions
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Add CPU trap number and error code to siginfo_t in the SIGSEGV case for x86.

Index: linux-2.6-skas4/arch/x86/mm/fault_32.c
===================================================================
--- linux-2.6-skas4.orig/arch/x86/mm/fault_32.c	2008-01-08 18:48:30.000000000 -0500
+++ linux-2.6-skas4/arch/x86/mm/fault_32.c	2008-01-08 18:48:36.000000000 -0500
@@ -211,6 +211,8 @@ static noinline void force_sig_info_faul
 	info.si_errno = 0;
 	info.si_code = si_code;
 	info.si_addr = (void __user *)address;
+	info.si_trapno = tsk->thread.trap_no;
+	info.si_error = tsk->thread.error_code;
 	force_sig_info(si_signo, &info, tsk);
 }
 
Index: linux-2.6-skas4/arch/x86/mm/fault_64.c
===================================================================
--- linux-2.6-skas4.orig/arch/x86/mm/fault_64.c	2008-01-08 18:48:30.000000000 -0500
+++ linux-2.6-skas4/arch/x86/mm/fault_64.c	2008-01-08 18:48:36.000000000 -0500
@@ -502,6 +502,8 @@ bad_area_nosemaphore:
 		info.si_errno = 0;
 		/* info.si_code has been set above */
 		info.si_addr = (void __user *)address;
+		info.si_trapno = tsk->thread.trap_no;
+		info.si_error = tsk->thread.error_code;
 		force_sig_info(SIGSEGV, &info, tsk);
 		return;
 	}
@@ -577,6 +579,8 @@ do_sigbus:
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void __user *)address;
+	info.si_trapno = tsk->thread.trap_no;
+	info.si_error = tsk->thread.error_code;
 	force_sig_info(SIGBUS, &info, tsk);
 	return;
 }
Index: linux-2.6-skas4/include/asm-generic/siginfo.h
===================================================================
--- linux-2.6-skas4.orig/include/asm-generic/siginfo.h	2008-01-08 18:48:30.000000000 -0500
+++ linux-2.6-skas4/include/asm-generic/siginfo.h	2008-01-08 18:48:36.000000000 -0500
@@ -82,6 +82,9 @@ typedef struct siginfo {
 #ifdef __ARCH_SI_TRAPNO
 			int _trapno;	/* TRAP # which caused the signal */
 #endif
+#ifdef __ARCH_SI_ERROR
+			int _error;	/* CPU error code */
+#endif
 		} _sigfault;
 
 		/* SIGPOLL */
@@ -112,6 +115,12 @@ typedef struct siginfo {
 #ifdef __ARCH_SI_TRAPNO
 #define si_trapno	_sifields._sigfault._trapno
 #endif
+#ifdef __ARCH_SI_ERROR
+#define si_error	_sifields._sigfault._error
+#endif
+#ifdef __ARCH_SI_ERROR
+#define si_error	_sifields._sigfault._error
+#endif
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
 
Index: linux-2.6-skas4/include/asm-x86/siginfo.h
===================================================================
--- linux-2.6-skas4.orig/include/asm-x86/siginfo.h	2008-01-08 18:48:30.000000000 -0500
+++ linux-2.6-skas4/include/asm-x86/siginfo.h	2008-01-08 18:48:36.000000000 -0500
@@ -5,6 +5,12 @@
 # define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
 #endif
 
+#define __ARCH_SI_TRAPNO
+#define __ARCH_SI_ERROR
+
+#define __ARCH_SI_TRAPNO
+#define __ARCH_SI_ERROR
+
 #include <asm-generic/siginfo.h>
 
 #endif
Index: linux-2.6-skas4/include/linux/signalfd.h
===================================================================
--- linux-2.6-skas4.orig/include/linux/signalfd.h	2008-01-08 18:48:30.000000000 -0500
+++ linux-2.6-skas4/include/linux/signalfd.h	2008-01-08 18:48:36.000000000 -0500
@@ -26,6 +26,8 @@ struct signalfd_siginfo {
 	__u64 ssi_utime;
 	__u64 ssi_stime;
 	__u64 ssi_addr;
+	__u32 ssi_trap_no;
+	__u32 ssi_error_code;
 
 	/*
 	 * Pad strcture to 128 bytes. Remember to update the
@@ -36,7 +38,7 @@ struct signalfd_siginfo {
 	 * comes out of a read(2) and we really don't want to have
 	 * a compat on read(2).
 	 */
-	__u8 __pad[48];
+	__u8 __pad[40];
 };
 
 
Index: linux-2.6-skas4/kernel/signal.c
===================================================================
--- linux-2.6-skas4.orig/kernel/signal.c	2008-01-08 18:48:30.000000000 -0500
+++ linux-2.6-skas4/kernel/signal.c	2008-01-08 18:48:36.000000000 -0500
@@ -2108,6 +2108,9 @@ int copy_siginfo_to_user(siginfo_t __use
 #ifdef __ARCH_SI_TRAPNO
 		err |= __put_user(from->si_trapno, &to->si_trapno);
 #endif
+#ifdef __ARCH_SI_ERROR
+		err |= __put_user(from->si_error, &to->si_error);
+#endif
 		break;
 	case __SI_CHLD:
 		err |= __put_user(from->si_pid, &to->si_pid);

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
