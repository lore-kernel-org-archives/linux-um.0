Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyBKc-0000Ro-G4	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 09:34:02 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1DyBKK-0001km-Ez
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 09:34:02 -0700
Message-Id: <200507281626.j6SGQrKe009502@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/7] UML - Clean up prink calls
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
Date: Thu, 28 Jul 2005 12:26:53 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Christophe Lucas <clucas@rotomalug.org>, Domen Puncer <domen@coderock.org>

From: Christophe Lucas <clucas@rotomalug.org>

printk() calls should include appropriate KERN_* constant.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/drivers/mconsole_kern.c	2005-07-27 16:39:27.000000000 -0400
+++ linux-2.6.12/arch/um/drivers/mconsole_kern.c	2005-07-27 16:39:53.000000000 -0400
@@ -557,7 +557,7 @@
 
 	ent = create_proc_entry("mconsole", S_IFREG | 0200, NULL);
 	if(ent == NULL){
-		printk("create_proc_mconsole : create_proc_entry failed\n");
+		printk(KERN_INFO "create_proc_mconsole : create_proc_entry failed\n");
 		return(0);
 	}
 
Index: linux-2.6.12/arch/um/kernel/exitcode.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/exitcode.c	2005-07-27 16:39:26.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/exitcode.c	2005-07-27 16:39:53.000000000 -0400
@@ -48,7 +48,7 @@
 
 	ent = create_proc_entry("exitcode", 0600, &proc_root);
 	if(ent == NULL){
-		printk("make_proc_exitcode : Failed to register "
+		printk(KERN_WARNING "make_proc_exitcode : Failed to register "
 		       "/proc/exitcode\n");
 		return(0);
 	}
Index: linux-2.6.12/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/process_kern.c	2005-07-27 16:39:29.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/process_kern.c	2005-07-27 16:39:53.000000000 -0400
@@ -412,7 +412,7 @@
 
 	if (ent == NULL)
 	{
-		printk("Failed to register /proc/sysemu\n");
+		printk(KERN_WARNING "Failed to register /proc/sysemu\n");
 		return(0);
 	}
 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
