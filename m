Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Mdi-0007L7-NN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:07:34 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8Mdf-000203-Lb for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:07:34 -0800
Message-Id: <200503072037.j27Kbgbc003957@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/16] UML - Get rid of uneccessary hostfs build
	trick
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
Date: Mon, 07 Mar 2005 15:37:42 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Get rid of the grepping for __st_ino in hostfs, since it doesn't work on x86_64
(the grep finds it, but it is ifdefed out), and Al says it's unnecessary
anyway.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/fs/hostfs/Makefile
===================================================================
--- linux-2.6.11.orig/fs/hostfs/Makefile	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/fs/hostfs/Makefile	2005-03-05 12:09:15.000000000 -0500
@@ -3,13 +3,6 @@
 # Licensed under the GPL
 #
 
-# struct stat64 changed the inode field name between 2.2 and 2.4 from st_ino
-# to __st_ino.  It stayed in the same place, so as long as the correct name
-# is used, hostfs compiled on 2.2 should work on 2.4 and vice versa.
-
-STAT64_INO_FIELD := $(shell grep -q __st_ino /usr/include/bits/stat.h && \
-				echo __)st_ino
-
 hostfs-objs := hostfs_kern.o hostfs_user.o
 
 obj-y =
@@ -20,7 +13,5 @@
 USER_OBJS := $(filter %_user.o,$(obj-y) $(obj-m) $(SINGLE_OBJS))
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
-USER_CFLAGS += -DSTAT64_INO_FIELD=$(STAT64_INO_FIELD)
-
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
Index: linux-2.6.11/fs/hostfs/hostfs_user.c
===================================================================
--- linux-2.6.11.orig/fs/hostfs/hostfs_user.c	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/fs/hostfs/hostfs_user.c	2005-03-05 12:09:15.000000000 -0500
@@ -28,10 +28,7 @@
 	if(lstat64(path, &buf) < 0)
 		return(-errno);
 
-	/* See the Makefile for why STAT64_INO_FIELD is passed in
-	 * by the build
-	 */
-	if(inode_out != NULL) *inode_out = buf.STAT64_INO_FIELD;
+	if(inode_out != NULL) *inode_out = buf.st_ino;
 	if(mode_out != NULL) *mode_out = buf.st_mode;
 	if(nlink_out != NULL) *nlink_out = buf.st_nlink;
 	if(uid_out != NULL) *uid_out = buf.st_uid;



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
