Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyf5i-0006pQ-TL
 for linux-um@lists.infradead.org; Sun, 10 Jan 2021 18:05:29 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/2] Revert "um: allocate a guard page to helper threads"
Date: Sun, 10 Jan 2021 19:05:08 +0100
Message-Id: <20210110190509.65a0c174fcca.I148fc32a2b85fd17746ca528f3811c80483232bd@changeid>
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
Cc: Benjamin Berg <benjamin@sipsolutions.net>, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

This reverts commit ef4459a6da09 ("um: allocate a guard page to
helper threads"), it's broken in multiple ways:

 1) the free no longer matches the alloc; and

 2) more importantly, the set_memory_ro() causes allocation of
    page tables for the normal memory that doesn't have any,
    and that later causes corruption and crashes (usually but
    not always in vfree()).

We could fix the first bug and use vmalloc() to work around the
second, but set_memory_ro() actually doesn't do anything either
so I'll just revert that as well.

Reported-by: Benjamin Berg <benjamin@sipsolutions.net>
Fixes: ef4459a6da09 ("um: allocate a guard page to helper threads")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/ubd_kern.c         |  2 +-
 arch/um/include/shared/kern_util.h |  2 +-
 arch/um/kernel/process.c           | 11 ++++-------
 arch/um/os-Linux/helper.c          |  4 ++--
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 13b1fe694b90..7e07b321e847 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1241,7 +1241,7 @@ static int __init ubd_driver_init(void){
 		/* Letting ubd=sync be like using ubd#s= instead of ubd#= is
 		 * enough. So use anyway the io thread. */
 	}
-	stack = alloc_stack(0);
+	stack = alloc_stack(0, 0);
 	io_pid = start_io_thread(stack + PAGE_SIZE - sizeof(void *),
 				 &thread_fd);
 	if(io_pid < 0){
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index d8c279e3312f..2888ec812f6e 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -19,7 +19,7 @@ extern int kmalloc_ok;
 #define UML_ROUND_UP(addr) \
 	((((unsigned long) addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
-extern unsigned long alloc_stack(int atomic);
+extern unsigned long alloc_stack(int order, int atomic);
 extern void free_stack(unsigned long stack, int order);
 
 struct pt_regs;
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 2a986ece5478..81d508daf67c 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -32,7 +32,6 @@
 #include <os.h>
 #include <skas.h>
 #include <linux/time-internal.h>
-#include <asm/set_memory.h>
 
 /*
  * This is a per-cpu array.  A processor only modifies its entry and it only
@@ -63,18 +62,16 @@ void free_stack(unsigned long stack, int order)
 	free_pages(stack, order);
 }
 
-unsigned long alloc_stack(int atomic)
+unsigned long alloc_stack(int order, int atomic)
 {
-	unsigned long addr;
+	unsigned long page;
 	gfp_t flags = GFP_KERNEL;
 
 	if (atomic)
 		flags = GFP_ATOMIC;
-	addr = __get_free_pages(flags, 1);
+	page = __get_free_pages(flags, order);
 
-	set_memory_ro(addr, 1);
-
-	return addr + PAGE_SIZE;
+	return page;
 }
 
 static inline void set_current(struct task_struct *task)
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index feb48d796e00..9fa6e4187d4f 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -45,7 +45,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	unsigned long stack, sp;
 	int pid, fds[2], ret, n;
 
-	stack = alloc_stack(__cant_sleep());
+	stack = alloc_stack(0, __cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
@@ -116,7 +116,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	unsigned long stack, sp;
 	int pid, status, err;
 
-	stack = alloc_stack(__cant_sleep());
+	stack = alloc_stack(0, __cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

