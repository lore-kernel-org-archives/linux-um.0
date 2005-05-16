Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXmCb-0002DS-8z	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 13:28:37 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DXlkE-0001zx-1O	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 13:00:31 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050516180143.95BDB1993E0@zion.home.lan>
Subject: [uml-devel] [patch 1/1] uml: replace pause with sigsuspend
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
Date: Mon, 16 May 2005 20:01:41 +0200
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Replace pause with sigsuspend, to avoid needing to set an empty handler for SIGWINCH.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/drivers/chan_user.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff -puN arch/um/drivers/chan_user.c~uml-replace-pause-with-sigsuspend arch/um/drivers/chan_user.c
--- linux-2.6.git/arch/um/drivers/chan_user.c~uml-replace-pause-with-sigsuspend	2005-05-16 08:07:30.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/chan_user.c	2005-05-16 08:08:10.000000000 +0200
@@ -67,10 +67,6 @@ error:
  * it (see below for how we make sure to exit only on SIGWINCH).
  */
 
-static void winch_handler(int sig)
-{
-}
-
 struct winch_data {
 	int pty_fd;
 	int pipe_fd;
@@ -93,14 +89,11 @@ static int winch_thread(void *arg)
 		printk("winch_thread : failed to write synchronization "
 		       "byte, err = %d\n", -count);
 
-	/* We are not using SIG_IGN on purpose, so don't fix it as I thought to
-	 * do! If using SIG_IGN, the pause() call below would not stop on
-	 * SIGWINCH. */
-
-	signal(SIGWINCH, winch_handler);
 	sigfillset(&sigs);
 	sigdelset(&sigs, SIGWINCH);
-	/* Block anything else than SIGWINCH. */
+	/* Block anything else than SIGWINCH. XXX: Actually, this may be removed
+	 * maybe, due to sigsuspend below, which replaces the signal mask, but
+	 * let's keep it.*/
 	if(sigprocmask(SIG_SETMASK, &sigs, NULL) < 0){
 		printk("winch_thread : sigprocmask failed, errno = %d\n", 
 		       errno);
@@ -130,7 +123,7 @@ static int winch_thread(void *arg)
 	while(1){
 		/* This will be interrupted by SIGWINCH only, since other signals
 		 * are blocked.*/
-		pause();
+		sigsuspend(&sigs);
 
 		count = os_write_file(pipe_fd, &c, sizeof(c));
 		if(count != sizeof(c))
_


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
