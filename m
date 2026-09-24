Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448A1C98317
	for <linux-um@archiver.kernel.org>; Thu, 24 Sep 2026 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F+mLTFWcuTBUsCxvuF5xTJ0KZMxOy4eAk395s+P/g3g=; b=tDWkw/bwkDlUDs4u4OpjkyOk+o
	g3Yfy+Eff8r4VIruLIb4kzq5Reg/XUMlA9nFkezmOygigZRXT7n6UG7wf67QSFBO1RDPMBNHQHbbI
	v+juYcgd+es3OAcOdiz0Q/JruBNAv+geNvqkcSiVxRFZJZxP55q8fMFsZmJEi5Qqhr3YJjeP0o4JU
	CNLXQnjikKX8wei2uVu0etpfvkJA9F2m1dWktG0hTQsrkap/XtLUQZsg//d6oelKHoFkSO3EwMnB8
	UwG3cvUcEQNhU+y+7+aP0WVzVFg1JV3VypCcS1sXu6MSa9M7CfIuYtflOlwEwhc5DfuwjfsIg1/g7
	ifa5re4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9ikz-0000000B07K-3cyc;
	Thu, 24 Sep 2026 12:40:57 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9ikw-0000000B05T-0437
	for linux-um@lists.infradead.org;
	Thu, 24 Sep 2026 12:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=F+mLTFWcuTBUsCxvuF5xTJ0KZMxOy4eAk395s+P/g3g=;
	t=1790253653; x=1791463253; b=p8glfNHeeQZjbY3DndqfXTYRJcZ5In9mAFJNDAgUunZl01g
	HrVGrJtjQS9Z2T8QTUx1f1Ky3MT1vAdf7HgWJWjyOFLNs6yOnmxnWxZnQfx99d0fgvcKZbfQ7eTxm
	ctLTfRkY7wAyuq//jlhhdTNkk5D//eruPvHNDDZzwZ108vaZqzCFQ3JSyMXufrT+jMH7u8uWWPzfq
	Y5JYyYKTLCb5UGhK3Z1O8cSB+XQZ+fpEzSqH38o3Ph6s5derWvQN2wV51ShnV98byR1fJaSDGqZVE
	1BARP89jM2Zbu1WkxoKoF3tTzZt4GaJGrGadhp/fgBFXcUF0OaRRL0rjlCSio7+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9ikr-000000092x8-1pkb;
	Thu, 24 Sep 2026 14:40:49 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/4] s390: remove unwind_module_init()
Date: Thu, 24 Sep 2026 14:35:50 +0200
Message-ID: <20260924144039.4af0d88b163a.I91f8c59a12ad3d5fe67d50aa3b0434d666ffc9f8@changeid>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924124039.1621965-6-johannes@sipsolutions.net>
References: <20260924124039.1621965-6-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_054054_062533_52286AF2 
X-CRM114-Status: UNSURE (   8.28  )
X-CRM114-Notice: Please train this message.
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

This is dead code, but will likely conflict with
the ORC unwinder unification.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/s390/include/asm/unwind.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/include/asm/unwind.h b/arch/s390/include/asm/unwind.h
index b8ecf04e3468..021056d5982c 100644
--- a/arch/s390/include/asm/unwind.h
+++ b/arch/s390/include/asm/unwind.h
@@ -91,8 +91,5 @@ static inline struct pt_regs *unwind_get_entry_regs(struct unwind_state *state)
 	     unwind_next_frame(state))
 
 static inline void unwind_init(void) {}
-static inline void unwind_module_init(struct module *mod, void *orc_ip,
-				      size_t orc_ip_size, void *orc,
-				      size_t orc_size) {}
 
 #endif /* _ASM_S390_UNWIND_H */
-- 
2.55.0


