Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFxie-0008OJ-Ae for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 09:35:48 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CFxid-0005J4-4T for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 09:35:48 -0700
Message-Id: <200410081635.i98GZgr02277@trolli.pdb.fsc.net>
From: bodo.stroesser@fujitsu-siemens.com
Subject: [uml-devel] Inconsistency in incremental patches 2.6.9
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
Date: Fri, 08 Oct 2004 18:35:40 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com

The incremental patches for 2.6.9 do not fully apply.
Before "signal-interface-cleaning" this patch is missing:

Bodo

--- orig/arch/um/kernel/signal_kern.c	2004-09-29 18:15:46.505334183 +0200
+++ new/arch/um/kernel/signal_kern.c	2004-09-29 18:16:37.813855152 +0200
@@ -88,9 +88,6 @@
 					    (unsigned long) ka->sa.sa_handler,
 					    restorer, regs, oldset);
 
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked, 


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
