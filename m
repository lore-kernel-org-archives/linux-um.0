Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbQx2-0005Bq-CF	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 15:35:40 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DbQx0-0007hj-QR	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 15:35:40 -0700
Message-Id: <200505262230.j4QMUVwq014693@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/7] UML - single-space a help message
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
Date: Thu, 26 May 2005 18:30:31 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

One of the ubd driver help strings was bust.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/ubd_kern.c	2005-05-26 17:17:01.000000000 -0400
+++ linux-2.6.11/arch/um/drivers/ubd_kern.c	2005-05-26 17:23:52.000000000 -0400
@@ -439,9 +439,9 @@ static int udb_setup(char *str)
 __setup("udb", udb_setup);
 __uml_help(udb_setup,
 "udb\n"
-"    This option is here solely to catch ubd -> udb typos, which can be\n\n"
-"    to impossible to catch visually unless you specifically look for\n\n"
-"    them.  The only result of any option starting with 'udb' is an error\n\n"
+"    This option is here solely to catch ubd -> udb typos, which can be\n"
+"    to impossible to catch visually unless you specifically look for\n"
+"    them.  The only result of any option starting with 'udb' is an error\n"
 "    in the boot output.\n\n"
 );
 



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
