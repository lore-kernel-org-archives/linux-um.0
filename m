Return-Path: <linux-kernel-owner@vger.kernel.org>
From: James Hogan <james.hogan@imgtec.com>
Date: Wed, 27 Mar 2013 10:47:12 +0000
Message-ID: <1364381234-22960-2-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1364381234-22960-1-git-send-email-james.hogan@imgtec.com>
References: <1364381234-22960-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 1/3] hostfs: remove "will unlock" comment
To: Jeff Dike <jdike@addtoit.com>, Al Viro <viro@ZenIV.linux.org.uk>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>, Nick Piggin <npiggin@kernel.dk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

A "will unlock" comment was added to hostfs in the following commit,
along with a spinlock:

Commit e9193059b1b3733695d5b80e667778311695aa73 ("hostfs: fix races in
dentry_name() and inode_name()").

But the spinlock was subsequently removed in the following commit:

Commit ec2447c278ee973d35f38e53ca16ba7f965ae33d ("hostfs: simplify
locking").

Since the comment is no longer applicable, remove it.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Nick Piggin <npiggin@kernel.dk>
---
 fs/hostfs/hostfs_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 0f6e52d..95b9c87 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -121,7 +121,7 @@ static char *dentry_name(struct dentry *dentry)
 	if (!name)
 		return NULL;
 
-	return __dentry_name(dentry, name); /* will unlock */
+	return __dentry_name(dentry, name);
 }
 
 static char *inode_name(struct inode *ino)
-- 
1.8.1.2


