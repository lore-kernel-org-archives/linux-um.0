Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6ZLN-0002B9-5s for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 11:44:57 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C6ZLM-0002YJ-Ef for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 11:44:57 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040912182629.3FEC49F37@zion.localdomain>
Subject: [uml-devel] [patch 2/2] add-SIGPROF-get-set_signals
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
Date: Sun, 12 Sep 2004 20:26:29 +0200
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Since local_irq_save() and local_irq_disable() should match (apart from saving the
flags), [gs]et_signals must match [un]block_signals, i.e. they must act onto
SIGPROF, too. At least IMHO.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/kernel/signal_user.c |   20 +++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff -puN arch/um/kernel/signal_user.c~uml-add-SIGPROF-get-set_signals arch/um/kernel/signal_user.c
--- uml-linux-2.6.8.1/arch/um/kernel/signal_user.c~uml-add-SIGPROF-get-set_signals	2004-08-29 14:40:54.102986872 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/signal_user.c	2004-08-29 14:40:54.104986568 +0200
@@ -83,14 +83,21 @@ void unblock_signals(void)
 
 #define SIGIO_BIT 0
 #define SIGVTALRM_BIT 1
+#define SIGPROF_BIT 2
 
-static int enable_mask(sigset_t *mask)
+/*
+ * Inverts the signal mask:
+ * @mask: a sigset_t* point to the mask of blocked signals.
+ * Returns a mask (of different type) of *unblocked* signals.
+ */
+static inline int enable_mask(const sigset_t *mask)
 {
 	int sigs;
 
 	sigs = sigismember(mask, SIGIO) ? 0 : 1 << SIGIO_BIT;
 	sigs |= sigismember(mask, SIGVTALRM) ? 0 : 1 << SIGVTALRM_BIT;
 	sigs |= sigismember(mask, SIGALRM) ? 0 : 1 << SIGVTALRM_BIT;
+	sigs |= sigismember(mask, SIGPROF) ? 0 : 1 << SIGPROF_BIT;
 	return(sigs);
 }
 
@@ -103,21 +110,26 @@ int get_signals(void)
 	return(enable_mask(&mask));
 }
 
+/*Returns the old mask of the old active signals (not sigset_t, but
+ * suitable for set_signals.*/
 int set_signals(int enable)
 {
 	sigset_t mask;
+	sigset_t old_mask;
 	int ret;
 
 	sigemptyset(&mask);
-	if(enable & (1 << SIGIO_BIT)) 
+	if(enable & (1 << SIGIO_BIT))
 		sigaddset(&mask, SIGIO);
 	if(enable & (1 << SIGVTALRM_BIT)){
 		sigaddset(&mask, SIGVTALRM);
 		sigaddset(&mask, SIGALRM);
 	}
-	if(sigprocmask(SIG_UNBLOCK, &mask, &mask) < 0)
+	if(enable & (1 << SIGPROF_BIT))
+		sigaddset(&mask, SIGPROF);
+	if(sigprocmask(SIG_UNBLOCK, &mask, &old_mask) < 0)
 		panic("Failed to enable signals");
-	ret = enable_mask(&mask);
+	ret = enable_mask(&old_mask);
 	sigemptyset(&mask);
 	if((enable & (1 << SIGIO_BIT)) == 0) 
 		sigaddset(&mask, SIGIO);
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
