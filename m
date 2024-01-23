Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7494C47E49
	for <linux-um@archiver.kernel.org>; Tue, 23 Jan 2024 11:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4+a6MSyPXgEKom2aMNv4B3aI5DSh2DcgVCjXb8KtvOY=; b=dsJxZtkC46uEGfyrPxR1snF+18
	00H4Z0HDtHDcNpx4B0ynPgUVgxU7oV10DWpzxNO22xV4GJGVuEbl7lx7Xl8UehKZX7UkDWog2vE/H
	47HCbQLjWJUYnelvS0nwHJdwv0w78IJ9wNwX+TBT1yjEo/ALjfGySEg86NB4ljWoMQOcc07g8hGhG
	KJbnrNG2U5UEyPxZ8k/4e07Af827Xi1MGzMG3lfNkOoobLz5iMr1bO4KyW0lIbNiBzloC1UJZUM1U
	RX4JKxYtEewpdKH2Eka+ah9cu3rSJolPA4gCZSiIm4OvbvBwBw6k6g9bgaAP6vXUoNJ1tPeHGEqy+
	7bG7lktA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEZa-00G3oa-0S;
	Tue, 23 Jan 2024 11:04:06 +0000
Received: from out0-194.mail.aliyun.com ([140.205.0.194])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEZU-00G3jY-1F
	for linux-um@lists.infradead.org;
	Tue, 23 Jan 2024 11:04:04 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047190;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WDCKTk0_1706007836;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WDCKTk0_1706007836)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 19:03:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/5] um: Remove unused functions
Date: Tue, 23 Jan 2024 19:03:45 +0800
Message-Id: <20240123110347.1274217-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
References: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_030400_702781_1B5884E5 
X-CRM114-Status: UNSURE (   7.58  )
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

These functions are not used anymore. Removing them will also address
below -Wmissing-prototypes warnings:

arch/um/kernel/process.c:51:5: warning: no previous prototype for ‘pid_to_processor_id’ [-Wmissing-prototypes]
arch/um/kernel/process.c:253:5: warning: no previous prototype for ‘copy_to_user_proc’ [-Wmissing-prototypes]
arch/um/kernel/process.c:263:5: warning: no previous prototype for ‘clear_user_proc’ [-Wmissing-prototypes]
arch/um/kernel/tlb.c:579:6: warning: no previous prototype for ‘flush_tlb_mm_range’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/process.c | 21 ---------------------
 arch/um/kernel/tlb.c     |  6 ------
 2 files changed, 27 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 20f3813143d8..292c8014aaa6 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -48,17 +48,6 @@ static inline int external_pid(void)
 	return userspace_pid[0];
 }
 
-int pid_to_processor_id(int pid)
-{
-	int i;
-
-	for (i = 0; i < ncpus; i++) {
-		if (cpu_tasks[i].pid == pid)
-			return i;
-	}
-	return -1;
-}
-
 void free_stack(unsigned long stack, int order)
 {
 	free_pages(stack, order);
@@ -250,21 +239,11 @@ char *uml_strdup(const char *string)
 }
 EXPORT_SYMBOL(uml_strdup);
 
-int copy_to_user_proc(void __user *to, void *from, int size)
-{
-	return copy_to_user(to, from, size);
-}
-
 int copy_from_user_proc(void *to, void __user *from, int size)
 {
 	return copy_from_user(to, from, size);
 }
 
-int clear_user_proc(void __user *buf, int size)
-{
-	return clear_user(buf, size);
-}
-
 static atomic_t using_sysemu = ATOMIC_INIT(0);
 int sysemu_supported;
 
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 7d050ab0f78a..70b5e47e9761 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -576,12 +576,6 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 }
 EXPORT_SYMBOL(flush_tlb_range);
 
-void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-			unsigned long end)
-{
-	fix_range(mm, start, end, 0);
-}
-
 void flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
-- 
2.34.1


