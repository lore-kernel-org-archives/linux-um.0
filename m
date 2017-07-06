Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dTDwl-0002uc-M0
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2017 21:04:23 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dTDwk-0002Ee-Nd
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2017 21:04:23 +0000
From: Thomas Meyer <thomas@m3y3r.de>
Date: Thu,  6 Jul 2017 23:04:04 +0200
Message-Id: <20170706210404.18253-1-thomas@m3y3r.de>
Subject: [uml-devel] [PATCH] um: Fix FP register size for XSTATE/XSAVE
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
 arch/x86/um/os-Linux/registers.c | 9 ++++-----
 arch/x86/um/user-offsets.c       | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index 00f54a91bb4b..7265511d8e3b 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -30,7 +30,7 @@ int save_fp_registers(int pid, unsigned long *fp_regs)
 
 	if (have_xstate_support) {
 		iov.iov_base = fp_regs;
-		iov.iov_len = sizeof(struct _xstate);
+		iov.iov_len = FP_SIZE * sizeof(unsigned long);
 		if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
 			return -errno;
 		return 0;
@@ -49,10 +49,9 @@ int restore_i387_registers(int pid, unsigned long *fp_regs)
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
@@ -122,11 +121,11 @@ int put_fp_registers(int pid, unsigned long *regs)
 
 void arch_init_registers(int pid)
 {
-	struct _xstate fp_regs;
+	unsigned long fp_regs[FP_SIZE];
 	struct iovec iov;
 
 	iov.iov_base = &fp_regs;
-	iov.iov_len = sizeof(struct _xstate);
+	iov.iov_len = FP_SIZE * sizeof(unsigned long);
 	if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) == 0)
 		have_xstate_support = 1;
 }
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

