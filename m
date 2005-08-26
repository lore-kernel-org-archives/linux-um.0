Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8fl2-0002vn-Bd	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 08:04:40 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E8fkz-0004kB-N7
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 08:04:40 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050826145749.03BFE24D661@zion.home.lan>
Subject: [uml-devel] [patch 1/2] Fixup symlink function pointers for hppfs
	[for 2.6.13]
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
Date: Fri, 26 Aug 2005 16:57:44 +0200
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Update hppfs for the symlink functions prototype change.
Should be trivial, but please verify it's correct.

Yes, I know the code I leave there is still _bogus_, see next patch for this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/fs/hppfs/hppfs_kern.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff -puN fs/hppfs/hppfs_kern.c~hppfs-fix-symlink fs/hppfs/hppfs_kern.c
--- linux-2.6.git/fs/hppfs/hppfs_kern.c~hppfs-fix-symlink	2005-08-24 17:43:56.000000000 +0200
+++ linux-2.6.git-paolo/fs/hppfs/hppfs_kern.c	2005-08-24 18:17:46.000000000 +0200
@@ -679,25 +679,25 @@ static int hppfs_readlink(struct dentry 
 	return(n);
 }
 
-static int hppfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void* hppfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct file *proc_file;
 	struct dentry *proc_dentry;
-	int (*follow_link)(struct dentry *, struct nameidata *);
-	int err, n;
+	void * (*follow_link)(struct dentry *, struct nameidata *);
+	void *ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
 	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);
-	err = PTR_ERR(proc_dentry);
-	if(IS_ERR(proc_dentry))
-		return(err);
+
+	if (IS_ERR(proc_dentry))
+		return proc_dentry;
 
 	follow_link = proc_dentry->d_inode->i_op->follow_link;
-	n = (*follow_link)(proc_dentry, nd);
+	ret = (*follow_link)(proc_dentry, nd);
 
 	fput(proc_file);
 
-	return(n);
+	return ret;
 }
 
 static struct inode_operations hppfs_dir_iops = {
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
