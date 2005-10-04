Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EPoVA-00058G-70	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Oct 2005 14:51:08 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EPoVA-0002Zx-3i
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Oct 2005 14:51:08 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1EMs7p-0008SD-Ia	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 12:06:56 -0700
Message-Id: <200510041853.j94IrnqX008942@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/2] UML - Fix Al's build tidying
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
Date: Tue, 04 Oct 2005 14:53:49 -0400
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@ftp.linux.org.uk>

Al's build tidying missed one bit from me - without this UML doesn't boot.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
Index: linux-2.6.13/arch/um/sys-i386/user-offsets.c
===================================================================
--- linux-2.6.13.orig/arch/um/sys-i386/user-offsets.c	2005-10-04 13:33:39.000000000 -0400
+++ linux-2.6.13/arch/um/sys-i386/user-offsets.c	2005-10-04 14:57:24.000000000 -0400
@@ -46,7 +46,7 @@
 	OFFSET(HOST_SC_FP_ST, _fpstate, _st);
 	OFFSET(HOST_SC_FXSR_ENV, _fpstate, _fxsr_env);
 
-	DEFINE_LONGS(HOST_FRAME_SIZE, FRAME_SIZE);
+	DEFINE(HOST_FRAME_SIZE, FRAME_SIZE);
 	DEFINE_LONGS(HOST_FP_SIZE, sizeof(struct user_i387_struct));
 	DEFINE_LONGS(HOST_XFP_SIZE, sizeof(struct user_fxsr_struct));
 




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
