Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTwm-005VgX-4a
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:02:03 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 14/27] um: Create signal stack memory assignment in stub_data
Date: Wed,  3 Mar 2021 16:55:10 +0100
Message-Id: <20210303155523.124277-15-benjamin@sipsolutions.net>
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

When we switch to use seccomp, we need both the signal stack and other
data (i.e. syscall information) to co-exist in the stub data. To
facilitate this, start by defining separate memory areas for the stack
and syscall data.

Only change the signal stack setup for now, as the syscall code will be
reworked later.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/skas/stub-data.h | 12 ++++++++++++
 arch/um/kernel/skas/clone.c             |  5 ++++-
 arch/um/os-Linux/skas/process.c         |  9 ++++++++-
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 5e3ade3fb38b..2d5da12679ad 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -8,10 +8,22 @@
 #ifndef __STUB_DATA_H
 #define __STUB_DATA_H
 
+#include <linux/compiler_types.h>
+#include <as-layout.h>
+
 struct stub_data {
 	unsigned long offset;
 	int fd;
 	long parent_err, child_err;
+
+	/* 128 leaves enough room for additional fields in the struct. */
+	unsigned char syscall_data[UM_KERN_PAGE_SIZE - MINSIGSTKSZ - 128]
+		      __aligned(16);
+
+	/* Stack for our signal handlers and for calling into . */
+	unsigned char sigstack[MINSIGSTKSZ + 32] __aligned(16);
 };
 
+typedef char stub_data_sizecheck[sizeof(struct stub_data) <= UM_KERN_PAGE_SIZE ? 1 : -1] __always_unused;
+
 #endif
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index 592cdb138441..3e2139a81475 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -28,8 +28,11 @@ stub_clone_handler(void)
 	struct stub_data *data = (void *) ((unsigned long)&stack & ~(UM_KERN_PAGE_SIZE - 1));
 	long err;
 
+	/* Use the syscall data as a temporary stack area. */
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
-			    (unsigned long)data + UM_KERN_PAGE_SIZE / 2 - sizeof(void *));
+			    (unsigned long) data->syscall_data +
+					    sizeof(data->syscall_data) -
+					    sizeof(void *));
 	if (err) {
 		data->parent_err = err;
 		goto done;
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 15818009731d..717cfe7400a1 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -204,6 +204,7 @@ extern char __syscall_stub_start[];
 static int userspace_tramp(void *stack)
 {
 	struct sigaction sa;
+	struct stub_data *data;
 	void *addr;
 	int fd;
 	unsigned long long offset;
@@ -234,8 +235,14 @@ static int userspace_tramp(void *stack)
 			STUB_DATA, errno);
 		exit(1);
 	}
+	data = (void *) addr;
+	/*
+	 * We need at least MINSIGSTKSZ for the kernel and glibc wants a bit more
+	 * But we cannot use BUILD_BUG_ON here.
+	 * BUILD_BUG_ON (sizeof(data->sigstack) >= MINSIGSTKSZ + sizeof(struct stack_t));
+	 */
 
-	set_sigstack((void *) STUB_DATA, UM_KERN_PAGE_SIZE);
+	set_sigstack((void *) &data->sigstack, sizeof(data->sigstack));
 	sigemptyset(&sa.sa_mask);
 	sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
 	sa.sa_sigaction = (void *) segv_handler;
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

