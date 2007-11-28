Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxSDF-0001Q7-JM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 11:04:45 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxSDC-000059-Uh
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 11:04:45 -0800
Date: Wed, 28 Nov 2007 14:04:40 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071128190440.GA8313@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/4] UML - Work around host tcsetattr bug
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Under the conditions that UML uses it, tcgetattr is guaranteed to
return -EINTR when the console is attached to /dev/ptmx, making
generic_console_write hang because it loops, calling tcgetattr until
it succeeds.  This is a host bug - see
http://marc.info/?l=linux-kernel&m=119618990807182&w=2 for the
details.

This patch works around it by blocking SIGIO while the terminal
attributes are being fiddled.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/chan_user.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6.22/arch/um/drivers/chan_user.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/chan_user.c	2007-11-21 11:43:50.000000000 -0500
+++ linux-2.6.22/arch/um/drivers/chan_user.c	2007-11-27 14:03:10.000000000 -0500
@@ -74,10 +74,16 @@ void generic_free(void *data)
 
 int generic_console_write(int fd, const char *buf, int n)
 {
+	sigset_t old, no_sigio;
 	struct termios save, new;
 	int err;
 
 	if (isatty(fd)) {
+		sigemptyset(&no_sigio);
+		sigaddset(&no_sigio, SIGIO);
+		if (sigprocmask(SIG_BLOCK, &no_sigio, &old))
+			goto error;
+
 		CATCH_EINTR(err = tcgetattr(fd, &save));
 		if (err)
 			goto error;
@@ -97,8 +103,11 @@ int generic_console_write(int fd, const 
 	 * Restore raw mode, in any case; we *must* ignore any error apart
 	 * EINTR, except for debug.
 	 */
-	if (isatty(fd))
+	if (isatty(fd)) {
 		CATCH_EINTR(tcsetattr(fd, TCSAFLUSH, &save));
+		sigprocmask(SIG_SETMASK, &old, NULL);
+	}
+
 	return err;
 error:
 	return -errno;

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
