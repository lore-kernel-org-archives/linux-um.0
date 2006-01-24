Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F1Wpn-0004wj-KE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Jan 2006 14:40:19 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F1Wpn-0004Wo-9p
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Jan 2006 14:40:19 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060124233226.GA8941@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [PATCH] include fixlet for uml-add-tls-support
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
Date: Tue, 24 Jan 2006 18:32:26 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, wstearns@pobox.net

linux/unistd.h is the place to get the _syscall* macros, not asm/unistd.h.
wstearns likes it, and it doesn't hurt me, so it seems to be good.

Index: linux-2.6.15/arch/um/os-Linux/tls.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/tls.c	2006-01-19 10:11:33.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/tls.c	2006-01-19 10:14:37.000000000 -0500
@@ -43,7 +43,7 @@ int os_get_thread_area(void *data, int p
 #endif
 
 #ifdef UML_CONFIG_MODE_TT
-#include "asm/unistd.h"
+#include "linux/unistd.h"
 
 _syscall1(int, get_thread_area, modify_ldt_t *, u_info);
 _syscall1(int, set_thread_area, modify_ldt_t *, u_info);


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
