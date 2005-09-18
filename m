Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EH04k-00056X-7b	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:23:26 -0700
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EH04i-00024d-5j	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:23:26 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050918140953.31461.96489.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Subject: [uml-devel] [PATCH 05/12] HPPFS: check copy_*_user calls
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
Date: Sun, 18 Sep 2005 16:09:53 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

Add missing checking for copy_to_user() calls, and fix the existing ones
(we must return the number of correctly read bytes - XXX: verify please.).
---

 fs/hppfs/hppfs_kern.c |   36 +++++++++++++++++++++---------------
 1 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -258,7 +258,7 @@ static ssize_t read_proc(struct file *fi
 static ssize_t hppfs_read_file(int fd, char *buf, ssize_t count)
 {
 	ssize_t n;
-	int cur, err;
+	int cur, ret;
 	char *new_buf;
 
 	n = -ENOMEM;
@@ -268,27 +268,30 @@ static ssize_t hppfs_read_file(int fd, c
 		goto out;
 	}
 	n = 0;
-	while(count > 0){
+	while (count > 0) {
+		unsigned long left;
 		cur = min_t(ssize_t, count, PAGE_SIZE);
-		err = os_read_file(fd, new_buf, cur);
-		if(err < 0){
-			printk("hppfs_read : read failed, errno = %d\n", -err);
-			n = err;
+		ret = os_read_file(fd, new_buf, cur);
+		if (ret < 0) {
+			printk("hppfs_read : read failed, errno = %d\n", -ret);
+			n = ret;
 			goto out_free;
-		}
-		else if(err == 0)
+		} else if (ret == 0)
 			break;
 
-		if(copy_to_user(buf, new_buf, err)){
-			n = -EFAULT;
+		left = copy_to_user(buf, new_buf, ret);
+		n += ret - left;
+		count -= ret - left;
+
+		if (left) {
+			if (!n)
+				n = -EFAULT;
 			goto out_free;
 		}
-		n += err;
-		count -= err;
 	}
- out_free:
+out_free:
 	kfree(new_buf);
- out:
+out:
 	return n;
 }
 
@@ -313,7 +316,10 @@ static ssize_t hppfs_read(struct file *f
 
 		if(off + count > hppfs->len)
 			count = hppfs->len - off;
-		copy_to_user(buf, &data->contents[off], count);
+		err = copy_to_user(buf, &data->contents[off], count);
+		count -= err;
+		if (!count)
+			return -EFAULT;
 		*ppos += count;
 	} else if(hppfs->host_fd != -1) {
 		err = os_seek_file(hppfs->host_fd, *ppos);



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
