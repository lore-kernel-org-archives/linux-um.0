Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CLDTu-0007VK-Cw for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 21:26:18 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CLDTt-0001ge-CM for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 21:26:18 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041023035316.B7CC48F3C@zion.localdomain>
Subject: [uml-devel] [patch 2/5] UML: resync LDS script for SMP changes
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
Date: Sat, 23 Oct 2004 05:53:16 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Add a couple entries to the linker script which are needed for SMP to link.
(From Yan Burman)

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/dyn.lds.S |    2 ++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/uml.lds.S |    2 ++
 2 files changed, 4 insertions(+)

diff -puN arch/um/kernel/uml.lds.S~uml-smp-lds-fix arch/um/kernel/uml.lds.S
--- vanilla-linux-2.6.9/arch/um/kernel/uml.lds.S~uml-smp-lds-fix	2004-10-21 01:33:45.945044440 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/uml.lds.S	2004-10-21 01:33:45.947044136 +0200
@@ -35,6 +35,8 @@ SECTIONS
   {
     *(.text)
     SCHED_TEXT
+    LOCK_TEXT
+    *(.fixup)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
     *(.gnu.linkonce.t*)
diff -puN arch/um/kernel/dyn.lds.S~uml-smp-lds-fix arch/um/kernel/dyn.lds.S
--- vanilla-linux-2.6.9/arch/um/kernel/dyn.lds.S~uml-smp-lds-fix	2004-10-21 01:33:58.339160248 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/dyn.lds.S	2004-10-21 01:36:01.192483704 +0200
@@ -59,6 +59,8 @@ SECTIONS
   .text           : {
     *(.text)
     SCHED_TEXT
+    LOCK_TEXT
+    *(.fixup)
     *(.stub .text.* .gnu.linkonce.t.*)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
