Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXIWZ-0005v2-8v for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 07:56:19 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HXIWX-0007CP-QW
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 07:56:19 -0700
Date: Fri, 30 Mar 2007 10:52:55 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070330145255.GA5466@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/2] UML - Fix umid in xterm titles
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
To: Andrew Morton <akpm@osdl.org>
Cc: Davide Brini <davide.brini@unibo.it>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Davide Brini <davide.brini@unibo.it>

Calls lines_init() *after* xterm_title is modified to include umid.

Signed-off-by: Davide Brini <davide.brini@unibo.it>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/ssl.c           |    4 ++--
 arch/um/drivers/stdio_console.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/ssl.c	2007-03-30 10:11:01.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/ssl.c	2007-03-30 10:28:51.000000000 -0400
@@ -191,12 +191,12 @@ static int ssl_init(void)
 	ssl_driver = register_lines(&driver, &ssl_ops, serial_lines,
 				    ARRAY_SIZE(serial_lines));
 
-	lines_init(serial_lines, ARRAY_SIZE(serial_lines), &opts);
-
 	new_title = add_xterm_umid(opts.xterm_title);
 	if (new_title != NULL)
 		opts.xterm_title = new_title;
 
+	lines_init(serial_lines, ARRAY_SIZE(serial_lines), &opts);
+
 	ssl_init_done = 1;
 	register_console(&ssl_cons);
 	return 0;
Index: linux-2.6.21-mm/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/stdio_console.c	2007-03-30 10:11:01.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/stdio_console.c	2007-03-30 10:28:51.000000000 -0400
@@ -166,12 +166,12 @@ int stdio_init(void)
 		return -1;
 	printk(KERN_INFO "Initialized stdio console driver\n");
 
-	lines_init(vts, ARRAY_SIZE(vts), &opts);
-
 	new_title = add_xterm_umid(opts.xterm_title);
 	if(new_title != NULL)
 		opts.xterm_title = new_title;
 
+	lines_init(vts, ARRAY_SIZE(vts), &opts);
+
 	con_init_done = 1;
 	register_console(&stdiocons);
 	return 0;

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
