Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BeoMQ-00064K-FU for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Jun 2004 22:07:18 -0700
Received: from lsmod.de ([217.172.172.73])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BeoMQ-0002UQ-2d for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Jun 2004 22:07:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by lsmod.de (Postfix) with ESMTP id 1BE3480415
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 28 Jun 2004 07:07:10 +0200 (CEST)
From: "Bernhard M. Wiedemann" <bernhard@lsmod.de>
Message-ID: <Pine.LNX.4.53.0406280630500.19434@ibiza.lsmod.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] exports
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
Date: Mon, 28 Jun 2004 07:07:10 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

Hi There

could someone please add those missing symbol exports?
I need them for a LKM.
thanks
Bernhard M. Wiedemann aka greenbird (users sf net)

diff -ur ./linux-2.6.6-um/arch/um/kernel/ksyms.c ./linux-2.6.5-um/arch/um/kernel/ksyms.c
--- ./linux-2.6.6-um/arch/um/kernel/ksyms.c    2004-06-16 20:28:56.000000000 +0200
+++ ./linux-2.6.5-um/arch/um/kernel/ksyms.c      2004-05-01 06:27:28.000000000 +0200
@@ -50,11 +50,13 @@
 EXPORT_SYMBOL(find_iomem);

 #ifdef CONFIG_MODE_TT
+EXPORT_SYMBOL(strncpy_from_user_tt);
 EXPORT_SYMBOL(copy_from_user_tt);
 EXPORT_SYMBOL(copy_to_user_tt);
 #endif

 #ifdef CONFIG_MODE_SKAS
+EXPORT_SYMBOL(strncpy_from_user_skas);
 EXPORT_SYMBOL(copy_to_user_skas);
 EXPORT_SYMBOL(copy_from_user_skas);
 #endif


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
