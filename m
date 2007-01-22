Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H95Y7-0001bH-0m for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Jan 2007 12:13:51 -0800
Received: from allen.werkleitz.de ([80.190.251.108])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H95Y4-0002fi-8O
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Jan 2007 12:13:50 -0800
Date: Mon, 22 Jan 2007 21:13:17 +0100
From: Johannes Stezenbach <js@linuxtv.org>
Message-ID: <20070122201317.GA8594@linuxtv.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] [UML] fix mknod
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@karaya.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Hi,

I was playing with user-mode Linux and found that mknod creates
devices node in hostfs with wrong major/minor numbers.
The patch below fixes it for me.

Johannes


---
mknod() is broken on UML because userspace has differernt
dev_t size and encoding than kernel.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>


diff -rup linux-2.6.19.orig/fs/hostfs/hostfs.h linux-2.6.19/fs/hostfs/hostfs.h
--- linux-2.6.19.orig/fs/hostfs/hostfs.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/fs/hostfs/hostfs.h	2007-01-22 20:53:23.000000000 +0100
@@ -76,7 +76,17 @@ extern int make_symlink(const char *from
 extern int unlink_file(const char *file);
 extern int do_mkdir(const char *file, int mode);
 extern int do_rmdir(const char *file);
-extern int do_mknod(const char *file, int mode, int dev);
+
+/* gnu_dev_makedev from glibc's sys/sysmacros.h */
+static inline unsigned long long makedev(unsigned int major, unsigned int minor)
+{
+	return ((minor & 0xff) | ((major & 0xfff) << 8)
+		| (((unsigned long long int) (minor & ~0xff)) << 12)
+		| (((unsigned long long int) (major & ~0xfff)) << 32));
+
+}
+
+extern int do_mknod(const char *file, int mode, unsigned long long dev);
 extern int link_file(const char *from, const char *to);
 extern int do_readlink(char *file, char *buf, int size);
 extern int rename_file(char *from, char *to);
diff -rup linux-2.6.19.orig/fs/hostfs/hostfs_kern.c linux-2.6.19/fs/hostfs/hostfs_kern.c
--- linux-2.6.19.orig/fs/hostfs/hostfs_kern.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/fs/hostfs/hostfs_kern.c	2007-01-22 20:57:58.000000000 +0100
@@ -740,6 +740,7 @@ int hostfs_mknod(struct inode *dir, stru
 	struct inode *inode;
 	char *name;
 	int err = -ENOMEM;
+	unsigned long long udev;
 
 	inode = iget(dir->i_sb, 0);
 	if(inode == NULL)
@@ -755,7 +756,9 @@ int hostfs_mknod(struct inode *dir, stru
 		goto out_put;
 
 	init_special_inode(inode, mode, dev);
-	err = do_mknod(name, mode, dev);
+	/* userspace has different dev_t encoding than kernel... */
+	udev = makedev(MAJOR(dev), MINOR(dev));
+	err = do_mknod(name, mode, udev);
 	if(err)
 		goto out_free;
 
diff -rup linux-2.6.19.orig/fs/hostfs/hostfs_user.c linux-2.6.19/fs/hostfs/hostfs_user.c
--- linux-2.6.19.orig/fs/hostfs/hostfs_user.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/fs/hostfs/hostfs_user.c	2007-01-22 20:54:37.000000000 +0100
@@ -295,7 +295,7 @@ int do_rmdir(const char *file)
 	return(0);
 }
 
-int do_mknod(const char *file, int mode, int dev)
+int do_mknod(const char *file, int mode, unsigned long long dev)
 {
 	int err;
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
