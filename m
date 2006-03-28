Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FON9O-0005ah-Ps for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:58:58 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FON9O-0005Aj-KL
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:58:59 -0800
Message-Id: <200603282300.k2SN0Fci022997@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 8/10] UML - __user annotations
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
Date: Tue, 28 Mar 2006 18:00:15 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk

From: Al Viro <viro@zeniv.linux.org.uk>

uml: __user annotations (hppfs)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

 fs/hppfs/hppfs_kern.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
index a44dc58..8469826 100644
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -216,10 +216,10 @@ static struct dentry *hppfs_lookup(struc
 static struct inode_operations hppfs_file_iops = {
 };
 
-static ssize_t read_proc(struct file *file, char *buf, ssize_t count,
+static ssize_t read_proc(struct file *file, char __user *buf, ssize_t count,
 			 loff_t *ppos, int is_user)
 {
-	ssize_t (*read)(struct file *, char *, size_t, loff_t *);
+	ssize_t (*read)(struct file *, char __user *, size_t, loff_t *);
 	ssize_t n;
 
 	read = file->f_dentry->d_inode->i_fop->read;
@@ -236,7 +236,7 @@ static ssize_t read_proc(struct file *fi
 	return n;
 }
 
-static ssize_t hppfs_read_file(int fd, char *buf, ssize_t count)
+static ssize_t hppfs_read_file(int fd, char __user *buf, ssize_t count)
 {
 	ssize_t n;
 	int cur, err;
@@ -274,7 +274,7 @@ static ssize_t hppfs_read_file(int fd, c
 	return n;
 }
 
-static ssize_t hppfs_read(struct file *file, char *buf, size_t count,
+static ssize_t hppfs_read(struct file *file, char __user *buf, size_t count,
 			  loff_t *ppos)
 {
 	struct hppfs_private *hppfs = file->private_data;
@@ -313,12 +313,12 @@ static ssize_t hppfs_read(struct file *f
 	return(count);
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
@@ -658,7 +658,7 @@ static struct super_operations hppfs_sbo
 	.statfs		= hppfs_statfs,
 };
 
-static int hppfs_readlink(struct dentry *dentry, char *buffer, int buflen)
+static int hppfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
 	struct file *proc_file;
 	struct dentry *proc_dentry;



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
