Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IcNnD-0005F4-A0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:06:47 -0700
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IcNnC-0008NR-PK
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:06:47 -0700
Date: Mon, 1 Oct 2007 12:06:32 -0400
From: dhowells@redhat.com
Message-Id: <200710011606.l91G6W9E028542@pobox.devel.redhat.com>
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

From dhowells  Mon Oct  1 14: 11:59 2007
Return-Path: <dhowells@redhat.com>
Received: from localhost.localdomain [127.0.0.1]
	by warthog.procyon.org.uk with IMAP (fetchmail-6.3.7)
	for <dhowells@localhost> (single-drop); Mon, 01 Oct 2007 14:11:59 +0100 (BST)
Received: from pobox.devel.redhat.com ([unix socket])
	 by pobox.devel.redhat.com (Cyrus v2.2.12-Invoca-RPM-2.2.12-8.1.RHEL4) with LMTPA;
	 Mon, 01 Oct 2007 09:11:50 -0400
X-Sieve: CMU Sieve 2.2
Received: from warthog.cambridge.redhat.com (devserv.devel.redhat.com [10.10.36.72])
	by pobox.devel.redhat.com (8.13.1/8.13.1) with ESMTP id l91DBnVD031197;
	Mon, 1 Oct 2007 09:11:49 -0400
Received: from [127.0.0.1] (helo=warthog.procyon.org.uk)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.66 #1 (Red Hat Linux))
	id 1IcL3u-0007i8-3r; Mon, 01 Oct 2007 14:11:50 +0100
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 29/30] IGET: Stop HPPFS from using iget() and read_inode()
To: hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
    akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    dhowells@redhat.com
Date: Mon, 01 Oct 2007 14:11:50 +0100
Message-ID: <20071001131150.29339.92417.stgit@warthog.procyon.org.uk>
In-Reply-To: <20071001130921.29339.72876.stgit@warthog.procyon.org.uk>
References: <20071001130921.29339.72876.stgit@warthog.procyon.org.uk>
User-Agent: StGIT/0.13
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Resent-To: user-mode-linux-devel@lists.sourceforge.net
Resent-cc: jdike@karaya.com
Resent-Date: Mon, 01 Oct 2007 17:06:33 +0100
Resent-Message-ID: <19196.1191254793@redhat.com>
Resent-From: David Howells <dhowells@redhat.com>

Stop the HPPFS filesystem from using iget() and read_inode().  Provide an
hppfs_iget(), and call that instead of iget().  hppfs_iget() then uses
iget_locked() directly and returns a proper error code instead of an inode in
the event of an error.

hppfs_fill_sb_common() returns any error incurred when getting the root inode
instead of EINVAL.

Note that the contents of hppfs_kern.c need to be examined:

 (*) The HPPFS inode retains a pointer to the proc dentry it is shadowing, but
     whilst it does appear to retain a reference to it, it doesn't appear to
     destroy the reference if the inode goes away.

 (*) hppfs_iget() should perhaps subsume init_inode() and hppfs_read_inode().

 (*) It would appear that all hppfs inodes are the same inode because iget()
     was being called with inode number 0, which forms the lookup key.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/hppfs/hppfs_kern.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
index affb741..a1e1f0f 100644
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -155,6 +155,20 @@ static void hppfs_read_inode(struct inode *ino)
 	ino->i_blocks = proc_ino->i_blocks;
 }
 
+static struct inode *hppfs_iget(struct super_block *sb)
+{
+	struct inode *inode;
+
+	inode = iget_locked(sb, 0);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+	if (inode->i_state & I_NEW) {
+		hppfs_read_inode(inode);
+		unlock_new_inode(inode);
+	}
+	return inode;
+}
+
 static struct dentry *hppfs_lookup(struct inode *ino, struct dentry *dentry,
                                   struct nameidata *nd)
 {
@@ -190,9 +204,11 @@ static struct dentry *hppfs_lookup(struct inode *ino, struct dentry *dentry,
 	if(IS_ERR(proc_dentry))
 		return(proc_dentry);
 
-	inode = iget(ino->i_sb, 0);
-	if(inode == NULL)
+	inode = hppfs_iget(ino->i_sb);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
 		goto out_dput;
+	}
 
 	err = init_inode(inode, proc_dentry);
 	if(err)
@@ -652,7 +668,6 @@ static void hppfs_destroy_inode(struct inode *inode)
 static const struct super_operations hppfs_sbops = {
 	.alloc_inode	= hppfs_alloc_inode,
 	.destroy_inode	= hppfs_destroy_inode,
-	.read_inode	= hppfs_read_inode,
 	.delete_inode	= hppfs_delete_inode,
 	.statfs		= hppfs_statfs,
 };
@@ -745,9 +760,11 @@ static int hppfs_fill_super(struct super_block *sb, void *d, int silent)
 	sb->s_magic = HPPFS_SUPER_MAGIC;
 	sb->s_op = &hppfs_sbops;
 
-	root_inode = iget(sb, 0);
-	if(root_inode == NULL)
+	root_inode = hppfs_iget(sb);
+	if (IS_ERR(root_inode)) {
+		err = PTR_ERR(root_inode);
 		goto out;
+	}
 
 	err = init_inode(root_inode, proc_sb->s_root);
 	if(err)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
