Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGiHr-00015o-Um for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:51:31 -0800
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DGiHZ-0002Zm-7U for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:51:31 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050330173400.36A5FEFEFF@zion>
Subject: [uml-devel] [patch 6/8] uml: fix hostfs special perm handling [for
	2.6.12]
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
Date: Wed, 30 Mar 2005 19:34:00 +0200
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, rob@landley.net


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Rob Landley <rob@landley.net>
When opening devices nodes on hostfs, it does not make sense to call
access(), since we are not going to open the file on the host.

If the device node is owned by root, the root user in UML should succeed in
opening it, even if UML won't be able to open the file.

As reported by Rob Landley, UML currently does not follow this, so here's an
(untested) fix.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff -puN fs/hostfs/hostfs_kern.c~uml-fix-hostfs-special-perm-handling fs/hostfs/hostfs_kern.c
--- linux-2.6.11/fs/hostfs/hostfs_kern.c~uml-fix-hostfs-special-perm-handling	2005-03-22 20:10:07.000000000 +0100
+++ linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c	2005-03-22 20:12:45.000000000 +0100
@@ -806,15 +806,21 @@ int hostfs_permission(struct inode *ino,
 	char *name;
 	int r = 0, w = 0, x = 0, err;
 
-	if(desired & MAY_READ) r = 1;
-	if(desired & MAY_WRITE) w = 1;
-	if(desired & MAY_EXEC) x = 1;
+	if (desired & MAY_READ) r = 1;
+	if (desired & MAY_WRITE) w = 1;
+	if (desired & MAY_EXEC) x = 1;
 	name = inode_name(ino, 0);
-	if(name == NULL) return(-ENOMEM);
-	err = access_file(name, r, w, x);
+	if (name == NULL) return(-ENOMEM);
+
+	if (S_ISCHR(ino->i_mode) || S_ISBLK(ino->i_mode) ||
+			S_ISFIFO(ino->i_mode) || S_ISSOCK(ino->i_mode))
+		err = 0;
+	else
+		err = access_file(name, r, w, x);
 	kfree(name);
-	if(!err) err = generic_permission(ino, desired, NULL);
-	return(err);
+	if(!err)
+		err = generic_permission(ino, desired, NULL);
+	return err;
 }
 
 int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
_


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
