Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fx1Mq-0005mZ-Vv
 for linux-um@lists.infradead.org; Tue, 04 Sep 2018 02:47:02 +0000
Received: by mail-pl1-x643.google.com with SMTP id f6-v6so898159plo.1
 for <linux-um@lists.infradead.org>; Mon, 03 Sep 2018 19:46:50 -0700 (PDT)
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 24/25] usb: cdc-acm: Change return type to void
Date: Tue,  4 Sep 2018 11:44:50 +0900
Message-Id: <1536029091-4426-25-git-send-email-climbbb.kim@gmail.com>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>

Since tty_standard_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/usb/class/cdc-acm.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 27346d6..de6a27e 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -572,23 +572,15 @@ static void acm_softint(struct work_struct *work)
 static int acm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct acm *acm;
-	int retval;
 
 	acm = acm_get_by_minor(tty->index);
 	if (!acm)
 		return -ENODEV;
 
-	retval = tty_standard_install(driver, tty);
-	if (retval)
-		goto error_init_termios;
-
+	tty_standard_install(driver, tty);
 	tty->driver_data = acm;
 
 	return 0;
-
-error_init_termios:
-	tty_port_put(&acm->port);
-	return retval;
 }
 
 static int acm_tty_open(struct tty_struct *tty, struct file *filp)
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

