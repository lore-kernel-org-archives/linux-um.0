Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eazi1-0004fy-Jn for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:37 -0800
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eazhv-0001rk-Cc for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:34 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051112180748.20133.97774.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 7/9] uml console channels: fix the API of
	console_write
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
Date: Sat, 12 Nov 2005 19:07:52 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Since the 4th param is unused, remove it altogether.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/chan_kern.c |    5 ++---
 arch/um/drivers/chan_user.c |    2 +-
 arch/um/include/chan_user.h |    4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index 16e7dc8..5b58fad 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -89,8 +89,7 @@ static int not_configged_write(int fd, c
 	return(-EIO);
 }
 
-static int not_configged_console_write(int fd, const char *buf, int len,
-				       void *data)
+static int not_configged_console_write(int fd, const char *buf, int len)
 {
 	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
@@ -299,7 +298,7 @@ int console_write_chan(struct list_head 
 		chan = list_entry(ele, struct chan, list);
 		if(!chan->output || (chan->ops->console_write == NULL))
 			continue;
-		n = chan->ops->console_write(chan->fd, buf, len, chan->data);
+		n = chan->ops->console_write(chan->fd, buf, len);
 		if(chan->primary) ret = n;
 	}
 	return(ret);
diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 1c55d58..5d50d4a 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -20,7 +20,7 @@
 #include "choose-mode.h"
 #include "mode.h"
 
-int generic_console_write(int fd, const char *buf, int n, void *unused)
+int generic_console_write(int fd, const char *buf, int n)
 {
 	struct termios save, new;
 	int err;
diff --git a/arch/um/include/chan_user.h b/arch/um/include/chan_user.h
index f77d9aa..659bb3c 100644
--- a/arch/um/include/chan_user.h
+++ b/arch/um/include/chan_user.h
@@ -25,7 +25,7 @@ struct chan_ops {
 	void (*close)(int, void *);
 	int (*read)(int, char *, void *);
 	int (*write)(int, const char *, int, void *);
-	int (*console_write)(int, const char *, int, void *);
+	int (*console_write)(int, const char *, int);
 	int (*window_size)(int, void *, unsigned short *, unsigned short *);
 	void (*free)(void *);
 	int winch;
@@ -37,7 +37,7 @@ extern struct chan_ops fd_ops, null_ops,
 extern void generic_close(int fd, void *unused);
 extern int generic_read(int fd, char *c_out, void *unused);
 extern int generic_write(int fd, const char *buf, int n, void *unused);
-extern int generic_console_write(int fd, const char *buf, int n, void *state);
+extern int generic_console_write(int fd, const char *buf, int n);
 extern int generic_window_size(int fd, void *unused, unsigned short *rows_out,
 			       unsigned short *cols_out);
 extern void generic_free(void *data);



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
