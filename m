Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EH04I-00055c-LW	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:22:58 -0700
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EH04G-0004E7-Js	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:22:58 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050918140941.31461.28784.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Subject: [uml-devel] [PATCH 01/12] HPPFS: procfs acquiring superblock cleanups
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
Date: Sun, 18 Sep 2005 16:09:43 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Al Viro

Cleanup dirty dricks to get a procfs superblock to wrap read/write
operations from procfs, and pass a mntget(proc_mnt) instead of NULL to
dentry_open.

Actually, since Al had suggested creating a vfsmount on our own, while I
found that proc_mnt already exists for this purpose and is initialized very
early, I use that, unless it is still NULL. We could probably drop this
check (but not the mntget() at each dentry_open(), since it expects this,
and can mntput() on error).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hppfs/hppfs_kern.c |   38 ++++++++++++++++++++++++--------------
 1 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -13,6 +13,7 @@
 #include <linux/ctype.h>
 #include <linux/dcache.h>
 #include <linux/statfs.h>
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 #include <asm/fcntl.h>
 #include "os.h"
@@ -44,6 +45,7 @@ static inline struct hppfs_inode_info *H
 #define HPPFS_SUPER_MAGIC 0xb00000ee
 
 static struct super_operations hppfs_sbops;
+static struct vfsmount * proc_submnt;
 
 static int is_pid(struct dentry *dentry)
 {
@@ -472,7 +474,7 @@ static int hppfs_open(struct inode *inod
 	proc_dentry = HPPFS_I(inode)->proc_dentry;
 
 	/* XXX This isn't closed anywhere */
-	data->proc_file = dentry_open(dget(proc_dentry), NULL,
+	data->proc_file = dentry_open(dget(proc_dentry), mntget(proc_submnt),
 				      file_mode(file->f_mode));
 	err = PTR_ERR(data->proc_file);
 	if(IS_ERR(data->proc_file))
@@ -526,7 +528,7 @@ static int hppfs_dir_open(struct inode *
 		goto out;
 
 	proc_dentry = HPPFS_I(inode)->proc_dentry;
-	data->proc_file = dentry_open(dget(proc_dentry), NULL,
+	data->proc_file = dentry_open(dget(proc_dentry), mntget(proc_submnt),
 				      file_mode(file->f_mode));
 	err = PTR_ERR(data->proc_file);
 	if(IS_ERR(data->proc_file))
@@ -665,7 +667,7 @@ static int hppfs_readlink(struct dentry 
 	int ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
-	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);
+	proc_file = dentry_open(dget(proc_dentry), mntget(proc_submnt), O_RDONLY);
 	if (IS_ERR(proc_file))
 		return PTR_ERR(proc_file);
 
@@ -683,7 +685,7 @@ static void* hppfs_follow_link(struct de
 	void *ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
-	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);
+	proc_file = dentry_open(dget(proc_dentry), mntget(proc_submnt), O_RDONLY);
 	if (IS_ERR(proc_file))
 		return proc_file;
 
@@ -726,20 +728,12 @@ static int init_inode(struct inode *inod
 static int hppfs_fill_super(struct super_block *sb, void *d, int silent)
 {
 	struct inode *root_inode;
-	struct file_system_type *procfs;
 	struct super_block *proc_sb;
 	int err;
 
 	err = -ENOENT;
-	procfs = get_fs_type("proc");
-	if(procfs == NULL)
-		goto out;
-
-	if(list_empty(&procfs->fs_supers))
-		goto out;
 
-	proc_sb = list_entry(procfs->fs_supers.next, struct super_block,
-			     s_instances);
+	proc_sb = proc_submnt->mnt_sb;
 
 	sb->s_blocksize = 1024;
 	sb->s_blocksize_bits = 10;
@@ -786,12 +780,28 @@ static struct file_system_type hppfs_typ
 
 static int __init init_hppfs(void)
 {
-	return(register_filesystem(&hppfs_type));
+	int ret;
+	proc_submnt = do_kern_mount("proc", 0, "proc", NULL);
+
+	if (IS_ERR(proc_submnt)) {
+		ret = PTR_ERR(proc_submnt);
+		goto err;
+	}
+
+	ret = register_filesystem(&hppfs_type);
+	if (ret)
+		goto err_put;
+	return 0;
+err_put:
+	mntput(proc_submnt);
+err:
+	return ret;
 }
 
 static void __exit exit_hppfs(void)
 {
 	unregister_filesystem(&hppfs_type);
+	mntput(proc_submnt);
 }
 
 module_init(init_hppfs)



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
