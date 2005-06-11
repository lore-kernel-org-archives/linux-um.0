Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DguAa-0002V6-Uw	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 17:48:16 -0700
Received: from quack.cs.berkeley.edu ([128.32.132.234] helo=quack.quarl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DguAZ-0002GV-CV	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 17:48:16 -0700
Subject: Re: [uml-devel] hostfs permissions
References: <quack.20050609T2234.87is0msrl6@meow.quarl.org>
	<200506101803.21108.blaisorblade@yahoo.it>
	<quack.20050610T1314.87aclyvuim@quack.cs.berkeley.edu>
	<200506110026.24655.blaisorblade@yahoo.it>
From: Karl Chen <quarl@cs.berkeley.edu>
In-Reply-To: <200506110026.24655.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Sat, 11 Jun 2005 00:26:24 +0200")
Message-ID: <quack.20050610T1748.87psutn2gh@quack.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 10 Jun 2005 17:48:14 -0700
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

>>>>> On 2005-06-10 15:26 PDT, Blaisorblade  writes:

    Blaisorblade> Ok, in this case there's probably a simpler
    Blaisorblade> road: simply use a 2.4.27-1bs kernel. The
    Blaisorblade> implemented behaviour is that all created files
    Blaisorblade> will have the ID they have on the host, i.e. the
    Blaisorblade> ID of the user running UML.

Thanks for the tip!  I will be running UML under different user
IDs but I'd rather it always be the same uid inside the UML.  I
used this micropatch to get exactly the behavior I want.  It's
obviously for this particular experiment only; I still think
uid,gid mount options would be better in general.  I guess that's
only 5 or 10 more lines of code...


diff -u /home/quarl/proj/uml/linux/linux-2.4.27/arch/um/fs/hostfs/.backup/hostfs_kern.c.\~1\~ /home/quarl/proj/uml/linux/linux-2.4.27/arch/um/fs/hostfs/hostfs_kern.c
--- /home/quarl/proj/uml/linux/linux-2.4.27/arch/um/fs/hostfs/.backup/hostfs_kern.c.~1~	2005-06-10 16:58:51.000000000 -0700
+++ /home/quarl/proj/uml/linux/linux-2.4.27/arch/um/fs/hostfs/hostfs_kern.c	2005-06-10 17:35:01.829485585 -0700
@@ -1,3 +1,6 @@
+#define KLUDGE_FS_UID 7777
+#define KLUDGE_FS_GID 7777
+
 /*
  * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
  * Licensed under the GPL
@@ -142,6 +145,10 @@
 	ino->i_blocks = i_blocks;
 	if(kdev_same(ino->i_sb->s_dev, ROOT_DEV) && (ino->i_uid == getuid()))
 		ino->i_uid = 0;
+        else if (ino->i_uid == getuid()) {          /* KC KLUDGE */
+                ino->i_uid = KLUDGE_FS_UID;         /* KC KLUDGE */
+                ino->i_gid = KLUDGE_FS_GID;         /* KC KLUDGE */
+        }                                           /* KC KLUDGE */
 	return(0);
 }
 
@@ -760,13 +767,17 @@
 		if(kdev_same(dentry->d_inode->i_sb->s_dev, ROOT_DEV) &&
 		   (attr->ia_uid == 0))
 			attr->ia_uid = getuid();
+                else if (attr->ia_uid == KLUDGE_FS_UID) { /* KC KLUDGE */
+                        attr->ia_uid = getuid();          /* KC KLUDGE */
+                        attr->ia_gid = getgid();          /* KC KLUDGE */
+                }                                         /* KC KLUDGE */
 		attrs.ia_valid |= HOSTFS_ATTR_UID;
 		attrs.ia_uid = attr->ia_uid;
 	}
 	if(attr->ia_valid & ATTR_GID){
 		if(kdev_same(dentry->d_inode->i_sb->s_dev, ROOT_DEV) &&
 		   (attr->ia_gid == 0))
-			attr->ia_gid = getuid();
+			attr->ia_gid = getgid();
 		attrs.ia_valid |= HOSTFS_ATTR_GID;
 		attrs.ia_gid = attr->ia_gid;
 	}


-- 
Karl 2005-06-10 17:44


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
