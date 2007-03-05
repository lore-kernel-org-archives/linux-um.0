Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOKG9-0006r3-5M for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:58:28 -0800
Received: from mbox.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOKG3-0004hW-Gb
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:58:14 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Mon, 05 Mar 2007 21:49:01 +0100
Message-Id: <20070305204901.9072.51033.stgit@americanbeauty.home.lan>
In-Reply-To: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
References: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 03/11] uml - hostfs: make hostfs= option work as
	a jail, as intended.
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

When a given host directory is specified to be mounted both in hostfs=path1 and
with mount option -o path2, we should give access to path1/path2, but this does
not happen. Fix that in the simpler way.

Also, root_ino can be the empty string, since we use %s/%s as format.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hostfs/hostfs_kern.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 6f10e43..9baf697 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -47,7 +47,7 @@ struct dentry_operations hostfs_dentry_ops = {
 };
 
 /* Changed in hostfs_args before the kernel starts running */
-static char *root_ino = "/";
+static char *root_ino = "";
 static int append = 0;
 
 #define HOSTFS_SUPER_MAGIC 0x00c0ffee
@@ -947,15 +947,17 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 	sb->s_magic = HOSTFS_SUPER_MAGIC;
 	sb->s_op = &hostfs_sbops;
 
-	if((data == NULL) || (*data == '\0'))
-		data = root_ino;
+	/* NULL is printed as <NULL> by sprintf: avoid that. */
+	if (data == NULL)
+		data = "";
 
 	err = -ENOMEM;
-	name = kmalloc(strlen(data) + 1, GFP_KERNEL);
+	name = kmalloc(strlen(root_ino) + 1
+			+ strlen(data) + 1, GFP_KERNEL);
 	if(name == NULL)
 		goto out;
 
-	strcpy(name, data);
+	sprintf(name, "%s/%s", root_ino, data);
 
 	root_inode = iget(sb, 0);
 	if(root_inode == NULL)



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
