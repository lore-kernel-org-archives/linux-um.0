Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C42uO-0003xb-4K for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 12:42:40 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C42uM-0001Hn-2Y for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 12:42:39 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml-patch-2.6.7-2
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
	<20040827041056.A3753@almesberger.net>
In-Reply-To: <20040827041056.A3753@almesberger.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200409051844.13906.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aq2OBhl7zlKyiNf"
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
Date: Sun, 5 Sep 2004 21:35:54 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Werner Almesberger <wa@almesberger.net>, Jeff Dike <jdike@addtoit.com>


--Boundary-00=_aq2OBhl7zlKyiNf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 27 August 2004 09:10, Werner Almesberger wrote:
> Jeff Dike wrote:
> > hostfs and humfs are still somewhat dodgy on 2.6.
>
> Opening files for writing even if we only want to read them causes
> a number of problems: 
Well, that is simply not needed. The -ETXTBUSY check is not a fix, but a 
workaround. Old good hostfs didn't do this. Btw, 

I'm experiencing two more problems with 2.6.8.1:
- ls /mnt/host/dev/mapper/control returns EPERM errors, when trying to stat 
files; on the host, as the same user, or with 2.6.7-1 this does not happen.
Why? It seems like hostfs opens files even to just stat them. Or maybe, it 
implements a wrong permission check.

In fact, I'm not able to see the opening with strace (don't ask me why - I 
attach to the kernel thread, but I don't get the opening of the file; I got 
it only once, maybe ), but externfs_lookup calls init_inode which calls 
host_open_file! That's simply brain-damaged!

My guest searches for binaries on the host, and as a result I get file 
descriptors 0-1023 opened by UML! I'm not joking!

- Also (maybe related with calling iget(..., 0) ) I get this message on every 
unmount:

VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice 
day...

which also seems to mean that files are not closed when unmounting hostfs!

-Finally, for some reasons, the dev and rdev field returned by stat are 
screwed; when listing a device node on hostfs, it prints always the maj and 
min of the device containing the filesystem; i.e., file->rdev = host_stat -> 
dev instead of rdev. And I'm not able to see where the exchange happens.

Instead, my old fix for the same problem always worked flawlessly. I'm 
attaching it - it's for the old hostfs, but maybe it's better anyway.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_aq2OBhl7zlKyiNf
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-hostfs-fix-maj-min.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-hostfs-fix-maj-min.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.7-paolo/fs/hostfs/hostfs.h      |    2 +-
 uml-linux-2.6.7-paolo/fs/hostfs/hostfs_kern.c |   11 ++++++++---
 uml-linux-2.6.7-paolo/fs/hostfs/hostfs_user.c |   10 +++++++---
 3 files changed, 16 insertions(+), 7 deletions(-)

diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-fix-maj-min fs/hostfs/hostfs_kern.c
--- uml-linux-2.6.7/fs/hostfs/hostfs_kern.c~uml-hostfs-fix-maj-min	2004-08-16 16:18:00.564794256 +0200
+++ uml-linux-2.6.7-paolo/fs/hostfs/hostfs_kern.c	2004-08-16 16:35:36.759228296 +0200
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
--- uml-linux-2.6.7/fs/hostfs/hostfs_user.c~uml-hostfs-fix-maj-min	2004-08-16 16:18:00.591790152 +0200
+++ uml-linux-2.6.7-paolo/fs/hostfs/hostfs_user.c	2004-08-16 16:24:24.949358920 +0200
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
diff -puN fs/hostfs/hostfs.h~uml-hostfs-fix-maj-min fs/hostfs/hostfs.h
--- uml-linux-2.6.7/fs/hostfs/hostfs.h~uml-hostfs-fix-maj-min	2004-08-16 16:22:16.017959472 +0200
+++ uml-linux-2.6.7-paolo/fs/hostfs/hostfs.h	2004-08-16 16:22:39.607373336 +0200
@@ -38,7 +38,7 @@ extern int stat_file(const char *path, u
 		     int *blksize_out, unsigned long long *blocks_out);
 extern int access_file(char *path, int r, int w, int x);
 extern int open_file(char *path, int r, int w, int append);
-extern int file_type(const char *path, int *rdev);
+extern int file_type(const char *path, int *maj, int *min);
 extern void *open_dir(char *path, int *err_out);
 extern char *read_dir(void *stream, unsigned long long *pos, 
 		      unsigned long long *ino_out, int *len_out);
_

--Boundary-00=_aq2OBhl7zlKyiNf--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
