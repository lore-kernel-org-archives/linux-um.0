Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHALj-0002I6-0e for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:17:07 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CHALa-0008Gu-NI for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:17:06 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001626.A9065868B@zion.localdomain>
Subject: [uml-devel] [patch 2/6] uml: fix warning for unused var
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
Date: Tue, 12 Oct 2004 02:16:26 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


That var is used only when CONFIG_UML_REAL_TIME_CLOCK is on, so #ifdef its
definition.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/time_kern.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/time_kern.c~uml-fix-unused-warning arch/um/kernel/time_kern.c
--- linux-2.6.9-current/arch/um/kernel/time_kern.c~uml-fix-unused-warning	2004-10-12 01:05:59.458570536 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/time_kern.c	2004-10-12 01:05:59.460570232 +0200
@@ -44,7 +44,9 @@ int timer_irq_inited = 0;
 
 static int first_tick;
 static unsigned long long prev_usecs;
+#ifdef CONFIG_UML_REAL_TIME_CLOCK
 static long long delta;   		/* Deviation per interval */
+#endif
 
 #define MILLION 1000000
 
@@ -60,7 +62,7 @@ void timer_irq(union uml_pt_regs *regs)
 	}
 
 	if(first_tick){
-#if defined(CONFIG_UML_REAL_TIME_CLOCK)
+#ifdef CONFIG_UML_REAL_TIME_CLOCK
 		/* We've had 1 tick */
 		unsigned long long usecs = os_usecs();
 
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
