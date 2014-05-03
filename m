Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1WgfMz-0000En-El
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 May 2014 19:13:09 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WgfMx-00043x-Sz for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 May 2014 19:13:09 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sat,  3 May 2014 21:12:44 +0200
Message-Id: <1399144364-30696-2-git-send-email-richard@nod.at>
In-Reply-To: <1399144364-30696-1-git-send-email-richard@nod.at>
References: <1399144364-30696-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
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
Subject: [uml-devel] [PATCH 2/2] um: Ensure that nobody remaps the stub vma
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>

This fixes a long standing problem that UML crashes
or locks up if a task messes with it' stub vma.

Reported-by: toralf.foerster@gmx.de
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/tlb.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 9472079..b33d1d1 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -12,6 +12,7 @@
 #include <mem_user.h>
 #include <os.h>
 #include <skas.h>
+#include <kern_util.h>
 
 struct host_vm_change {
 	struct host_vm_op {
@@ -90,6 +91,9 @@ static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
 	struct host_vm_op *last;
 	int fd, ret = 0;
 
+	if ((virt >= STUB_START) && (virt < STUB_END))
+		return -EINVAL;
+
 	fd = phys_mapping(phys, &offset);
 	if (hvc->index != 0) {
 		last = &hvc->ops[hvc->index - 1];
@@ -124,6 +128,9 @@ static int add_munmap(unsigned long addr, unsigned long len,
 	struct host_vm_op *last;
 	int ret = 0;
 
+	if ((addr >= STUB_START) && (addr < STUB_END))
+		return -EINVAL;
+
 	if (hvc->index != 0) {
 		last = &hvc->ops[hvc->index - 1];
 		if ((last->type == MUNMAP) &&
@@ -283,8 +290,10 @@ void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 	/* This is not an else because ret is modified above */
 	if (ret) {
 		printk(KERN_ERR "fix_range_common: failed, killing current "
-		       "process\n");
-		force_sig(SIGKILL, current);
+		       "process: %d\n", task_tgid_vnr(current));
+		/* We are under mmap_sem, release it such that current can terminate */
+		up_write(&current->mm->mmap_sem);
+		fatal_sigsegv();
 	}
 }
 
@@ -409,6 +418,9 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 		w = 0;
 	}
 
+	if ((address >= STUB_START) && (address < STUB_END))
+		goto kill;
+
 	mm_id = &mm->context.id;
 	prot = ((r ? UM_PROT_READ : 0) | (w ? UM_PROT_WRITE : 0) |
 		(x ? UM_PROT_EXEC : 0));
@@ -435,7 +447,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 
 kill:
 	printk(KERN_ERR "Failed to flush page for address 0x%lx\n", address);
-	force_sig(SIGKILL, current);
+	fatal_sigsegv();
 }
 
 pgd_t *pgd_offset_proc(struct mm_struct *mm, unsigned long address)
-- 
1.8.1.4


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

