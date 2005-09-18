Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EH04N-000566-Aq	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:23:03 -0700
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EH04L-0004F1-MQ	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:23:03 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050918140959.31461.51318.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Subject: [uml-devel] [PATCH 08/12] HPPFS: add sparse annotations
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
Date: Sun, 18 Sep 2005 16:10:00 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add sparse annotations and add some missing "static" to hppfs_kern.c - no
bug fixed in this patch. There's still a warning - but sparse can't
understand set_fs(KERNEL_DS) it seems.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hppfs/hppfs_kern.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -104,7 +104,7 @@ static char *dentry_name(struct dentry *
 	return(name);
 }
 
-struct dentry_operations hppfs_dentry_ops = {
+static struct dentry_operations hppfs_dentry_ops = {
 };
 
 static int file_removed(struct dentry *dentry, const char *file)
@@ -226,10 +226,10 @@ static struct inode_operations hppfs_fil
  * We also know if we're called from userspace from is_user, which is used for
  * set_fs(). I'm leaving this redundancy to bite any wrong caller.
  */
-static ssize_t read_proc(struct file *file, char *buf, ssize_t count,
+static ssize_t read_proc(struct file *file, char __user *buf, ssize_t count,
 			 loff_t *ppos, int is_user)
 {
-	ssize_t (*read)(struct file *, char *, size_t, loff_t *);
+	ssize_t (*read)(struct file *, char __user *, size_t, loff_t *);
 	ssize_t n;
 	mm_segment_t old_fs;
 
@@ -256,7 +256,7 @@ static ssize_t read_proc(struct file *fi
 	return n;
 }
 
-static ssize_t hppfs_read_file(int fd, char *buf, ssize_t count)
+static ssize_t hppfs_read_file(int fd, char __user *buf, ssize_t count)
 {
 	ssize_t n;
 	int cur, ret;
@@ -296,7 +296,7 @@ out:
 	return n;
 }
 
-static ssize_t hppfs_read(struct file *file, char *buf, size_t count,
+static ssize_t hppfs_read(struct file *file, char __user *buf, size_t count,
 			  loff_t *ppos)
 {
 	struct hppfs_private *hppfs = file->private_data;
@@ -353,12 +353,12 @@ static ssize_t hppfs_read(struct file *f
 	return written;
 }
 
-static ssize_t hppfs_write(struct file *file, const char *buf, size_t len,
+static ssize_t hppfs_write(struct file *file, const char __user *buf, size_t len,
 			   loff_t *ppos)
 {
 	struct hppfs_private *data = file->private_data;
 	struct file *proc_file = data->proc_file;
-	ssize_t (*write)(struct file *, const char *, size_t, loff_t *);
+	ssize_t (*write)(struct file *, const char __user *, size_t, loff_t *);
 	int err;
 
 	write = proc_file->f_dentry->d_inode->i_fop->write;
@@ -710,7 +710,7 @@ static struct inode *hppfs_alloc_inode(s
 	return(&hi->vfs_inode);
 }
 
-void hppfs_delete_inode(struct inode *ino)
+static void hppfs_delete_inode(struct inode *ino)
 {
 	clear_inode(ino);
 }
@@ -728,11 +728,11 @@ static struct super_operations hppfs_sbo
 	.statfs		= hppfs_statfs,
 };
 
-static int hppfs_readlink(struct dentry *dentry, char *buffer, int buflen)
+static int hppfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
 	struct file *proc_file;
 	struct dentry *proc_dentry;
-	int (*readlink)(struct dentry *, char *, int);
+	int (*readlink)(struct dentry *, char __user *, int);
 	int ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
