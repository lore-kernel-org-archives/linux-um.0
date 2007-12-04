Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IzLH6-00075o-Dr for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 16:04:32 -0800
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IzLH6-0000m3-0L
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 16:04:32 -0800
Received: by wa-out-1112.google.com with SMTP id k22so6126263waf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 03 Dec 2007 16:04:29 -0800 (PST)
Message-ID: <ea9232d10712031604q30abb48cu1380abd4f661d0c7@mail.gmail.com>
Date: Tue, 4 Dec 2007 01:04:29 +0100
From: "Karol Swietlicki" <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml: Get rid of arch/um/Makefile-tt
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
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This patch removes a mostly empty file which is not used anymore.
Compile and run tested.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
---
diff -rupN orig/arch/um/Makefile-tt orig2/arch/um/Makefile-tt
--- orig/arch/um/Makefile-tt	2007-11-29 12:56:05.000000000 +0100
+++ orig2/arch/um/Makefile-tt	1970-01-01 01:00:00.000000000 +0100
@@ -1,5 +0,0 @@
-#
-# Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
-# Licensed under the GPL
-#
-

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
