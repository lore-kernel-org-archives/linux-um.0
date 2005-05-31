Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dd9eO-0001FO-DL	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 May 2005 09:31:32 -0700
Received: from 81-223-63-139.dynamic.adsl-line.inode.at ([81.223.63.139]
	helo=mercury.foo)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1Dd9eN-0004kO-Cx
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 May 2005 09:31:32 -0700
From: Dominik Hackl <dominik@hackl.dhs.org>
Message-ID: <Pine.LNX.4.61.0505311804570.10685@mercury.foo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] [PATCH 2.6.12-rc5] UML + UDF duplicated symbol
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
Date: Tue, 31 May 2005 18:31:51 +0200 (CEST)
To: bfennema@falcon.csc.calpoly.edu
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net



Linux with UDF compiled in, can't be linked against the libc (needed for 
UML).

This patch makes the variable __mon_yday static and avoids a namespace 
conflict with the libc.


	Signed-off-by: Dominik Hackl <dominik@hackl.dhs.org>



--- linux-2.6.12-rc5.orig/fs/udf/udftime.c	2005-05-25 20:37:16.000000000 +0200
+++ linux-2.6.12-rc5/fs/udf/udftime.c	2005-05-31 16:51:11.000000000 +0200
@@ -46,7 +46,7 @@
 #endif
 
 /* How many days come before each month (0-12).  */
-const unsigned short int __mon_yday[2][13] =
+const static unsigned short int __mon_yday[2][13] =
 {
 	/* Normal years.  */
 	{ 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365 },


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
