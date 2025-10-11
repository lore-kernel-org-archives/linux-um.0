Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A005FCCD184
	for <linux-um@archiver.kernel.org>; Sat, 11 Oct 2025 09:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ggOs2eAUyo4VXT1Pr+8pBElLmd5laphuk6GJ+x94CPU=; b=3pkj5ZkVV4PLTZlmli75gg9cDF
	O63Bf0mr/e88mYMZI1nKXilgXyIUIIyB/zGNUCsaV6wdMUXtksDKalVz/wI5SDs6Cknqm1a821XbF
	2Ln1MM0wrUIh/IkvOQjssqw7WUOGDgw1V/ryLn99svZ4w27YIMWvfThyRgJXWmSrT5C6FGkdIq+58
	OFOoBt5UweeAbk0jf1aN6vqxYfQYCTkyetPfPG4gsPvAtCnn37Nl23wWRF7PeATNrOJDKybcJMXdm
	SEYSat1AsePvZhxJgxVA8fBd5gaxM9fFD4AsedPcyevVxHhLdj7GFxoOPKx9YcaasvwYtd6P3szFP
	QKI3zriA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7Vyp-0000000A0CM-1Lw9;
	Sat, 11 Oct 2025 09:33:35 +0000
Received: from canpmsgout08.his.huawei.com ([113.46.200.223])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7Vym-0000000A0Bz-0n4O
	for linux-um@lists.infradead.org;
	Sat, 11 Oct 2025 09:33:33 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ggOs2eAUyo4VXT1Pr+8pBElLmd5laphuk6GJ+x94CPU=;
	b=s/FXj8qapy0aucC0yRdED0WqNkV/UN3jfUkKNvl0TPiLMj0ukdb4x6JBR7WCjVkbzn42YlJ3q
	rR/t/viNbnsmLxMScKfrptU8kbmtJ3lSNhVJq0B9Yl376ILQQGf78WkdzuNlPOpDGMEGKIoM8GK
	lX/f9e3QOBj51OJpfB9loRQ=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ckJLr0ZXFzmV6w;
	Sat, 11 Oct 2025 17:33:08 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id D8772140123;
	Sat, 11 Oct 2025 17:33:25 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 11 Oct
 2025 17:33:25 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <geoff@geoffthorpe.net>
CC: <linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<brauner@kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH] hostfs: Fix only passing host root in boot stage with new mount
Date: Sat, 11 Oct 2025 09:22:35 +0000
Message-ID: <20251011092235.29880-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251011_023332_573487_3635A67D 
X-CRM114-Status: GOOD (  12.48  )
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

In the old mount proceedure, hostfs could only pass root directory during
boot. This is because it constructed the root directory using the @root_ino
event without any mount options. However, when using it with the new mount
API, this step is no longer triggered. As a result, if users mounts without
specifying any mount options, the @host_root_path remains uninitialized. To
prevent this issue, the @host_root_path should be initialized at the time
of allocation.

Reported-by: Geoffrey Thorpe <geoff@geoffthorpe.net>
Closes: https://lore.kernel.org/all/643333a0-f434-42fb-82ac-d25a0b56f3b7@geoffthorpe.net/
Fixes: cd140ce9f611 ("hostfs: convert hostfs to use the new mount API")
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/hostfs/hostfs_kern.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 1e1acf5775ab..86455eebbf6c 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -979,7 +979,7 @@ static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct hostfs_fs_info *fsi = fc->s_fs_info;
 	struct fs_parse_result result;
-	char *host_root;
+	char *host_root, *tmp_root;
 	int opt;
 
 	opt = fs_parse(fc, hostfs_param_specs, param, &result);
@@ -990,11 +990,13 @@ static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_hostfs:
 		host_root = param->string;
 		if (!*host_root)
-			host_root = "";
-		fsi->host_root_path =
-			kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
-		if (fsi->host_root_path == NULL)
+			break;
+		tmp_root = kasprintf(GFP_KERNEL, "%s%s",
+				     fsi->host_root_path, host_root);
+		if (!tmp_root)
 			return -ENOMEM;
+		kfree(fsi->host_root_path);
+		fsi->host_root_path = tmp_root;
 		break;
 	}
 
@@ -1004,17 +1006,17 @@ static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 static int hostfs_parse_monolithic(struct fs_context *fc, void *data)
 {
 	struct hostfs_fs_info *fsi = fc->s_fs_info;
-	char *host_root = (char *)data;
+	char *tmp_root, *host_root = (char *)data;
 
 	/* NULL is printed as '(null)' by printf(): avoid that. */
 	if (host_root == NULL)
-		host_root = "";
+		return 0;
 
-	fsi->host_root_path =
-		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
-	if (fsi->host_root_path == NULL)
+	tmp_root = kasprintf(GFP_KERNEL, "%s%s", fsi->host_root_path, host_root);
+	if (!tmp_root)
 		return -ENOMEM;
-
+	kfree(fsi->host_root_path);
+	fsi->host_root_path = tmp_root;
 	return 0;
 }
 
@@ -1049,6 +1051,11 @@ static int hostfs_init_fs_context(struct fs_context *fc)
 	if (!fsi)
 		return -ENOMEM;
 
+	fsi->host_root_path = kasprintf(GFP_KERNEL, "%s/", root_ino);
+	if (!fsi->host_root_path) {
+		kfree(fsi);
+		return -ENOMEM;
+	}
 	fc->s_fs_info = fsi;
 	fc->ops = &hostfs_context_ops;
 	return 0;
-- 
2.22.0


