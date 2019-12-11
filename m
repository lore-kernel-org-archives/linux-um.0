Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 11 Dec 2019 11:27:41 -0800
In-Reply-To: <20191211192742.95699-1-brendanhiggins@google.com>
Message-Id: <20191211192742.95699-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
Subject: [PATCH v1 6/7] staging: axis-fifo: add unspecified HAS_IOMEM dependency
From: Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Moses Christopher <moseschristopherb@gmail.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>, devel@driverdev.osuosl.org
List-ID: <linux-um.lists.infradead.org>

Currently CONFIG_XIL_AXIS_FIFO=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/staging/axis-fifo/axis-fifo.o: in function `axis_fifo_probe':
drivers/staging/axis-fifo/axis-fifo.c:809: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/staging/axis-fifo/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/axis-fifo/Kconfig b/drivers/staging/axis-fifo/Kconfig
index 3fffe4d6f327f..f180a8e9f58af 100644
--- a/drivers/staging/axis-fifo/Kconfig
+++ b/drivers/staging/axis-fifo/Kconfig
@@ -4,7 +4,7 @@
 #
 config XIL_AXIS_FIFO
 	tristate "Xilinx AXI-Stream FIFO IP core driver"
-	depends on OF
+	depends on OF && HAS_IOMEM
 	help
 	  This adds support for the Xilinx AXI-Stream FIFO IP core driver.
 	  The AXI Streaming FIFO allows memory mapped access to a AXI Streaming
-- 
2.24.0.525.g8f36a354ae-goog


