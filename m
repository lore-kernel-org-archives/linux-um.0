Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DB0F8E4B7
	for <linux-um@archiver.kernel.org>; Fri, 17 Apr 2026 07:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kxo1Wb+M6Nkal9euSt7glrlpHKcTagXDGbTG3uGiMJo=; b=RD3WDDKOVahSmVQ0PgYEy2zGuU
	+LWrWAPmGHVRJQ5AovxzaH6pXTsNi3iLbS+6fRrsmtV4L+Uu7pyVxd+336tY+0f0F0cI4yFKVABsc
	Q/wAJv6Gbt/Koz5mWgd3Jp0Y3TnkI5Jk330N8VJr3R16uNTbSepHKjBQJO0gxqd29vIa9hU3KWI5V
	AJ7qAlq6rfaShjXW7u/oNN5U+0/NtyV23++MCsfuY2zqbGPawRr2tytpJwYTD/jwI8YEsyH5Qescx
	lojZEnnFEfA3w7BBlWhYT0Ik4q2F4NFryvk5YDd0DpOlQt5pt/DVzoO/N4fErNHxa8geN2gqS7lXZ
	l2+XYc9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDdp2-00000003c0l-1Abe;
	Fri, 17 Apr 2026 07:41:04 +0000
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDdoz-00000003c0L-3opv
	for linux-um@lists.infradead.org;
	Fri, 17 Apr 2026 07:41:03 +0000
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowAAnfhEK5OFpCQnYDQ--.60278S2;
	Fri, 17 Apr 2026 15:40:58 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] um: vfio: bound the iommu_group sysfs path formatting
Date: Fri, 17 Apr 2026 15:40:56 +0800
Message-ID: <20260417074056.6937-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAnfhEK5OFpCQnYDQ--.60278S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW5CFW3Kr1UGryDJr1fZwb_yoWktFg_u3
	9ruF1DG348GF1rZrnIy34fA3yYy3yavrW8uayDtasayF9rZryUZF1Ikryft3WUXa4fZF4D
	X393tryxAr10gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjZNVP
	UUUUU==
X-Originating-IP: [111.196.245.116]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_004102_337845_5FFD40C4 
X-CRM114-Status: UNSURE (   7.89  )
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

uml_vfio_user_get_group_id() builds the iommu_group sysfs path in a
PATH_MAX buffer with sprintf() and an unvalidated device string.

If the device component is long enough, the formatted path runs past the
end of the heap buffer before readlink() is attempted.

Use snprintf() and reject device strings whose formatted path does not
fit in PATH_MAX.

Fixes: a0e2cb6a9063 ("um: Add VFIO-based virtual PCI driver")

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/um/drivers/vfio_user.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/vfio_user.c b/arch/um/drivers/vfio_user.c
index 6a45d8e14582..5230e18b5b53 100644
--- a/arch/um/drivers/vfio_user.c
+++ b/arch/um/drivers/vfio_user.c
@@ -81,7 +81,12 @@ int uml_vfio_user_get_group_id(const char *device)
 	if (!path)
 		return -ENOMEM;
 
-	sprintf(path, "/sys/bus/pci/devices/%s/iommu_group", device);
+	r = snprintf(path, PATH_MAX, "/sys/bus/pci/devices/%s/iommu_group",
+		     device);
+	if (r >= PATH_MAX) {
+		r = -ENAMETOOLONG;
+		goto free_path;
+	}
 
 	buf = uml_kmalloc(PATH_MAX + 1, UM_GFP_KERNEL);
 	if (!buf) {
-- 
2.50.1 (Apple Git-155)


