Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eazhx-0004ft-MI for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:33 -0800
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eazhr-0001wX-BW for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:33 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051112180738.20133.98491.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 6/9] uml console channels: remove console_write
	wrappers
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
Date: Sat, 12 Nov 2005 19:07:46 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

We were using a long series of (stupid) wrappers which all call
generic_console_write(). Since the wrappers only change the 4th param, which is
unused by the called proc, remove them and call generic_console_write()
directly.

If needed at any time in the future to reintroduce this stuff, the member could
be moved to a generic struct, to avoid this duplicated handling.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/fd.c        |    9 +--------
 arch/um/drivers/port_user.c |    9 +--------
 arch/um/drivers/pty.c       |   11 ++---------
 arch/um/drivers/tty.c       |    9 +--------
 arch/um/drivers/xterm.c     |    9 +--------
 5 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/arch/um/drivers/fd.c b/arch/um/drivers/fd.c
index f0b888f..3296e86 100644
--- a/arch/um/drivers/fd.c
+++ b/arch/um/drivers/fd.c
@@ -76,13 +76,6 @@ static void fd_close(int fd, void *d)
 	}
 }
 
-static int fd_console_write(int fd, const char *buf, int n, void *d)
-{
-	struct fd_chan *data = d;
-
-	return(generic_console_write(fd, buf, n, &data->tt));
-}
-
 struct chan_ops fd_ops = {
 	.type		= "fd",
 	.init		= fd_init,
@@ -90,7 +83,7 @@ struct chan_ops fd_ops = {
 	.close		= fd_close,
 	.read		= generic_read,
 	.write		= generic_write,
-	.console_write	= fd_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= generic_free,
 	.winch		= 1,
diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
index ed4a1a6..c43e8bb 100644
--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -100,13 +100,6 @@ static void port_close(int fd, void *d)
 	os_close_file(fd);
 }
 
-static int port_console_write(int fd, const char *buf, int n, void *d)
-{
-	struct port_chan *data = d;
-
-	return(generic_console_write(fd, buf, n, &data->tt));
-}
-
 struct chan_ops port_ops = {
 	.type		= "port",
 	.init		= port_init,
@@ -114,7 +107,7 @@ struct chan_ops port_ops = {
 	.close		= port_close,
 	.read	        = generic_read,
 	.write		= generic_write,
-	.console_write	= port_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= port_free,
 	.winch		= 1,
diff --git a/arch/um/drivers/pty.c b/arch/um/drivers/pty.c
index 0306a1b..1c555c3 100644
--- a/arch/um/drivers/pty.c
+++ b/arch/um/drivers/pty.c
@@ -118,13 +118,6 @@ static int pty_open(int input, int outpu
 	return(fd);
 }
 
-static int pty_console_write(int fd, const char *buf, int n, void *d)
-{
-	struct pty_chan *data = d;
-
-	return(generic_console_write(fd, buf, n, &data->tt));
-}
-
 struct chan_ops pty_ops = {
 	.type		= "pty",
 	.init		= pty_chan_init,
@@ -132,7 +125,7 @@ struct chan_ops pty_ops = {
 	.close		= generic_close,
 	.read		= generic_read,
 	.write		= generic_write,
-	.console_write	= pty_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= generic_free,
 	.winch		= 0,
@@ -145,7 +138,7 @@ struct chan_ops pts_ops = {
 	.close		= generic_close,
 	.read		= generic_read,
 	.write		= generic_write,
-	.console_write	= pty_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= generic_free,
 	.winch		= 0,
diff --git a/arch/um/drivers/tty.c b/arch/um/drivers/tty.c
index 6fbb670..94c9265 100644
--- a/arch/um/drivers/tty.c
+++ b/arch/um/drivers/tty.c
@@ -60,13 +60,6 @@ static int tty_open(int input, int outpu
 	return(fd);
 }
 
-static int tty_console_write(int fd, const char *buf, int n, void *d)
-{
-	struct tty_chan *data = d;
-
-	return(generic_console_write(fd, buf, n, &data->tt));
-}
-
 struct chan_ops tty_ops = {
 	.type		= "tty",
 	.init		= tty_chan_init,
@@ -74,7 +67,7 @@ struct chan_ops tty_ops = {
 	.close		= generic_close,
 	.read		= generic_read,
 	.write		= generic_write,
-	.console_write	= tty_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= generic_free,
 	.winch		= 0,
diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
index b530f1a..aaa6366 100644
--- a/arch/um/drivers/xterm.c
+++ b/arch/um/drivers/xterm.c
@@ -194,13 +194,6 @@ static void xterm_free(void *d)
 	free(d);
 }
 
-static int xterm_console_write(int fd, const char *buf, int n, void *d)
-{
-	struct xterm_chan *data = d;
-
-	return(generic_console_write(fd, buf, n, &data->tt));
-}
-
 struct chan_ops xterm_ops = {
 	.type		= "xterm",
 	.init		= xterm_init,
@@ -208,7 +201,7 @@ struct chan_ops xterm_ops = {
 	.close		= xterm_close,
 	.read		= generic_read,
 	.write		= generic_write,
-	.console_write	= xterm_console_write,
+	.console_write	= generic_console_write,
 	.window_size	= generic_window_size,
 	.free		= xterm_free,
 	.winch		= 1,



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
