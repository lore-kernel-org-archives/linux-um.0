Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AB3C3064D
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 07:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8U+T+OtYRWj69A4KjvK0CvBsqAefUQB6hbCulnBHC+I=; b=hA50iGbwLDutYvT7acdYN5O9UV
	Yo4XOMsbGCSnIkNkBrrz0DKY5wjpwM/tfK8pqEgAe1pH5kY3O4KMwWSlzxy8AqkafguEUeqS/kHX6
	qDeiFvI6kCp6bAok1uvaAZGTFEpzAwwwRvUHG9pbgAdVdZ+UAT5WU5XEP0CwYBRQNwxmmQ21Sg0sq
	0u4GMlkHgjnBDVQ2ffPU7Q24GRd8vZfbcV/kl+GT6AnkTZJpbPelvMhpTfeJjKqSAIZSKY7S4csXM
	/7Oar6IhgZi3CqLowPL5iTWyPqer0t8U/8jW4rhxK++PYEvKMucik4E/5j8EXQ1FSzOs8hC6U3mdb
	6fpKBX/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOXsm-00000005r0Z-4A9Y;
	Tue, 02 Jul 2024 07:24:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOXsj-00000005r03-3fsn
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 07:24:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=8U+T+OtYRWj69A4KjvK0CvBsqAefUQB6hbCulnBHC+I=; t=1719905093; x=1721114693; 
	b=VZcqZuOPv0fdsdtjbQSE/KXODKp/3qPt7Q8Q2owMf/xHQMYWxuPgKh2KtfAp6wKTZjXP0yyzJ8v
	XZ7/XMvS6/qqJGRalPBUUnHdYaiBsN6vLMIHaLD+mOh+35qp0iBQKE5CwfznXS3WN9UNetd/tsDcQ
	297dK35FOOhBbqDzKpxlNT8jCd9vbLVM/EXJwxi0ME85Wjw3mZ6MdqHGF7qdzqfAU1Y/JNURR7daD
	6AX9366glrOxQz6eWbsw9Z+l/12VxRJd0ZJHX6GsWIVmsAvHln6foDYOywrkbFBYgwkMFfpSlWpYA
	C20iWB+6a9PWQ/c+R6Hoxiy5HG/gtexHRkNw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOXsg-00000004rX2-2KVI;
	Tue, 02 Jul 2024 09:24:50 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] hostfs: fix dev_t handling
Date: Tue,  2 Jul 2024 09:24:41 +0200
Message-ID: <20240702092440.acc960585dd5.Id0767e12f562a69c6cd3c3262dc3d765db350cf6@changeid>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_002454_149874_21EE768B 
X-CRM114-Status: GOOD (  15.10  )
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

From: Johannes Berg <johannes.berg@intel.com>

dev_t is a kernel type and may have different definitions
in kernel and userspace. On 32-bit x86 this currently makes
the stat structure being 4 bytes longer in the user code,
causing stack corruption.

However, this is (potentially) not the only problem, since
dev_t is a different type on user/kernel side, so we don't
know that the major/minor encoding isn't also different.
Decode/encode it instead to address both problems.

Fixes: 74ce793bcbde ("hostfs: Fix ephemeral inodes")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/hostfs/hostfs.h      |  7 ++++---
 fs/hostfs/hostfs_kern.c | 10 ++++++----
 fs/hostfs/hostfs_user.c |  7 ++++---
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index 0239e3af3945..8b39c15c408c 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -63,9 +63,10 @@ struct hostfs_stat {
 	struct hostfs_timespec atime, mtime, ctime;
 	unsigned int blksize;
 	unsigned long long blocks;
-	unsigned int maj;
-	unsigned int min;
-	dev_t dev;
+	struct {
+		unsigned int maj;
+		unsigned int min;
+	} rdev, dev;
 };
 
 extern int stat_file(const char *path, struct hostfs_stat *p, int fd);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index a73d27c4dd58..2c4d503a62e0 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -530,10 +530,11 @@ static int hostfs_inode_update(struct inode *ino, const struct hostfs_stat *st)
 static int hostfs_inode_set(struct inode *ino, void *data)
 {
 	struct hostfs_stat *st = data;
-	dev_t rdev;
+	dev_t dev, rdev;
 
 	/* Reencode maj and min with the kernel encoding.*/
-	rdev = MKDEV(st->maj, st->min);
+	rdev = MKDEV(st->rdev.maj, st->rdev.min);
+	dev = MKDEV(st->dev.maj, st->dev.min);
 
 	switch (st->mode & S_IFMT) {
 	case S_IFLNK:
@@ -559,7 +560,7 @@ static int hostfs_inode_set(struct inode *ino, void *data)
 		return -EIO;
 	}
 
-	HOSTFS_I(ino)->dev = st->dev;
+	HOSTFS_I(ino)->dev = dev;
 	ino->i_ino = st->ino;
 	ino->i_mode = st->mode;
 	return hostfs_inode_update(ino, st);
@@ -568,8 +569,9 @@ static int hostfs_inode_set(struct inode *ino, void *data)
 static int hostfs_inode_test(struct inode *inode, void *data)
 {
 	const struct hostfs_stat *st = data;
+	dev_t dev = MKDEV(st->dev.maj, st->dev.min);
 
-	return inode->i_ino == st->ino && HOSTFS_I(inode)->dev == st->dev;
+	return inode->i_ino == st->ino && HOSTFS_I(inode)->dev == dev;
 }
 
 static struct inode *hostfs_iget(struct super_block *sb, char *name)
diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
index 840619e39a1a..97e9c40a9448 100644
--- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -34,9 +34,10 @@ static void stat64_to_hostfs(const struct stat64 *buf, struct hostfs_stat *p)
 	p->mtime.tv_nsec = 0;
 	p->blksize = buf->st_blksize;
 	p->blocks = buf->st_blocks;
-	p->maj = os_major(buf->st_rdev);
-	p->min = os_minor(buf->st_rdev);
-	p->dev = buf->st_dev;
+	p->rdev.maj = os_major(buf->st_rdev);
+	p->rdev.min = os_minor(buf->st_rdev);
+	p->dev.maj = os_major(buf->st_dev);
+	p->dev.min = os_minor(buf->st_dev);
 }
 
 int stat_file(const char *path, struct hostfs_stat *p, int fd)
-- 
2.45.2


