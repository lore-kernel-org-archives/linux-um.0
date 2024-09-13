Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BFAFA3759
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=il6g9/DKpO4uIRhZ89sH+VLpafro2K8XMn8EYlmhmKI=; b=O18AArpqXKmsGwRPuFJwGG4DGy
	Y02gmgm+Df3XABNt9q74/qHDC83PODBQlveaj2+ackRIWGWLPCQYoUI4r29Q0Uj9IUACcWP5mclxx
	Yl27dh9hYly+CS7oQj4DGI1f8E6z31Dk4G5G7NKO3HVutZpH/sBgLpi+t4qD4NMZo0dj/A7jXI2OQ
	7xzFObgvbe8OUpIVV0ZsY//VRZKKAHeYd5uKbUawyjn6uTIi61oqUnh/506JwzHYzWeWQaZLjsUO4
	P8V9dVm3p9BZb2wnpeEAUL8SL9Qu5+iLbm/aG9NG3lCMKCB5sMWkR2Ns05ANbwDUhDlp29kXx/Rh8
	Yw3PnEhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7BJ-0000000GApp-205Q;
	Fri, 13 Sep 2024 14:21:53 +0000
Received: from out0-201.mail.aliyun.com ([140.205.0.201])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7BF-0000000GAo3-346U
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 14:21:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726237306; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=il6g9/DKpO4uIRhZ89sH+VLpafro2K8XMn8EYlmhmKI=;
	b=CHwoaZPBppJV2JSw6/G4ZbHe/TEVf4ZJNdxw3bEJ9Sl6pzBxYU25/XsuIBDG6d6t8m7lIeQxioX5EUD9RknQqUPy95JYO2axseWxejBQS/TUSmJ9K6ZXDYtrXd9JLxSx8YI9yqGtLg4D8J7KlfRM0AP/zEjK/ZlhdFBt3+3qRnc=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZIP7E8W_1726237306)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 22:21:46 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/3] um: Fix the definition for physmem_size
Date: Fri, 13 Sep 2024 22:21:37 +0800
Message-Id: <20240913142137.248245-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913142137.248245-1-tiwei.btw@antgroup.com>
References: <20240913142137.248245-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_072150_007619_E2BD19A6 
X-CRM114-Status: GOOD (  10.50  )
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
index cc5238c1bf1e..cee3d09ba429 100644
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


