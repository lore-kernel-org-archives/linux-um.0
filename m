Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F5606A324
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Xz8MepZM;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=S/VvehNz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nbWfXLrAbKstbutEceRuhfJnnVR8Tsb07bAH/14sQ6g=; b=Xz8MepZMQAm/Ho
	r7+C1jIJM3PJ20l+NKG+Tq536GJQZH2Bx4zBXbjGGpK87LaUvlE92Qog+uHJvbqundI41fQ/Xe0jA
	RiLxKr/IFCA0wHIDwSk2NaqtO5+BjGCzE+plTGk3b+bq+K73ln84bVygeHzMZSxDVgnMvLIUU0q/t
	qKfx3N0ArbG+NEUjr9PM+VHghanYUrCjpMuu9XV5TZvpDFReLZ/39w1cuXz1fZLNQZzUE5NsB5hfX
	Z1CHVY6EM0ffoDTAQCwr/t1qd6i6HfedkPNeEJ2n6vS90mNyjOAl7eSOovXF45sGFmJJWVzNcyY+X
	6tqCMD1phwr++6xVdrzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU29O-0000000C1fW-00lk;
	Thu, 19 Nov 2026 13:26:06 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU29L-0000000C1cV-2QfN
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 13:26:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nbWfXLrAbKstbutEceRuhfJnnVR8Tsb07bAH/14sQ6g=;
	t=1795094763; x=1796304363; b=S/VvehNzK/y2OUBLM1lD21qMmK8bMBWyP6rbqYI1sUU43Wl
	pdrBuzxo/Exqtx1bgBo7HjktyCQfWC+I+V7pVp0Q5HhZHrfmfUKMuJ25+HmDVZGhAXz3eRPrqmW0z
	stTRL9+pq6fQjtTuJ8W84jgTRjgi0zr1Db40FUwIVdkr9XNcP4m9dj1pex1VgoSROSgTq/95B3g4y
	S+FAMQu3QfYH8thebn8Vr+7OFW4nant8Q/7qDsU3oqWPBwjLWuZHAg1teWCbr0m7VrvMQ2dOr/c0h
	pAqhlmR0MLRaSGVCFBs0Q7wrQWoac6tAdHA4WUg9VaF0MJnOMchlD6kiKl6mKoQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU29H-00000004LQj-0TSw;
	Thu, 19 Nov 2026 14:25:59 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?UTF-8?q?=E5=AD=9F=E4=BB=A4=E6=BE=B3?= <menglingao@xiaomi.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC 1/5] hostfs: sort directory entries
Date: Thu, 19 Nov 2026 14:24:38 +0100
Message-ID: <20261119142555.3273bc19860f.I3e85e66282742afae00f81549db5e2c5f760008b@changeid>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119132555.228479-7-johannes@sipsolutions.net>
References: <20261119132555.228479-7-johannes@sipsolutions.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_052603_620472_F901C3AA 
X-CRM114-Status: GOOD (  20.63  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Benjamin Berg <benjamin.berg@intel.com>

Otherwise the order of directory entries is the one returned by the host
file system. This order is consistent, but not well-defined, causing
possible issues when reproducing a run in a different or re-created
setup.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/hostfs/hostfs_kern.c | 147 ++++++++++++++++++++++++++++++++++------
 1 file changed, 127 insertions(+), 20 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 613146e76dec..e8419b96b869 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -19,6 +19,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/namei.h>
+#include <linux/list_sort.h>
 #include "hostfs.h"
 #include <init.h>
 #include <kern.h>
@@ -27,6 +28,15 @@ struct hostfs_fs_info {
 	char *host_root_path;
 };
 
+struct hostfs_dentry_list {
+	struct list_head list;
+	unsigned long long ino;
+	unsigned int type;
+
+	int name_len;
+	char name[];
+};
+
 struct hostfs_inode_info {
 	int fd;
 	fmode_t mode;
@@ -38,7 +48,7 @@ struct hostfs_inode_info {
 
 static inline struct hostfs_inode_info *HOSTFS_I(struct inode *inode)
 {
-	return list_entry(inode, struct hostfs_inode_info, vfs_inode);
+	return container_of(inode, struct hostfs_inode_info, vfs_inode);
 }
 
 #define FILE_HOSTFS_I(file) HOSTFS_I(file_inode(file))
@@ -235,6 +245,25 @@ static void hostfs_evict_inode(struct inode *inode)
 	}
 }
 
+static void hostfs_file_free_dentries(struct file *file)
+{
+	struct hostfs_dentry_list *entry;
+	struct list_head *list = file->private_data;
+
+	if (!list)
+		return;
+	file->private_data = NULL;
+
+	while ((entry = list_first_entry_or_null(list,
+						 struct hostfs_dentry_list,
+						 list))) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+
+	kfree(list);
+}
+
 static void hostfs_free_inode(struct inode *inode)
 {
 	kmem_cache_free(hostfs_inode_cache, HOSTFS_I(inode));
@@ -267,30 +296,100 @@ static const struct super_operations hostfs_sbops = {
 	.show_options	= hostfs_show_options,
 };
 
+static int hostfs_dentry_sort(void *priv,
+			      const struct list_head *a,
+			      const struct list_head *b)
+{
+	struct hostfs_dentry_list *hdl_a =
+		list_entry(a, struct hostfs_dentry_list, list);
+	struct hostfs_dentry_list *hdl_b =
+		list_entry(b, struct hostfs_dentry_list, list);
+
+	return strcmp(hdl_a->name, hdl_b->name);
+}
+
+static loff_t hostfs_seekdir(struct file *file, loff_t offset, int whence)
+{
+	struct inode *inode = file->f_mapping->host;
+
+	/* Seeking to the start discards the cache */
+	if (offset == 0 && whence == SEEK_SET)
+		hostfs_file_free_dentries(file);
+
+	return generic_file_llseek_size(file, offset, whence,
+					inode->i_sb->s_maxbytes,
+					i_size_read(inode));
+}
+
 static int hostfs_readdir(struct file *file, struct dir_context *ctx)
 {
-	void *dir;
-	char *name;
-	unsigned long long next, ino;
-	int error, len;
+	struct hostfs_dentry_list *hdl;
+	struct list_head *dentry_list = file->private_data;
 	unsigned int type;
+	loff_t pos;
+	int error;
 
-	name = dentry_name(file->f_path.dentry);
-	if (name == NULL)
-		return -ENOMEM;
-	dir = open_dir(name, &error);
-	__putname(name);
-	if (dir == NULL)
-		return -error;
-	next = ctx->pos;
-	seek_dir(dir, next);
-	while ((name = read_dir(dir, &next, &ino, &len, &type)) != NULL) {
-		if (!dir_emit(ctx, name, len, ino, type))
-			break;
-		ctx->pos = next;
+	if (!dentry_list) {
+		unsigned long long next, ino;
+		int len;
+		void *dir;
+		char *name;
+
+		dentry_list = kmalloc(sizeof(struct list_head), GFP_KERNEL);
+		if (!dentry_list)
+			return -ENOMEM;
+		INIT_LIST_HEAD(dentry_list);
+		file->private_data = dentry_list;
+
+		name = dentry_name(file->f_path.dentry);
+		if (!name) {
+			error = ENOMEM;
+			goto discard_cache;
+		}
+		dir = open_dir(name, &error);
+		__putname(name);
+		if (!dir)
+			goto discard_cache;
+
+		while ((name = read_dir(dir, &next, &ino, &len, &type))) {
+			hdl = kzalloc(struct_size(hdl, name, len + 1),
+				      GFP_KERNEL);
+			if (!hdl) {
+				error = ENOMEM;
+				goto discard_cache;
+			}
+
+			hdl->name_len = len;
+			hdl->ino = ino;
+			hdl->type = type;
+			memcpy(hdl->name, name, len + 1);
+			INIT_LIST_HEAD(&hdl->list);
+			list_add_tail(&hdl->list, dentry_list);
+		}
+
+		close_dir(dir);
+
+		list_sort(NULL, dentry_list, hostfs_dentry_sort);
 	}
-	close_dir(dir);
+
+	pos = -1;
+	list_for_each_entry(hdl, dentry_list, list) {
+		pos++;
+		if (pos < ctx->pos)
+			continue;
+
+		if (!dir_emit(ctx, hdl->name, hdl->name_len, hdl->ino,
+			      hdl->type))
+			break;
+
+		ctx->pos = pos + 1;
+	}
+
 	return 0;
+
+discard_cache:
+	hostfs_file_free_dentries(file);
+	return -error;
 }
 
 static int hostfs_open(struct inode *ino, struct file *file)
@@ -359,6 +458,13 @@ static int hostfs_file_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int hostfs_dir_release(struct inode *inode, struct file *file)
+{
+	hostfs_file_free_dentries(file);
+
+	return 0;
+}
+
 static int hostfs_fsync(struct file *file, loff_t start, loff_t end,
 			int datasync)
 {
@@ -389,10 +495,11 @@ static const struct file_operations hostfs_file_fops = {
 };
 
 static const struct file_operations hostfs_dir_fops = {
-	.llseek		= generic_file_llseek,
+	.llseek		= hostfs_seekdir,
 	.iterate_shared	= hostfs_readdir,
 	.read		= generic_read_dir,
 	.open		= hostfs_open,
+	.release	= hostfs_dir_release,
 	.fsync		= hostfs_fsync,
 };
 
-- 
2.56.1


