Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWqH-0004cs-U0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:13 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWqG-0000GY-Ev for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:13 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231740.3112355C7D@zion.localdomain>
Subject: [uml-devel] [patch 11/20] uml: remove SIGPROF from change_signals
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
Date: Thu, 04 Nov 2004 00:17:40 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>

Since local_irq_save() and local_irq_disable() should match (apart from saving
the flags), get/set_signals must match [un]block_signals, i.e. change_signals;
since get/set_signals don't enable/disable SIGPROF (and this behaviour is safe
as explained in the comment the patch adds, since the profiling code does not
interact with the kernel code), not even change_signals must toggle it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/signal_user.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/signal_user.c~uml-remove-SIGPROF-change_signals arch/um/kernel/signal_user.c
--- vanilla-linux-2.6.9/arch/um/kernel/signal_user.c~uml-remove-SIGPROF-change_signals	2004-11-03 23:44:59.984441096 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/signal_user.c	2004-11-03 23:44:59.986440792 +0100
@@ -57,6 +57,10 @@ int change_sig(int signal, int on)
 	return(!sigismember(&old, signal));
 }
 
+/* Both here and in set/get_signal we don't touch SIGPROF, because we must not
+ * disable profiling; it's safe because the profiling code does not interact
+ * with the kernel code at all.*/
+
 static void change_signals(int type)
 {
 	sigset_t mask;
@@ -65,7 +69,6 @@ static void change_signals(int type)
 	sigaddset(&mask, SIGVTALRM);
 	sigaddset(&mask, SIGALRM);
 	sigaddset(&mask, SIGIO);
-	sigaddset(&mask, SIGPROF);
 	if(sigprocmask(type, &mask, NULL) < 0)
 		panic("Failed to change signal mask - errno = %d", errno);
 }
_


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
