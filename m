Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dywbv-0002iR-LB	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 12:03:03 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1Dywbu-0005sh-42
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 12:03:03 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050730190539.DA3481AEA0@zion.home.lan>
Subject: [uml-devel] [patch 3/3] uml: fix SIGWINCH handler race while waiting
	for signals.
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
Date: Sat, 30 Jul 2005 21:05:39 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, bstroesser@fujitsu-siemens.com


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

If a SIGWINCH comes in, while winch_thread() isn't waiting
in wait(), winch_thread could miss signals.
It isn't very probable, that anyone will see this causing
trouble, as it would need a very special timing, that a
missed SIGWINCH results in a wrong window size.

So, this is a minor problem. But why not fix, as it can
be done so easy?

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/drivers/chan_user.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff -puN arch/um/drivers/chan_user.c~uml-fix-winch_thread arch/um/drivers/chan_user.c
--- linux-2.6.git/arch/um/drivers/chan_user.c~uml-fix-winch_thread	2005-07-30 18:03:31.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/chan_user.c	2005-07-30 18:03:31.000000000 +0200
@@ -63,7 +63,7 @@ error:
  *
  * SIGWINCH can't be received synchronously, so you have to set up to receive it
  * as a signal.  That being the case, if you are going to wait for it, it is
- * convenient to sit in a pause() and wait for the signal to bounce you out of
+ * convenient to sit in sigsuspend() and wait for the signal to bounce you out of
  * it (see below for how we make sure to exit only on SIGWINCH).
  */
 
@@ -94,18 +94,19 @@ static int winch_thread(void *arg)
 		       "byte, err = %d\n", -count);
 
 	/* We are not using SIG_IGN on purpose, so don't fix it as I thought to
-	 * do! If using SIG_IGN, the pause() call below would not stop on
+	 * do! If using SIG_IGN, the sigsuspend() call below would not stop on
 	 * SIGWINCH. */
 
 	signal(SIGWINCH, winch_handler);
 	sigfillset(&sigs);
-	sigdelset(&sigs, SIGWINCH);
-	/* Block anything else than SIGWINCH. */
+	/* Block all signals possible. */
 	if(sigprocmask(SIG_SETMASK, &sigs, NULL) < 0){
 		printk("winch_thread : sigprocmask failed, errno = %d\n", 
 		       errno);
 		exit(1);
 	}
+	/* In sigsuspend(), block anything else than SIGWINCH. */
+	sigdelset(&sigs, SIGWINCH);
 
 	if(setsid() < 0){
 		printk("winch_thread : setsid failed, errno = %d\n", errno);
@@ -130,7 +131,7 @@ static int winch_thread(void *arg)
 	while(1){
 		/* This will be interrupted by SIGWINCH only, since other signals
 		 * are blocked.*/
-		pause();
+		sigsuspend(&sigs);
 
 		count = os_write_file(pipe_fd, &c, sizeof(c));
 		if(count != sizeof(c))
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
