Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF2CC54798
	for <linux-um@archiver.kernel.org>; Fri, 23 Feb 2024 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Jy1mji0huxlzAVzICNupOAFUqwB/9+kefsnRGGH0duA=; b=JNiMzJrj3K7vbGqmQB9yZBIfsA
	BcCvghlJ8YPhm8B6hekZFASq56wafnbRLyLth06tIeoljY6sEzaMEB8ZN4BGuXn9dHfWdOzGCTp7w
	NB3wTj8XuUtLy91X8KhHm2DBRvNDSosVEHlBDskQ4wTppWr0dmj3Tkx46W/vcDTWolvsyDdn9BCmu
	mcW4CPfwJNphFS8YAY5/JycCk2Ksg40zfZpHJyWubai3UmjWDRJ/LGloV0u47cPqTn0VMQMqq3BvQ
	RmKBxzEVJa8K8m584YO62IIyC0vCTbcCsktD/8ZTmeaWC4ZX7wv2e7MxmxV2p6uoK7WV7GgAiPnoV
	DSyKOsVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdWCI-00000009h6Z-332S;
	Fri, 23 Feb 2024 14:06:42 +0000
Received: from frasgout13.his.huawei.com ([14.137.139.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdWAw-00000009gcR-25M8
	for linux-um@lists.infradead.org;
	Fri, 23 Feb 2024 14:05:36 +0000
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4ThBFk73GWz9y3CZ
	for <linux-um@lists.infradead.org>; Fri, 23 Feb 2024 21:49:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id E2879140133
	for <linux-um@lists.infradead.org>; Fri, 23 Feb 2024 22:04:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.218.207])
	by APP1 (Coremail) with SMTP id LxC2BwC3YBkApthlMxERAw--.25951S2;
	Fri, 23 Feb 2024 15:04:55 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH RESEND 1/1] um: oops on accessing a non-present page in the vmalloc area
Date: Fri, 23 Feb 2024 15:04:35 +0100
Message-Id: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwC3YBkApthlMxERAw--.25951S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF1rCFykWr15ZrW5KFg_yoW8GFy7pF
	sxGa1ktr4S9F12ya9rX3s2vr4xKa4kt3W7CrWDAw1Sva1j9F1fZrWakwn8Aw109rWrGayx
	tFWYyryjyw4DXw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0264kExVAvwVAq
	07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUj0JPt
	UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_060519_048376_7666041D 
X-CRM114-Status: UNSURE (   9.10  )
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

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

If a segmentation fault is caused by accessing an address in the vmalloc
area, check that the target page is present.

Currently, if the kernel hits a guard page in the vmalloc area, UML blindly
assumes that the fault is caused by a stale mapping and will be fixed by
flush_tlb_kernel_vm(). Unsurprisingly, if the fault is caused by accessing
a guard page, no mapping is created, and when the faulting instruction is
restarted, it will cause exactly the same fault again, effectively creating
an infinite loop.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 arch/um/kernel/trap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 6d8ae86ae978..d5b85f1bfe33 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -206,11 +206,15 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 	int err;
 	int is_write = FAULT_WRITE(fi);
 	unsigned long address = FAULT_ADDRESS(fi);
+	pte_t *pte;
 
 	if (!is_user && regs)
 		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
 
 	if (!is_user && (address >= start_vm) && (address < end_vm)) {
+		pte = virt_to_pte(&init_mm, address);
+		if (!pte_present(*pte))
+			page_fault_oops(regs, address, ip);
 		flush_tlb_kernel_vm();
 		goto out;
 	}
-- 
2.34.1


