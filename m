Return-Path: <linux-kernel-owner@vger.kernel.org>
From: James Hogan <james.hogan@imgtec.com>
Date: Wed, 27 Mar 2013 10:47:14 +0000
Message-ID: <1364381234-22960-4-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1364381234-22960-1-git-send-email-james.hogan@imgtec.com>
References: <1364381234-22960-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 3/3] hostfs: use kmalloc instead of kzalloc
To: Jeff Dike <jdike@addtoit.com>, Al Viro <viro@ZenIV.linux.org.uk>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The inode info structure is zeroed at allocation with kzalloc, and then
all but one of the fields (including the largest, vfs_inode) are
initialised explicitly. Switch to using kmalloc and initialise the
remaining field too.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 fs/hostfs/hostfs_kern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index f2372ef..32f35f1 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -228,10 +228,11 @@ static struct inode *hostfs_alloc_inode(struct super_block *sb)
 {
 	struct hostfs_inode_info *hi;
 
-	hi = kzalloc(sizeof(*hi), GFP_KERNEL);
+	hi = kmalloc(sizeof(*hi), GFP_KERNEL);
 	if (hi == NULL)
 		return NULL;
 	hi->fd = -1;
+	hi->mode = 0;
 	inode_init_once(&hi->vfs_inode);
 	return &hi->vfs_inode;
 }
-- 
1.8.1.2


