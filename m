Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B675BC369A1
	for <linux-um@archiver.kernel.org>; Tue,  8 Apr 2025 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9llnL/axqmEUzjeX7hNnkgDjMD+ldU7RxHS4bdZ4ImY=; b=JhIiELVtgFfXTyrJ7XGgzCyspJ
	HPrLlFp8B8Se+nqcluh6dU+/yO/FCCOWFzeMc7AePb2OWkuNJx4JgluFUQGLH3KlG7Q9yCtIf9/wD
	5Wj9zftFm5UwY0Q/CiXQDz6ZjvEYhugia3fj3eBxRMmGBqmr67dJWvnb8E5X1nLcfpQD8DYOA/pqH
	+EvVGtGV5YeKZpjhPAx6AZ4TLa63k/kczISTY1qKr/rc8rrzFHZwuXuUuZLX25/XuJGUEoXVRahGs
	nT2cmekwwOGyejJM6yrBFn/qGJljuubDP8ORA4ZvdzJbD5uTXCmoPlv64XxG7RF1azueuO4jPMcrT
	KpNYqyCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u23mG-000000039tS-40FK;
	Tue, 08 Apr 2025 07:53:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u23g3-000000038pR-1aZd
	for linux-um@lists.infradead.org;
	Tue, 08 Apr 2025 07:47:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9llnL/axqmEUzjeX7hNnkgDjMD+ldU7RxHS4bdZ4ImY=;
	t=1744098441; x=1745308041; b=tvJ42Ozvll1FexHr7njf5qiLbNhP2117l0nO3Jbo1weGLwc
	ESWBAuk5nGY6x3vBjQWkVuDdxQIWuG8KlSSlgilc9QozsSWhpG2QyLsWyoEjPa4oZc0Ptgu6an3Zl
	n6Z/pZRqwoArNf5DnwjOdHrr5W2TRFCcrjQojLp30XjJ51oq+UvdeiEs6evjPmsTsH5IhZpQJnRs0
	+ifQZcGY+8Z0LC7+CnzdcSkRd8HzmyvyRTbR7pZ4cBgqRcUddZVYowhw9tL5NWrDJ1jhDnJMUb0O1
	6iR9HNb4A+u69kNoHiolggohF4dn+X7GrR4bffMDuGrF7FJes5tYSpheRO3uy/GA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1u23fz-00000003Ylg-064w;
	Tue, 08 Apr 2025 09:47:19 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/2] um: use proper care when taking mmap lock during segfault
Date: Tue,  8 Apr 2025 09:45:24 +0200
Message-ID: <20250408074524.300153-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408074524.300153-1-benjamin@sipsolutions.net>
References: <20250408074524.300153-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_004723_440723_1C9E55B0 
X-CRM114-Status: GOOD (  23.46  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

Segfaults can occur at times where the mmap lock cannot be taken. If
that happens the segfault handler may not be able to take the mmap lock.

Fix the code to use the same approach as most other architectures.
Unfortunately, this requires copying code from mm/memory.c and modifying
it slightly as UML does not have exception tables.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/trap.c | 129 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 117 insertions(+), 12 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index ce073150dc20..cbe924a0fa87 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -18,6 +18,122 @@
 #include <skas.h>
 #include <arch.h>
 
+/*
+ * NOTE: UML does not have exception tables. As such, this is almost a copy
+ * of the code in mm/memory.c, only adjusting the logic to simply check whether
+ * we are coming from the kernel instead of doing an additional lookup in the
+ * exception table.
+ * We can do this simplification because we never get here if the exception was
+ * fixable.
+ */
+static inline bool get_mmap_lock_carefully(struct mm_struct *mm, bool is_user)
+{
+	if (likely(mmap_read_trylock(mm)))
+		return true;
+
+	if (!is_user)
+		return false;
+
+	return !mmap_read_lock_killable(mm);
+}
+
+static inline bool mmap_upgrade_trylock(struct mm_struct *mm)
+{
+	/*
+	 * We don't have this operation yet.
+	 *
+	 * It should be easy enough to do: it's basically a
+	 *    atomic_long_try_cmpxchg_acquire()
+	 * from RWSEM_READER_BIAS -> RWSEM_WRITER_LOCKED, but
+	 * it also needs the proper lockdep magic etc.
+	 */
+	return false;
+}
+
+static inline bool upgrade_mmap_lock_carefully(struct mm_struct *mm, bool is_user)
+{
+	mmap_read_unlock(mm);
+	if (!is_user)
+		return false;
+
+	return !mmap_write_lock_killable(mm);
+}
+
+/*
+ * Helper for page fault handling.
+ *
+ * This is kind of equivalend to "mmap_read_lock()" followed
+ * by "find_extend_vma()", except it's a lot more careful about
+ * the locking (and will drop the lock on failure).
+ *
+ * For example, if we have a kernel bug that causes a page
+ * fault, we don't want to just use mmap_read_lock() to get
+ * the mm lock, because that would deadlock if the bug were
+ * to happen while we're holding the mm lock for writing.
+ *
+ * So this checks the exception tables on kernel faults in
+ * order to only do this all for instructions that are actually
+ * expected to fault.
+ *
+ * We can also actually take the mm lock for writing if we
+ * need to extend the vma, which helps the VM layer a lot.
+ */
+static struct vm_area_struct *
+um_lock_mm_and_find_vma(struct mm_struct *mm,
+			unsigned long addr, bool is_user)
+{
+	struct vm_area_struct *vma;
+
+	if (!get_mmap_lock_carefully(mm, is_user))
+		return NULL;
+
+	vma = find_vma(mm, addr);
+	if (likely(vma && (vma->vm_start <= addr)))
+		return vma;
+
+	/*
+	 * Well, dang. We might still be successful, but only
+	 * if we can extend a vma to do so.
+	 */
+	if (!vma || !(vma->vm_flags & VM_GROWSDOWN)) {
+		mmap_read_unlock(mm);
+		return NULL;
+	}
+
+	/*
+	 * We can try to upgrade the mmap lock atomically,
+	 * in which case we can continue to use the vma
+	 * we already looked up.
+	 *
+	 * Otherwise we'll have to drop the mmap lock and
+	 * re-take it, and also look up the vma again,
+	 * re-checking it.
+	 */
+	if (!mmap_upgrade_trylock(mm)) {
+		if (!upgrade_mmap_lock_carefully(mm, is_user))
+			return NULL;
+
+		vma = find_vma(mm, addr);
+		if (!vma)
+			goto fail;
+		if (vma->vm_start <= addr)
+			goto success;
+		if (!(vma->vm_flags & VM_GROWSDOWN))
+			goto fail;
+	}
+
+	if (expand_stack_locked(vma, addr))
+		goto fail;
+
+success:
+	mmap_write_downgrade(mm);
+	return vma;
+
+fail:
+	mmap_write_unlock(mm);
+	return NULL;
+}
+
 /*
  * Note this is constrained to return 0, -EFAULT, -EACCES, -ENOMEM by
  * segv().
@@ -44,21 +160,10 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 	if (is_user)
 		flags |= FAULT_FLAG_USER;
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
-	if (!vma)
-		goto out;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto out;
-	if (is_user && !ARCH_IS_STACKGROW(address))
-		goto out;
-	vma = expand_stack(mm, address);
+	vma = um_lock_mm_and_find_vma(mm, address, is_user);
 	if (!vma)
 		goto out_nosemaphore;
 
-good_area:
 	*code_out = SEGV_ACCERR;
 	if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
-- 
2.49.0


