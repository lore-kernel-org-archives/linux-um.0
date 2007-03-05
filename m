Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOKG7-0006qz-2f for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:58:28 -0800
Received: from mbox.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOKG4-0000KN-CK
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:58:15 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Mon, 05 Mar 2007 21:49:03 +0100
Message-Id: <20070305204903.9072.73019.stgit@americanbeauty.home.lan>
In-Reply-To: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
References: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 05/11] hostfs: rename some vars for clarity
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

* rename name to host_root_path
* rename data to req_root.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hostfs/hostfs_kern.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 0bcf7ac..b4e127b 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -961,7 +961,7 @@ static int contains_dotdot(const char* path)
 static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 {
 	struct inode *root_inode;
-	char *name, *data = d;
+	char *host_root_path, *req_root = d;
 	int err;
 
 	sb->s_blocksize = 1024;
@@ -970,20 +970,20 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 	sb->s_op = &hostfs_sbops;
 
 	/* NULL is printed as <NULL> by sprintf: avoid that. */
-	if (data == NULL)
-		data = "";
+	if (req_root == NULL)
+		req_root = "";
 
 	err = -EINVAL;
-	if (unlikely(contains_dotdot(data)))
+	if (unlikely(contains_dotdot(req_root)))
 		goto out;
 
 	err = -ENOMEM;
-	name = kmalloc(strlen(root_ino) + 1
-			+ strlen(data) + 1, GFP_KERNEL);
-	if(name == NULL)
+	host_root_path = kmalloc(strlen(root_ino) + 1
+			+ strlen(req_root) + 1, GFP_KERNEL);
+	if(host_root_path == NULL)
 		goto out;
 
-	sprintf(name, "%s/%s", root_ino, data);
+	sprintf(host_root_path, "%s/%s", root_ino, req_root);
 
 	root_inode = iget(sb, 0);
 	if(root_inode == NULL)
@@ -993,10 +993,10 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
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
@@ -1016,7 +1016,7 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
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
