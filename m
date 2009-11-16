Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1752724AbZKPA1k@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/12] arch/um: handle compat_ioctl in tty line driver
Date: Mon, 16 Nov 2009 00:26:56 +0000
Message-Id: <1258331227-1694-2-git-send-email-arnd@arndb.de>
In-Reply-To: <1258331227-1694-1-git-send-email-arnd@arndb.de>
References: <1258331227-1694-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, Alexey Dobriyan <adobriyan@gmail.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This pushes the handling of VT specific ioctls down to the
UML specific drivers so we can remove it from the common
compat_ioctl.c file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net
---
 arch/um/drivers/line.c          |    6 ++++++
 arch/um/drivers/ssl.c           |    1 +
 arch/um/drivers/stdio_console.c |    1 +
 arch/um/include/shared/line.h   |    2 ++
 4 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index cf8a97f..e819d9b 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -315,6 +315,12 @@ int line_ioctl(struct tty_struct *tty, struct file * file,
 	return ret;
 }
 
+long line_compat_ioctl(struct tty_struct *tty, struct file * file,
+	       unsigned int cmd, unsigned long arg)
+{
+	return line_ioctl(tty, file, cmd, arg);
+}
+
 void line_throttle(struct tty_struct *tty)
 {
 	struct line *line = tty->driver_data;
diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index f1786e6..eccf14a 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -137,6 +137,7 @@ static const struct tty_operations ssl_ops = {
 	.flush_chars 		= line_flush_chars,
 	.set_termios 		= line_set_termios,
 	.ioctl 	 		= line_ioctl,
+	.compat_ioctl 	 	= line_compat_ioctl,
 	.throttle 		= line_throttle,
 	.unthrottle 		= line_unthrottle,
 #if 0
diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_console.c
index 49266f6..2cb1f04 100644
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -120,6 +120,7 @@ static const struct tty_operations console_ops = {
 	.flush_chars 		= line_flush_chars,
 	.set_termios 		= line_set_termios,
 	.ioctl 	 		= line_ioctl,
+	.compat_ioctl 	 	= line_compat_ioctl,
 	.throttle 		= line_throttle,
 	.unthrottle 		= line_unthrottle,
 };
diff --git a/arch/um/include/shared/line.h b/arch/um/include/shared/line.h
index 311a0d3..6ef62e4 100644
--- a/arch/um/include/shared/line.h
+++ b/arch/um/include/shared/line.h
@@ -79,6 +79,8 @@ extern void line_flush_chars(struct tty_struct *tty);
 extern int line_write_room(struct tty_struct *tty);
 extern int line_ioctl(struct tty_struct *tty, struct file * file,
 		      unsigned int cmd, unsigned long arg);
+extern long line_compat_ioctl(struct tty_struct *tty, struct file * file,
+		      unsigned int cmd, unsigned long arg);
 extern void line_throttle(struct tty_struct *tty);
 extern void line_unthrottle(struct tty_struct *tty);
 
-- 
1.6.3.3

