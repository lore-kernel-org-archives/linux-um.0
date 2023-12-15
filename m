Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE7FC46CC5
	for <linux-um@archiver.kernel.org>; Fri, 15 Dec 2023 12:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8q4PzrKs2FLRiSdhYmqWyLRGy6LJ8kabPDSBTbTIyoc=; b=vsJ9v9e0hLLVvDLQ4jHa5w7iGO
	GQYCoUIxyeHoKxvWZ7BJW3WwLuwgdQ/QG+PBkcOp5dZdXKpyJV4KdvNckBXDCSHGYFNk/f4B3M0Wa
	trRBMyyGjg6YvNnXISjU/Mzi1B8WDB01dkTCmJzDrd2ny6CGDBLgpc1HVZgPmdbROjc7HgnuhUySm
	D4fF5K6KEftpznhy6MwnGXiOXO7nEXibVL8e2EHC+2OhcfokjFOXAcf45WqljjR10zBR43n8CNETJ
	wBth3nOyXZcBcJjL0n0zE0u7nP8PrFs7PiVLR+lbrnV+ZFmXwvNwFO7n601dBz5HkIMca/Lpbimc8
	sPAa/N/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE76H-003C1L-0a;
	Fri, 15 Dec 2023 12:15:29 +0000
Received: from frasgout12.his.huawei.com ([14.137.139.154])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE76C-003Bv0-2Z
	for linux-um@lists.infradead.org;
	Fri, 15 Dec 2023 12:15:27 +0000
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ss7565W0Sz9xFn2
	for <linux-um@lists.infradead.org>; Fri, 15 Dec 2023 19:57:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 3C7C9140113
	for <linux-um@lists.infradead.org>; Fri, 15 Dec 2023 20:15:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.148.243])
	by APP2 (Coremail) with SMTP id GxC2BwCnpV86Q3xlRz6QAg--.57272S3;
	Fri, 15 Dec 2023 13:15:02 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH 1/2] um: do not panic on kernel mode faults
Date: Fri, 15 Dec 2023 13:14:30 +0100
Message-Id: <20231215121431.680-2-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215121431.680-1-petrtesarik@huaweicloud.com>
References: <20231215121431.680-1-petrtesarik@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCnpV86Q3xlRz6QAg--.57272S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF1ftr1ktw48KFWUCFg_yoW8XF15pF
	nxAa1agr4Sv3W5Aa9rWr4kZ3y3Ja4qgw12krZ7G34a9w1jgFnxuFWkZwn7XryYgryFgF4U
	tFWYyry2krs8Zw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0Ew4C26cxK6c8Ij28Icw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUnvtZUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_041525_132324_FBF9232B 
X-CRM114-Status: GOOD (  10.14  )
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

Do not call panic() on unrecoverable page faults in kernel mode. Although
such page faults always indicate a bug in the kernel, other architectures
prefer to kill only the current process and continue.

The new behavior is useful for testing intentional kernel mode page faults
with KUnit.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 arch/um/kernel/trap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 6d8ae86ae978..1124a382fd14 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -17,6 +17,14 @@
 #include <os.h>
 #include <skas.h>
 
+static void page_fault_oops(struct uml_pt_regs *regs, unsigned long address,
+			    unsigned long ip)
+{
+	pr_alert("Kernel mode fault at addr 0x%lx, ip 0x%lx\n", address, ip);
+	show_regs(container_of(regs, struct pt_regs, regs));
+	make_task_dead(SIGKILL);
+}
+
 /*
  * Note this is constrained to return 0, -EFAULT, -EACCES, -ENOMEM by
  * segv().
@@ -249,11 +257,8 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 	else if (!is_user && arch_fixup(ip, regs))
 		goto out;
 
-	if (!is_user) {
-		show_regs(container_of(regs, struct pt_regs, regs));
-		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx",
-		      address, ip);
-	}
+	if (!is_user)
+		page_fault_oops(regs, address, ip);
 
 	show_segv_info(regs);
 
-- 
2.34.1


