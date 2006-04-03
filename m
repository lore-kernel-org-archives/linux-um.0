Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQRZP-0002Yn-Bl for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Apr 2006 09:06:23 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FQRZN-00017g-On
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Apr 2006 09:06:23 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060403150734.GA4081@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - TLS fixlets
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
Date: Mon, 3 Apr 2006 11:07:34 -0400
To: torvalds@osdl.org
Cc: Blaisorblade <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Two small TLS fixes -

arch/um/os-Linux/sys-i386/tls.c uses errno and -E* so it should include 
    errno.h
__setup_host_supports_tls returns 1, but as an initcall, it should return 0

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/os-Linux/sys-i386/tls.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/sys-i386/tls.c	2006-04-03 09:39:23.000000000 -0400
+++ linux-2.6.16/arch/um/os-Linux/sys-i386/tls.c	2006-04-03 09:39:42.000000000 -0400
@@ -1,3 +1,4 @@
+#include <errno.h>
 #include <linux/unistd.h>
 #include "sysdep/tls.h"
 #include "user_util.h"
Index: linux-2.6.16/arch/um/sys-i386/tls.c
===================================================================
--- linux-2.6.16.orig/arch/um/sys-i386/tls.c	2006-04-03 09:39:15.000000000 -0400
+++ linux-2.6.16/arch/um/sys-i386/tls.c	2006-04-03 09:39:43.000000000 -0400
@@ -378,7 +378,7 @@ static int __init __setup_host_supports_
 	} else
 		printk(KERN_ERR "  Host TLS support NOT detected! "
 				"TLS support inside UML will not work\n");
-	return 1;
+	return 0;
 }
 
 __initcall(__setup_host_supports_tls);


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
