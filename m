Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D50EC44529
	for <linux-um@archiver.kernel.org>; Tue, 21 Jul 2026 08:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HeeA2LyVYkBrApZ3FSmYX3HkeM/3RILmw/o0Nn3SWoQ=; b=bQYKa9mNhcaYWP35ms7eTNBneO
	BdEzXQVpm2OvAMDSCCjNRgLD+MsQ8+SCjtafSwiMBE2wxE8VxGbzHZp187HhL9vSZJUmvzia2VaKl
	rNGEYoGjRSU0pyAusFqB+yHeKfWj/X1bfXX29a1kbPo7Sqzu5S2dOV0HDs014CtIaiUw7/rqsfUgg
	aflPboExYbfS5GRN2qCdoadW8R5eA5+ejJ/aDQfSIXPgxsk93MH+n4qDggckWrjdrDOhdyaG83Mfi
	HXFQs12I/p3pnFdWG3VgC5UbR/h2jUEEBvQC+zYiPwtp8Bu43fwWgo3ORBi6kIIrHl33w3B00t/ic
	eje91Tnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm659-00000008rle-2q1d;
	Tue, 21 Jul 2026 08:44:07 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm656-00000008rku-40P4
	for linux-um@lists.infradead.org;
	Tue, 21 Jul 2026 08:44:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=HeeA2LyVYkBrApZ3FSmYX3HkeM/3RILmw/o0Nn3SWoQ=; t=1784623444; x=1785833044; 
	b=D0beFEwgBte/WSQvirV1TCLbly7uJT6sr38k5dCPT6opG74h6Tz0vRY8rVggfgDusDgNexq/gPp
	T530mnA7GytHh92RWMV1l5G9UjlVcPZkeDobzbz21YkczgL5PBT2nSQSpyYFv3DWkdIFyz87lsw8c
	LI55VdG3hIOwQMDNI9sCOs+hAAj2PiVw3mLlaPXRNnVJHJ4VFMuT84Ek4Wz6hKZ9TL6ulgR5ONAzu
	ePnSnbeeYwdGnnBTUKwuRKVr723Zu4Hxwd0H/RbDmHiPqy++Ay0nj7i2JePGEKoPHfCSgmAgaOe4H
	8HjsDY7qa4FUjksYD6qkHRZR5G8ZJntaI2Pw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wm651-00000001tQy-0aeC;
	Tue, 21 Jul 2026 10:43:59 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2] um: fix futex implementation
Date: Tue, 21 Jul 2026 10:43:56 +0200
Message-ID: <20260721084356.290579-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_014404_993843_D1450CAA 
X-CRM114-Status: GOOD (  15.96  )
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

From: Johannes Berg <johannes.berg@intel.com>

The futex operations are both now wrong, neither have proper
atomic semantics, which are needed for SMP. Even if we don't
have SMP across threads of a process yet, multiple processes
can use futexes to synchronize.

Also remove the documentation that's duplicated (and wrong,
as this implementation never returns -EAGAIN).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: fix oldval read
---
 arch/um/kernel/skas/uaccess.c | 134 +++++++++++++---------------------
 1 file changed, 51 insertions(+), 83 deletions(-)

diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index caef1deef795..f48f0e7c2497 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -231,116 +231,90 @@ long strnlen_user(const char __user *str, long len)
 }
 EXPORT_SYMBOL(strnlen_user);
 
-/**
- * arch_futex_atomic_op_inuser() - Atomic arithmetic operation with constant
- *			  argument and comparison of the previous
- *			  futex value with another constant.
- *
- * @op:		operation to execute
- * @oparg:	argument to operation
- * @oval:	old value at uaddr
- * @uaddr:	pointer to user space address
- *
- * Return:
- * 0 - On success
- * -EFAULT - User access resulted in a page fault
- * -EAGAIN - Atomic operation was unable to complete due to contention
- * -ENOSYS - Operation not supported
- */
-
 int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 {
-	int oldval, ret;
-	struct page *page;
 	unsigned long addr = (unsigned long) uaddr;
+	u32 *p, oldval, newval;
+	struct page *page;
 	pte_t *pte;
 
-	ret = -EFAULT;
 	if (!access_ok(uaddr, sizeof(*uaddr)))
 		return -EFAULT;
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+		break;
+	default:
+		return -ENOSYS;
+	}
+
 	preempt_disable();
 	pte = maybe_map(addr, 1);
-	if (pte == NULL)
-		goto out_inuser;
+	if (pte == NULL) {
+		preempt_enable();
+		return -EFAULT;
+	}
 
 	page = pte_page(*pte);
 #ifdef CONFIG_64BIT
 	pagefault_disable();
-	addr = (unsigned long) page_address(page) +
-			(((unsigned long) addr) & ~PAGE_MASK);
+	p = page_address(page) + (addr & ~PAGE_MASK);
 #else
-	addr = (unsigned long) kmap_atomic(page) +
-		((unsigned long) addr & ~PAGE_MASK);
+	p = kmap_atomic(page) + (addr & ~PAGE_MASK);
 #endif
-	uaddr = (u32 *) addr;
-	oldval = *uaddr;
 
-	ret = 0;
+	do {
+		oldval = READ_ONCE(*p);
+
+		switch (op) {
+		case FUTEX_OP_SET:
+			newval = oparg;
+			break;
+		case FUTEX_OP_ADD:
+			newval = oldval + oparg;
+			break;
+		case FUTEX_OP_OR:
+			newval = oldval | oparg;
+			break;
+		case FUTEX_OP_ANDN:
+			newval = oldval & ~oparg;
+			break;
+		case FUTEX_OP_XOR:
+			newval = oldval ^ oparg;
+			break;
+		}
+	} while (!try_cmpxchg(p, &oldval, newval));
+
+	*oval = oldval;
 
-	switch (op) {
-	case FUTEX_OP_SET:
-		*uaddr = oparg;
-		break;
-	case FUTEX_OP_ADD:
-		*uaddr += oparg;
-		break;
-	case FUTEX_OP_OR:
-		*uaddr |= oparg;
-		break;
-	case FUTEX_OP_ANDN:
-		*uaddr &= ~oparg;
-		break;
-	case FUTEX_OP_XOR:
-		*uaddr ^= oparg;
-		break;
-	default:
-		ret = -ENOSYS;
-	}
 #ifdef CONFIG_64BIT
 	pagefault_enable();
 #else
 	kunmap_atomic((void *)addr);
 #endif
-
-out_inuser:
 	preempt_enable();
-
-	if (ret == 0)
-		*oval = oldval;
-
-	return ret;
+	return 0;
 }
-EXPORT_SYMBOL(arch_futex_atomic_op_inuser);
-
-/**
- * futex_atomic_cmpxchg_inatomic() - Compare and exchange the content of the
- *				uaddr with newval if the current value is
- *				oldval.
- * @uval:	pointer to store content of @uaddr
- * @uaddr:	pointer to user space address
- * @oldval:	old value
- * @newval:	new value to store to @uaddr
- *
- * Return:
- * 0 - On success
- * -EFAULT - User access resulted in a page fault
- * -EAGAIN - Atomic operation was unable to complete due to contention
- */
 
 int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
-			      u32 oldval, u32 newval)
+				  u32 oldval, u32 newval)
 {
 	struct page *page;
 	pte_t *pte;
-	int ret = -EFAULT;
 
 	if (!access_ok(uaddr, sizeof(*uaddr)))
 		return -EFAULT;
 
 	preempt_disable();
 	pte = maybe_map((unsigned long) uaddr, 1);
-	if (pte == NULL)
-		goto out_inatomic;
+	if (pte == NULL) {
+		preempt_enable();
+		return -EFAULT;
+	}
 
 	page = pte_page(*pte);
 #ifdef CONFIG_64BIT
@@ -350,19 +324,13 @@ int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	uaddr = kmap_atomic(page) + ((unsigned long) uaddr & ~PAGE_MASK);
 #endif
 
-	*uval = *uaddr;
-
-	ret = cmpxchg(uaddr, oldval, newval);
+	*uval = cmpxchg(uaddr, oldval, newval);
 
 #ifdef CONFIG_64BIT
 	pagefault_enable();
 #else
 	kunmap_atomic(uaddr);
 #endif
-	ret = 0;
-
-out_inatomic:
 	preempt_enable();
-	return ret;
+	return 0;
 }
-EXPORT_SYMBOL(futex_atomic_cmpxchg_inatomic);
-- 
2.53.0


