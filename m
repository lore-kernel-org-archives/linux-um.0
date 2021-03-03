Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTqx-005UJF-2P
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 15:56:06 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 04/27] um: Drop NULL check from start_userspace
Date: Wed,  3 Mar 2021 16:55:00 +0100
Message-Id: <20210303155523.124277-5-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-1-benjamin@sipsolutions.net>
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>

start_userspace is only called from exactly one location, and the passed
pointer for the userspace process stack cannot be NULL.

Remove the check, without changing the control flow.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/os-Linux/skas/process.c | 53 +++++++++++++++------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index d30c96b599ac..1c31f833a7ed 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -188,7 +188,7 @@ extern char __syscall_stub_start[];
 
 /**
  * userspace_tramp() - userspace trampoline
- * @stack:	pointer to the new userspace stack page, can be NULL, if? FIXME:
+ * @stack:	pointer to the new userspace stack page
  *
  * The userspace trampoline is used to setup a new userspace process in start_userspace() after it was clone()'ed.
  * This function will run on a temporary stack page.
@@ -203,9 +203,13 @@ extern char __syscall_stub_start[];
  */
 static int userspace_tramp(void *stack)
 {
+	struct sigaction sa;
 	void *addr;
 	int fd;
 	unsigned long long offset;
+	unsigned long segv_handler = STUB_CODE +
+				     (unsigned long) stub_segv_handler -
+				     (unsigned long) __syscall_stub_start;
 
 	ptrace(PTRACE_TRACEME, 0, 0, 0);
 
@@ -221,34 +225,25 @@ static int userspace_tramp(void *stack)
 		exit(1);
 	}
 
-	if (stack != NULL) {
-		fd = phys_mapping(to_phys(stack), &offset);
-		addr = mmap((void *) STUB_DATA,
-			    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
-			    MAP_FIXED | MAP_SHARED, fd, offset);
-		if (addr == MAP_FAILED) {
-			printk(UM_KERN_ERR "mapping segfault stack at 0x%lx failed, errno = %d\n",
-			       STUB_DATA, errno);
-			exit(1);
-		}
+	fd = phys_mapping(to_phys(stack), &offset);
+	addr = mmap((void *) STUB_DATA,
+		    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_SHARED, fd, offset);
+	if (addr == MAP_FAILED) {
+		printk(UM_KERN_ERR "mapping segfault stack at 0x%lx failed, errno = %d\n",
+		       STUB_DATA, errno);
+		exit(1);
 	}
-	if (stack != NULL) {
-		struct sigaction sa;
-
-		unsigned long v = STUB_CODE +
-				  (unsigned long) stub_segv_handler -
-				  (unsigned long) __syscall_stub_start;
-
-		set_sigstack((void *) STUB_DATA, UM_KERN_PAGE_SIZE);
-		sigemptyset(&sa.sa_mask);
-		sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
-		sa.sa_sigaction = (void *) v;
-		sa.sa_restorer = NULL;
-		if (sigaction(SIGSEGV, &sa, NULL) < 0) {
-			printk(UM_KERN_ERR "%s - setting SIGSEGV handler failed - errno = %d\n",
-			       __func__, errno);
-			exit(1);
-		}
+
+	set_sigstack((void *) STUB_DATA, UM_KERN_PAGE_SIZE);
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
+	sa.sa_sigaction = (void *) segv_handler;
+	sa.sa_restorer = NULL;
+	if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+		printk(UM_KERN_ERR "%s - setting SIGSEGV handler failed - errno = %d\n",
+		       __func__, errno);
+		exit(1);
 	}
 
 	kill(os_getpid(), SIGSTOP);
@@ -260,7 +255,7 @@ int kill_userspace_mm[NR_CPUS];
 
 /**
  * start_userspace() - prepare a new userspace process
- * @stub_stack:	pointer to the stub stack. Can be NULL, if? FIXME:
+ * @stub_stack:	pointer to the stub stack.
  *
  * Setups a new temporary stack page that is used while userspace_tramp() runs
  * Clones the kernel process into a new userspace process, with FDs only.
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

