Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSqhU-00011w-No
 for linux-um@lists.infradead.org; Thu, 15 Oct 2020 00:00:57 +0000
Received: by mail-wr1-x441.google.com with SMTP id s9so1012697wro.8
 for <linux-um@lists.infradead.org>; Wed, 14 Oct 2020 17:00:56 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v3 1/2] mmap locking API: Order lock of nascent mm outside
 lock of live mm
Date: Thu, 15 Oct 2020 02:00:40 +0200
Message-Id: <20201015000041.1734214-2-jannh@google.com>
In-Reply-To: <20201015000041.1734214-1-jannh@google.com>
References: <20201015000041.1734214-1-jannh@google.com>
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
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Michel Lespinasse <walken@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W . Biederman" <ebiederm@xmission.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, John Hubbard <jhubbard@nvidia.com>, Johannes Berg <johannes@sipsolutions.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Until now, the mmap lock of the nascent mm was ordered inside the mmap lock
of the old mm (in dup_mmap() and in UML's activate_mm()).
A following patch will change the exec path to very broadly lock the
nascent mm, but fine-grained locking should still work at the same time for
the old mm.

In particular, mmap locking calls are hidden behind the copy_from_user()
calls and such that are reached through functions like copy_strings() -
when a page fault occurs on a userspace memory access, the mmap lock
will be taken.

To do this in a way that lockdep is happy about, let's turn around the lock
ordering in both places that currently nest the locks.
Since SINGLE_DEPTH_NESTING is normally used for the inner nesting layer,
make up our own lock subclass MMAP_LOCK_SUBCLASS_NASCENT and use that
instead.
The added locking calls in exec_mmap() are temporary; the following patch
will move the locking out of exec_mmap().

As Johannes Berg pointed out[1][2], moving the mmap locking of
arch/um/'s activate_mm() up into the execve code also fixes an issue that
would've caused a scheduling-in-atomic bug due to mmap_write_lock_nested()
while holding a spinlock if UM had support for voluntary preemption.
(Even when a semaphore is uncontended, locking it can still trigger
rescheduling via might_sleep().)

[1] https://lore.kernel.org/linux-mm/115d17aa221b73a479e26ffee52899ddb18b1f53.camel@sipsolutions.net/
[2] https://lore.kernel.org/linux-mm/7b7d6954b74e109e653539d880173fa9cb5c5ddf.camel@sipsolutions.net/

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/um/include/asm/mmu_context.h |  3 +--
 fs/exec.c                         |  4 ++++
 include/linux/mmap_lock.h         | 23 +++++++++++++++++++++--
 kernel/fork.c                     |  7 ++-----
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 17ddd4edf875..c13bc5150607 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -48,9 +48,8 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 	 * when the new ->mm is used for the first time.
 	 */
 	__switch_mm(&new->context.id);
-	mmap_write_lock_nested(new, SINGLE_DEPTH_NESTING);
+	mmap_assert_write_locked(new);
 	uml_setup_stubs(new);
-	mmap_write_unlock(new);
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
diff --git a/fs/exec.c b/fs/exec.c
index a91003e28eaa..229dbc7aa61a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1114,6 +1114,8 @@ static int exec_mmap(struct mm_struct *mm)
 	if (ret)
 		return ret;
 
+	mmap_write_lock_nascent(mm);
+
 	if (old_mm) {
 		/*
 		 * Make sure that if there is a core dump in progress
@@ -1125,6 +1127,7 @@ static int exec_mmap(struct mm_struct *mm)
 		if (unlikely(old_mm->core_state)) {
 			mmap_read_unlock(old_mm);
 			mutex_unlock(&tsk->signal->exec_update_mutex);
+			mmap_write_unlock(mm);
 			return -EINTR;
 		}
 	}
@@ -1138,6 +1141,7 @@ static int exec_mmap(struct mm_struct *mm)
 	tsk->mm->vmacache_seqnum = 0;
 	vmacache_flush(tsk);
 	task_unlock(tsk);
+	mmap_write_unlock(mm);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
 		BUG_ON(active_mm != old_mm);
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 0707671851a8..24de1fe99ee4 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -3,6 +3,18 @@
 
 #include <linux/mmdebug.h>
 
+/*
+ * Lock subclasses for the mmap_lock.
+ *
+ * MMAP_LOCK_SUBCLASS_NASCENT is for core kernel code that wants to lock an mm
+ * that is still being constructed and wants to be able to access the active mm
+ * normally at the same time. It nests outside MMAP_LOCK_SUBCLASS_NORMAL.
+ */
+enum {
+	MMAP_LOCK_SUBCLASS_NORMAL = 0,
+	MMAP_LOCK_SUBCLASS_NASCENT
+};
+
 #define MMAP_LOCK_INITIALIZER(name) \
 	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
 
@@ -16,9 +28,16 @@ static inline void mmap_write_lock(struct mm_struct *mm)
 	down_write(&mm->mmap_lock);
 }
 
-static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
+/*
+ * Lock an mm_struct that is still being set up (during fork or exec).
+ * This nests outside the mmap locks of live mm_struct instances.
+ * No interruptible/killable versions exist because at the points where you're
+ * supposed to use this helper, the mm isn't visible to anything else, so we
+ * expect the mmap_lock to be uncontended.
+ */
+static inline void mmap_write_lock_nascent(struct mm_struct *mm)
 {
-	down_write_nested(&mm->mmap_lock, subclass);
+	down_write_nested(&mm->mmap_lock, MMAP_LOCK_SUBCLASS_NASCENT);
 }
 
 static inline int mmap_write_lock_killable(struct mm_struct *mm)
diff --git a/kernel/fork.c b/kernel/fork.c
index da8d360fb032..db67eb4ac7bd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -474,6 +474,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	unsigned long charge;
 	LIST_HEAD(uf);
 
+	mmap_write_lock_nascent(mm);
 	uprobe_start_dup_mmap();
 	if (mmap_write_lock_killable(oldmm)) {
 		retval = -EINTR;
@@ -481,10 +482,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	}
 	flush_cache_dup_mm(oldmm);
 	uprobe_dup_mmap(oldmm, mm);
-	/*
-	 * Not linked in yet - no deadlock potential:
-	 */
-	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
 
 	/* No ordering required: file already has been exposed. */
 	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
@@ -600,12 +597,12 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	/* a new mm has just been created */
 	retval = arch_dup_mmap(oldmm, mm);
 out:
-	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
 	dup_userfaultfd_complete(&uf);
 fail_uprobe_end:
 	uprobe_end_dup_mmap();
+	mmap_write_unlock(mm);
 	return retval;
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
-- 
2.28.0.1011.ga647a8990f-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

