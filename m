Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DslX5-0000x3-Jd	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:31 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DslX5-0002eK-2m	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:31 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050713180228.4582021E739@zion.home.lan>
Subject: [uml-devel] [patch 5/9] uml: fix hppfs error path
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
Date: Wed, 13 Jul 2005 20:02:27 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Fix the error message to refer to the error code, i.e. err, not count, plus
add some cosmetical fixes.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/fs/hppfs/hppfs_kern.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN fs/hppfs/hppfs_kern.c~uml-hppfs-error-case fs/hppfs/hppfs_kern.c
--- linux-2.6.git-broken/fs/hppfs/hppfs_kern.c~uml-hppfs-error-case	2005-07-13 19:41:36.000000000 +0200
+++ linux-2.6.git-broken-paolo/fs/hppfs/hppfs_kern.c	2005-07-13 19:41:36.000000000 +0200
@@ -233,7 +233,7 @@ static ssize_t read_proc(struct file *fi
 		set_fs(USER_DS);
 
 	if(ppos) *ppos = file->f_pos;
-	return(n);
+	return n;
 }
 
 static ssize_t hppfs_read_file(int fd, char *buf, ssize_t count)
@@ -254,7 +254,7 @@ static ssize_t hppfs_read_file(int fd, c
 		err = os_read_file(fd, new_buf, cur);
 		if(err < 0){
 			printk("hppfs_read : read failed, errno = %d\n",
-			       count);
+			       err);
 			n = err;
 			goto out_free;
 		}
@@ -271,7 +271,7 @@ static ssize_t hppfs_read_file(int fd, c
  out_free:
 	kfree(new_buf);
  out:
-	return(n);
+	return n;
 }
 
 static ssize_t hppfs_read(struct file *file, char *buf, size_t count,
_


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
