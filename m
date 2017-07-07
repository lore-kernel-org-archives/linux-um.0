Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dTaNi-0002BQ-Il
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 21:01:42 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dTaNe-0007Tr-RA
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 21:01:42 +0000
From: Thomas Meyer <thomas@m3y3r.de>
Date: Fri,  7 Jul 2017 23:01:27 +0200
Message-Id: <20170707210127.11601-1-thomas@m3y3r.de>
In-Reply-To: <20170706210404.18253-1-thomas@m3y3r.de>
References: <20170706210404.18253-1-thomas@m3y3r.de>
Subject: [uml-devel] [PATCH] um: v2: Fix FP register size for XSTATE/XSAVE
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hard code max size. Taken from
https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/common/x86-xstate.h

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/os-Linux/skas/process.c  | 22 ++++++++++++++++++----
 arch/x86/um/os-Linux/registers.c | 16 +++++++++++-----
 arch/x86/um/user-offsets.c       |  2 +-
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 03b3c4cc7735..1a7cce387950 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -91,19 +91,25 @@ extern unsigned long current_stub_stack(void);
 static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 {
 	int err;
-	unsigned long fpregs[FP_SIZE];
+	void * fpregs;
+
+	fpregs = malloc(FP_SIZE * sizeof(unsigned long));
+	if(fpregs == NULL) {
+		printk(UM_KERN_ERR "cannot alloc memory for save_fp_registers!");
+		goto errout;
+	}
 
 	err = get_fp_registers(pid, fpregs);
 	if (err < 0) {
 		printk(UM_KERN_ERR "save_fp_registers returned %d\n",
 		       err);
-		fatal_sigsegv();
+		goto errout;
 	}
 	err = ptrace(PTRACE_CONT, pid, 0, SIGSEGV);
 	if (err) {
 		printk(UM_KERN_ERR "Failed to continue stub, pid = %d, "
 		       "errno = %d\n", pid, errno);
-		fatal_sigsegv();
+		goto errout;
 	}
 	wait_stub_done(pid);
 
@@ -117,8 +123,16 @@ static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 	if (err < 0) {
 		printk(UM_KERN_ERR "put_fp_registers returned %d\n",
 		       err);
-		fatal_sigsegv();
+		goto errout;
 	}
+	return;
+
+	errout:
+		if(fpregs != NULL) {
+			free(fpregs);
+		}
+		fatal_sigsegv();
+
 }
 
 static void handle_segv(int pid, struct uml_pt_regs * regs)
diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index 00f54a91bb4b..e972c3d3b7b1 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -5,6 +5,7 @@
  */
 
 #include <errno.h>
+#include <stdlib.h>
 #include <sys/ptrace.h>
 #ifdef __i386__
 #include <sys/user.h>
@@ -30,7 +31,7 @@ int save_fp_registers(int pid, unsigned long *fp_regs)
 
 	if (have_xstate_support) {
 		iov.iov_base = fp_regs;
-		iov.iov_len = sizeof(struct _xstate);
+		iov.iov_len = FP_SIZE * sizeof(unsigned long);
 		if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
 			return -errno;
 		return 0;
@@ -49,10 +50,9 @@ int restore_i387_registers(int pid, unsigned long *fp_regs)
 int restore_fp_registers(int pid, unsigned long *fp_regs)
 {
 	struct iovec iov;
-
 	if (have_xstate_support) {
 		iov.iov_base = fp_regs;
-		iov.iov_len = sizeof(struct _xstate);
+		iov.iov_len = FP_SIZE * sizeof(unsigned long);
 		if (ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
 			return -errno;
 		return 0;
@@ -122,13 +122,19 @@ int put_fp_registers(int pid, unsigned long *regs)
 
 void arch_init_registers(int pid)
 {
-	struct _xstate fp_regs;
+	void * fp_regs;
 	struct iovec iov;
 
+	fp_regs = malloc(FP_SIZE * sizeof(unsigned long));
+	if(fp_regs == NULL)
+		return;
+
 	iov.iov_base = &fp_regs;
-	iov.iov_len = sizeof(struct _xstate);
+	iov.iov_len = FP_SIZE * sizeof(unsigned long);
 	if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) == 0)
 		have_xstate_support = 1;
+
+	free(fp_regs);
 }
 #endif
 
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index cb3c22370cf5..c0111f093361 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -50,7 +50,7 @@ void foo(void)
 	DEFINE(HOST_GS, GS);
 	DEFINE(HOST_ORIG_AX, ORIG_EAX);
 #else
-	DEFINE(HOST_FP_SIZE, sizeof(struct _xstate) / sizeof(unsigned long));
+	DEFINE_LONGS(HOST_FP_SIZE, 2696);
 	DEFINE_LONGS(HOST_BX, RBX);
 	DEFINE_LONGS(HOST_CX, RCX);
 	DEFINE_LONGS(HOST_DI, RDI);
-- 
2.13.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

