Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzmoJ-0005kT-J6
 for linux-um@lists.infradead.org; Wed, 13 Jan 2021 20:32:08 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: hostfs: use a kmem cache for inodes
Date: Wed, 13 Jan 2021 21:31:55 +0100
Message-Id: <20210113213155.049fef96fce4.If4230573eba7b6e24ebc79f8ca827577260a60e5@changeid>
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
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

This collects all of them together and makes it possible to
e.g. exclude it from slub debugging.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/hostfs/hostfs_kern.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index aea35459d390..4a5beca6eaa8 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -34,6 +34,8 @@ static inline struct hostfs_inode_info *HOSTFS_I(struct inode *inode)
 
 #define FILE_HOSTFS_I(file) HOSTFS_I(file_inode(file))
 
+static struct kmem_cache *hostfs_inode_cache;
+
 /* Changed in hostfs_args before the kernel starts running */
 static char *root_ino = "";
 static int append = 0;
@@ -221,7 +223,7 @@ static struct inode *hostfs_alloc_inode(struct super_block *sb)
 {
 	struct hostfs_inode_info *hi;
 
-	hi = kmalloc(sizeof(*hi), GFP_KERNEL_ACCOUNT);
+	hi = kmem_cache_alloc(hostfs_inode_cache, GFP_KERNEL_ACCOUNT);
 	if (hi == NULL)
 		return NULL;
 	hi->fd = -1;
@@ -243,7 +245,7 @@ static void hostfs_evict_inode(struct inode *inode)
 
 static void hostfs_free_inode(struct inode *inode)
 {
-	kfree(HOSTFS_I(inode));
+	kmem_cache_free(hostfs_inode_cache, HOSTFS_I(inode));
 }
 
 static int hostfs_show_options(struct seq_file *seq, struct dentry *root)
@@ -986,12 +988,16 @@ MODULE_ALIAS_FS("hostfs");
 
 static int __init init_hostfs(void)
 {
+	hostfs_inode_cache = KMEM_CACHE(hostfs_inode_info, 0);
+	if (!hostfs_inode_cache)
+		return -ENOMEM;
 	return register_filesystem(&hostfs_type);
 }
 
 static void __exit exit_hostfs(void)
 {
 	unregister_filesystem(&hostfs_type);
+	kmem_cache_destroy(hostfs_inode_cache);
 }
 
 module_init(init_hostfs)
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

