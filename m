Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9650CC4332F
	for <linux-um@archiver.kernel.org>; Mon, 17 Oct 2022 09:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZL62qZs6DrH1TkbNuuws5Uh9FwRJxUi1O/OcuTAKmZg=; b=qkEiRl+H4oKBB0
	gENFh3SqlOlSQbR+npyxszogsgFaCfB0Y0BUhUyGyxxCP8ZSWJvofZA5T32TIk/ofzTAZ5DwNEhas
	uJdsSVpS66YjrNpZAAbyVE74TAKXUiZM4cdqwBhreZS5xBOeofrY0At157G/6G96ifrwGX+PJZBwZ
	IvzCuJ6Q8g44uf2FIv6TFjuWjFB0BxfqyBjlIHrtU32O70gXa8lqsMHlPnxHTlb8meXnFBTCNO5VD
	sSgBCh48oCgwmumDEqpYGDBiez+qVvzxuuBKj1eoFURhiBFZmibK25fP7y+WXOtKntU/rb5xAmxjb
	niHJ00o7rogj4jTvHRCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okM55-009aWT-Bk; Mon, 17 Oct 2022 09:06:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okM52-009aU4-5G
	for linux-um@lists.infradead.org; Mon, 17 Oct 2022 09:06:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=CreLvLOhf7fJu+MESU0Kj9ZulKMkTZz231hG6ZbA/ZE=; t=1665997598; x=1667207198; 
	b=JT0ps13Tesqojk8inj1sjPDXlY2DTMdfyuemQW9wUWnJ5dvoMjEDt+4JALMZ2nEBTkcNdKV7zol
	ZnX286gbgysIGpEUMEroPxDZxPjAar+v1kaBsXcG4WDvpPENRWqe89/VmYKzmeqd0LTmOv/KybwY7
	unGsD9+3PngSQr6iuUFQug6wLFmyimGLqccZQ178Jn9jyDFwYN/e0KSQATElw4slW97JANOkPOqx+
	9grAdsDxmdH3FvyFeNFgr5/HKSNQTLthdzvtvk2VkGKzDL+zd1+56taQS+nDvooWVstJPZrznAEle
	bD0qhcSVz9SCnepcLVUy8fxu+dGOdptfyFew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1okM4v-009ENX-0L;
	Mon, 17 Oct 2022 11:06:33 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: protect VMA iteration
Date: Mon, 17 Oct 2022 11:06:30 +0200
Message-Id: <20221017110630.c6c786d46e74.I7b85b7dd326d2d078dabdd4ae40c35dc4ee1f3bc@changeid>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_020640_224907_EEF6567F 
X-CRM114-Status: UNSURE (   7.40  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Johannes Berg <johannes.berg@intel.com>

Looks like this is needed now, otherwise we get RCU
splats from lockdep. But I don't know anything about
this code ...

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/tlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index ad449173a1a1..3cc6b753e579 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -587,8 +587,10 @@ void flush_tlb_mm(struct mm_struct *mm)
 	struct vm_area_struct *vma;
 	VMA_ITERATOR(vmi, mm, 0);
 
+	rcu_read_lock();
 	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
+	rcu_read_unlock();
 }
 
 void force_flush_all(void)
@@ -597,6 +599,8 @@ void force_flush_all(void)
 	struct vm_area_struct *vma;
 	VMA_ITERATOR(vmi, mm, 0);
 
+	rcu_read_lock();
 	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
+	rcu_read_unlock();
 }
-- 
2.37.3


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
