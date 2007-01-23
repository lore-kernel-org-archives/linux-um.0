Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H9LWw-0004f7-Uj for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 05:17:43 -0800
Received: from allen.werkleitz.de ([80.190.251.108])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H9LWv-0005Rx-Uj
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 05:17:42 -0800
Date: Tue, 23 Jan 2007 14:17:30 +0100
From: Johannes Stezenbach <js@linuxtv.org>
Message-ID: <20070123131730.GA9286@linuxtv.org>
References: <20070122201317.GA8594@linuxtv.org>
	<200701230902.30715.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200701230902.30715.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] [UML] fix mknod
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Jan 23, 2007 at 09:02:30AM +0100, Blaisorblade wrote:
> On Monday 22 January 2007 21:13, Johannes Stezenbach wrote:
> >
> > I was playing with user-mode Linux and found that mknod creates
> > devices node in hostfs with wrong major/minor numbers.
> > The patch below fixes it for me.
> 
> Hmpf. Still having this bug on hostfs is quite bad. Thanks for reporting.
> 
> It should be hostfs_user.c to take major and minor and to combine them 
> correctly - it can use libc's macros.

Right, below is a better patch.


Thanks,
Johannes

---
Fix UML hostfs mknod(): userspace has differernt
dev_t size and encoding than kernel, so extract major/minor
and reencode using glibc makedev() macro.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

diff -rup linux-2.6.19.orig/fs/hostfs/hostfs.h linux-2.6.19/fs/hostfs/hostfs.h
--- linux-2.6.19.orig/fs/hostfs/hostfs.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/fs/hostfs/hostfs.h	2007-01-23 14:11:03.000000000 +0100
@@ -76,7 +76,7 @@ extern int make_symlink(const char *from
 extern int unlink_file(const char *file);
 extern int do_mkdir(const char *file, int mode);
 extern int do_rmdir(const char *file);
-extern int do_mknod(const char *file, int mode, int dev);
+extern int do_mknod(const char *file, int mode, unsigned int major, unsigned int minor);
 extern int link_file(const char *from, const char *to);
 extern int do_readlink(char *file, char *buf, int size);
 extern int rename_file(char *from, char *to);
diff -rup linux-2.6.19.orig/fs/hostfs/hostfs_kern.c linux-2.6.19/fs/hostfs/hostfs_kern.c
--- linux-2.6.19.orig/fs/hostfs/hostfs_kern.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/fs/hostfs/hostfs_kern.c	2007-01-23 14:11:20.000000000 +0100
@@ -755,7 +755,7 @@ int hostfs_mknod(struct inode *dir, stru
 		goto out_put;
 
 	init_special_inode(inode, mode, dev);
-	err = do_mknod(name, mode, dev);
+	err = do_mknod(name, mode, MAJOR(dev), MINOR(dev));
 	if(err)
 		goto out_free;
 
diff -rup linux-2.6.19.orig/fs/hostfs/hostfs_user.c linux-2.6.19/fs/hostfs/hostfs_user.c
--- linux-2.6.19.orig/fs/hostfs/hostfs_user.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/fs/hostfs/hostfs_user.c	2007-01-23 14:11:39.000000000 +0100
@@ -295,11 +295,11 @@ int do_rmdir(const char *file)
 	return(0);
 }
 
-int do_mknod(const char *file, int mode, int dev)
+int do_mknod(const char *file, int mode, unsigned int major, unsigned int minor)
 {
 	int err;
 
-	err = mknod(file, mode, dev);
+	err = mknod(file, mode, makedev(major, minor));
 	if(err) return(-errno);
 	return(0);
 }

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
