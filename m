Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9BMa-0002Dn-A4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 16:17:16 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D9BMZ-0004J9-Ii for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 16:17:16 -0800
Message-Id: <200503100215.j2A2FkDN015217@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/9] UML - Fix hostfs typo
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
Date: Wed, 09 Mar 2005 21:15:46 -0500
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Fix a typo in the hostfs setgid code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/include/kern.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/kern.h	2005-03-08 20:13:55.000000000 -0500
+++ linux-2.6.11/arch/um/include/kern.h	2005-03-08 21:56:19.000000000 -0500
@@ -26,6 +26,7 @@
 extern void perror(char *err);
 extern int kill(int pid, int sig);
 extern int getuid(void);
+extern int getgid(void);
 extern int pause(void);
 extern int write(int, const void *, int);
 extern int exit(int);
Index: linux-2.6.11/fs/hostfs/hostfs_kern.c
===================================================================
--- linux-2.6.11.orig/fs/hostfs/hostfs_kern.c	2005-03-08 20:17:34.000000000 -0500
+++ linux-2.6.11/fs/hostfs/hostfs_kern.c	2005-03-08 20:18:15.000000000 -0500
@@ -845,7 +845,7 @@
 	if(attr->ia_valid & ATTR_GID){
 		if((dentry->d_inode->i_sb->s_dev == ROOT_DEV) &&
 		   (attr->ia_gid == 0))
-			attr->ia_gid = getuid();
+			attr->ia_gid = getgid();
 		attrs.ia_valid |= HOSTFS_ATTR_GID;
 		attrs.ia_gid = attr->ia_gid;
 	}



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
