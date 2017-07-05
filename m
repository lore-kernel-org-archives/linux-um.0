Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dSssO-0002dk-7L
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 22:34:28 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dSssN-00052j-9Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 22:34:28 +0000
From: Thomas Meyer <thomas@m3y3r.de>
Date: Thu,  6 Jul 2017 00:34:05 +0200
Message-Id: <20170705223405.10585-2-thomas@m3y3r.de>
In-Reply-To: <20170705223405.10585-1-thomas@m3y3r.de>
References: <20170705223405.10585-1-thomas@m3y3r.de>
Subject: [uml-devel] [PATCH 3/3] um: Add kerneldoc for userspace_tramp() and
 start_userspace()
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

Also use correct function name spelling (stub_segv_handler) for better grepping

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/os-Linux/skas/process.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 03b3c4c..4530867 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -108,7 +108,7 @@ static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 	wait_stub_done(pid);
 
 	/*
-	 * faultinfo is prepared by the stub-segv-handler at start of
+	 * faultinfo is prepared by the stub_segv_handler at start of
 	 * the stub stack page. We just have to copy it.
 	 */
 	memcpy(fi, (void *)current_stub_stack(), sizeof(*fi));
@@ -175,6 +175,21 @@ static void handle_trap(int pid, struct uml_pt_regs *regs,
 
 extern char __syscall_stub_start[];
 
+/**
+ * userspace_tramp() - userspace trampoline
+ * @stack:	pointer to the new userspace stack page, can be NULL, if? FIXME:
+ *
+ * The userspace trampoline is used to setup a new userspace process in start_userspace() after it was clone()'ed.
+ * This function will run on a temporary stack page.
+ * It ptrace()'es itself, then
+ * Two pages are mapped into the userspace address space:
+ * - STUB_CODE (with EXEC), which contains the skas stub code
+ * - STUB_DATA (with R/W), which contains a data page that is used to transfer certain data between the UML userspace process and the UML kernel.
+ * Also for the userspace process a SIGSEGV handler is installed to catch pagefaults in the userspace process.
+ * And last the process stops itself to give control to the UML kernel for this userspace process.
+ *
+ * Return: Always zero, otherwise the current userspace process is ended with non null exit() call
+ */
 static int userspace_tramp(void *stack)
 {
 	void *addr;
@@ -236,12 +251,24 @@ static int userspace_tramp(void *stack)
 
 int userspace_pid[NR_CPUS];
 
+/**
+ * start_userspace() - prepare a new userspace process
+ * @stub_stack:	pointer to the stub stack. Can be NULL, if? FIXME:
+ *
+ * Setups a new temporary stack page that is used while userspace_tramp() runs
+ * Clones the kernel process into a new userspace process, with FDs only.
+ *
+ * Return: When positive: the process id of the new userspace process,
+ *         when negative: an error number.
+ * FIXME: can PIDs become negative?!
+ */
 int start_userspace(unsigned long stub_stack)
 {
 	void *stack;
 	unsigned long sp;
 	int pid, status, n, flags, err;
 
+	/* setup a temporary stack page */
 	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
 		     PROT_READ | PROT_WRITE | PROT_EXEC,
 		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
@@ -252,10 +279,12 @@ int start_userspace(unsigned long stub_stack)
 		return err;
 	}
 
+	/* set stack pointer to the end of the stack page, so it can grow downwards */
 	sp = (unsigned long) stack + UM_KERN_PAGE_SIZE - sizeof(void *);
 
 	flags = CLONE_FILES | SIGCHLD;
 
+	/* clone into new userspace process */
 	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
 	if (pid < 0) {
 		err = -errno;
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

