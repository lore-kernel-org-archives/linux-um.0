Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EH04v-00056n-Lr	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:23:37 -0700
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EH04u-00027t-O0	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:23:37 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050918141004.31461.39445.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Subject: [uml-devel] [PATCH 10/12] HPPFS: don't open a file when it stays
	unused
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
Date: Sun, 18 Sep 2005 16:10:04 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

hppfs_follow_link() and hppfs_readlink() open the file but then doesn't use it,
apart for fput().

I assume that dropping this dentry_open doesn't remove any needed permission
checking.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hppfs/hppfs_kern.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -745,15 +745,11 @@ static struct super_operations hppfs_sbo
 
 static int hppfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
-	struct file *proc_file;
 	struct dentry *proc_dentry;
 	int (*readlink)(struct dentry *, char __user *, int);
 	int ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
-	proc_file = dentry_open(dget(proc_dentry), mntget(proc_submnt), O_RDONLY);
-	if (IS_ERR(proc_file))
-		return PTR_ERR(proc_file);
 
 	readlink = proc_dentry->d_inode->i_op->readlink;
 	if (readlink == NULL)
@@ -761,22 +757,16 @@ static int hppfs_readlink(struct dentry 
 	ret = (*readlink)(proc_dentry, buffer, buflen);
 	ret = proc_dentry->d_inode->i_op->readlink(proc_dentry, buffer, buflen);
 
-	fput(proc_file);
-
 	return ret;
 }
 
 static void* hppfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	struct file *proc_file;
 	struct dentry *proc_dentry;
 	void * (*follow_link)(struct dentry *, struct nameidata *);
 	void *ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
-	proc_file = dentry_open(dget(proc_dentry), mntget(proc_submnt), O_RDONLY);
-	if (IS_ERR(proc_file))
-		return proc_file;
 
 	follow_link = proc_dentry->d_inode->i_op->follow_link;
 
@@ -788,8 +778,6 @@ static void* hppfs_follow_link(struct de
 
 	ret = follow_link(proc_dentry, nd);
 
-	fput(proc_file);
-
 	return ret;
 }
 



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
