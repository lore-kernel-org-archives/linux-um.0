Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93F1C3ABD1
	for <linux-um@archiver.kernel.org>; Mon, 16 Sep 2024 05:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CJgZGzYMVBL3IfrmAZkoR5Aw2/PtQZpaw3y5LK6ZT4k=; b=jXEqk5mNjE+qvRCQ4MKr+Smgfc
	FQJH7ymEql30czcOeMecIy+xxANUY/xLBgCy++o7TMHhzDJ2/o+avwgMHkV+xNTGegZRr2UK88YW6
	YxZ7ctOl4Ay906wywi9DwfbmMtJsojVGvaNdYW164jLnRDKZ2FQ0MkUrv1QI1N91DZzH9FwLEoQ3G
	XVFegCY5G2F68iXho2yqNLO9H0eGZhw76TanT4pgmEbkaRFEgby/IF5HQa9pN5QIBmoRfz3UKO79y
	fXTtOeZfzgh/tB0Npy92Wxgc5nnRmiYdWUfDZmWuBVhc6Z69MTCYfvs4EbD6QRhOxYpMB16oMCvWP
	i1a3Uisg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sq3qO-000000035S3-3AuO;
	Mon, 16 Sep 2024 05:00:12 +0000
Received: from out0-219.mail.aliyun.com ([140.205.0.219])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sq3qL-000000035QA-1ioG
	for linux-um@lists.infradead.org;
	Mon, 16 Sep 2024 05:00:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726462806; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CJgZGzYMVBL3IfrmAZkoR5Aw2/PtQZpaw3y5LK6ZT4k=;
	b=zJ7RYnxpGg2GaBQEmaf8VI859MOIVwWcBiqox5DfD7xfuoJQZ1812hmFPNHCRYl0CTxCs/yUYxBcSSJG7FP6lxP7fab70FMEOe9VxfcL6PDpiaP4sI67JpuJt3VaLfQ+UajIez3B8xF10xNJBP0yH5yCPcQ1mV2Rh/2DeX4GTgg=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZKOkLXb_1726462805)
          by smtp.aliyun-inc.com;
          Mon, 16 Sep 2024 13:00:05 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 4/4] um: Fix the definition for physmem_size
Date: Mon, 16 Sep 2024 12:59:50 +0800
Message-Id: <20240916045950.508910-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916045950.508910-1-tiwei.btw@antgroup.com>
References: <20240916045950.508910-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240915_220009_786619_975F02BA 
X-CRM114-Status: GOOD (  10.31  )
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

Currently physmem_size is defined as long long but declared locally
as unsigned long long before using it in separate .c files. Make them
match by defining physmem_size as unsigned long long and also move
the declaration to a common header to allow the compiler to check it.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/virtio_uml.c       | 2 --
 arch/um/include/shared/as-layout.h | 2 ++
 arch/um/kernel/physmem.c           | 2 --
 arch/um/kernel/um_arch.c           | 2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index e7f5556e3c96..4d3e9b9f5b61 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -72,8 +72,6 @@ struct virtio_uml_vq_info {
 	bool suspended;
 };
 
-extern unsigned long long physmem_size;
-
 #define vu_err(vu_dev, ...)	dev_err(&(vu_dev)->pdev->dev, ##__VA_ARGS__)
 
 /* Vhost-user protocol */
diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 61965a06c18a..283226c34ca4 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -36,6 +36,8 @@ struct cpu_task {
 
 extern struct cpu_task cpu_tasks[];
 
+extern unsigned long long physmem_size;
+
 extern unsigned long high_physmem;
 extern unsigned long uml_physmem;
 extern unsigned long uml_reserved;
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index 94aca17993fd..636830fe00f2 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -22,8 +22,6 @@ static int physmem_fd = -1;
 unsigned long high_physmem;
 EXPORT_SYMBOL(high_physmem);
 
-extern unsigned long long physmem_size;
-
 void __init mem_total_pages(unsigned long physmem, unsigned long iomem)
 {
 	unsigned long phys_pages, iomem_pages, total_pages;
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 8f86aa468b50..99cdf4b2d648 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -131,7 +131,7 @@ static int have_root __initdata;
 static int have_console __initdata;
 
 /* Set in uml_mem_setup and modified in linux_main */
-long long physmem_size = 64 * 1024 * 1024;
+unsigned long long physmem_size = 64 * 1024 * 1024;
 EXPORT_SYMBOL(physmem_size);
 
 static const char *usage_string =
-- 
2.34.1


