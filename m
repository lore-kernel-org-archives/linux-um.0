Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AD5C531D1
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8EX8u3DyHyeJH+e0LfcNHKjym5IEINL3FMcZbLpQ6EQ=; b=A13jA2v/FfoLbNZBSirf1f2qJ0
	rgS7yjckx5A04UQsv4nY7vJeX/e4R8ZHU6hYqh41R61LNlnLNpRICG8L2ILpuqxfp5c/I2BQiDvDt
	OrWdnNGSodvTTfHSXJ8d2+suXHAu/zMrlRZTtGlw23bBXdxFiO0RLoF362bK6/psprKlk8RHpdAeR
	L47yuxeBkkR6be3E4dtkvJiXxp/W6bqAfKMIFYyB2VYDhDv4rBJ6L6r4U9oqIPHCCVmcW1jtGWdco
	VlHQadnsDxL2KTztPTXYNf0/70hfVoDTXOEx8lBl4J4avcyaKARGa9wGOogIV241ULzptC6713Fq7
	0ubKmXlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmprD-0000000Drtt-1XoE;
	Thu, 23 Jul 2026 09:36:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmprA-0000000DrnL-2OC8
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 09:36:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8EX8u3DyHyeJH+e0LfcNHKjym5IEINL3FMcZbLpQ6EQ=;
	t=1784799404; x=1786009004; b=vnA3JWXyE7/MSDuRpRFNKaXMTEOpfWB1NSj5WwtZT6gEtAT
	Z+EPLP8rCieXUNYM1eibDu8/wjDFeFeWQw802TU6AbAtrvYN3DFtlAyjw4zM/sN28+fs5r/5vmwuD
	F1HT5HrxVyIBsrWRFD5amGRJFjlJpB+79V+1UjMaShnlwG+s6bvNH5q2aoiJ6cZogA0BA2FAKUH66
	8Zl0o4z38pBGW6OgINs0vbQCyyDpO61NVdgK89a/RioZZlHejXiQPLzu9iOnHK+LKBv8axU2r8fuD
	jphe0kXTkgV9F5zeKFDshBV4uvFYo8fAQtyQXgzarWxUuEFoxZCsRORaNE7E12RQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmpr7-0000000Aeqq-3e2t;
	Thu, 23 Jul 2026 11:36:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>,
	liam@infradead.org,
	ljs@kernel.org,
	Ricardo Koller <ricarkol@google.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 07/10] um: nommu: add SMP futex operations
Date: Thu, 23 Jul 2026 11:35:48 +0200
Message-ID: <20260723113633.d8373755f77c.I0a83e5ca6be6c95a81d4b2ec69677bbea5889d7d@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723093633.140989-12-johannes@sipsolutions.net>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_023644_623897_B3220DA9 
X-CRM114-Status: GOOD (  10.82  )
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
v2: use cmpxchg() return value correctly
---
 arch/um/include/asm/futex.h | 51 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/futex.h b/arch/um/include/asm/futex.h
index 785fd6649aa2..07ab81f09281 100644
--- a/arch/um/include/asm/futex.h
+++ b/arch/um/include/asm/futex.h
@@ -12,7 +12,56 @@ int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
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
+	*uval = cmpxchg(p, oldval, newval);
+
+	return 0;
+}
+#endif /* CONFIG_SMP */
+
+#endif /* CONFIG_MMU */
 
 #endif
-- 
2.53.0


