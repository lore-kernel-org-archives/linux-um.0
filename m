Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFcwl-0001Av-0K for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 11:24:59 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CFcwi-0008I1-5F for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Oct 2004 11:24:58 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041007182257.2D5B7D85E@zion.localdomain>
Subject: [uml-devel] [patch 2/2] uml: fix major & minor handling in hostfs
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 07 Oct 2004 20:22:57 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Currently hostfs passes the rdev value from stat() on the host as rdev value
to return to stat() on the guest; but we cannot pass rdev as is because glibc
and the kernel disagree about its definition. So we must decode it in a
major/minor couple with glibc macros and re-encode it in kernelspace code.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/fs/hostfs/hostfs.h      |    2 +-
 linux-2.6.9-current-paolo/fs/hostfs/hostfs_kern.c |   11 ++++++++---
 linux-2.6.9-current-paolo/fs/hostfs/hostfs_user.c |   10 +++++++---
 3 files changed, 16 insertions(+), 7 deletions(-)

diff -puN fs/hostfs/hostfs.h~uml-hostfs-fix-maj-min fs/hostfs/hostfs.h
--- linux-2.6.9-current/fs/hostfs/hostfs.h~uml-hostfs-fix-maj-min	2004-10-07 17:38:01.759274464 +0200
+++ linux-2.6.9-current-paolo/fs/hostfs/hostfs.h	2004-10-07 17:38:01.763273856 +0200
@@ -38,7 +38,7 @@ extern int stat_file(const char *path, u
 		     int *blksize_out, unsigned long long *blocks_out);
 extern int access_file(char *path, int r, int w, int x);
 extern int open_file(char *path, int r, int w, int append);
-extern int file_type(const char *path, int *rdev);
+extern int file_type(const char *path, int *maj, int *min);
 extern void *open_dir(char *path, int *err_out);
 extern char *read_dir(void *stream, unsigned long long *pos,
 		      unsigned long long *ino_out, int *len_out);
diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-fix-maj-min fs/hostfs/hostfs_kern.c
--- linux-2.6.9-current/fs/hostfs/hostfs_kern.c~uml-hostfs-fix-maj-min	2004-10-07 17:38:01.760274312 +0200
+++ linux-2.6.9-current-paolo/fs/hostfs/hostfs_kern.c	2004-10-07 17:38:01.764273704 +0200
@@ -18,6 +18,7 @@
 #include <linux/buffer_head.h>
 #include <linux/root_dev.h>
 #include <linux/statfs.h>
+#include <linux/kdev_t.h>
 #include <asm/uaccess.h>
 #include "hostfs.h"
 #include "kern_util.h"
@@ -230,7 +231,7 @@ static int read_inode(struct inode *ino)
 	if(name == NULL)
 		goto out;
 
-	if(file_type(name, NULL) == OS_TYPE_SYMLINK){
+	if(file_type(name, NULL, NULL) == OS_TYPE_SYMLINK){
 		name = follow_link(name);
 		if(IS_ERR(name)){
 			err = PTR_ERR(name);
@@ -523,13 +524,17 @@ static struct address_space_operations h
 static int init_inode(struct inode *inode, struct dentry *dentry)
 {
 	char *name;
-	int type, err = -ENOMEM, rdev;
+	int type, err = -ENOMEM;
+	int maj, min;
+	dev_t rdev = 0;
 
 	if(dentry){
 		name = dentry_name(dentry, 0);
 		if(name == NULL)
 			goto out;
-		type = file_type(name, &rdev);
+		type = file_type(name, &maj, &min);
+		/*Reencode maj and min with the kernel encoding.*/
+		rdev = MKDEV(maj, min);
 		kfree(name);
 	}
 	else type = OS_TYPE_DIR;
diff -puN fs/hostfs/hostfs_user.c~uml-hostfs-fix-maj-min fs/hostfs/hostfs_user.c
--- linux-2.6.9-current/fs/hostfs/hostfs_user.c~uml-hostfs-fix-maj-min	2004-10-07 17:38:01.761274160 +0200
+++ linux-2.6.9-current-paolo/fs/hostfs/hostfs_user.c	2004-10-07 17:38:01.764273704 +0200
@@ -54,14 +54,18 @@ int stat_file(const char *path, unsigned
 	return(0);
 }
 
-int file_type(const char *path, int *rdev)
+int file_type(const char *path, int *maj, int *min)
 {
  	struct stat64 buf;
 
 	if(lstat64(path, &buf) < 0)
 		return(-errno);
-	if(rdev != NULL)
-		*rdev = buf.st_rdev;
+	/*We cannot pass rdev as is because glibc and the kernel disagree
+	 *about its definition.*/
+	if(maj != NULL)
+		*maj = major(buf.st_rdev);
+	if(min != NULL)
+		*min = minor(buf.st_rdev);
 
 	if(S_ISDIR(buf.st_mode)) return(OS_TYPE_DIR);
 	else if(S_ISLNK(buf.st_mode)) return(OS_TYPE_SYMLINK);
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
