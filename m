Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWqz-0004jW-V5 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:57 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWqy-0004Lq-6P for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:55:57 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231735.8C1E955C79@zion.localdomain>
Subject: [uml-devel] [patch 09/20] uml: use SIG_IGN for empty sighandler
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
Date: Thu, 04 Nov 2004 00:17:35 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it


Avoid creating a dummy no-op procedure instead of using SIG_IGN.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/drivers/chan_user.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

diff -puN arch/um/drivers/chan_user.c~uml-use-SIG_IGN-for-empty-handling arch/um/drivers/chan_user.c
--- vanilla-linux-2.6.9/arch/um/drivers/chan_user.c~uml-use-SIG_IGN-for-empty-handling	2004-11-03 23:44:59.439523936 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/drivers/chan_user.c	2004-11-03 23:44:59.442523480 +0100
@@ -37,10 +37,6 @@ int generic_console_write(int fd, const 
 	return(err);
 }
 
-static void winch_handler(int sig)
-{
-}
-
 struct winch_data {
 	int pty_fd;
 	int pipe_fd;
@@ -63,7 +59,7 @@ static int winch_thread(void *arg)
 		printk("winch_thread : failed to write synchronization "
 		       "byte, err = %d\n", -count);
 
-	signal(SIGWINCH, winch_handler);
+	signal(SIGWINCH, SIG_IGN);
 	sigfillset(&sigs);
 	sigdelset(&sigs, SIGWINCH);
 	if(sigprocmask(SIG_SETMASK, &sigs, NULL) < 0){
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
