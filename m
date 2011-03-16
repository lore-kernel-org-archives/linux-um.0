Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 15 Mar 2011 17:22:08 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Message-Id: <20110315172208.82934b13.randy.dunlap@oracle.com>
In-Reply-To: <20110315194543.a5d56c0c.sfr@canb.auug.org.au>
References: <20110315194543.a5d56c0c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH -next] uml: fix tty interface warnings
To: Stephen Rothwell <sfr@canb.auug.org.au>, gregkh@suse.de
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix tty interface warnings in arch/um:

arch/um/drivers/stdio_console.c:122: warning: initialization from incompatible pointer type
arch/um/drivers/ssl.c:139: warning: initialization from incompatible pointer type

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc:	Jeff Dike <jdike@addtoit.com>
Cc:	user-mode-linux-devel@lists.sourceforge.net
---
 arch/um/drivers/line.c        |    3 +--
 arch/um/include/shared/line.h |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

--- linux-next-20110315.orig/arch/um/drivers/line.c
+++ linux-next-20110315/arch/um/drivers/line.c
@@ -255,8 +255,7 @@ static const struct {
 	{ KDSIGACCEPT, KERN_INFO,  "KDSIGACCEPT" },
 };
 
-int line_ioctl(struct tty_struct *tty, struct file * file,
-	       unsigned int cmd, unsigned long arg)
+int line_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 {
 	int ret;
 	int i;
--- linux-next-20110315.orig/arch/um/include/shared/line.h
+++ linux-next-20110315/arch/um/include/shared/line.h
@@ -77,7 +77,7 @@ extern int line_chars_in_buffer(struct t
 extern void line_flush_buffer(struct tty_struct *tty);
 extern void line_flush_chars(struct tty_struct *tty);
 extern int line_write_room(struct tty_struct *tty);
-extern int line_ioctl(struct tty_struct *tty, struct file * file,
+extern int line_ioctl(struct tty_struct *tty,
 		      unsigned int cmd, unsigned long arg);
 extern void line_throttle(struct tty_struct *tty);
 extern void line_unthrottle(struct tty_struct *tty);
