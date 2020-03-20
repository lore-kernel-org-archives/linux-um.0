Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFHNK-0004XR-Ci
 for linux-um@lists.infradead.org; Fri, 20 Mar 2020 13:07:47 +0000
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] hostfs: Use kasprintf() instead of fixed buffer formatting
Date: Fri, 20 Mar 2020 15:07:35 +0200
Message-Id: <20200320130735.50925-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Improve readability and maintainability by replacing a hardcoded string
allocation and formatting by the use of the kasprintf() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/hostfs/hostfs_kern.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index e6b8c49076bb..c070c0d8e3e9 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -139,8 +139,8 @@ static char *inode_name(struct inode *ino)
 
 static char *follow_link(char *link)
 {
-	int len, n;
 	char *name, *resolved, *end;
+	int n;
 
 	name = __getname();
 	if (!name) {
@@ -164,15 +164,13 @@ static char *follow_link(char *link)
 		return name;
 
 	*(end + 1) = '\0';
-	len = strlen(link) + strlen(name) + 1;
 
-	resolved = kmalloc(len, GFP_KERNEL);
+	resolved = kasprintf(GFP_KERNEL, "%s%s", link, name);
 	if (resolved == NULL) {
 		n = -ENOMEM;
 		goto out_free;
 	}
 
-	sprintf(resolved, "%s%s", link, name);
 	__putname(name);
 	kfree(link);
 	return resolved;
@@ -921,18 +919,16 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 	sb->s_d_op = &simple_dentry_operations;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 
-	/* NULL is printed as <NULL> by sprintf: avoid that. */
+	/* NULL is printed as '(null)' by printf(): avoid that. */
 	if (req_root == NULL)
 		req_root = "";
 
 	err = -ENOMEM;
 	sb->s_fs_info = host_root_path =
-		kmalloc(strlen(root_ino) + strlen(req_root) + 2, GFP_KERNEL);
+		kasprintf(GFP_KERNEL, "%s/%s", root_ino, req_root);
 	if (host_root_path == NULL)
 		goto out;
 
-	sprintf(host_root_path, "%s/%s", root_ino, req_root);
-
 	root_inode = new_inode(sb);
 	if (!root_inode)
 		goto out;
-- 
2.25.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

