Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16613C44532
	for <linux-um@archiver.kernel.org>; Mon, 20 Jul 2026 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PLQrycrKJpGn8OQk9ozd2ZN+MpkNzHo+k5op2DKDjqY=; b=TfCFUw75Q/ZhXyibp6P9tXTpxE
	AIiUqMCtlsnGV5CI7ojt99Qckbk7rfASmrnX0yFDFfIQlu0U6CvP3fLA2arCoTrht31nXRWxWN3UL
	dn0P1K4SOllwSD67mOmDMTOC15hvXdMCLwEtV1LhEzVF/+6u69CdY5m0hnJF847ruJyDD1o4nWxVZ
	6P5y03ovdmO+VgwQ3GqxgxfwfFC3WeirWiPZZVD4B87OYqzOEZ5H1vvmTgTpABRgCopsbMpZWdvsW
	GhYf/2ZzCu0uY8JFWdiyP4HavZb7hmQzYaqM60MUwievSAFQ0St2cBM+Tsg3fVB8XH8+Z1ZSVXnBQ
	OiE/kd4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt5I-00000007h9z-2iqB;
	Mon, 20 Jul 2026 18:51:24 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt59-00000007h17-46s5
	for linux-um@lists.infradead.org;
	Mon, 20 Jul 2026 18:51:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PLQrycrKJpGn8OQk9ozd2ZN+MpkNzHo+k5op2DKDjqY=;
	t=1784573475; x=1785783075; b=tOOeGB4O9pjdcnfzuO01shvBfmsizhm/25X/aZrWa9+fIQm
	B4q7+pH75/BxTrhLMMLaSoQABJdoh4QB5lVUtTWSd1YVPflcjus7FnWLMy10ESPdwn8e4c5pi5AHw
	KfYf6FOgMHmjx4vgueaawdBOKX3GTYcjy022neGv52ksDpcmt4NC9VmHL9nQmG8jka9/qW9SkiF1k
	1uMqS9U0AVG2x7UtF7WkeYeoU8qObWWIstIw88izLgaYMZQDSBo4ZswDhZSJAhlIZHn/qJbQBPUAy
	Bf4ksaZ08Weu19u+OgZXhac9Ailz4oEy5OnseLx8n1h8bcGBejabiQSUvvOM6eDA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wlt57-0000000GsPP-0GiQ;
	Mon, 20 Jul 2026 20:51:13 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 7/9] um: nommu: add SMP futex operations
Date: Mon, 20 Jul 2026 20:26:57 +0200
Message-ID: <20260720205103.4b4ce01cd017.I0a83e5ca6be6c95a81d4b2ec69677bbea5889d7d@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720185103.530603-11-johannes@sipsolutions.net>
References: <20260720185103.530603-11-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_115116_050176_FD5F8DF9 
X-CRM114-Status: GOOD (  11.28  )
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

The asm-generic futex implementation only supports UP operations,
and the normal (MMU) implementation from uaccess.c isn't built
nor would it work.

Since NOMMU shares address space anyway, it's all trivial and we
can just make a trivial implementation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/futex.h | 53 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/futex.h b/arch/um/include/asm/futex.h
index 785fd6649aa2..ecfaad61acc0 100644
--- a/arch/um/include/asm/futex.h
+++ b/arch/um/include/asm/futex.h
@@ -12,7 +12,58 @@ int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 			      u32 oldval, u32 newval);
 #else
+#include <linux/atomic.h>
 #include <asm-generic/futex.h>
-#endif
+
+#ifdef CONFIG_SMP
+static inline int
+arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
+{
+	u32 oldval, newval;
+	u32 *p = (u32 __force *)uaddr;
+
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
+		default:
+			return -ENOSYS;
+		}
+	} while (!try_cmpxchg(p, &oldval, newval));
+
+	*oval = oldval;
+	return 0;
+}
+
+static inline int
+futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+			      u32 oldval, u32 newval)
+{
+	u32 *p = (u32 __force *)uaddr;
+
+	/* FIXME - shouldn't it be *uval = cmpxchg()? */
+	*uval = *p;
+	cmpxchg(p, oldval, newval);
+
+	return 0;
+}
+#endif /* CONFIG_SMP */
+
+#endif /* CONFIG_MMU */
 
 #endif
-- 
2.53.0


