Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWa7z-0005Jo-U7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 08:32:00 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HWa7x-0001Do-6e
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 08:31:59 -0700
Date: Wed, 28 Mar 2007 11:28:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070328152846.GA6330@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/4] UML - hostfs variable renaming
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Blaisorblade <blaisorblade@yahoo.it>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

* rename name to host_root_path
* rename data to req_root.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> 
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---

 fs/hostfs/hostfs_kern.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

Index: linux-2.6.21-mm/fs/hostfs/hostfs_kern.c
===================================================================
--- linux-2.6.21-mm.orig/fs/hostfs/hostfs_kern.c	2007-03-27 12:29:28.000000000 -0400
+++ linux-2.6.21-mm/fs/hostfs/hostfs_kern.c	2007-03-27 12:34:10.000000000 -0400
@@ -938,7 +938,7 @@ static const struct address_space_operat
 static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 {
 	struct inode *root_inode;
-	char *name, *data = d;
+	char *host_root_path, *req_root = d;
 	int err;
 
 	sb->s_blocksize = 1024;
@@ -947,16 +947,16 @@ static int hostfs_fill_sb_common(struct 
 	sb->s_op = &hostfs_sbops;
 
 	/* NULL is printed as <NULL> by sprintf: avoid that. */
-	if (data == NULL)
-		data = "";
+	if (req_root == NULL)
+		req_root = "";
 
 	err = -ENOMEM;
-	name = kmalloc(strlen(root_ino) + 1
-			+ strlen(data) + 1, GFP_KERNEL);
-	if(name == NULL)
+	host_root_path = kmalloc(strlen(root_ino) + 1
+				 + strlen(req_root) + 1, GFP_KERNEL);
+	if(host_root_path == NULL)
 		goto out;
 
-	sprintf(name, "%s/%s", root_ino, data);
+	sprintf(host_root_path, "%s/%s", root_ino, req_root);
 
 	root_inode = iget(sb, 0);
 	if(root_inode == NULL)
@@ -966,10 +966,10 @@ static int hostfs_fill_sb_common(struct 
 	if(err)
 		goto out_put;
 
-	HOSTFS_I(root_inode)->host_filename = name;
-	/* Avoid that in the error path, iput(root_inode) frees again name through
-	 * hostfs_destroy_inode! */
-	name = NULL;
+	HOSTFS_I(root_inode)->host_filename = host_root_path;
+	/* Avoid that in the error path, iput(root_inode) frees again
+	 * host_root_path through hostfs_destroy_inode! */
+	host_root_path = NULL;
 
 	err = -ENOMEM;
 	sb->s_root = d_alloc_root(root_inode);
@@ -989,7 +989,7 @@ static int hostfs_fill_sb_common(struct 
  out_put:
         iput(root_inode);
  out_free:
-	kfree(name);
+	kfree(host_root_path);
  out:
 	return(err);
 }

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
