Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1rgr-0002ZU-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 11:15:09 -0700
Received: from smtp.schwaar.com ([212.31.69.154])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1rgp-0008QV-HT
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Sep 2003 11:15:07 -0700
Mime-Version: 1.0
Message-Id: <p05111b01bb962e502881@[10.96.96.13]>
From: Hannes Schulz <schulz@schwaar.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Subject: [uml-devel] [PATCH] correct gid in hostfs_kern.c
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 23 Sep 2003 19:20:40 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com

I was reading hostfs_* because I wanted hostfs as rootfs (when 
launched by root).


Regards

Hannes


--- uml-2.4.22um5-orig/arch/um/fs/hostfs/hostfs_kern.c	2003-09-23 
15:21:33.000000000 +0200
+++ uml-2.4.22um5-hwh1/arch/um/fs/hostfs/hostfs_kern.c	2003-09-23 
15:24:42.000000000 +0200
@@ -766,7 +766,7 @@
  	if(attr->ia_valid & ATTR_GID){
  		if(kdev_same(dentry->d_inode->i_sb->s_dev, ROOT_DEV) &&
  		   (attr->ia_gid == 0))
-			attr->ia_gid = getuid();
+			attr->ia_gid = getgid();
  		attrs.ia_valid |= HOSTFS_ATTR_GID;
  		attrs.ia_gid = attr->ia_gid;
  	}


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
