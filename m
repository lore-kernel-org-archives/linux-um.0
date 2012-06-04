Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Sbdsc-00017y-2i
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 20:27:58 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Sbdsb-0005iv-6r
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 20:27:58 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon,  4 Jun 2012 22:27:34 +0200
Message-Id: <1338841657-30358-4-git-send-email-richard@nod.at>
In-Reply-To: <1338841657-30358-1-git-send-email-richard@nod.at>
References: <1338841657-30358-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 3/6] um: remove line_ioctl()
To: jslaby@suse.cz
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, alan@linux.intel.com

line_ioctl() has no real function.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/line.c          |   86 ---------------------------------------
 arch/um/drivers/line.h          |    2 -
 arch/um/drivers/ssl.c           |    1 -
 arch/um/drivers/stdio_console.c |    1 -
 4 files changed, 0 insertions(+), 90 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index fb6e4ea..131129a 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -221,92 +221,6 @@ void line_set_termios(struct tty_struct *tty, struct ktermios * old)
 	/* nothing */
 }
 
-static const struct {
-	int  cmd;
-	char *level;
-	char *name;
-} tty_ioctls[] = {
-	/* don't print these, they flood the log ... */
-	{ TCGETS,      NULL,       "TCGETS"      },
-	{ TCSETS,      NULL,       "TCSETS"      },
-	{ TCSETSW,     NULL,       "TCSETSW"     },
-	{ TCFLSH,      NULL,       "TCFLSH"      },
-	{ TCSBRK,      NULL,       "TCSBRK"      },
-
-	/* general tty stuff */
-	{ TCSETSF,     KERN_DEBUG, "TCSETSF"     },
-	{ TCGETA,      KERN_DEBUG, "TCGETA"      },
-	{ TIOCMGET,    KERN_DEBUG, "TIOCMGET"    },
-	{ TCSBRKP,     KERN_DEBUG, "TCSBRKP"     },
-	{ TIOCMSET,    KERN_DEBUG, "TIOCMSET"    },
-
-	/* linux-specific ones */
-	{ TIOCLINUX,   KERN_INFO,  "TIOCLINUX"   },
-	{ KDGKBMODE,   KERN_INFO,  "KDGKBMODE"   },
-	{ KDGKBTYPE,   KERN_INFO,  "KDGKBTYPE"   },
-	{ KDSIGACCEPT, KERN_INFO,  "KDSIGACCEPT" },
-};
-
-int line_ioctl(struct tty_struct *tty, unsigned int cmd,
-				unsigned long arg)
-{
-	int ret;
-	int i;
-
-	ret = 0;
-	switch(cmd) {
-#ifdef TIOCGETP
-	case TIOCGETP:
-	case TIOCSETP:
-	case TIOCSETN:
-#endif
-#ifdef TIOCGETC
-	case TIOCGETC:
-	case TIOCSETC:
-#endif
-#ifdef TIOCGLTC
-	case TIOCGLTC:
-	case TIOCSLTC:
-#endif
-	/* Note: these are out of date as we now have TCGETS2 etc but this
-	   whole lot should probably go away */
-	case TCGETS:
-	case TCSETSF:
-	case TCSETSW:
-	case TCSETS:
-	case TCGETA:
-	case TCSETAF:
-	case TCSETAW:
-	case TCSETA:
-	case TCXONC:
-	case TCFLSH:
-	case TIOCOUTQ:
-	case TIOCINQ:
-	case TIOCGLCKTRMIOS:
-	case TIOCSLCKTRMIOS:
-	case TIOCPKT:
-	case TIOCGSOFTCAR:
-	case TIOCSSOFTCAR:
-		return -ENOIOCTLCMD;
-#if 0
-	case TCwhatever:
-		/* do something */
-		break;
-#endif
-	default:
-		for (i = 0; i < ARRAY_SIZE(tty_ioctls); i++)
-			if (cmd == tty_ioctls[i].cmd)
-				break;
-		if (i == ARRAY_SIZE(tty_ioctls)) {
-			printk(KERN_ERR "%s: %s: unknown ioctl: 0x%x\n",
-			       __func__, tty->name, cmd);
-		}
-		ret = -ENOIOCTLCMD;
-		break;
-	}
-	return ret;
-}
-
 void line_throttle(struct tty_struct *tty)
 {
 	struct line *line = tty->driver_data;
diff --git a/arch/um/drivers/line.h b/arch/um/drivers/line.h
index 5b3d4fb..6c3b252 100644
--- a/arch/um/drivers/line.h
+++ b/arch/um/drivers/line.h
@@ -69,8 +69,6 @@ extern int line_chars_in_buffer(struct tty_struct *tty);
 extern void line_flush_buffer(struct tty_struct *tty);
 extern void line_flush_chars(struct tty_struct *tty);
 extern int line_write_room(struct tty_struct *tty);
-extern int line_ioctl(struct tty_struct *tty, unsigned int cmd,
-				unsigned long arg);
 extern void line_throttle(struct tty_struct *tty);
 extern void line_unthrottle(struct tty_struct *tty);
 
diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index e09801a..a39d53e 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -129,7 +129,6 @@ static const struct tty_operations ssl_ops = {
 	.flush_buffer 		= line_flush_buffer,
 	.flush_chars 		= line_flush_chars,
 	.set_termios 		= line_set_termios,
-	.ioctl 	 		= line_ioctl,
 	.throttle 		= line_throttle,
 	.unthrottle 		= line_unthrottle,
 #if 0
diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_console.c
index 7663541..5cefdba 100644
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -112,7 +112,6 @@ static const struct tty_operations console_ops = {
 	.flush_buffer 		= line_flush_buffer,
 	.flush_chars 		= line_flush_chars,
 	.set_termios 		= line_set_termios,
-	.ioctl 	 		= line_ioctl,
 	.throttle 		= line_throttle,
 	.unthrottle 		= line_unthrottle,
 };
-- 
1.7.7.3


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

