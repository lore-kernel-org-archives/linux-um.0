Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1L2UsI-0006Ef-0R
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Nov 2008 18:00:30 +0000
Received: from ug-out-1314.google.com ([66.249.92.170])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L2UsG-0008II-En for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Nov 2008 18:00:29 +0000
Received: by ug-out-1314.google.com with SMTP id 36so326625uga.17
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 18 Nov 2008 10:00:25 -0800 (PST)
Date: Tue, 18 Nov 2008 18:00:03 +0000
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20081118180003.GF3185@hack.voiplan.pt>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [Patch] hostfs: fix a duplicated global function name
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net


fs/hostfs/hostfs_user.c defines do_readlink() as non-static,
and so does fs/xfs/linux-2.6/xfs_ioctl.c when CONFIG_XFS_DEBUG=y.
So rename do_readlink() in hostfs to hostfs_do_readlink().

I think it's better if XFS guys will also rename their do_readlink(),
it's not necessary to use such a general name.

Compile test only.

Signed-off-by: WANG Cong <wangcong@zeuux.org>
Cc: Jeff Dike <jdike@addtoit.com>


---
diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index 6ae9011..2f34f8f 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -81,7 +81,7 @@ extern int do_rmdir(const char *file);
 extern int do_mknod(const char *file, int mode, unsigned int major,
 		    unsigned int minor);
 extern int link_file(const char *from, const char *to);
-extern int do_readlink(char *file, char *buf, int size);
+extern int hostfs_do_readlink(char *file, char *buf, int size);
 extern int rename_file(char *from, char *to);
 extern int do_statfs(char *root, long *bsize_out, long long *blocks_out,
 		     long long *bfree_out, long long *bavail_out,
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 7f34f43..3a31451 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -168,7 +168,7 @@ static char *follow_link(char *link)
 		if (name == NULL)
 			goto out;
 
-		n = do_readlink(link, name, len);
+		n = hostfs_do_readlink(link, name, len);
 		if (n < len)
 			break;
 		len *= 2;
@@ -943,7 +943,7 @@ int hostfs_link_readpage(struct file *file, struct page *page)
 	name = inode_name(page->mapping->host, 0);
 	if (name == NULL)
 		return -ENOMEM;
-	err = do_readlink(name, buffer, PAGE_CACHE_SIZE);
+	err = hostfs_do_readlink(name, buffer, PAGE_CACHE_SIZE);
 	kfree(name);
 	if (err == PAGE_CACHE_SIZE)
 		err = -E2BIG;
diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
index 53fd0a6..b79424f 100644
--- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -377,7 +377,7 @@ int link_file(const char *to, const char *from)
 	return 0;
 }
 
-int do_readlink(char *file, char *buf, int size)
+int hostfs_do_readlink(char *file, char *buf, int size)
 {
 	int n;
 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
