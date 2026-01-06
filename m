Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBF3CD0427
	for <linux-um@archiver.kernel.org>; Tue,  6 Jan 2026 00:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PUE29RVcIi26Mk2SiaNV7qk2hBD6KFujfwNUQ8xLRHc=; b=p7lKU6oG6Sh8ha/3Vq42UyBvMF
	GRKVnsHIQF4fKZCTg9RVYk3O7YC//7VBu04kUrZ+c5fO4+Fkum2/sM/P2tRNWHM/IZTt2+C/lS5gG
	92wW6/fs/d35HCVlxXYMppmnqjrNtIO+s+tgID0OgspgrC0TEPFpueSAJeKNBl2TGgys2ZnB+WGoh
	kazVo6uvoG13Rw5EpQCMfE4Cf557u8X9tQqtg3MTD7rS/bqKMBj/aCRvlgVJ69V76iO549PJxa0I3
	vXIsLil+6RK7vEOFwJBtG8fnxLPRrIajDcrf69VB/RV6dx8rdkO5D9Wq1NsXbddnjFtAVqplekS3W
	QCnYqDWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcvAs-0000000CGo9-2g7d;
	Tue, 06 Jan 2026 00:43:50 +0000
Received: from out28-50.mail.aliyun.com ([115.124.28.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcvAl-0000000CGnj-2Bct
	for linux-um@lists.infradead.org;
	Tue, 06 Jan 2026 00:43:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1767660218; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PUE29RVcIi26Mk2SiaNV7qk2hBD6KFujfwNUQ8xLRHc=;
	b=IHSHdO1dTn449dUx4PjXOM6La9Buu/HjDfEotQlkvuVWIi+GqSi3qELxgbz7iCZ6Sjv8ggo6YcWlGEtUoLM3XQkezCGqT0yFAo9VOTVqp/xN+FaOOynbhv1ziT6U7jVZ5JavS2OK9c+DrFCp8MSJvPfB0G0OahTiM5q9xFxv9Fg=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.g-szCsU_1767660196 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 06 Jan 2026 08:43:35 +0800
From: Tiwei Bie <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	Tiwei Bie <tiwei.btw@antgroup.com>
Subject: [PATCH] um: virtio_uml: Support adding devices via mconsole
Date: Tue,  6 Jan 2026 08:42:59 +0800
Message-Id: <20260106004259.1604736-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_164345_035984_A4FC02BD 
X-CRM114-Status: GOOD (  14.01  )
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

It can be used when we want to add virtio devices to UML while
it's up and running. Virtio devices can be added to UML using
the same syntax as the command line option:

(mconsole) config virtio_uml.device=<socket>:<virtio_id>[:<platform_id>]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/virtio_uml.c | 51 +++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 6cf1152a1a4e..c24da0cf1627 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -34,6 +34,7 @@
 #include <irq_kern.h>
 #include <init.h>
 #include <os.h>
+#include "mconsole_kern.h"
 #include "vhost_user.h"
 
 #define MAX_SUPPORTED_QUEUE_SIZE	256
@@ -1282,6 +1283,7 @@ static struct device vu_cmdline_parent = {
 	.release = vu_cmdline_release_dev,
 };
 
+static DEFINE_MUTEX(vu_cmdline_lock);
 static bool vu_cmdline_parent_registered;
 static int vu_cmdline_id;
 
@@ -1309,7 +1311,7 @@ static void vu_conn_broken(struct work_struct *wk)
 	vu_unregister_cmdline_device(&pdata->pdev->dev, NULL);
 }
 
-static int vu_cmdline_set(const char *device, const struct kernel_param *kp)
+static int vu_cmdline_set_device(const char *device)
 {
 	const char *ids = strchr(device, ':');
 	unsigned int virtio_device_id;
@@ -1321,6 +1323,8 @@ static int vu_cmdline_set(const char *device, const struct kernel_param *kp)
 	if (!ids || ids == device)
 		return -EINVAL;
 
+	guard(mutex)(&vu_cmdline_lock);
+
 	processed = sscanf(ids, ":%u%n:%d%n",
 			   &virtio_device_id, &consumed,
 			   &vu_cmdline_id, &consumed);
@@ -1366,6 +1370,11 @@ static int vu_cmdline_set(const char *device, const struct kernel_param *kp)
 	return err;
 }
 
+static int vu_cmdline_set(const char *device, const struct kernel_param *kp)
+{
+	return vu_cmdline_set_device(device);
+}
+
 static int vu_cmdline_get_device(struct device *dev, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1380,6 +1389,8 @@ static int vu_cmdline_get_device(struct device *dev, void *data)
 
 static int vu_cmdline_get(char *buffer, const struct kernel_param *kp)
 {
+	guard(mutex)(&vu_cmdline_lock);
+
 	buffer[0] = '\0';
 	if (vu_cmdline_parent_registered)
 		device_for_each_child(&vu_cmdline_parent, buffer,
@@ -1403,6 +1414,8 @@ __uml_help(vu_cmdline_param_ops,
 
 static void vu_unregister_cmdline_devices(void)
 {
+	guard(mutex)(&vu_cmdline_lock);
+
 	if (vu_cmdline_parent_registered) {
 		device_for_each_child(&vu_cmdline_parent, NULL,
 				      vu_unregister_cmdline_device);
@@ -1411,6 +1424,42 @@ static void vu_unregister_cmdline_devices(void)
 	}
 }
 
+static int vu_mc_config(char *str, char **error_out)
+{
+	if (*str != '=') {
+		*error_out = "Invalid config";
+		return -EINVAL;
+	}
+	str += 1;
+	return vu_cmdline_set_device(str);
+}
+
+static int vu_mc_id(char **str, int *start_out, int *end_out)
+{
+	return -EOPNOTSUPP;
+}
+
+static int vu_mc_remove(int n, char **error_out)
+{
+	return -EOPNOTSUPP;
+}
+
+static struct mc_device virtio_uml_mc = {
+	.list		= LIST_HEAD_INIT(virtio_uml_mc.list),
+	.name		= "virtio_uml.device",
+	.config		= vu_mc_config,
+	.get_config	= NULL,
+	.id		= vu_mc_id,
+	.remove		= vu_mc_remove,
+};
+
+static int __init virtio_uml_mc_init(void)
+{
+	mconsole_register_dev(&virtio_uml_mc);
+	return 0;
+}
+late_initcall(virtio_uml_mc_init);
+
 /* Platform driver */
 
 static const struct of_device_id virtio_uml_match[] = {
-- 
2.34.1


