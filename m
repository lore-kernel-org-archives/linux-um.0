Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD88C25B74
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JEq2Mh0Rlq08t7izyLbxxhiNFXu0zEokYecsL7S78cs=; b=4s9Y4041ro4bZHmr9elzbTXKIq
	sqlZ96+WIkPcRTQyaAea+HH8fnwZKy5sYsebMS4m1gQGjJ6RnjW9GSGhoXrtpa3zAJNSuF6DZc1Om
	YbbxPmX3RjNiTWY51Me/XAe/397btH5Mzg2xcUWbYxFsX1CsxkrGiH60AQJqzlYe8C0rXadkY8Xdh
	AHc8EkdCh0fcGHvREj+qR39Sa6QBDHBkP9o+oG1uymxgpf+Sa7k7aM0FJGmsOFXV9wStpKtxovu57
	bdlWstxxxd9MKpsd/yD3Z3ejG5vpoG3mDRQCZmn9Q/aWZhxyYME0xP3hwgJ9Qgkc41Y7rEHgqS3Tn
	l7X0S4MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCeSF-00000007AlU-0eZ6;
	Thu, 30 May 2024 12:00:23 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCeS7-00000007Aj5-0Jwd
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 12:00:21 +0000
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Vql8G56dvzwQb9;
	Thu, 30 May 2024 19:56:14 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 8668F180AA5;
	Thu, 30 May 2024 20:00:03 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 30 May
 2024 20:00:03 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>
CC: <brauner@kernel.org>, <viro@zeniv.linux.org.uk>,
	<linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH v2] hostfs: convert hostfs to use the new mount API
Date: Thu, 30 May 2024 20:01:11 +0800
Message-ID: <20240530120111.3794664-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_050019_492887_A231E6EC 
X-CRM114-Status: GOOD (  16.16  )
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

Convert the hostfs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
Changes since v1:
  - Fixed uninitialized variable warning and rebase on latest code.
---
 fs/hostfs/hostfs_kern.c | 83 ++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index a73d27c4dd58..6ec3c368d7bf 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -16,11 +16,16 @@
 #include <linux/seq_file.h>
 #include <linux/writeback.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/namei.h>
 #include "hostfs.h"
 #include <init.h>
 #include <kern.h>
 
+struct hostfs_fs_info {
+	char *host_root_path;
+};
+
 struct hostfs_inode_info {
 	int fd;
 	fmode_t mode;
@@ -90,8 +95,10 @@ static char *__dentry_name(struct dentry *dentry, char *name)
 	char *p = dentry_path_raw(dentry, name, PATH_MAX);
 	char *root;
 	size_t len;
+	struct hostfs_fs_info *fsi;
 
-	root = dentry->d_sb->s_fs_info;
+	fsi = dentry->d_sb->s_fs_info;
+	root = fsi->host_root_path;
 	len = strlen(root);
 	if (IS_ERR(p)) {
 		__putname(name);
@@ -196,8 +203,10 @@ static int hostfs_statfs(struct dentry *dentry, struct kstatfs *sf)
 	long long f_bavail;
 	long long f_files;
 	long long f_ffree;
+	struct hostfs_fs_info *fsi;
 
-	err = do_statfs(dentry->d_sb->s_fs_info,
+	fsi = dentry->d_sb->s_fs_info;
+	err = do_statfs(fsi->host_root_path,
 			&sf->f_bsize, &f_blocks, &f_bfree, &f_bavail, &f_files,
 			&f_ffree, &sf->f_fsid, sizeof(sf->f_fsid),
 			&sf->f_namelen);
@@ -245,7 +254,11 @@ static void hostfs_free_inode(struct inode *inode)
 
 static int hostfs_show_options(struct seq_file *seq, struct dentry *root)
 {
-	const char *root_path = root->d_sb->s_fs_info;
+	struct hostfs_fs_info *fsi;
+	const char *root_path;
+
+	fsi = root->d_sb->s_fs_info;
+	root_path = fsi->host_root_path;
 	size_t offset = strlen(root_ino) + 1;
 
 	if (strlen(root_path) > offset)
@@ -922,10 +935,11 @@ static const struct inode_operations hostfs_link_iops = {
 	.get_link	= hostfs_get_link,
 };
 
-static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
+static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct hostfs_fs_info *fsi = sb->s_fs_info;
 	struct inode *root_inode;
-	char *host_root_path, *req_root = d;
+	char *host_root = fc->source;
 	int err;
 
 	sb->s_blocksize = 1024;
@@ -939,15 +953,15 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 		return err;
 
 	/* NULL is printed as '(null)' by printf(): avoid that. */
-	if (req_root == NULL)
-		req_root = "";
+	if (fc->source == NULL)
+		host_root = "";
 
-	sb->s_fs_info = host_root_path =
-		kasprintf(GFP_KERNEL, "%s/%s", root_ino, req_root);
-	if (host_root_path == NULL)
+	fsi->host_root_path =
+		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
+	if (fsi->host_root_path == NULL)
 		return -ENOMEM;
 
-	root_inode = hostfs_iget(sb, host_root_path);
+	root_inode = hostfs_iget(sb, fsi->host_root_path);
 	if (IS_ERR(root_inode))
 		return PTR_ERR(root_inode);
 
@@ -955,7 +969,7 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 		char *name;
 
 		iput(root_inode);
-		name = follow_link(host_root_path);
+		name = follow_link(fsi->host_root_path);
 		if (IS_ERR(name))
 			return PTR_ERR(name);
 
@@ -972,11 +986,38 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 	return 0;
 }
 
-static struct dentry *hostfs_read_sb(struct file_system_type *type,
-			  int flags, const char *dev_name,
-			  void *data)
+static int hostfs_fc_get_tree(struct fs_context *fc)
 {
-	return mount_nodev(type, flags, data, hostfs_fill_sb_common);
+	return get_tree_nodev(fc, hostfs_fill_super);
+}
+
+static void hostfs_fc_free(struct fs_context *fc)
+{
+	struct hostfs_fs_info *fsi = fc->s_fs_info;
+
+	if (!fsi)
+		return;
+
+	kfree(fsi->host_root_path);
+	kfree(fsi);
+}
+
+static const struct fs_context_operations hostfs_context_ops = {
+	.get_tree	= hostfs_fc_get_tree,
+	.free		= hostfs_fc_free,
+};
+
+static int hostfs_init_fs_context(struct fs_context *fc)
+{
+	struct hostfs_fs_info *fsi;
+
+	fsi = kzalloc(sizeof(*fsi), GFP_KERNEL);
+	if (!fsi)
+		return -ENOMEM;
+
+	fc->s_fs_info = fsi;
+	fc->ops = &hostfs_context_ops;
+	return 0;
 }
 
 static void hostfs_kill_sb(struct super_block *s)
@@ -986,11 +1027,11 @@ static void hostfs_kill_sb(struct super_block *s)
 }
 
 static struct file_system_type hostfs_type = {
-	.owner 		= THIS_MODULE,
-	.name 		= "hostfs",
-	.mount	 	= hostfs_read_sb,
-	.kill_sb	= hostfs_kill_sb,
-	.fs_flags 	= 0,
+	.owner			= THIS_MODULE,
+	.name			= "hostfs",
+	.init_fs_context	= hostfs_init_fs_context,
+	.kill_sb		= hostfs_kill_sb,
+	.fs_flags		= 0,
 };
 MODULE_ALIAS_FS("hostfs");
 
-- 
2.34.1


