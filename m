Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EH04n-00056c-SW	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:23:29 -0700
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EH04m-000262-W5	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:23:29 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050918140946.31461.26100.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Subject: [uml-devel] [PATCH 02/12] HPPFS: don't check sb->s_op in is_pid()
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
Date: Sun, 18 Sep 2005 16:09:46 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Al Viro

To check whether a directory in /proc is a "pid" directory, we also check
(uselessly) whether the super_operations match the HPPFS ones. Drop that,
as suggested by Al Viro. Cleanup codingstyle in nearby code, btw.

Actually, we don't know why we used to do this. Just guessing.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hppfs/hppfs_kern.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -49,18 +49,16 @@ static struct vfsmount * proc_submnt;
 
 static int is_pid(struct dentry *dentry)
 {
-	struct super_block *sb;
 	int i;
 
-	sb = dentry->d_sb;
-	if((sb->s_op != &hppfs_sbops) || (dentry->d_parent != sb->s_root))
-		return(0);
+	if (dentry->d_parent != dentry->d_sb->s_root)
+		return 0;
 
-	for(i = 0; i < dentry->d_name.len; i++){
-		if(!isdigit(dentry->d_name.name[i]))
-			return(0);
+	for (i = 0; i < dentry->d_name.len; i++) {
+		if (!isdigit(dentry->d_name.name[i]))
+			return 0;
 	}
-	return(1);
+	return 1;
 }
 
 static char *dentry_name(struct dentry *dentry, int extra)



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
