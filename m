Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWra-0004kB-JG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:34 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWrY-0004SM-Qf for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:34 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231737.CCD4A55C7B@zion.localdomain>
Subject: [uml-devel] [patch 10/20] uml: catch EINTR in generic_console_write
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
Date: Thu, 04 Nov 2004 00:17:37 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it


Make generic_console_write() catch the EINTR error code and retry
doing the calls accordingly.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/drivers/chan_user.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff -puN arch/um/drivers/chan_user.c~uml-catch_eintr_generic_console_write arch/um/drivers/chan_user.c
--- vanilla-linux-2.6.9/arch/um/drivers/chan_user.c~uml-catch_eintr_generic_console_write	2004-11-03 23:44:59.720481224 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/drivers/chan_user.c	2004-11-03 23:44:59.722480920 +0100
@@ -27,14 +27,26 @@ int generic_console_write(int fd, const 
 	int err;
 
 	if(isatty(fd)){
-		tcgetattr(fd, &save);
+		CATCH_EINTR(err = tcgetattr(fd, &save));
+		if (err)
+			goto error;
 		new = save;
+		/* The terminal becomes a bit less raw, to handle \n also as
+		 * "Carriage Return", not only as "New Line". Otherwise, the new
+		 * line won't start at the first column.*/
 		new.c_oflag |= OPOST;
-		tcsetattr(fd, TCSAFLUSH, &new);
+		CATCH_EINTR(err = tcsetattr(fd, TCSAFLUSH, &new));
+		if (err)
+			goto error;
 	}
 	err = generic_write(fd, buf, n, NULL);
-	if(isatty(fd)) tcsetattr(fd, TCSAFLUSH, &save);
+	/* Restore raw mode, in any case; we *must* ignore any error apart
+	 * EINTR, except for debug.*/
+	if(isatty(fd))
+		CATCH_EINTR(tcsetattr(fd, TCSAFLUSH, &save));
 	return(err);
+error:
+	return(-errno);
 }
 
 struct winch_data {
_


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
