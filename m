Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693E8C3DA49
	for <linux-um@archiver.kernel.org>; Thu, 25 Jul 2024 06:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4+uaxYAzUOG4otg01Vcjpn9RSFwR3O+Kw/IgkSDChug=; b=rONwuB+jALD2AmXz4j+eGz9hDc
	bd21w7rM91ibb0WvRo2f7HukNICS81EgGH/hkOWrPZLDDxzfE1/R+M8DUh0GOrlas+Zogal814xRh
	C2cDWX4151AgRfTJ/y3yU1nXcB/zyeyLqosRGILXWlZP5ksveaoKubT4tUT1EBKLUNt2ZJ7+jzjJj
	z5iwnQaGV3AeVoi5zqUGtSaIerwDnqB7sCVmjCeVmksLKBH1VEaO36tQ4nRZgwopjp95X8xyhIW9u
	cVs4vX6XkzRp5Fe3ZbzRwfM0FgQP/w6gHmZHUyBTwwtNTp2ijHpobZC90FHBC4Edwmss0o0uc+OUL
	mJJf7ZGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWsFC-000000005Mh-2rG3;
	Thu, 25 Jul 2024 06:46:30 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWsF7-000000005K5-1sO6
	for linux-um@lists.infradead.org;
	Thu, 25 Jul 2024 06:46:28 +0000
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WV1Wc1ML9z2ClPV;
	Thu, 25 Jul 2024 14:41:48 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id CE06E14044F;
	Thu, 25 Jul 2024 14:46:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 25 Jul
 2024 14:46:13 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <brauner@kernel.org>
CC: <viro@zeniv.linux.org.uk>, <maze@google.com>,
	<linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH] hostfs: fix the host directory parse when mounting.
Date: Thu, 25 Jul 2024 14:51:30 +0800
Message-ID: <20240725065130.1821964-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240724_234625_825883_A0C7460D 
X-CRM114-Status: GOOD (  15.17  )
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

hostfs not keep the host directory when mounting. When the host
directory is none (default), fc->source is used as the host root
directory, and this is wrong. Here we use `parse_monolithic` to
handle the old mount path for parsing the root directory. For new
mount path, The `parse_param` is used for the host directory parse.

Reported-and-tested-by: Maciej Żenczykowski <maze@google.com>
Fixes: cd140ce9f611 ("hostfs: convert hostfs to use the new mount API")
Link: https://lore.kernel.org/all/CANP3RGceNzwdb7w=vPf5=7BCid5HVQDmz1K5kC9JG42+HVAh_g@mail.gmail.com/
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/hostfs/hostfs_kern.c | 65 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 2b532670a561..48d2a21c3380 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -17,6 +17,7 @@
 #include <linux/writeback.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/namei.h>
 #include "hostfs.h"
 #include <init.h>
@@ -927,7 +928,6 @@ static const struct inode_operations hostfs_link_iops = {
 static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct hostfs_fs_info *fsi = sb->s_fs_info;
-	const char *host_root = fc->source;
 	struct inode *root_inode;
 	int err;
 
@@ -941,15 +941,6 @@ static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	/* NULL is printed as '(null)' by printf(): avoid that. */
-	if (fc->source == NULL)
-		host_root = "";
-
-	fsi->host_root_path =
-		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
-	if (fsi->host_root_path == NULL)
-		return -ENOMEM;
-
 	root_inode = hostfs_iget(sb, fsi->host_root_path);
 	if (IS_ERR(root_inode))
 		return PTR_ERR(root_inode);
@@ -975,6 +966,58 @@ static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	return 0;
 }
 
+enum hostfs_parma {
+	Opt_hostfs,
+};
+
+static const struct fs_parameter_spec hostfs_param_specs[] = {
+	fsparam_string_empty("hostfs",		Opt_hostfs),
+	{}
+};
+
+static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct hostfs_fs_info *fsi = fc->s_fs_info;
+	struct fs_parse_result result;
+	char *host_root;
+	int opt;
+
+	opt = fs_parse(fc, hostfs_param_specs, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_hostfs:
+		host_root = param->string;
+		if (!host_root)
+			host_root = "";
+		fsi->host_root_path =
+			kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
+		if (fsi->host_root_path == NULL)
+			return -ENOMEM;
+		break;
+	}
+
+	return 0;
+}
+
+static int hostfs_parse_monolithic(struct fs_context *fc, void *data)
+{
+	struct hostfs_fs_info *fsi = fc->s_fs_info;
+	char *host_root = (char *)data;
+
+	/* NULL is printed as '(null)' by printf(): avoid that. */
+	if (host_root == NULL)
+		host_root = "";
+
+	fsi->host_root_path =
+		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
+	if (fsi->host_root_path == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int hostfs_fc_get_tree(struct fs_context *fc)
 {
 	return get_tree_nodev(fc, hostfs_fill_super);
@@ -992,6 +1035,8 @@ static void hostfs_fc_free(struct fs_context *fc)
 }
 
 static const struct fs_context_operations hostfs_context_ops = {
+	.parse_monolithic = hostfs_parse_monolithic,
+	.parse_param	= hostfs_parse_param,
 	.get_tree	= hostfs_fc_get_tree,
 	.free		= hostfs_fc_free,
 };
-- 
2.34.1


