Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiri Slaby <jslaby@suse.cz>
Date: Mon,  4 Jun 2012 13:35:26 +0200
Message-Id: <1338809738-18967-13-git-send-email-jslaby@suse.cz>
In-Reply-To: <1338809738-18967-1-git-send-email-jslaby@suse.cz>
References: <1338809738-18967-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 12/24] TTY: um/line, add tty_port
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

And use count from there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
 arch/um/drivers/line.c |    7 ++++---
 arch/um/drivers/line.h |    2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index acfd0e0..482a7bd 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -404,7 +404,7 @@ int line_open(struct line *lines, struct tty_struct *tty)
 		goto out_unlock;
 
 	err = 0;
-	if (line->count++)
+	if (line->port.count++)
 		goto out_unlock;
 
 	BUG_ON(tty->driver_data);
@@ -446,7 +446,7 @@ void line_close(struct tty_struct *tty, struct file * filp)
 	mutex_lock(&line->count_lock);
 	BUG_ON(!line->valid);
 
-	if (--line->count)
+	if (--line->port.count)
 		goto out_unlock;
 
 	line->tty = NULL;
@@ -478,7 +478,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 
 	mutex_lock(&line->count_lock);
 
-	if (line->count) {
+	if (line->port.count) {
 		*error_out = "Device is already open";
 		goto out;
 	}
@@ -663,6 +663,7 @@ int register_lines(struct line_driver *line_driver,
 	driver->init_termios = tty_std_termios;
 	
 	for (i = 0; i < nlines; i++) {
+		tty_port_init(&lines[i].port);
 		spin_lock_init(&lines[i].lock);
 		mutex_init(&lines[i].count_lock);
 		lines[i].driver = line_driver;
diff --git a/arch/um/drivers/line.h b/arch/um/drivers/line.h
index 0a18347..0e06a1f 100644
--- a/arch/um/drivers/line.h
+++ b/arch/um/drivers/line.h
@@ -32,9 +32,9 @@ struct line_driver {
 };
 
 struct line {
+	struct tty_port port;
 	struct tty_struct *tty;
 	struct mutex count_lock;
-	unsigned long count;
 	int valid;
 
 	char *init_str;
-- 
1.7.10.3


