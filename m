Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 16 Mar 2015 12:41:05 +0100
Message-Id: <1426506079-26183-2-git-send-email-richard@nod.at>
In-Reply-To: <1426506079-26183-1-git-send-email-richard@nod.at>
References: <1426506079-26183-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 01/15] hostfs: hostfs_file_open: Switch to data locking model
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, richard@nod.at
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Instead of serializing hostfs_file_open() we can use
a per inode mutex to protect ->mode.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs_kern.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index fd62cae..104d58d 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -24,6 +24,7 @@ struct hostfs_inode_info {
 	int fd;
 	fmode_t mode;
 	struct inode vfs_inode;
+	struct mutex open_mutex;
 };
 
 static inline struct hostfs_inode_info *HOSTFS_I(struct inode *inode)
@@ -225,6 +226,7 @@ static struct inode *hostfs_alloc_inode(struct super_block *sb)
 	hi->fd = -1;
 	hi->mode = 0;
 	inode_init_once(&hi->vfs_inode);
+	mutex_init(&hi->open_mutex);
 	return &hi->vfs_inode;
 }
 
@@ -295,7 +297,6 @@ static int hostfs_readdir(struct file *file, struct dir_context *ctx)
 
 static int hostfs_file_open(struct inode *ino, struct file *file)
 {
-	static DEFINE_MUTEX(open_mutex);
 	char *name;
 	fmode_t mode = 0;
 	int err;
@@ -324,15 +325,15 @@ retry:
 	if (fd < 0)
 		return fd;
 
-	mutex_lock(&open_mutex);
+	mutex_lock(&HOSTFS_I(ino)->open_mutex);
 	/* somebody else had handled it first? */
 	if ((mode & HOSTFS_I(ino)->mode) == mode) {
-		mutex_unlock(&open_mutex);
+		mutex_unlock(&HOSTFS_I(ino)->open_mutex);
 		return 0;
 	}
 	if ((mode | HOSTFS_I(ino)->mode) != mode) {
 		mode |= HOSTFS_I(ino)->mode;
-		mutex_unlock(&open_mutex);
+		mutex_unlock(&HOSTFS_I(ino)->open_mutex);
 		close_file(&fd);
 		goto retry;
 	}
@@ -342,12 +343,12 @@ retry:
 		err = replace_file(fd, HOSTFS_I(ino)->fd);
 		close_file(&fd);
 		if (err < 0) {
-			mutex_unlock(&open_mutex);
+			mutex_unlock(&HOSTFS_I(ino)->open_mutex);
 			return err;
 		}
 	}
 	HOSTFS_I(ino)->mode = mode;
-	mutex_unlock(&open_mutex);
+	mutex_unlock(&HOSTFS_I(ino)->open_mutex);
 
 	return 0;
 }
-- 
2.3.2

