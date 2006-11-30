Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GpsTO-0002LB-Lm for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Nov 2006 12:25:34 -0800
Received: from crown.reflexsecurity.com ([72.54.139.163])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GpsTN-0003St-73
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Nov 2006 12:25:34 -0800
Date: Thu, 30 Nov 2006 15:24:13 -0500
From: Jason Lunz <lunz@falooley.org>
Message-ID: <20061130202411.GA8628@knob.reflex>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] fix skas-2.6.19-rc6-v9-pre9 compile for linux
	2.6.19
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


linux/config.h is now included automatically. #including it by hand is a
build error in 2.6.19; this removes the three instances in the latest
skas3-2.6 patch.

Jason

---
 include/linux/proc_mm.h |    1 -
 mm/proc_mm-mod.c        |    1 -
 mm/proc_mm.c            |    1 -
 3 files changed, 3 deletions(-)

Index: linux-2.6.19/include/linux/proc_mm.h
===================================================================
--- linux-2.6.19.orig/include/linux/proc_mm.h
+++ linux-2.6.19/include/linux/proc_mm.h
@@ -6,7 +6,6 @@
 #ifndef __PROC_MM_H
 #define __PROC_MM_H
 
-#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/compiler.h>
 
Index: linux-2.6.19/mm/proc_mm-mod.c
===================================================================
--- linux-2.6.19.orig/mm/proc_mm-mod.c
+++ linux-2.6.19/mm/proc_mm-mod.c
@@ -1,4 +1,3 @@
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/proc_mm.h>
 #include <linux/ptrace.h>
Index: linux-2.6.19/mm/proc_mm.c
===================================================================
--- linux-2.6.19.orig/mm/proc_mm.c
+++ linux-2.6.19/mm/proc_mm.c
@@ -3,7 +3,6 @@
  * Licensed under the GPL
  */
 
-#include <linux/config.h>
 #include <linux/compiler.h>
 #include <linux/mm.h>
 #include <linux/init.h>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
