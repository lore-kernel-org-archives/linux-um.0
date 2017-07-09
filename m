Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dUKlQ-0008AE-8w
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jul 2017 22:33:16 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dUKlP-0000A6-6h
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jul 2017 22:33:16 +0000
From: Thomas Meyer <thomas@m3y3r.de>
Date: Mon, 10 Jul 2017 00:33:03 +0200
Message-Id: <20170709223303.24424-1-thomas@m3y3r.de>
In-Reply-To: <CAFLxGvzyMVKMmm6Xuf=myOQ+_XdndDYHv1TW8ztN5qT4i-uQsA@mail.gmail.com>
References: <CAFLxGvzyMVKMmm6Xuf=myOQ+_XdndDYHv1TW8ztN5qT4i-uQsA@mail.gmail.com>
Subject: [uml-devel] [PATCH] um: v3: Fix FP register size for XSTATE/XSAVE
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
To: richard.weinberger@gmail.com, user-mode-linux-devel@lists.sourceforge.net

Hard code max size. Taken from
https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/common/x86-xstate.h

v3: use static fp_regs for get_skas_faultinfo

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/os-Linux/skas/process.c  |  7 ++++---
 arch/x86/um/os-Linux/registers.c | 18 ++++++++++++------
 arch/x86/um/user-offsets.c       |  2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 03b3c4cc7735..b5fdef795985 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -88,12 +88,13 @@ void wait_stub_done(int pid)
 
 extern unsigned long current_stub_stack(void);
 
+static unsigned long skas_faultinfo_fpregs[FP_SIZE];
+
 static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 {
 	int err;
-	unsigned long fpregs[FP_SIZE];
 
-	err = get_fp_registers(pid, fpregs);
+	err = get_fp_registers(pid, skas_faultinfo_fpregs);
 	if (err < 0) {
 		printk(UM_KERN_ERR "save_fp_registers returned %d\n",
 		       err);
@@ -113,7 +114,7 @@ static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 	 */
 	memcpy(fi, (void *)current_stub_stack(), sizeof(*fi));
 
-	err = put_fp_registers(pid, fpregs);
+	err = put_fp_registers(pid, skas_faultinfo_fpregs);
 	if (err < 0) {
 		printk(UM_KERN_ERR "put_fp_registers returned %d\n",
 		       err);
diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index 00f54a91bb4b..2717911d1bef 100644
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
 
-	iov.iov_base = &fp_regs;
-	iov.iov_len = sizeof(struct _xstate);
+	fp_regs = malloc(FP_SIZE * sizeof(unsigned long));
+	if(fp_regs == NULL)
+		return;
+
+	iov.iov_base = fp_regs;
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

