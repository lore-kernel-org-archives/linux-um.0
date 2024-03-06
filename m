Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557D2C5475B
	for <linux-um@archiver.kernel.org>; Wed,  6 Mar 2024 09:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tetrM2/lVoO6b6MoahszNtPEy7BfcDE3luQSqTYJhgU=; b=HKaVwnPUhhCAUKidHdhZubkjnK
	17isC0UFx5RIyO8FkFt1GtDZiul3YO3Gch50neoNoIv48j79+7L7zIw82fGdVg7SI7fi3fXywRbk4
	xRpUppXgM3zzV9ebMd4pUoCRbBj3gFB52jh5VU5kKJ8su1gkJ+AH0RYY/LBiAYA1wadU8yMz8lMUh
	nvAb7LnNw7KkFxJJrmpniUQlzZOjdCesQuWDifwIaoSwW8Fs3ftfX97oCohGE3fu/CPldMUZkFtNT
	LYEPMrrV49Xu0RhDtik8t3Gx0S5LcLxh/lOYHiphW6KLXsSrjiDKY7Y0SSCnVMR5kqmpAmFyImJOG
	WcIIWdcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhnLE-0000000H6Uh-3mBF;
	Wed, 06 Mar 2024 09:13:36 +0000
Received: from azure-sdnproxy.icoremail.net ([20.231.56.155])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhnLA-0000000H6Re-2S6y
	for linux-um@lists.infradead.org;
	Wed, 06 Mar 2024 09:13:35 +0000
Received: from ubuntu.localdomain (unknown [218.12.17.6])
	by mail-app3 (Coremail) with SMTP id cC_KCgDXbjqcM+hl8KcCAg--.1124S2;
	Wed, 06 Mar 2024 17:13:10 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-um@lists.infradead.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	axboe@kernel.dk,
	brauner@kernel.org,
	hare@suse.de,
	jinpu.wang@ionos.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] um: Fix return value in ubd_init()
Date: Wed,  6 Mar 2024 17:12:59 +0800
Message-Id: <20240306091259.18605-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgDXbjqcM+hl8KcCAg--.1124S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF18Gw4rtw4UuFWfZw1kZrb_yoWDCwcEkr
	ykXr9ruw4DKr47Jry2v343Z3sIya1jkrs3ZayIvry3JFsxCw4avw4fCrn8Aw4UWrsa9FWq
	yrWIyr93CF47ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb0tC7UUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIMAWXnadMR0wACs0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_011332_786221_8CCD9C6F 
X-CRM114-Status: UNSURE (   9.02  )
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

When kmalloc_array() fails to allocate memory, the ubd_init()
should return -ENOMEM instead of -1. So, fix it.

Fixes: f88f0bdfc32f ("um: UBD Improvements")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 arch/um/drivers/ubd_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 92ee2697ff3..85e33caf62a 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1098,7 +1098,7 @@ static int __init ubd_init(void)
 
 	if (irq_req_buffer == NULL) {
 		printk(KERN_ERR "Failed to initialize ubd buffering\n");
-		return -1;
+		return -ENOMEM;
 	}
 	io_req_buffer = kmalloc_array(UBD_REQ_BUFFER_SIZE,
 				      sizeof(struct io_thread_req *),
@@ -1109,7 +1109,7 @@ static int __init ubd_init(void)
 
 	if (io_req_buffer == NULL) {
 		printk(KERN_ERR "Failed to initialize ubd buffering\n");
-		return -1;
+		return -ENOMEM;
 	}
 	platform_driver_register(&ubd_driver);
 	mutex_lock(&ubd_lock);
-- 
2.17.1


