Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4oWG-0004Rs-26	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 16:37:28 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E4oWF-0005If-Ol
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 16:37:28 -0700
Message-Id: <200508152325.j7FNP4JX009004@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/4] UML -
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
Date: Mon, 15 Aug 2005 19:25:04 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

From Al Viro:

Fix a macro typo which could break if the macro is passed arguments with
side-effects.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/include/sysdep-x86_64/ptrace.h	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/include/sysdep-x86_64/ptrace.h	2005-08-15 13:32:57.000000000 -0400
@@ -227,7 +227,7 @@
                         panic("Bad register in UPT_SET : %d\n", reg);  \
 			break; \
                 } \
-                val; \
+                __upt_val; \
         })
 
 #define UPT_SET_SYSCALL_RETURN(r, res) \



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
