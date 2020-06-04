Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgoC6-0003sX-Tm
 for linux-um@lists.infradead.org; Thu, 04 Jun 2020 11:38:00 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: remove mmap_sem usage from activate_mm()
Date: Thu,  4 Jun 2020 13:37:52 +0200
Message-Id: <20200604133752.397dedea0758.I7a24aaa26794eb3fa432003c1bf55cbb816489e2@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

Lockdep complains about the mmap_sem because we try to
down_write() it while we already hold the task (spin)lock.

Since commit 9bfb23fc4a48 ("sys_unshare: remove the dead
CLONE_THREAD/SIGHAND/VM code") this is no longer called
by sys_unshare(), and thus the only caller of this is
exec_mmap() in fs/exec.c. But in this case, the new mm
is completely new, so it shouldn't be possible to change
it concurrently.

Remove the mmap_sem handling completely.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/mmu_context.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index b4deb1bfbb68..8a6e1c5e2c22 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -43,13 +43,11 @@ extern void force_flush_all(void);
 static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 {
 	/*
-	 * This is called by fs/exec.c and sys_unshare()
-	 * when the new ->mm is used for the first time.
+	 * This is called by fs/exec.c when the new ->mm is used
+	 * for the first time.
 	 */
 	__switch_mm(&new->context.id);
-	down_write_nested(&new->mmap_sem, 1);
 	uml_setup_stubs(new);
-	up_write(&new->mmap_sem);
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

