Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNS34-003HYe-Pq
 for linux-um@lists.infradead.org; Fri, 25 Feb 2022 04:17:44 +0000
Received: by mail-yb1-xb49.google.com with SMTP id
 b18-20020a25fa12000000b0062412a8200eso2029289ybe.22
 for <linux-um@lists.infradead.org>; Thu, 24 Feb 2022 20:17:41 -0800 (PST)
Date: Fri, 25 Feb 2022 12:17:27 +0800
Message-Id: <20220225041727.1902850-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [PATCH v2] Input: samsung-keypad - Properly state IOMEM dependency
From: David Gow <davidgow@google.com>
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
To: Joonyoung Shim <jy0922.shim@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Gow <davidgow@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, anton ivanov <anton.ivanov@cambridgegreys.com>

Make the samsung-keypad driver explicitly depend on CONFIG_HAS_IOMEM, as it
calls devm_ioremap(). This prevents compile errors in some configs (e.g,
allyesconfig/randconfig under UML):

/usr/bin/ld: drivers/input/keyboard/samsung-keypad.o: in function `samsung_keypad_probe':
samsung-keypad.c:(.text+0xc60): undefined reference to `devm_ioremap'

Signed-off-by: David Gow <davidgow@google.com>
Acked-by: anton ivanov <anton.ivanov@cambridgegreys.com>
---

Changes since v1:
http://lists.infradead.org/pipermail/linux-um/2022-February/002264.html
- Fix to depend on HAS_IOMEM, not IOMEM
- Add Acked-by tag.

---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 0c607da9ee10..9417ee0b1eff 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -556,7 +556,7 @@ config KEYBOARD_PMIC8XXX
 
 config KEYBOARD_SAMSUNG
 	tristate "Samsung keypad support"
-	depends on HAVE_CLK
+	depends on HAS_IOMEM && HAVE_CLK
 	select INPUT_MATRIXKMAP
 	help
 	  Say Y here if you want to use the keypad on your Samsung mobile
-- 
2.35.1.574.g5d30c73bfb-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

