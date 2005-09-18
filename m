Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EH04z-00056o-Ok	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:23:41 -0700
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EH04y-00028e-FA	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:23:41 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050918140957.31461.8463.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Subject: [uml-devel] [PATCH 07/12] HPPFS: fix broken read method
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
Date: Sun, 18 Sep 2005 16:09:57 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When data to be read has been loaded in memory (sadly kmalloc'ed() memory,
not buffer cache, but I hope it doesn't really matter), we alloc memory one
page at a time, and chain the pages. On a read, we properly walk the page
list, but we fail to handle reads which cross a page boundary.

This patch should fix that. But please, cross check this with
drivers/char/mem.c as I did or use a paper sheet to check it
(as I've done) - it's absolutely nontrivial to get right.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 fs/hppfs/hppfs_kern.c |   61 +++++++++++++++++++++++++++++++------------------
 1 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -302,40 +302,55 @@ static ssize_t hppfs_read(struct file *f
 	struct hppfs_private *hppfs = file->private_data;
 	struct hppfs_data *data;
 	loff_t off;
-	int err;
+	int err, written = 0;
 
 	if (hppfs->contents != NULL) {
-		if(*ppos >= hppfs->len) return(0);
-
-		data = hppfs->contents;
 		off = *ppos;
-		while(off >= sizeof(data->contents)){
-			data = list_entry(data->list.next, struct hppfs_data,
-					  list);
-			off -= sizeof(data->contents);
-		}
 
-		if(off + count > hppfs->len)
+		if (off >= hppfs->len)
+			return 0;
+
+		if (off + count > hppfs->len)
 			count = hppfs->len - off;
-		/*XXX: we should walk the list of remaining buffers! */
-		err = copy_to_user(buf, &data->contents[off], count);
-		count -= err;
-		if (!count)
-			return -EFAULT;
-		*ppos += count;
-	} else if(hppfs->host_fd != -1) {
+
+		data = hppfs->contents;
+		while (count) {
+			int chunk;
+			while (off >= sizeof(data->contents)) {
+				data = list_entry(data->list.next,
+						struct hppfs_data, list);
+				off -= sizeof(data->contents);
+			}
+
+			chunk = min_t(size_t, sizeof(data->contents) - off, count);
+			err = copy_to_user(buf, &data->contents[off], chunk);
+			if (err) {
+				*ppos += chunk - err;
+				written += chunk - err;
+				if (written == 0)
+					written = -EFAULT;
+				break;
+			}
+			off += chunk;
+			buf += chunk;
+			count -= chunk;
+			written += chunk;
+		}
+		*ppos += written;
+	} else if (hppfs->host_fd != -1) {
 		err = os_seek_file(hppfs->host_fd, *ppos);
 		if (err < 0){
 			printk("hppfs_read : seek failed, errno = %d\n", err);
 			return(err);
 		}
-		count = hppfs_read_file(hppfs->host_fd, buf, count);
-		if(count > 0)
-			*ppos += count;
-	} else
-		count = read_proc(hppfs->proc_file, buf, count, ppos, 1);
+		written = hppfs_read_file(hppfs->host_fd, buf, count);
+		*ppos += written;
+	} else {
+		/* It handles ppos on its own */
+		written = read_proc(hppfs->proc_file, buf, count, ppos, 1);
+	}
 
-	return(count);
+	return written;
 }
 
 static ssize_t hppfs_write(struct file *file, const char *buf, size_t len,



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
