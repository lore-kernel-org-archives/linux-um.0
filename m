Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXN9j-0003jO-JF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 09:39:27 -0700
Received: from smtp.wp.pl ([212.77.101.160])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BXN9i-0004pQ-A5
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 09:39:26 -0700
Received: from unknown (HELO [172.16.13.24]) (sikkh@[213.25.96.171])
	(envelope-sender <sikkh@wp.pl>)
	by smtp.wp.pl (wp-smtpd) with RC4-MD5 encrypted SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	7 Jun 2004 18:39:16 +0200
From: Piotr Neuman <sikkh@wp.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rtJxAGRQ6SFBXdK"
Message-Id: <200406071844.27297.sikkh@wp.pl>
Subject: [uml-devel] Humfs directory creation bug.
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
Date: Mon, 7 Jun 2004 18:44:27 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_rtJxAGRQ6SFBXdK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Humfs code misreported device when getting stat info on directories. This code 
hopefully fixes that (mv will work with hardlinks as expected now). 

Apply to 2.4.26-1 UML release (in arch/um/fs/hostfs/). Patch:

Index: externfs.c
===================================================================
--- externfs.c	(revision 708)
+++ externfs.c	(working copy)
@@ -844,7 +844,6 @@
 		return(-ENOMEM);
 	err = (*ops->make_dir)(file, mode, current->fsuid, current->fsgid, 
 			       mount);
-	kfree(file);
 
 	inode = get_inode(ino->i_sb, dentry, ops, 1);
 	if(IS_ERR(inode)){
@@ -852,6 +851,11 @@
 		goto out;
 	}
 
+	err = read_name(inode, file);
+	kfree(file);
+	if(err)
+		goto out;
+
 	d_instantiate(dentry, inode);
 	inode->i_nlink = 2;
 	inode->i_mode = S_IFDIR | mode;

--Boundary-00=_rtJxAGRQ6SFBXdK
Content-Type: text/x-diff;
  charset="us-ascii";
  name="humfs_mkdir.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="humfs_mkdir.patch"

Index: externfs.c
===================================================================
--- externfs.c	(revision 708)
+++ externfs.c	(working copy)
@@ -844,7 +844,6 @@
 		return(-ENOMEM);
 	err = (*ops->make_dir)(file, mode, current->fsuid, current->fsgid, 
 			       mount);
-	kfree(file);
 
 	inode = get_inode(ino->i_sb, dentry, ops, 1);
 	if(IS_ERR(inode)){
@@ -852,6 +851,11 @@
 		goto out;
 	}
 
+	err = read_name(inode, file);
+	kfree(file);
+	if(err)
+		goto out;
+
 	d_instantiate(dentry, inode);
 	inode->i_nlink = 2;
 	inode->i_mode = S_IFDIR | mode;

--Boundary-00=_rtJxAGRQ6SFBXdK--


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
