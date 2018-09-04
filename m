Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fx1MO-0005cK-MG
 for linux-um@lists.infradead.org; Tue, 04 Sep 2018 02:46:34 +0000
Received: by mail-pl1-x642.google.com with SMTP id u11-v6so890607plq.5
 for <linux-um@lists.infradead.org>; Mon, 03 Sep 2018 19:46:22 -0700 (PDT)
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 18/25] mmc: core: sdio_uart: Change return type to void
Date: Tue,  4 Sep 2018 11:44:44 +0900
Message-Id: <1536029091-4426-19-git-send-email-climbbb.kim@gmail.com>
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
 drivers/mmc/core/sdio_uart.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index 25e1130..b727186 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -731,14 +731,11 @@ static int sdio_uart_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	int idx = tty->index;
 	struct sdio_uart_port *port = sdio_uart_port_get(idx);
-	int ret = tty_standard_install(driver, tty);
 
-	if (ret == 0)
-		/* This is the ref sdio_uart_port get provided */
-		tty->driver_data = port;
-	else
-		sdio_uart_port_put(port);
-	return ret;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+
+	return 0;
 }
 
 /**
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

