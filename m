Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Sbdsb-00017m-4Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 20:27:57 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SbdsY-0005ir-9f
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 20:27:57 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon,  4 Jun 2012 22:27:32 +0200
Message-Id: <1338841657-30358-2-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 1/6] TTY: um/line, add tty_port
To: jslaby@suse.cz
Cc: user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Richard Weinberger <richard@nod.at>, alan@linux.intel.com

From: Jiri Slaby <jslaby@suse.cz>

And use count from there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: Richard Weinberger <richard@nod.at>
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

