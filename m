Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kulikov Vasiliy <segooon@gmail.com>
Subject: [PATCH 10/14] hppfs: check for IS_ERR() instead of != NULL
Date: Sun,  5 Sep 2010 22:32:56 +0400
Message-Id: <1283711577-7505-1-git-send-email-segooon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Vasiliy Kulikov <segooon@gmail.com>, Jeff Dike <jdike@addtoit.com>, Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Vasiliy Kulikov <segooon@gmail.com>

Function get_inode may return ERR_PTR(...). Check for it.

Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
---
 Compile tested.

 fs/hppfs/hppfs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hppfs/hppfs.c b/fs/hppfs/hppfs.c
index 7b02772..e7d6535 100644
--- a/fs/hppfs/hppfs.c
+++ b/fs/hppfs/hppfs.c
@@ -173,7 +173,7 @@ static struct dentry *hppfs_lookup(struct inode *ino, struct dentry *dentry,
 
 	err = -ENOMEM;
 	inode = get_inode(ino->i_sb, proc_dentry);
-	if (!inode)
+	if (IS_ERR_OR_NULL(inode))
 		goto out_dput;
 
  	d_add(dentry, inode);
@@ -730,7 +730,7 @@ static int hppfs_fill_super(struct super_block *sb, void *d, int silent)
 
 	err = -ENOMEM;
 	root_inode = get_inode(sb, proc_mnt->mnt_sb->s_root);
-	if (!root_inode)
+	if (IS_ERR_OR_NULL(root_inode))
 		goto out_mntput;
 
 	sb->s_root = d_alloc_root(root_inode);
-- 
1.7.0.4

