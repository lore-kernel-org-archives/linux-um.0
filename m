Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from [43.155.65.254] (helo=smtpbg.qq.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEFXI-00A1nC-My
	for linux-um@lists.infradead.org; Wed, 20 Jul 2022 19:39:14 +0000
From: Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] um:do not initialise statics to 0.
Date: Thu, 21 Jul 2022 03:36:43 +0800
Message-Id: <20220720193643.8081-1-gaoxin@cdjrlc.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>

do not initialise statics to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 arch/um/drivers/stdio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_console.c
index e8b762f4d8c2..e0f7543ef499 100644
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -90,7 +90,7 @@ static int con_remove(int n, char **error_out)
 }
 
 /* Set in an initcall, checked in an exitcall */
-static int con_init_done = 0;
+static int con_init_done;
 
 static int con_install(struct tty_driver *driver, struct tty_struct *tty)
 {
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

