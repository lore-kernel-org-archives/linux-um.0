Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fx1MK-0005aT-8V
 for linux-um@lists.infradead.org; Tue, 04 Sep 2018 02:46:29 +0000
Received: by mail-pg1-x543.google.com with SMTP id 7-v6so898655pgf.2
 for <linux-um@lists.infradead.org>; Mon, 03 Sep 2018 19:46:18 -0700 (PDT)
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 17/25] misc: pti: Change return type to void
Date: Tue,  4 Sep 2018 11:44:43 +0900
Message-Id: <1536029091-4426-18-git-send-email-climbbb.kim@gmail.com>
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
 drivers/misc/pti.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
index 41f2a9f..5c885a1 100644
--- a/drivers/misc/pti.c
+++ b/drivers/misc/pti.c
@@ -462,26 +462,24 @@ static int pti_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	int idx = tty->index;
 	struct pti_tty *pti_tty_data;
-	int ret = tty_standard_install(driver, tty);
 
-	if (ret == 0) {
-		pti_tty_data = kmalloc(sizeof(struct pti_tty), GFP_KERNEL);
-		if (pti_tty_data == NULL)
-			return -ENOMEM;
+	tty_standard_install(driver, tty);
+	pti_tty_data = kmalloc(sizeof(struct pti_tty), GFP_KERNEL);
+	if (pti_tty_data == NULL)
+		return -ENOMEM;
 
-		if (idx == PTITTY_MINOR_START)
-			pti_tty_data->mc = pti_request_masterchannel(0, NULL);
-		else
-			pti_tty_data->mc = pti_request_masterchannel(2, NULL);
+	if (idx == PTITTY_MINOR_START)
+		pti_tty_data->mc = pti_request_masterchannel(0, NULL);
+	else
+		pti_tty_data->mc = pti_request_masterchannel(2, NULL);
 
-		if (pti_tty_data->mc == NULL) {
-			kfree(pti_tty_data);
-			return -ENXIO;
-		}
-		tty->driver_data = pti_tty_data;
+	if (pti_tty_data->mc == NULL) {
+		kfree(pti_tty_data);
+		return -ENXIO;
 	}
+	tty->driver_data = pti_tty_data;
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

