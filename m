Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Sep 2012 12:55:02 +0800
Message-ID: <CAPgLHd8r0utq4Ts58T1mWRpWpiSLB0oCxhOw_JMSAeRudnExnQ@mail.gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] hppfs: fix the return value of get_inode()
To: jdike@addtoit.com, richard@nod.at
Cc: yongjun_wei@trendmicro.com.cn, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function get_inode() returns ERR_PTR().
But the users hppfs_lookup() and hppfs_fill_super() use NULL
test for check the return value, not IS_ERR(), so we'd better
change the return value of get_inode() to NULL instead of
ERR_PTR().

dpatch engine is used to generated this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 fs/hppfs/hppfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hppfs/hppfs.c b/fs/hppfs/hppfs.c
index c1dffe4..31b1e85 100644
--- a/fs/hppfs/hppfs.c
+++ b/fs/hppfs/hppfs.c
@@ -674,7 +674,7 @@ static struct inode *get_inode(struct super_block *sb, struct dentry *dentry)
 
 	if (!inode) {
 		dput(dentry);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 
 	if (S_ISDIR(dentry->d_inode->i_mode)) {


