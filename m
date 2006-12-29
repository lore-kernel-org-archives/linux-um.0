Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H0RQy-0002xe-TZ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Dec 2006 15:46:44 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H0RQy-0007gx-59
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Dec 2006 15:46:44 -0800
Message-Id: <200612292341.kBTNfSLf005539@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 29 Dec 2006 18:41:28 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/6] UML - Console whitespace and comment tidying
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Some comment and whitespace cleanups in the console and mconsole code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

--
 arch/um/drivers/stdio_console.c |    2 --
 arch/um/include/mconsole_kern.h |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)


Index: linux-2.6.18-mm/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stdio_console.c	2006-12-29 17:26:54.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/stdio_console.c	2006-12-29 18:20:43.000000000 -0500
@@ -30,8 +30,6 @@
 
 #define MAX_TTYS (16)
 
-/* ----------------------------------------------------------------------------- */
-
 /* Referenced only by tty_driver below - presumably it's locked correctly
  * by the tty driver.
  */
Index: linux-2.6.18-mm/arch/um/include/mconsole_kern.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/mconsole_kern.h	2006-12-29 17:26:54.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/mconsole_kern.h	2006-12-29 18:21:37.000000000 -0500
@@ -20,7 +20,7 @@ struct mc_device {
 	char *name;
 	int (*config)(char *, char **);
 	int (*get_config)(char *, char *, int, char **);
-        int (*id)(char **, int *, int *);
+	int (*id)(char **, int *, int *);
 	int (*remove)(int, char **);
 };
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
