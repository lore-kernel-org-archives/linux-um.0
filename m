Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuFjR-0006Lc-Qh for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:41 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EuFjR-0005Nf-JD
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:42 -0800
Message-Id: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/9] UML - Better diagnostics for broken configs
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
Date: Wed, 04 Jan 2006 16:51:59 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Produce a compile-time error if both MODE_SKAS and MODE_TT are disabled.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/include/choose-mode.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/choose-mode.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15/arch/um/include/choose-mode.h	2005-11-17 10:43:47.000000000 -0500
@@ -23,6 +23,9 @@ static inline void *__choose_mode(void *
 
 #elif defined(UML_CONFIG_MODE_TT)
 #define CHOOSE_MODE(tt, skas) (tt)
+
+#else
+#error CONFIG_MODE_SKAS and CONFIG_MODE_TT are both disabled
 #endif
 
 #define CHOOSE_MODE_PROC(tt, skas, args...) \



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
