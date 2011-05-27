Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sage@newdream.net>) id 1QQ48K-00078C-3g
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 May 2011 20:59:48 +0000
Received: from cobra.newdream.net ([66.33.216.30])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QQ48J-00050o-2c for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 May 2011 20:59:48 +0000
From: Sage Weil <sage@newdream.net>
Date: Fri, 27 May 2011 13:42:07 -0700
Message-Id: <1306528939-30636-15-git-send-email-sage@newdream.net>
In-Reply-To: <1306528939-30636-1-git-send-email-sage@newdream.net>
References: <1306528939-30636-1-git-send-email-sage@newdream.net>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 14/26] hostfs: remove unnecessary dentry_unhash
	on rmdir, dir rename
To: hch@infradead.org, viro@ZenIV.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, Sage Weil <sage@newdream.net>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>

hostfs does not have problems with references to unlinked directories.

CC: Jeff Dike <jdike@addtoit.com>
CC: Richard Weinberger <richard@nod.at>
CC: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/hostfs/hostfs_kern.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index e6816b9..2638c83 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -683,8 +683,6 @@ int hostfs_rmdir(struct inode *ino, struct dentry *dentry)
 	char *file;
 	int err;
 
-	dentry_unhash(dentry);
-
 	if ((file = dentry_name(dentry)) == NULL)
 		return -ENOMEM;
 	err = do_rmdir(file);
@@ -738,9 +736,6 @@ int hostfs_rename(struct inode *from_ino, struct dentry *from,
 	char *from_name, *to_name;
 	int err;
 
-	if (to->d_inode && S_ISDIR(to->d_inode->i_mode))
-		dentry_unhash(to);
-
 	if ((from_name = dentry_name(from)) == NULL)
 		return -ENOMEM;
 	if ((to_name = dentry_name(to)) == NULL) {
-- 
1.7.0


------------------------------------------------------------------------------
vRanger cuts backup time in half-while increasing security.
With the market-leading solution for virtual backup and recovery, 
you get blazing-fast, flexible, and affordable data protection.
Download your free trial now. 
http://p.sf.net/sfu/quest-d2dcopy1
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

