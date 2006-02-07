Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6IV9-0003qJ-H0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:43 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F6IV8-0008C8-NP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:43 -0800
Message-Id: <200602070224.k172O5n6009679@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/8] UML - Initialize process FP registers properly
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
Date: Mon, 06 Feb 2006 21:24:05 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

We weren't making sure that we initialized the FP registers of new processes
to sane values.

This patch also moves some defines in the affected area closer to where they
are used.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/sys-x86_64/ptrace_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/sys-x86_64/ptrace_user.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15/arch/um/sys-x86_64/ptrace_user.c	2006-02-06 17:36:41.000000000 -0500
@@ -24,6 +24,13 @@ int ptrace_setregs(long pid, unsigned lo
 	return(0);
 }
 
+int ptrace_setfpregs(long pid, unsigned long *regs)
+{
+	if (ptrace(PTRACE_SETFPREGS, pid, 0, regs) < 0)
+		return -errno;
+	return 0;
+}
+
 void ptrace_pokeuser(unsigned long addr, unsigned long data)
 {
 	panic("ptrace_pokeuser");
Index: linux-2.6.15/arch/um/sys-x86_64/user-offsets.c
===================================================================
--- linux-2.6.15.orig/arch/um/sys-x86_64/user-offsets.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/sys-x86_64/user-offsets.c	2006-02-06 17:36:41.000000000 -0500
@@ -57,7 +57,7 @@ void foo(void)
 #endif
 
 	DEFINE_LONGS(HOST_FRAME_SIZE, FRAME_SIZE);
-	DEFINE(HOST_FP_SIZE, 0);
+	DEFINE(HOST_FP_SIZE, sizeof(struct _fpstate) / sizeof(unsigned long));
 	DEFINE(HOST_XFP_SIZE, 0);
 	DEFINE_LONGS(HOST_RBX, RBX);
 	DEFINE_LONGS(HOST_RCX, RCX);
Index: linux-2.6.15/arch/um/include/registers.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/registers.h	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/include/registers.h	2006-02-06 17:36:41.000000000 -0500
@@ -14,7 +14,7 @@ extern int restore_fp_registers(int pid,
 extern void save_registers(int pid, union uml_pt_regs *regs);
 extern void restore_registers(int pid, union uml_pt_regs *regs);
 extern void init_registers(int pid);
-extern void get_safe_registers(unsigned long * regs);
+extern void get_safe_registers(unsigned long * regs, unsigned long * fp_regs);
 extern void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer);
 
 #endif
Index: linux-2.6.15/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/sys-x86_64/registers.c	2006-02-06 17:34:36.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/sys-x86_64/registers.c	2006-02-06 17:36:41.000000000 -0500
@@ -70,9 +70,12 @@ void init_registers(int pid)
 		      err);
 }
 
-void get_safe_registers(unsigned long *regs)
+void get_safe_registers(unsigned long *regs, unsigned long *fp_regs)
 {
 	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
+	if(fp_regs != NULL)
+		memcpy(fp_regs, exec_fp_regs,
+		       HOST_FP_SIZE * sizeof(unsigned long));
 }
 
 #ifndef JB_PC
Index: linux-2.6.15/arch/um/os-Linux/skas/mem.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/skas/mem.c	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/skas/mem.c	2006-02-06 17:36:41.000000000 -0500
@@ -60,7 +60,7 @@ static inline long do_syscall_stub(struc
 
 	multi_count++;
 
-	get_safe_registers(regs);
+	get_safe_registers(regs, NULL);
 	regs[REGS_IP_INDEX] = UML_CONFIG_STUB_CODE +
 		((unsigned long) &batch_syscall_stub -
 		 (unsigned long) &__syscall_stub_start);
Index: linux-2.6.15/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/skas/process.c	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/skas/process.c	2006-02-06 17:36:41.000000000 -0500
@@ -310,16 +310,12 @@ void userspace(union uml_pt_regs *regs)
 		}
 	}
 }
-#define INIT_JMP_NEW_THREAD 0
-#define INIT_JMP_REMOVE_SIGSTACK 1
-#define INIT_JMP_CALLBACK 2
-#define INIT_JMP_HALT 3
-#define INIT_JMP_REBOOT 4
 
 int copy_context_skas0(unsigned long new_stack, int pid)
 {
 	int err;
-	unsigned long regs[MAX_REG_NR];
+	unsigned long regs[HOST_FRAME_SIZE];
+	unsigned long fp_regs[HOST_FP_SIZE];
 	unsigned long current_stack = current_stub_stack();
 	struct stub_data *data = (struct stub_data *) current_stack;
 	struct stub_data *child_data = (struct stub_data *) new_stack;
@@ -334,7 +330,7 @@ int copy_context_skas0(unsigned long new
 				      .timer    = ((struct itimerval)
 					            { { 0, 1000000 / hz() },
 						      { 0, 1000000 / hz() }})});
-	get_safe_registers(regs);
+	get_safe_registers(regs, fp_regs);
 
 	/* Set parent's instruction pointer to start of clone-stub */
 	regs[REGS_IP_INDEX] = UML_CONFIG_STUB_CODE +
@@ -350,6 +346,11 @@ int copy_context_skas0(unsigned long new
 		panic("copy_context_skas0 : PTRACE_SETREGS failed, "
 		      "pid = %d, errno = %d\n", pid, errno);
 
+	err = ptrace_setfpregs(pid, fp_regs);
+	if(err < 0)
+		panic("copy_context_skas0 : PTRACE_SETFPREGS failed, "
+		      "pid = %d, errno = %d\n", pid, errno);
+
 	/* set a well known return code for detection of child write failure */
 	child_data->err = 12345678;
 
@@ -457,6 +458,12 @@ void new_thread(void *stack, void **swit
 	set_signals(flags);
 }
 
+#define INIT_JMP_NEW_THREAD 0
+#define INIT_JMP_REMOVE_SIGSTACK 1
+#define INIT_JMP_CALLBACK 2
+#define INIT_JMP_HALT 3
+#define INIT_JMP_REBOOT 4
+
 void thread_wait(void *sw, void *fb)
 {
 	sigjmp_buf buf, **switch_buf = sw, *fork_buf;
Index: linux-2.6.15/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/sys-i386/registers.c	2006-02-06 17:34:36.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/sys-i386/registers.c	2006-02-06 17:36:41.000000000 -0500
@@ -122,9 +122,12 @@ void init_registers(int pid)
 		      err);
 }
 
-void get_safe_registers(unsigned long *regs)
+void get_safe_registers(unsigned long *regs, unsigned long *fp_regs)
 {
 	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
+	if(fp_regs != NULL)
+		memcpy(fp_regs, exec_fp_regs,
+		       HOST_FP_SIZE * sizeof(unsigned long));
 }
 
 #ifndef JB_PC



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
