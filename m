Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EH04e-00056L-QU	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:23:20 -0700
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EH04c-00023Y-BI	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:23:20 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050918141002.31461.43928.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Subject: [uml-devel] [PATCH 09/12] HPPFS: add special permission checking from
	procfs
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
Date: Sun, 18 Sep 2005 16:10:02 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Al Viro

Procfs uses a special permission method in some cases, so we can't use the
generic one, and must call instead the inode's one if it's not null (only
some inodes use a custom method).

It seems that this method is used to avoid a chroot'ed process to escape
its chroot by accessing another process's root/cwd through procfs (both by
a quick read of the code and by testing on the host), like in "cd
/proc/1/root".

I've not added a ->permission operation on symlink, as there is no procfs
symlink using it, and I wonder if symlink can have permissions set at all
(guess not).

If you disagree, just add it (hppfs_permission() handles null pointers
gracefully).

Note: I've cared to use the proc inode (I missed that in the beginning) -
since the dentry is always created by the underlying ->lookup this should be
safe - or not? I've gone to do some checking, and since we pass to it a
procfs inode, referring to the procfs superblock, it seems that yes, we're
fine.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hppfs/hppfs_kern.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -214,7 +214,22 @@ static struct dentry *hppfs_lookup(struc
 	return(ERR_PTR(err));
 }
 
+static int hppfs_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+	struct inode *proc_inode;
+	int (*permission) (struct inode *, int, struct nameidata *);
+
+	proc_inode = HPPFS_I(inode)->proc_dentry->d_inode;
+	permission = proc_inode->i_op->permission;
+
+	if (permission == NULL)
+		return generic_permission(inode, mask, NULL);
+
+	return (*permission)(proc_inode, mask, nd);
+}
+
 static struct inode_operations hppfs_file_iops = {
+	.permission	= hppfs_permission,
 };
 
 /* Pass down ppos when you're being called from userspace.
@@ -779,6 +794,7 @@ static void* hppfs_follow_link(struct de
 }
 
 static struct inode_operations hppfs_dir_iops = {
+	.permission	= hppfs_permission,
 	.lookup		= hppfs_lookup,
 };
 



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
