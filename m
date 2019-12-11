Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 11 Dec 2019 11:27:36 -0800
In-Reply-To: <20191211192742.95699-1-brendanhiggins@google.com>
Message-Id: <20191211192742.95699-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
Subject: [PATCH v1 1/7] pinctrl: equilibrium: add unspecified HAS_IOMEM dependency
From: Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>, linux-gpio@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

Currently CONFIG_PINCTRL_EQUILIBRIUM=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/pinctrl/pinctrl-equilibrium.o: in function `eqbr_pinctrl_probe':
drivers/pinctrl/pinctrl-equilibrium.c:908: undefined reference to `devm_platform_ioremap_resource'
ld: drivers/pinctrl/pinctrl-equilibrium.c:223: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the CONFIG_HAS_IOMEM=y dependency.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/pinctrl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 3bfbf2ff6e2bd..2c0b30477f7d0 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -422,6 +422,7 @@ config PINCTRL_TB10X
 
 config PINCTRL_EQUILIBRIUM
 	tristate "Generic pinctrl and GPIO driver for Intel Lightning Mountain SoC"
+	depends on HAS_IOMEM
 	select PINMUX
 	select PINCONF
 	select GPIOLIB
-- 
2.24.0.525.g8f36a354ae-goog


