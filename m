Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEsJp-0000ib-7H for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 09:37:41 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CEsJe-0002Eo-0p for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 09:37:41 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041005163021.B5E6FB00C@zion.localdomain>
Subject: [uml-devel] [patch 1/1] uml: remove SIGPROF from change_signals
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
Date: Tue, 05 Oct 2004 18:30:21 +0200
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>

Since local_irq_save() and local_irq_disable() should match (apart from saving
the flags), get/set_signals must match [un]block_signals, i.e. change_signals;
since get/set_signals don't enable/disable SIGPROF (and this behaviour is safe
as explained in the comment the patch adds, since the profiling code does not
interact with the kernel code), not even change_signals must toggle it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/kernel/signal_user.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/signal_user.c~uml-remove-SIGPROF-change_signals arch/um/kernel/signal_user.c
--- uml-linux-2.6.8.1/arch/um/kernel/signal_user.c~uml-remove-SIGPROF-change_signals	2004-09-21 18:11:58.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/signal_user.c	2004-09-21 18:11:58.000000000 +0200
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
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
