Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Mon,  4 May 2015 14:53:41 +0200
Message-Id: <1430744021-4140-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] hostfs: Use correct mask for file mode
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, markus.stenberg@iki.fi, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

S_IFMT is obviously wrong and needs to be 0777.
We're interested in the file mode, not the type.

Fixes: b98b91029c (hostfs: No need to box and later unbox the file mode)
Reported-by: Markus Stenberg <markus.stenberg@iki.fi>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index ef26317..07d8d8f 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -581,7 +581,7 @@ static int hostfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	if (name == NULL)
 		goto out_put;
 
-	fd = file_create(name, mode & S_IFMT);
+	fd = file_create(name, mode & 0777);
 	if (fd < 0)
 		error = fd;
 	else
-- 
1.8.4.5

