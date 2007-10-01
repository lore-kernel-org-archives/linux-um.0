Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IcNn9-0005Ev-86 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:06:43 -0700
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IcNn7-00073N-L4
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:06:43 -0700
Date: Mon, 1 Oct 2007 12:06:32 -0400
From: dhowells@redhat.com
Message-Id: <200710011606.l91G6Woc028541@pobox.devel.redhat.com>
Subject: [uml-devel] (no subject)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: 

From dhowells  Mon Oct  1 14: 11:57 2007
Return-Path: <dhowells@redhat.com>
Received: from localhost.localdomain [127.0.0.1]
	by warthog.procyon.org.uk with IMAP (fetchmail-6.3.7)
	for <dhowells@localhost> (single-drop); Mon, 01 Oct 2007 14:11:57 +0100 (BST)
Received: from pobox.devel.redhat.com ([unix socket])
	 by pobox.devel.redhat.com (Cyrus v2.2.12-Invoca-RPM-2.2.12-8.1.RHEL4) with LMTPA;
	 Mon, 01 Oct 2007 09:11:45 -0400
X-Sieve: CMU Sieve 2.2
Received: from warthog.cambridge.redhat.com (devserv.devel.redhat.com [10.10.36.72])
	by pobox.devel.redhat.com (8.13.1/8.13.1) with ESMTP id l91DBimG031190;
	Mon, 1 Oct 2007 09:11:45 -0400
Received: from [127.0.0.1] (helo=warthog.procyon.org.uk)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.66 #1 (Red Hat Linux))
	id 1IcL3p-0007hp-1L; Mon, 01 Oct 2007 14:11:45 +0100
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 28/30] IGET: Stop HOSTFS from using iget() and read_inode()
To: hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
    akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    dhowells@redhat.com
Date: Mon, 01 Oct 2007 14:11:45 +0100
Message-ID: <20071001131144.29339.30718.stgit@warthog.procyon.org.uk>
In-Reply-To: <20071001130921.29339.72876.stgit@warthog.procyon.org.uk>
References: <20071001130921.29339.72876.stgit@warthog.procyon.org.uk>
User-Agent: StGIT/0.13
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Resent-To: user-mode-linux-devel@lists.sourceforge.net
Resent-cc: jdike@karaya.com
Resent-Date: Mon, 01 Oct 2007 17:06:27 +0100
Resent-Message-ID: <19182.1191254787@redhat.com>
Resent-From: David Howells <dhowells@redhat.com>

Stop the HOSTFS filesystem from using iget() and read_inode().  Provide
hostfs_iget(), and call that instead of iget().  hostfs_iget() then uses
iget_locked() directly and returns a proper error code instead of an inode in
the event of an error.

hostfs_fill_sb_common() returns any error incurred when getting the root inode
instead of EINVAL.

Note that the contents of hostfs_kern.c need to be examined:

 (*) hostfs_iget() should perhaps subsume init_inode() and hostfs_read_inode().

 (*) It would appear that all hostfs inodes are the same inode because iget()
     was being called with inode number 0 - which forms the lookup key.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/hostfs/hostfs_kern.c |   58 ++++++++++++++++++++++++++++++++---------------
 1 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index c778620..c6a456a 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -208,7 +208,7 @@ static char *follow_link(char *link)
 	return ERR_PTR(n);
 }
 
-static int read_inode(struct inode *ino)
+static int hostfs_read_inode(struct inode *ino)
 {
 	char *name;
 	int err = 0;
@@ -238,6 +238,25 @@ static int read_inode(struct inode *ino)
 	return err;
 }
 
+static struct inode *hostfs_iget(struct super_block *sb)
+{
+	struct inode *inode;
+	long ret;
+
+	inode = iget_locked(sb, 0);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+	if (inode->i_state & I_NEW) {
+		ret = hostfs_read_inode(inode);
+		if (ret < 0) {
+			iget_failed(inode);
+			return ERR_PTR(ret);
+		}
+		unlock_new_inode(inode);
+	}
+	return inode;
+}
+
 int hostfs_statfs(struct dentry *dentry, struct kstatfs *sf)
 {
 	/* do_statfs uses struct statfs64 internally, but the linux kernel
@@ -305,17 +324,11 @@ static void hostfs_destroy_inode(struct inode *inode)
 	kfree(HOSTFS_I(inode));
 }
 
-static void hostfs_read_inode(struct inode *inode)
-{
-	read_inode(inode);
-}
-
 static const struct super_operations hostfs_sbops = {
 	.alloc_inode	= hostfs_alloc_inode,
 	.drop_inode	= generic_delete_inode,
 	.delete_inode   = hostfs_delete_inode,
 	.destroy_inode	= hostfs_destroy_inode,
-	.read_inode	= hostfs_read_inode,
 	.statfs		= hostfs_statfs,
 };
 
@@ -584,9 +597,11 @@ int hostfs_create(struct inode *dir, struct dentry *dentry, int mode,
 	char *name;
 	int error, fd;
 
-	error = -ENOMEM;
-	inode = iget(dir->i_sb, 0);
-	if(inode == NULL) goto out;
+	inode = hostfs_iget(dir->i_sb);
+	if (IS_ERR(inode)) {
+		error = PTR_ERR(inode);
+		goto out;
+	}
 
 	error = init_inode(inode, dentry);
 	if(error)
@@ -627,10 +642,11 @@ struct dentry *hostfs_lookup(struct inode *ino, struct dentry *dentry,
 	char *name;
 	int err;
 
-	err = -ENOMEM;
-	inode = iget(ino->i_sb, 0);
-	if(inode == NULL)
+	inode = hostfs_iget(ino->i_sb);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
 		goto out;
+	}
 
 	err = init_inode(inode, dentry);
 	if(err)
@@ -748,11 +764,13 @@ int hostfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
 	struct inode *inode;
 	char *name;
-	int err = -ENOMEM;
+	int err;
 
-	inode = iget(dir->i_sb, 0);
-	if(inode == NULL)
+	inode = hostfs_iget(dir->i_sb);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
 		goto out;
+	}
 
 	err = init_inode(inode, dentry);
 	if(err)
@@ -973,9 +991,11 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 
 	sprintf(host_root_path, "%s/%s", root_ino, req_root);
 
-	root_inode = iget(sb, 0);
-	if(root_inode == NULL)
+	root_inode = hostfs_iget(sb);
+	if (IS_ERR(root_inode)) {
+		err = PTR_ERR(root_inode);
 		goto out_free;
+	}
 
 	err = init_inode(root_inode, NULL);
 	if(err)
@@ -991,7 +1011,7 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 	if(sb->s_root == NULL)
 		goto out_put;
 
-	err = read_inode(root_inode);
+	err = hostfs_read_inode(root_inode);
 	if(err){
 		/* No iput in this case because the dput does that for us */
 		dput(sb->s_root);


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
