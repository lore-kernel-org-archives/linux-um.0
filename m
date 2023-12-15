Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393CAC35274
	for <linux-um@archiver.kernel.org>; Fri, 15 Dec 2023 12:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BPZMHoNYrWn1nv8My8Cq6Ac7USFNF4Q0IvqxHorRqKw=; b=OLxQC0NTI2YDCitCc7hZUyIKby
	53/mz2zIwTYuZVGmDqTWRuyN+RqxiZxBXv/44PJoVxdLQlRjl3bre6D3RhU6wkdhR63DUuO8t7bJ0
	QfIpV7QMsbXJNKnrfyDbYxt32aEaYkMo1jl7M/bPXs4ulH0glgIBT9nex6nW3qvNfN0idsEJQ8ajB
	IcEJPvw6yP4EKha1iTvz1headUCSNUWmsHCqthcR1Clr8fRf7h9wrB+OyCIQYVLZARfn6JQkW4+yY
	Qk+GfhmOpOz+A7ntTCv9A7tPN9Tf+Vs/TBLpDWJeY3fH8Ea4jLxlyx2/+hUVuIWVyYj/gNELYpRiE
	xp84IpuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE76F-003C0A-1W;
	Fri, 15 Dec 2023 12:15:27 +0000
Received: from frasgout11.his.huawei.com ([14.137.139.23])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE76C-003Bun-2L
	for linux-um@lists.infradead.org;
	Fri, 15 Dec 2023 12:15:26 +0000
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ss78v43f6z9xrnp
	for <linux-um@lists.infradead.org>; Fri, 15 Dec 2023 20:01:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 7049414042B
	for <linux-um@lists.infradead.org>; Fri, 15 Dec 2023 20:15:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.148.243])
	by APP2 (Coremail) with SMTP id GxC2BwCnpV86Q3xlRz6QAg--.57272S4;
	Fri, 15 Dec 2023 13:15:08 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH 2/2] um: oops on accessing an non-present page in the vmalloc area
Date: Fri, 15 Dec 2023 13:14:31 +0100
Message-Id: <20231215121431.680-3-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215121431.680-1-petrtesarik@huaweicloud.com>
References: <20231215121431.680-1-petrtesarik@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCnpV86Q3xlRz6QAg--.57272S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF1rCFyDKFy3tr18Krg_yoW8GF1xpF
	43Gw48tr4I9F1Yya9rX3s2vr4xKas5t3W7C3yDJw1Svw1j9a1fZFWfuwnrAw1FvrW8Gayx
	tayYyryjkw4DGw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0Ew4C26cxK6c8Ij28Icw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRLqXdUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_041524_899865_F1B2AF0C 
X-CRM114-Status: UNSURE (   9.88  )
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

If a segmentation fault is caused by an address in the vmalloc area, check
that the target page is present.

Currently, if the kernel hits a guard page the vmalloc area, UML assumes
that the fault is caused merely by a stale mapping and will be fixed by
flush_tlb_kernel_vm(). Of course, this will not create any mapping for a
guard page, so the faulting instruction will cause exactly the same fault
when it is executed again, effectively creating a beautiful (but useless)
infinite loop.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 arch/um/kernel/trap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 1124a382fd14..ca9b5fd83c52 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -214,11 +214,15 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
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


