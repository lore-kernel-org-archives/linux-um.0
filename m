Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fx1Mh-0005ki-QP
 for linux-um@lists.infradead.org; Tue, 04 Sep 2018 02:46:53 +0000
Received: by mail-pf1-x443.google.com with SMTP id d4-v6so925208pfn.0
 for <linux-um@lists.infradead.org>; Mon, 03 Sep 2018 19:46:46 -0700 (PDT)
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 23/25] tty: vcc: Change return type to void
Date: Tue,  4 Sep 2018 11:44:49 +0900
Message-Id: <1536029091-4426-24-git-send-email-climbbb.kim@gmail.com>
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
 drivers/tty/vcc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 58b454c..ce32631 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -987,7 +987,6 @@ static int vcc_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct vcc_port *port_vcc;
 	struct tty_port *port_tty;
-	int ret;
 
 	if (unlikely(!tty)) {
 		pr_err("VCC: install: Invalid TTY handle\n");
@@ -997,9 +996,7 @@ static int vcc_install(struct tty_driver *driver, struct tty_struct *tty)
 	if (tty->index >= VCC_MAX_PORTS)
 		return -EINVAL;
 
-	ret = tty_standard_install(driver, tty);
-	if (ret)
-		return ret;
+	tty_standard_install(driver, tty);
 
 	port_tty = kzalloc(sizeof(struct tty_port), GFP_KERNEL);
 	if (!port_tty)
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

