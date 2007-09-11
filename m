Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IV76M-0006jF-9O for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 07:52:31 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IV76I-0003GG-Ia
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 07:52:28 -0700
Date: Tue, 11 Sep 2007 10:52:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070911145222.GA6391@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 3/3 ] UML - More idiomatic parameter parsing
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "Robert P. J. Day" <rpjday@mindspring.com>

Make mconsole parameter parsing slightly more idiomatic.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/mconsole_kern.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.22/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/mconsole_kern.c	2007-09-09 10:23:29.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/mconsole_kern.c	2007-09-11 10:38:17.000000000 -0400
@@ -878,7 +878,7 @@ void unlock_notify(void)
 
 __initcall(create_proc_mconsole);
 
-#define NOTIFY "=notify:"
+#define NOTIFY "notify:"
 
 static int mconsole_setup(char *str)
 {
@@ -890,7 +890,7 @@ static int mconsole_setup(char *str)
 	return 1;
 }
 
-__setup("mconsole", mconsole_setup);
+__setup("mconsole=", mconsole_setup);
 
 __uml_help(mconsole_setup,
 "mconsole=notify:<socket>\n"

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
