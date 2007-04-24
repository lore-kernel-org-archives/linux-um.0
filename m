Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgLxV-00076h-U0 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 07:25:34 -0700
Received: from an-out-0708.google.com ([209.85.132.240])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgLxS-0003aj-Fl
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 07:25:33 -0700
Received: by an-out-0708.google.com with SMTP id d40so1855704and
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 24 Apr 2007 07:25:29 -0700 (PDT)
From: Alberto Bertogli <albertito@gmail.com>
Date: Tue, 24 Apr 2007 11:26:26 -0300
Message-Id: <11774247864122-git-send-email-albertito@gmail.com>
Subject: [uml-devel] [PATCH] Make hostfs_setattr() support operations on
	closed files.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alberto Bertogli <albertito@gmail.com>

This patch allows hostfs_setattr() to work on closed files by calling
set_attr() (the userspace part) with the inode's fd.

Without this, applications that depend on doing attribute changes to
closed files will fail.

It works by using the fd versions instead of the path ones (for example
fchmod() instead of chmod(), fchown() instead of chown()) when an fd is
available.


Signed-off-by: Alberto Bertogli <albertito@gmail.com>
---

I hit this using hostfs as my root device and trying to do dpkg-reconfigure
locales, which called locale-gen which did something like:

	fd = open("f1.tmp");
	write(fd, ...);
	link("f1.tmp", "f1");
	unlink("f1.tmp");
	fchmod(fd, 0644);

And fchmod failed with ENOENT.

I compiled this and tested with locale-gen and a testcase I wrote for this.

I was also worried about the semantics, for instance, the outcome of:

	fd = open("f1.tmp");
	write(fd, ...);
	link("f1.tmp", "f1");
	unlink("f1.tmp");
	fd2 = open("f1.tmp");
	fchmod(fd, 0644);

In the host fchmod() changes f1 and not f1.tmp, but maybe the open() in the
middle got hostfs confused. Luckily this is not the case and it works fine;
but as I'm not familiar with hostfs there may be other issues.


 fs/hostfs/hostfs.h      |    4 +-
 fs/hostfs/hostfs_kern.c |   10 ++++-
 fs/hostfs/hostfs_user.c |   89 ++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 86 insertions(+), 17 deletions(-)

diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index 70543b1..d8850c7 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -55,7 +55,7 @@ extern int stat_file(const char *path, unsigned long long *inode_out,
 		     int *mode_out, int *nlink_out, int *uid_out, int *gid_out,
 		     unsigned long long *size_out, struct timespec *atime_out,
 		     struct timespec *mtime_out, struct timespec *ctime_out,
-		     int *blksize_out, unsigned long long *blocks_out);
+		     int *blksize_out, unsigned long long *blocks_out, int fd);
 extern int access_file(char *path, int r, int w, int x);
 extern int open_file(char *path, int r, int w, int append);
 extern int file_type(const char *path, int *maj, int *min);
@@ -71,7 +71,7 @@ extern int lseek_file(int fd, long long offset, int whence);
 extern int fsync_file(int fd, int datasync);
 extern int file_create(char *name, int ur, int uw, int ux, int gr,
 		       int gw, int gx, int or, int ow, int ox);
-extern int set_attr(const char *file, struct hostfs_iattr *attrs);
+extern int set_attr(const char *file, struct hostfs_iattr *attrs, int fd);
 extern int make_symlink(const char *from, const char *to);
 extern int unlink_file(const char *file);
 extern int do_mkdir(const char *file, int mode);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index fd301a9..c704d9c 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -147,7 +147,7 @@ static int read_name(struct inode *ino, char *name)
 
 	err = stat_file(name, &i_ino, &i_mode, &i_nlink, &ino->i_uid,
 			&ino->i_gid, &i_size, &ino->i_atime, &ino->i_mtime,
-			&ino->i_ctime, &i_blksize, &i_blocks);
+			&ino->i_ctime, &i_blksize, &i_blocks, -1);
 	if(err)
 		return(err);
 
@@ -817,8 +817,14 @@ int hostfs_permission(struct inode *ino, int desired, struct nameidata *nd)
 int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct hostfs_iattr attrs;
+	struct hostfs_inode_info *iinfo;
 	char *name;
 	int err;
+	int fd = -1;
+
+	iinfo = HOSTFS_I(dentry->d_inode);
+	if (iinfo != NULL)
+		fd = iinfo->fd;
 
 	err = inode_change_ok(dentry->d_inode, attr);
 	if (err)
@@ -864,7 +870,7 @@ int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 	name = dentry_name(dentry, 0);
 	if(name == NULL) return(-ENOMEM);
-	err = set_attr(name, &attrs);
+	err = set_attr(name, &attrs, fd);
 	kfree(name);
 	if(err)
 		return(err);
diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
index 1ed5ea3..e3b4d7c 100644
--- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -21,12 +21,16 @@ int stat_file(const char *path, unsigned long long *inode_out, int *mode_out,
 	      int *nlink_out, int *uid_out, int *gid_out,
 	      unsigned long long *size_out, struct timespec *atime_out,
 	      struct timespec *mtime_out, struct timespec *ctime_out,
-	      int *blksize_out, unsigned long long *blocks_out)
+	      int *blksize_out, unsigned long long *blocks_out, int fd)
 {
 	struct stat64 buf;
 
-	if(lstat64(path, &buf) < 0)
+	if(fd >= 0) {
+		if (fstat64(fd, &buf) < 0)
+			return(-errno);
+	} else if(lstat64(path, &buf) < 0) {
 		return(-errno);
+	}
 
 	if(inode_out != NULL) *inode_out = buf.st_ino;
 	if(mode_out != NULL) *mode_out = buf.st_mode;
@@ -202,58 +206,117 @@ int file_create(char *name, int ur, int uw, int ux, int gr,
 	return(fd);
 }
 
-int set_attr(const char *file, struct hostfs_iattr *attrs)
+int set_attr(const char *file, struct hostfs_iattr *attrs, int fd)
 {
 	struct utimbuf buf;
 	int err, ma;
 
 	if(attrs->ia_valid & HOSTFS_ATTR_MODE){
-		if(chmod(file, attrs->ia_mode) != 0) return(-errno);
+		if(fd >= 0){
+			if(fchmod(fd, attrs->ia_mode) != 0) return(-errno);
+		} else if(chmod(file, attrs->ia_mode) != 0){
+			return(-errno);
+		}
 	}
 	if(attrs->ia_valid & HOSTFS_ATTR_UID){
-		if(chown(file, attrs->ia_uid, -1)) return(-errno);
+		if(fd >= 0) {
+			if (fchown(fd, attrs->ia_uid, -1)) return(-errno);
+		} else if(chown(file, attrs->ia_uid, -1)){
+			return(-errno);
+		}
 	}
 	if(attrs->ia_valid & HOSTFS_ATTR_GID){
-		if(chown(file, -1, attrs->ia_gid)) return(-errno);
+		if(fd >= 0){
+			if (fchown(fd, -1, attrs->ia_gid)) return(-errno);
+		} else if(chown(file, -1, attrs->ia_gid)){
+			return(-errno);
+		}
 	}
 	if(attrs->ia_valid & HOSTFS_ATTR_SIZE){
-		if(truncate(file, attrs->ia_size)) return(-errno);
+		if(fd >= 0){
+			if (ftruncate(fd, attrs->ia_size)) return(-errno);
+		} else if(truncate(file, attrs->ia_size)) {
+			return(-errno);
+		}
 	}
 	ma = HOSTFS_ATTR_ATIME_SET | HOSTFS_ATTR_MTIME_SET;
 	if((attrs->ia_valid & ma) == ma){
+		struct timeval times[2];
+
 		buf.actime = attrs->ia_atime.tv_sec;
 		buf.modtime = attrs->ia_mtime.tv_sec;
-		if(utime(file, &buf) != 0) return(-errno);
+
+		/* atime */
+		times[0].tv_sec = attrs->ia_atime.tv_sec;
+		times[0].tv_usec = attrs->ia_atime.tv_nsec * 1000;
+
+		/* mtime */
+		times[1].tv_sec = attrs->ia_mtime.tv_sec;
+		times[1].tv_usec = attrs->ia_mtime.tv_nsec * 1000;
+
+		if(fd >= 0){
+			if(futimes(fd, times) != 0)
+				return(-errno);
+		} else if(utime(file, &buf) != 0){
+			return(-errno);
+		}
 	}
 	else {
 		struct timespec ts;
+		struct timeval times[2];
 
 		if(attrs->ia_valid & HOSTFS_ATTR_ATIME_SET){
 			err = stat_file(file, NULL, NULL, NULL, NULL, NULL,
-					NULL, NULL, &ts, NULL, NULL, NULL);
+					NULL, NULL, &ts, NULL, NULL, NULL, fd);
 			if(err != 0)
 				return(err);
 			buf.actime = attrs->ia_atime.tv_sec;
 			buf.modtime = ts.tv_sec;
-			if(utime(file, &buf) != 0)
+
+			/* atime */
+			times[0].tv_sec = attrs->ia_atime.tv_sec;
+			times[0].tv_usec = attrs->ia_atime.tv_nsec * 1000;
+
+			/* mtime */
+			times[1].tv_sec = ts.tv_sec;
+			times[1].tv_usec = ts.tv_nsec * 1000;
+
+			if(fd >= 0){
+				if(futimes(fd, times) != 0)
+					return(-errno);
+			} else if(utime(file, &buf) != 0){
 				return(-errno);
+			}
 		}
 		if(attrs->ia_valid & HOSTFS_ATTR_MTIME_SET){
 			err = stat_file(file, NULL, NULL, NULL, NULL, NULL,
-					NULL, &ts, NULL, NULL, NULL, NULL);
+					NULL, &ts, NULL, NULL, NULL, NULL, fd);
 			if(err != 0)
 				return(err);
 			buf.actime = ts.tv_sec;
 			buf.modtime = attrs->ia_mtime.tv_sec;
-			if(utime(file, &buf) != 0)
+
+			/* atime */
+			times[0].tv_sec = ts.tv_sec;
+			times[0].tv_usec = ts.tv_nsec * 1000;
+
+			/* mtime */
+			times[1].tv_sec = attrs->ia_mtime.tv_sec;
+			times[1].tv_usec = attrs->ia_mtime.tv_nsec * 1000;
+
+			if(fd >= 0){
+				if(futimes(fd, times) != 0)
+					return(-errno);
+			} else if(utime(file, &buf) != 0){
 				return(-errno);
+			}
 		}
 	}
 	if(attrs->ia_valid & HOSTFS_ATTR_CTIME) ;
 	if(attrs->ia_valid & (HOSTFS_ATTR_ATIME | HOSTFS_ATTR_MTIME)){
 		err = stat_file(file, NULL, NULL, NULL, NULL, NULL, NULL,
 				&attrs->ia_atime, &attrs->ia_mtime, NULL,
-				NULL, NULL);
+				NULL, NULL, fd);
 		if(err != 0) return(err);
 	}
 	return(0);
-- 
1.5.1.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
