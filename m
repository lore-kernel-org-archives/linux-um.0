Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@brocade.com>) id 1ZzooW-0003gL-KV
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 16:45:32 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZzooV-0002E9-PT
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 16:45:32 +0000
From: Anton Ivanov <aivanov@brocade.com>
Date: Fri, 20 Nov 2015 16:45:14 +0000
Message-Id: <1448037915-921549-2-git-send-email-aivanov@brocade.com>
In-Reply-To: <1448037915-921549-1-git-send-email-aivanov@brocade.com>
References: <1448037915-921549-1-git-send-email-aivanov@brocade.com>
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
Subject: [uml-devel] [PATCH 2/3] Errata: HR Timer subsystem
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anton Ivanov <aivanov@brocade.com>

The signals should be restored to their pre-off state
not turned on.

Signed-off-by: Anton Ivanov <aivanov@brocade.com>
---
 arch/um/kernel/skas/mmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 9591a66..a845de6 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -53,6 +53,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	struct mm_context *to_mm = &mm->context;
 	unsigned long stack = 0;
 	int ret = -ENOMEM;
+    unsigned long int flags;
 
 	stack = get_zeroed_page(GFP_KERNEL);
 	if (stack == 0)
@@ -62,12 +63,12 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	if (current->mm != NULL && current->mm != &init_mm)
 		from_mm = &current->mm->context;
 
-	block_signals();
+	local_irq_save(flags);
 	if (from_mm)
 		to_mm->id.u.pid = copy_context_skas0(stack,
 						     from_mm->id.u.pid);
 	else to_mm->id.u.pid = start_userspace(stack);
-	unblock_signals();
+    local_irq_restore(flags);
 
 	if (to_mm->id.u.pid < 0) {
 		ret = to_mm->id.u.pid;
-- 
2.1.4


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

