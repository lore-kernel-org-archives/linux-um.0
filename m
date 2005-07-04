Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DpTzv-00056L-WB	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jul 2005 09:40:43 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DpTzv-0005Qx-9a
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jul 2005 09:40:43 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050704164619.8F6FC1D8B91@zion.home.lan>
Subject: [uml-devel] [patch 1/1] uml: restore hppfs support
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
Date: Mon, 04 Jul 2005 18:46:19 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Some time ago a trivial patch broke HPPFS (one var became a pointer, not all
uses were updated). It wasn't fixed at that time because not very used, now
it's been requested so I've fixed this, and it has been tested positively (at
least partially).

Good for merging now.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/Kconfig       |    6 +++---
 linux-2.6.git-paolo/fs/hppfs/hppfs_kern.c |    7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff -puN arch/um/Kconfig~uml-hppfs arch/um/Kconfig
--- linux-2.6.git/arch/um/Kconfig~uml-hppfs	2005-07-04 18:37:37.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/Kconfig	2005-07-04 18:46:13.000000000 +0200
@@ -128,7 +128,6 @@ config HOSTFS
 
 config HPPFS
 	tristate "HoneyPot ProcFS (EXPERIMENTAL)"
-	depends on BROKEN
 	help
 	hppfs (HoneyPot ProcFS) is a filesystem which allows UML /proc
 	entries to be overridden, removed, or fabricated from the host.
@@ -141,8 +140,9 @@ config HPPFS
 	You only need this if you are setting up a UML honeypot.  Otherwise,
 	it is safe to say 'N' here.
 
-	If you are actively using it, please ask for it to be fixed. In this
-	moment, it does not work on 2.6 (it works somehow on 2.4).
+	If you are actively using it, please report any problems, since it's
+	getting fixed. In this moment, it is experimental on 2.6 (it works on
+	2.4).
 
 config MCONSOLE
 	bool "Management console"
diff -puN fs/hppfs/hppfs_kern.c~uml-hppfs fs/hppfs/hppfs_kern.c
--- linux-2.6.git/fs/hppfs/hppfs_kern.c~uml-hppfs	2005-07-04 18:37:37.000000000 +0200
+++ linux-2.6.git-paolo/fs/hppfs/hppfs_kern.c	2005-07-04 18:37:37.000000000 +0200
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/file.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -491,7 +492,7 @@ static int hppfs_open(struct inode *inod
 		fd = open_host_sock(host_file, &filter);
 		if(fd > 0){
 			data->contents = hppfs_get_data(fd, filter,
-							&data->proc_file,
+							data->proc_file,
 							file, &data->len);
 			if(!IS_ERR(data->contents))
 				data->host_fd = fd;
@@ -543,7 +544,7 @@ static int hppfs_dir_open(struct inode *
 static loff_t hppfs_llseek(struct file *file, loff_t off, int where)
 {
 	struct hppfs_private *data = file->private_data;
-	struct file *proc_file = &data->proc_file;
+	struct file *proc_file = data->proc_file;
 	loff_t (*llseek)(struct file *, loff_t, int);
 	loff_t ret;
 
@@ -586,7 +587,7 @@ static int hppfs_filldir(void *d, const 
 static int hppfs_readdir(struct file *file, void *ent, filldir_t filldir)
 {
 	struct hppfs_private *data = file->private_data;
-	struct file *proc_file = &data->proc_file;
+	struct file *proc_file = data->proc_file;
 	int (*readdir)(struct file *, void *, filldir_t);
 	struct hppfs_dirent dirent = ((struct hppfs_dirent)
 		                      { .vfs_dirent  	= ent,
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
