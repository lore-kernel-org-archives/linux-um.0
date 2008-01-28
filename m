Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Mon, 28 Jan 2008 16:38:29 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080128213829.GA10241@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 3/10] SKAS4 - Host SIGSEGV siginfo_t extensions
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
To: uml-user <user-mode-linux-user@lists.sourceforge.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Add CPU trap number and error code to siginfo_t in the SIGSEGV case for x86.

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 6ea19c2..2f74adf 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -65,6 +65,8 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, siginfo_t *from)
 		err |= __put_user(from->_sifields._pad[0], &to->_sifields._pad[0]);
 		switch (from->si_code >> 16) {
 		case __SI_FAULT >> 16:
+			err |= __put_user(from->si_trapno, &to->si_trapno);
+			err |= __put_user(from->si_error, &to->si_error);
 			break;
 		case __SI_CHLD >> 16:
 			err |= __put_user(from->si_utime, &to->si_utime);
diff --git a/arch/x86/mm/fault_32.c b/arch/x86/mm/fault_32.c
index a2273d4..0e7940d 100644
--- a/arch/x86/mm/fault_32.c
+++ b/arch/x86/mm/fault_32.c
@@ -211,6 +211,8 @@ static noinline void force_sig_info_fault(int si_signo, int si_code,
 	info.si_errno = 0;
 	info.si_code = si_code;
 	info.si_addr = (void __user *)address;
+	info.si_trapno = tsk->thread.trap_no;
+	info.si_error = tsk->thread.error_code;
 	force_sig_info(si_signo, &info, tsk);
 }
 
diff --git a/arch/x86/mm/fault_64.c b/arch/x86/mm/fault_64.c
index 0e26230..6365ba8 100644
--- a/arch/x86/mm/fault_64.c
+++ b/arch/x86/mm/fault_64.c
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
diff --git a/include/asm-generic/siginfo.h b/include/asm-generic/siginfo.h
index 8786e01..b295e86 100644
--- a/include/asm-generic/siginfo.h
+++ b/include/asm-generic/siginfo.h
@@ -82,6 +82,9 @@ typedef struct siginfo {
 #ifdef __ARCH_SI_TRAPNO
 			int _trapno;	/* TRAP # which caused the signal */
 #endif
+#ifdef __ARCH_SI_ERROR
+			int _error;	/* CPU error code */
+#endif
 		} _sigfault;
 
 		/* SIGPOLL */
@@ -112,6 +115,9 @@ typedef struct siginfo {
 #ifdef __ARCH_SI_TRAPNO
 #define si_trapno	_sifields._sigfault._trapno
 #endif
+#ifdef __ARCH_SI_ERROR
+#define si_error	_sifields._sigfault._error
+#endif
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
 
diff --git a/include/asm-x86/ia32.h b/include/asm-x86/ia32.h
index 0190b7c..afc75c3 100644
--- a/include/asm-x86/ia32.h
+++ b/include/asm-x86/ia32.h
@@ -119,6 +119,8 @@ typedef struct compat_siginfo{
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
 		struct {
 			unsigned int _addr;	/* faulting insn/memory ref. */
+			int _trapno;	/* TRAP # which caused the signal */
+			int _error;	/* CPU error code */
 		} _sigfault;
 
 		/* SIGPOLL */
diff --git a/include/asm-x86/siginfo.h b/include/asm-x86/siginfo.h
index a477bea..59c8d37 100644
--- a/include/asm-x86/siginfo.h
+++ b/include/asm-x86/siginfo.h
@@ -5,6 +5,9 @@
 # define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
 #endif
 
+#define __ARCH_SI_TRAPNO
+#define __ARCH_SI_ERROR
+
 #include <asm-generic/siginfo.h>
 
 #endif
diff --git a/include/linux/signalfd.h b/include/linux/signalfd.h
index 86f9b1e..71e3c45 100644
--- a/include/linux/signalfd.h
+++ b/include/linux/signalfd.h
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
 
 
diff --git a/kernel/signal.c b/kernel/signal.c
index afa4f78..1e067a1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2108,6 +2108,9 @@ int copy_siginfo_to_user(siginfo_t __user *to, siginfo_t *from)
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
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
