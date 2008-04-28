Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JqbcV-0002AP-No for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 15:14:47 -0700
Received: from feh.colobox.com ([209.177.154.210] ident=qmailr)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JqbcR-0007yW-Bp
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 15:14:47 -0700
Date: 28 Apr 2008 15:14:41 -0700
Message-ID: <20080428221441.13847.qmail@feh.colobox.com>
From: "Ryan Finnie" <ryan@finnie.org>
In-Reply-To: <20080428172840.GF9628@c2.user-mode-linux.org>
Subject: [uml-devel] [PATCH] SKAS4 - Clean up command line disable output
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

The PTRACE_GETSIGINFO notice was missing a linefeed.  In addition, tab 
and wrap each SKAS4 "disabled" message in parens so it doesn't break up 
the indendation within the switch_mm check block.

Signed-off-by: Ryan Finnie <ryan@finnie.org>
---

 start_up.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)


diff -ruN linux-2.6.24.orig/arch/um/os-Linux/start_up.c linux-2.6.24/arch/um/os-Linux/start_up.c
--- linux-2.6.24.orig/arch/um/os-Linux/start_up.c	2008-04-14 16:21:37.000000000 -0700
+++ linux-2.6.24/arch/um/os-Linux/start_up.c	2008-04-14 16:47:39.000000000 -0700
@@ -623,8 +623,8 @@
 		non_fatal("Failed\n");
 
 	if (disable_siginfo_segv)
-		non_fatal("Extended PTRACE_GETSIGINFO disabled on command "
-			  "line");
+		non_fatal("\t(Extended PTRACE_GETSIGINFO disabled on "
+			  "command line)\n");
 	else
 		have_siginfo_segv = 1;
 
@@ -688,7 +688,7 @@
 	close(there);
 
 	if (disable_switch_mm)
-		non_fatal("switch_mm support disabled on command line\n");
+		non_fatal("\t(switch_mm support disabled on command line)\n");
 	else
 		have_switch_mm = 1;
 
@@ -782,8 +782,8 @@
 	else non_fatal("OK\n");
 
 	if (disable_ptrace_switch_mm)
-		non_fatal("PTRACE_SWITCH_MM support disabled on command "
-			  "line\n");
+		non_fatal("\t(PTRACE_SWITCH_MM support disabled on command "
+			  "line)\n");
 	else
 		have_ptrace_switch_mm = 1;
 


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
