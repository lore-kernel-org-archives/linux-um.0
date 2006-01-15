Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyEmu-0005Ui-7o for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2006 12:47:44 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EyEms-0005BO-SC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2006 12:47:44 -0800
Message-Id: <200601152139.k0FLdrwi027752@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 10/11] UML - Use setjmp/longjmp instead of
	sigsetjmp/siglongjmp
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
Date: Sun, 15 Jan 2006 16:39:53 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Now that we are doing soft interrupts, there's no point in using
sigsetjmp and siglongjmp.  Using setjmp and longjmp saves a
sigprocmask on every jump.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/include/longjmp.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/include/longjmp.h	2006-01-09 11:44:53.000000000 -0500
+++ linux-2.6.15-mm/arch/um/include/longjmp.h	2006-01-09 11:48:47.000000000 -0500
@@ -5,13 +5,13 @@
 #include "os.h"
 
 #define UML_SIGLONGJMP(buf, val) do { \
-	siglongjmp(*buf, val);		\
+	longjmp(*buf, val);	\
 } while(0)
 
 #define UML_SIGSETJMP(buf, enable) ({ \
 	int n; \
 	enable = get_signals(); \
-	n = sigsetjmp(*buf, 1); \
+	n = setjmp(*buf); \
 	if(n != 0) \
 		set_signals(enable); \
 	n; })



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
