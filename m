Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 16 Mar 2015 12:41:19 +0100
Message-Id: <1426506079-26183-16-git-send-email-richard@nod.at>
In-Reply-To: <1426506079-26183-1-git-send-email-richard@nod.at>
References: <1426506079-26183-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 15/15] hostfs: No need to box and later unbox the file mode
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, richard@nod.at
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

There is really no point in having a function with 10
arguments.

Reported-by: Daniel Walter <d.walter@0x90.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs.h      |  3 +--
 fs/hostfs/hostfs_kern.c |  5 +----
 fs/hostfs/hostfs_user.c | 17 +++--------------
 3 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index 4fcd40d..493262e 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -77,8 +77,7 @@ extern int write_file(int fd, unsigned long long *offset, const char *buf,
 		      int len);
 extern int lseek_file(int fd, long long offset, int whence);
 extern int fsync_file(int fd, int datasync);
-extern int file_create(char *name, int ur, int uw, int ux, int gr,
-		       int gw, int gx, int or, int ow, int ox);
+extern int file_create(char *name, int mode);
 extern int set_attr(const char *file, struct hostfs_iattr *attrs, int fd);
 extern int make_symlink(const char *from, const char *to);
 extern int unlink_file(const char *file);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index f82f98a5..e77da44 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -582,10 +582,7 @@ static int hostfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	if (name == NULL)
 		goto out_put;
 
-	fd = file_create(name,
-			 mode & S_IRUSR, mode & S_IWUSR, mode & S_IXUSR,
-			 mode & S_IRGRP, mode & S_IWGRP, mode & S_IXGRP,
-			 mode & S_IROTH, mode & S_IWOTH, mode & S_IXOTH);
+	fd = file_create(name, mode & S_IFMT);
 	if (fd < 0)
 		error = fd;
 	else
diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
index 9765dab..34ab81b 100644
--- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -175,21 +175,10 @@ void close_dir(void *stream)
 	closedir(stream);
 }
 
-int file_create(char *name, int ur, int uw, int ux, int gr,
-		int gw, int gx, int or, int ow, int ox)
+int file_create(char *name, int mode)
 {
-	int mode, fd;
-
-	mode = 0;
-	mode |= ur ? S_IRUSR : 0;
-	mode |= uw ? S_IWUSR : 0;
-	mode |= ux ? S_IXUSR : 0;
-	mode |= gr ? S_IRGRP : 0;
-	mode |= gw ? S_IWGRP : 0;
-	mode |= gx ? S_IXGRP : 0;
-	mode |= or ? S_IROTH : 0;
-	mode |= ow ? S_IWOTH : 0;
-	mode |= ox ? S_IXOTH : 0;
+	int fd;
+
 	fd = open64(name, O_CREAT | O_RDWR, mode);
 	if (fd < 0)
 		return -errno;
-- 
2.3.2

