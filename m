Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EH046-00055Q-EF	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:22:46 -0700
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EH043-0001tC-Sx	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:22:46 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050918141006.31461.23599.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Subject: [uml-devel] [PATCH 11/12] HPPFS: add dentry_ops->d_revalidate
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
Date: Sun, 18 Sep 2005 16:10:07 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

We might need to revalidate a dentry (for instance when a process dies), so
call the underlying d_revalidate if it is defined, on the underlying
dentry.

Also, when we find a dentry in the dcache, we must call d_revalidate
ourselves.

BUT: for now, this is done with a NULL nameidata (which is only safe by
chance, given the current code). While looking into this, I realized that
the nameidata handling in calls to the underlying FS are bogus. I'm going
to fix this in next patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hppfs/hppfs_kern.c |   42 +++++++++++++++++++++++++++++++++++++-----
 1 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -104,7 +104,22 @@ static char *dentry_name(struct dentry *
 	return(name);
 }
 
+static int hppfs_d_revalidate(struct dentry * dentry, struct nameidata * nd)
+{
+	int (*d_revalidate)(struct dentry *, struct nameidata *);
+	struct dentry *proc_dentry;
+
+	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
+	if (proc_dentry->d_op && proc_dentry->d_op->d_revalidate)
+		d_revalidate = proc_dentry->d_op->d_revalidate;
+	else
+		return 1; /* "Still valid" code */
+
+	return (*d_revalidate)(proc_dentry, nd);
+}
+
 static struct dentry_operations hppfs_dentry_ops = {
+	.d_revalidate = hppfs_d_revalidate,
 };
 
 static int file_removed(struct dentry *dentry, const char *file)
@@ -157,7 +172,7 @@ static void hppfs_read_inode(struct inod
 	ino->i_blocks = proc_ino->i_blocks;
 }
 
-static struct dentry *hppfs_lookup(struct inode *ino, struct dentry *dentry,
+static struct dentry *hppfs_lookup(struct inode *parent_ino, struct dentry *dentry,
                                   struct nameidata *nd)
 {
 	struct dentry *proc_dentry, *new, *parent;
@@ -171,10 +186,18 @@ static struct dentry *hppfs_lookup(struc
 		return(ERR_PTR(-ENOENT));
 
 	err = -ENOMEM;
-	parent = HPPFS_I(ino)->proc_dentry;
+	parent = HPPFS_I(parent_ino)->proc_dentry;
+	
+	/* This more or less matches fs/namei.c:real_lookup() - we don't have
+	 * the fast path which looks up the dentry without the directory
+	 * semaphore. Please keep in sync. */
+
+	/* XXX: The only difference is nameidata: we pass NULL instead of nd.
+	 * Not normally allowed, would Oops if proc ever uses nd, and can Oops /
+	 * leak entries if we pass the same nd we got. */
 	down(&parent->d_inode->i_sem);
 	proc_dentry = d_lookup(parent, &dentry->d_name);
-	if(proc_dentry == NULL){
+	if (!proc_dentry) {
 		proc_dentry = d_alloc(parent, &dentry->d_name);
 		if(proc_dentry == NULL){
 			up(&parent->d_inode->i_sem);
@@ -186,13 +209,22 @@ static struct dentry *hppfs_lookup(struc
 			dput(proc_dentry);
 			proc_dentry = new;
 		}
+		up(&parent->d_inode->i_sem);
+	} else {
+		up(&parent->d_inode->i_sem);
+		if (proc_dentry->d_op && proc_dentry->d_op->d_revalidate) {
+			if (!proc_dentry->d_op->d_revalidate(proc_dentry, NULL) &&
+					!d_invalidate(proc_dentry)) {
+				dput(proc_dentry);
+				proc_dentry = ERR_PTR(-ENOENT);
+			}
+		}
 	}
-	up(&parent->d_inode->i_sem);
 
 	if(IS_ERR(proc_dentry))
 		return(proc_dentry);
 
-	inode = iget(ino->i_sb, 0);
+	inode = iget(parent_ino->i_sb, 0);
 	if(inode == NULL)
 		goto out_dput;
 



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
