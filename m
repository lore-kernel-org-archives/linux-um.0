Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5qHc-00084w-Sw for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 11:38:04 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C5qHU-0007fV-SN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 11:37:59 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040910170859.24ABDC74B@zion.localdomain>
Subject: [uml-devel] [patch 1/1] Refer to CONFIG_USERMODE, not to CONFIG_UM
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
Date: Fri, 10 Sep 2004 19:08:58 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Correct one Kconfig dependency, which should refer to CONFIG_USERMODE rather
than to CONFIG_UM.
We should also figure out how to make the config process work better for UML.
We would like to make UML able to "source drivers/Kconfig" and have the right
drivers selectable (i.e. LVM, ramdisk, and so on) and the ones for actual
hardware excluded. I've been reading such a request even from Jeff Dike at the
last Kernel Summit, (in the lwn.net coverage) but without any followup.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/drivers/char/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/char/Kconfig~CONFIG_UM-is-USERMODE drivers/char/Kconfig
--- linux-2.6.9-current/drivers/char/Kconfig~CONFIG_UM-is-USERMODE	2004-09-10 19:08:43.631737936 +0200
+++ linux-2.6.9-current-paolo/drivers/char/Kconfig	2004-09-10 19:08:43.633737632 +0200
@@ -59,7 +59,7 @@ config VT_CONSOLE
 
 config HW_CONSOLE
 	bool
-	depends on VT && !S390 && !UM
+	depends on VT && !S390 && !USERMODE
 	default y
 
 config SERIAL_NONSTANDARD
_


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
