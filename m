Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8hY7-0007XT-Vh	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 09:59:27 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E8hY6-0004In-KN
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 09:59:28 -0700
Resent-To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
        Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>,
        user-mode-linux-devel@lists.sourceforge.net
Resent-Message-ID: <200508261827.32263.blaisorblade@yahoo.it>
From: blaisorblade@yahoo.it
Message-Id: <20050826145753.7EC2624E793@zion.home.lan>
Subject: [uml-devel] [patch 2/2] hppfs: fix symlink error path
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
Date: Fri, 26 Aug 2005 16:57:53 +0200
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

While touching this code I noticed the error handling is bogus, so I fixed it
up.

I've removed the IS_ERR(proc_dentry) check, which will never trigger and is
clearly a typo: we must check proc_file instead.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/fs/hppfs/hppfs_kern.c |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff -puN fs/hppfs/hppfs_kern.c~hppfs-fix-symlink-oops fs/hppfs/hppfs_kern.c
--- linux-2.6.git/fs/hppfs/hppfs_kern.c~hppfs-fix-symlink-oops	2005-08-24 18:19:45.000000000 +0200
+++ linux-2.6.git-paolo/fs/hppfs/hppfs_kern.c	2005-08-24 18:19:45.000000000 +0200
@@ -38,7 +38,7 @@ struct hppfs_inode_info {
 
 static inline struct hppfs_inode_info *HPPFS_I(struct inode *inode)
 {
-	return(list_entry(inode, struct hppfs_inode_info, vfs_inode));
+	return container_of(inode, struct hppfs_inode_info, vfs_inode);
 }
 
 #define HPPFS_SUPER_MAGIC 0xb00000ee
@@ -662,38 +662,32 @@ static int hppfs_readlink(struct dentry 
 {
 	struct file *proc_file;
 	struct dentry *proc_dentry;
-	int (*readlink)(struct dentry *, char *, int);
-	int err, n;
+	int ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
 	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);
-	err = PTR_ERR(proc_dentry);
-	if(IS_ERR(proc_dentry))
-		return(err);
+	if (IS_ERR(proc_file))
+		return PTR_ERR(proc_file);
 
-	readlink = proc_dentry->d_inode->i_op->readlink;
-	n = (*readlink)(proc_dentry, buffer, buflen);
+	ret = proc_dentry->d_inode->i_op->readlink(proc_dentry, buffer, buflen);
 
 	fput(proc_file);
 
-	return(n);
+	return ret;
 }
 
 static void* hppfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct file *proc_file;
 	struct dentry *proc_dentry;
-	void * (*follow_link)(struct dentry *, struct nameidata *);
 	void *ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
 	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);
+	if (IS_ERR(proc_file))
+		return proc_file;
 
-	if (IS_ERR(proc_dentry))
-		return proc_dentry;
-
-	follow_link = proc_dentry->d_inode->i_op->follow_link;
-	ret = (*follow_link)(proc_dentry, nd);
+	ret = proc_dentry->d_inode->i_op->follow_link(proc_dentry, nd);
 
 	fput(proc_file);
 
_


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
