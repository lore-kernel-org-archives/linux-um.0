Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5qUI-0002SX-0Q for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 11:51:10 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C5qU2-0000rn-6n for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 11:51:00 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040910171543.76299C753@zion.localdomain>
Subject: [uml-devel] [patch 2/2] uml-remove-CONFIG_UML_SMP
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
Date: Fri, 10 Sep 2004 19:15:43 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Using CONFIG_UML_SMP and then making CONFIG_SMP = CONFIG_UML_SMP is useless
(there was a reason in 2.4, to have different help texts, but not now).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/Kconfig |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff -puN arch/um/Kconfig~uml-remove-CONFIG_UML_SMP arch/um/Kconfig
--- uml-linux-2.6.8.1/arch/um/Kconfig~uml-remove-CONFIG_UML_SMP	2004-08-29 14:40:57.198516280 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Kconfig	2004-08-29 14:40:57.201515824 +0200
@@ -154,8 +154,9 @@ config MAGIC_SYSRQ
 config HOST_2G_2G
 	bool "2G/2G host address space split"
 
-config UML_SMP
+config SMP
 	bool "Symmetric multi-processing support"
+	default n
 	help
         This option enables UML SMP support.  UML implements virtual SMP by
         allowing as many processes to run simultaneously on the host as
@@ -167,10 +168,6 @@ config UML_SMP
         CONFIG_SMP will be set to whatever this option is set to.
         It is safe to leave this unchanged.
 
-config SMP
-	bool
-	default UML_SMP
-
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
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
