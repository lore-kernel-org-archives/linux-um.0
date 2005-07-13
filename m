Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DslX6-0000xM-8D	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:32 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DslX4-0005lv-Eh	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:32 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050713180239.2C99021E742@zion.home.lan>
Subject: [uml-devel] [patch 8/9] uml - hostfs : unuse ROOT_DEV
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
Date: Wed, 13 Jul 2005 20:02:38 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, hch@infradead.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Christoph Hellwig <hch@infradead.org>

Minimal patch removing uses of ROOT_DEV; next patch unexports it. I've opposed
this, but I've planned to reintroduce the functionality without using
ROOT_DEV.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/fs/hostfs/hostfs_kern.c |    9 ---------
 1 files changed, 9 deletions(-)

diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-remove-root_dev-simple fs/hostfs/hostfs_kern.c
--- linux-2.6.git-broken/fs/hostfs/hostfs_kern.c~uml-hostfs-remove-root_dev-simple	2005-07-13 19:58:18.000000000 +0200
+++ linux-2.6.git-broken-paolo/fs/hostfs/hostfs_kern.c	2005-07-13 19:58:18.000000000 +0200
@@ -15,7 +15,6 @@
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
 #include <linux/list.h>
-#include <linux/root_dev.h>
 #include <linux/statfs.h>
 #include <linux/kdev_t.h>
 #include <asm/uaccess.h>
@@ -160,8 +159,6 @@ static int read_name(struct inode *ino, 
 	ino->i_size = i_size;
 	ino->i_blksize = i_blksize;
 	ino->i_blocks = i_blocks;
-	if((ino->i_sb->s_dev == ROOT_DEV) && (ino->i_uid == getuid()))
-		ino->i_uid = 0;
 	return(0);
 }
 
@@ -841,16 +838,10 @@ int hostfs_setattr(struct dentry *dentry
 		attrs.ia_mode = attr->ia_mode;
 	}
 	if(attr->ia_valid & ATTR_UID){
-		if((dentry->d_inode->i_sb->s_dev == ROOT_DEV) &&
-		   (attr->ia_uid == 0))
-			attr->ia_uid = getuid();
 		attrs.ia_valid |= HOSTFS_ATTR_UID;
 		attrs.ia_uid = attr->ia_uid;
 	}
 	if(attr->ia_valid & ATTR_GID){
-		if((dentry->d_inode->i_sb->s_dev == ROOT_DEV) &&
-		   (attr->ia_gid == 0))
-			attr->ia_gid = getgid();
 		attrs.ia_valid |= HOSTFS_ATTR_GID;
 		attrs.ia_gid = attr->ia_gid;
 	}
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
