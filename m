Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HVWAA-000701-1U for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Mar 2007 10:05:50 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HVWA9-0007Cz-7m
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Mar 2007 10:05:49 -0700
Date: Sun, 25 Mar 2007 13:01:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070325170144.GB6232@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - use correct register file size everywhere
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, stable@kernel.org
Cc: Davide Brini <brini@geomin.unibo.it>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This patch uses MAX_REG_NR consistently to refer to the register file
size.  FRAME_SIZE isn't sufficient because on x86_64, it is smaller
than the ptrace register file size.  MAX_REG_NR was introduced as a
consistent way to get the number of registers, but wasn't used
everywhere it should be.

When this causes a problem, it makes PTRACE_SETREGS fail on x86_64
because of a corrupted segment register value in the known-good
register file. The patch also adds a register dump at that point in
case there are any future problems here.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/sysdep-x86_64/ptrace.h  |    4 ----
 arch/um/os-Linux/skas/mem.c             |   10 +++++++---
 arch/um/os-Linux/skas/process.c         |    6 +++---
 arch/um/os-Linux/sys-i386/registers.c   |    5 +++--
 arch/um/os-Linux/sys-x86_64/registers.c |    4 ++--
 5 files changed, 15 insertions(+), 14 deletions(-)

Index: linux-2.6.21-mm/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/sysdep-x86_64/ptrace.h	2007-03-22 11:18:04.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/sysdep-x86_64/ptrace.h	2007-03-23 20:31:37.000000000 -0400
@@ -104,10 +104,6 @@ union uml_pt_regs {
 #endif
 #ifdef UML_CONFIG_MODE_SKAS
 	struct skas_regs {
-		/* x86_64 ptrace uses sizeof(user_regs_struct) as its register
-		 * file size, while i386 uses FRAME_SIZE.  Therefore, we need
-		 * to use UM_FRAME_SIZE here instead of HOST_FRAME_SIZE.
-		 */
 		unsigned long regs[MAX_REG_NR];
 		unsigned long fp[HOST_FP_SIZE];
                 struct faultinfo faultinfo;
Index: linux-2.6.21-mm/arch/um/os-Linux/skas/mem.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/skas/mem.c	2007-03-23 15:05:31.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/skas/mem.c	2007-03-25 10:33:30.000000000 -0400
@@ -48,7 +48,7 @@ int multi_op_count = 0;
 static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
 {
 	unsigned long regs[MAX_REG_NR];
-	int n;
+	int n, i;
 	long ret, offset;
 	unsigned long * data;
 	unsigned long * syscall;
@@ -66,9 +66,13 @@ static inline long do_syscall_stub(struc
 		 (unsigned long) &__syscall_stub_start);
 
 	n = ptrace_setregs(pid, regs);
-	if(n < 0)
+	if(n < 0){
+		printk("Registers - \n");
+		for(i = 0; i < MAX_REG_NR; i++)
+			printk("\t%d\t0x%lx\n", i, regs[i]);
 		panic("do_syscall_stub : PTRACE_SETREGS failed, errno = %d\n",
-		      n);
+		      -n);
+	}
 
 	wait_stub_done(pid, 0, "do_syscall_stub");
 
Index: linux-2.6.21-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/skas/process.c	2007-03-23 15:05:31.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/skas/process.c	2007-03-25 10:33:30.000000000 -0400
@@ -67,7 +67,7 @@ void wait_stub_done(int pid, int sig, ch
 
 	if((n < 0) || !WIFSTOPPED(status) ||
 	   (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){
-		unsigned long regs[HOST_FRAME_SIZE];
+		unsigned long regs[MAX_REG_NR];
 
 		if(ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
 			printk("Failed to get registers from stub, "
@@ -76,7 +76,7 @@ void wait_stub_done(int pid, int sig, ch
 			int i;
 
 			printk("Stub registers -\n");
-			for(i = 0; i < HOST_FRAME_SIZE; i++)
+			for(i = 0; i < ARRAY_SIZE(regs); i++)
 				printk("\t%d - %lx\n", i, regs[i]);
 		}
 		panic("%s : failed to wait for SIGUSR1/SIGTRAP, "
@@ -328,7 +328,7 @@ void userspace(union uml_pt_regs *regs)
 int copy_context_skas0(unsigned long new_stack, int pid)
 {
 	int err;
-	unsigned long regs[HOST_FRAME_SIZE];
+	unsigned long regs[MAX_REG_NR];
 	unsigned long fp_regs[HOST_FP_SIZE];
 	unsigned long current_stack = current_stub_stack();
 	struct stub_data *data = (struct stub_data *) current_stack;
Index: linux-2.6.21-mm/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/sys-i386/registers.c	2007-03-23 15:04:22.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/sys-i386/registers.c	2007-03-23 20:31:37.000000000 -0400
@@ -15,7 +15,7 @@
 
 /* These are set once at boot time and not changed thereafter */
 
-static unsigned long exec_regs[HOST_FRAME_SIZE];
+static unsigned long exec_regs[MAX_REG_NR];
 static unsigned long exec_fp_regs[HOST_FP_SIZE];
 static unsigned long exec_fpx_regs[HOST_XFP_SIZE];
 static int have_fpx_regs = 1;
@@ -101,6 +101,7 @@ void init_registers(int pid)
 {
 	int err;
 
+	memset(exec_regs, 0, sizeof(exec_regs));
 	err = ptrace(PTRACE_GETREGS, pid, 0, exec_regs);
 	if(err)
 		panic("check_ptrace : PTRACE_GETREGS failed, errno = %d",
@@ -124,7 +125,7 @@ void init_registers(int pid)
 
 void get_safe_registers(unsigned long *regs, unsigned long *fp_regs)
 {
-	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
+	memcpy(regs, exec_regs, sizeof(exec_regs));
 	if(fp_regs != NULL)
 		memcpy(fp_regs, exec_fp_regs,
 		       HOST_FP_SIZE * sizeof(unsigned long));
Index: linux-2.6.21-mm/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/sys-x86_64/registers.c	2007-03-20 15:02:25.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/sys-x86_64/registers.c	2007-03-25 10:33:48.000000000 -0400
@@ -14,7 +14,7 @@
 
 /* These are set once at boot time and not changed thereafter */
 
-static unsigned long exec_regs[HOST_FRAME_SIZE];
+static unsigned long exec_regs[MAX_REG_NR];
 static unsigned long exec_fp_regs[HOST_FP_SIZE];
 
 void init_thread_registers(union uml_pt_regs *to)
@@ -72,7 +72,7 @@ void init_registers(int pid)
 
 void get_safe_registers(unsigned long *regs, unsigned long *fp_regs)
 {
-	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
+	memcpy(regs, exec_regs, sizeof(exec_regs));
 	if(fp_regs != NULL)
 		memcpy(fp_regs, exec_fp_regs,
 		       HOST_FP_SIZE * sizeof(unsigned long));

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
