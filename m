Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Na5-0002EB-Q7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:07:53 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8Na4-0002dZ-8E for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:07:53 -0800
Message-Id: <200503072037.j27Kbnbc003967@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/16] UML - make the ubd driver recognize letters
	in device names
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
Date: Mon, 07 Mar 2005 15:37:49 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

ubd_get_config wasn't using the standard device number parser, which caused
it not to recognize letters.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/ubd_kern.c	2005-03-05 12:07:35.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/ubd_kern.c	2005-03-05 12:11:43.000000000 -0500
@@ -746,15 +746,9 @@
 static int ubd_get_config(char *name, char *str, int size, char **error_out)
 {
 	struct ubd *dev;
-	char *end;
 	int n, len = 0;
 
-	n = simple_strtoul(name, &end, 0);
-	if((*end != '\0') || (end == name)){
-		*error_out = "ubd_get_config : didn't parse device number";
-		return(-1);
-	}
-
+	n = parse_unit(&name);
 	if((n >= MAX_DEV) || (n < 0)){
 		*error_out = "ubd_get_config : device number out of range";
 		return(-1);



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
