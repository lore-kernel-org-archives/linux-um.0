Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kub8g-0008A0-Vi
 for linux-um@lists.infradead.org; Wed, 30 Dec 2020 13:03:44 +0000
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 20/31] um: allocate a guard page to helper threads
Date: Wed, 30 Dec 2020 08:03:02 -0500
Message-Id: <20201230130314.3636961-20-sashal@kernel.org>
In-Reply-To: <20201230130314.3636961-1-sashal@kernel.org>
References: <20201230130314.3636961-1-sashal@kernel.org>
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
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit ef4459a6da0955b533ebfc97a7d756ac090f50c9 ]

We've been running into stack overflows in helper threads
corrupting memory (e.g. because somebody put printf() or
os_info() there), so to avoid those causing hard-to-debug
issues later on, allocate a guard page for helper thread
stacks and mark it read-only.

Unfortunately, the crash dump at that point is useless as
the stack tracer will try to backtrace the *kernel* thread,
not the helper thread, but at least we don't survive to a
random issue caused by corruption.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/ubd_kern.c         |  2 +-
 arch/um/include/shared/kern_util.h |  2 +-
 arch/um/kernel/process.c           | 11 +++++++----
 arch/um/os-Linux/helper.c          |  4 ++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index b12c1b0d3e1d0..e337702c30c78 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1195,7 +1195,7 @@ static int __init ubd_driver_init(void){
 		/* Letting ubd=sync be like using ubd#s= instead of ubd#= is
 		 * enough. So use anyway the io thread. */
 	}
-	stack = alloc_stack(0, 0);
+	stack = alloc_stack(0);
 	io_pid = start_io_thread(stack + PAGE_SIZE - sizeof(void *),
 				 &thread_fd);
 	if(io_pid < 0){
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index ccafb62e8ccec..c3ccbc2bbd2ce 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -19,7 +19,7 @@ extern int kmalloc_ok;
 #define UML_ROUND_UP(addr) \
 	((((unsigned long) addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
-extern unsigned long alloc_stack(int order, int atomic);
+extern unsigned long alloc_stack(int atomic);
 extern void free_stack(unsigned long stack, int order);
 
 struct pt_regs;
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 9505a7e87396a..bb352dc446870 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -32,6 +32,7 @@
 #include <os.h>
 #include <skas.h>
 #include <linux/time-internal.h>
+#include <asm/set_memory.h>
 
 /*
  * This is a per-cpu array.  A processor only modifies its entry and it only
@@ -62,16 +63,18 @@ void free_stack(unsigned long stack, int order)
 	free_pages(stack, order);
 }
 
-unsigned long alloc_stack(int order, int atomic)
+unsigned long alloc_stack(int atomic)
 {
-	unsigned long page;
+	unsigned long addr;
 	gfp_t flags = GFP_KERNEL;
 
 	if (atomic)
 		flags = GFP_ATOMIC;
-	page = __get_free_pages(flags, order);
+	addr = __get_free_pages(flags, 1);
 
-	return page;
+	set_memory_ro(addr, 1);
+
+	return addr + PAGE_SIZE;
 }
 
 static inline void set_current(struct task_struct *task)
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 9fa6e4187d4fb..feb48d796e005 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -45,7 +45,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	unsigned long stack, sp;
 	int pid, fds[2], ret, n;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(__cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
@@ -116,7 +116,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	unsigned long stack, sp;
 	int pid, status, err;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(__cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
-- 
2.27.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

