Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IicJj-0002im-NW for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 13:50:07 -0700
Received: from wa-out-1112.google.com ([209.85.146.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IicJi-0002sc-Hd
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 13:50:07 -0700
Received: by wa-out-1112.google.com with SMTP id k22so544972waf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 18 Oct 2007 13:50:06 -0700 (PDT)
Message-ID: <ea9232d10710181350v1330e008w2b2cd436602025c5@mail.gmail.com>
Date: Thu, 18 Oct 2007 22:50:05 +0200
From: Magotari <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML: Gprof needs frame pointers.
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
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a short Kconfig fix for a problem in User Mode Linux.
Frame pointers are required for gprof support to work.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>

---

--- linux-2.6.23-mm1/arch/um/Kconfig.debug	2007-10-18 22:24:13.000000000 +0200
+++ linux-2.6.23-mm1.local/arch/um/Kconfig.debug	2007-10-18
22:04:04.000000000 +0200
@@ -4,7 +4,7 @@

 config GPROF
 	bool "Enable gprof support"
-	depends on DEBUG_INFO
+	depends on DEBUG_INFO && FRAME_POINTER
 	help
 	  This allows profiling of a User-Mode Linux kernel with the gprof
 	  utility.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
