Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 15 Nov 2016 17:39:02 -0500
From: Keno Fischer <keno@juliacomputing.com>
Subject: [PATCH v2] gpio: Remove GPIO_DEVRES option
Message-ID: <20161115223902.GA8347@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, gnurou@gmail.com, linux-gpio@vger.kernel.org, jdike@addtoit.com, richard@nod.at, user-mode-linux-devel@lists.sourceforge.net, shawn.guo@linaro.org, acourbot@nvidia.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This option was added in 6a89a314ab107a12af08c71420c19a37a30fc2d3 to allow use
of the devm_gpio_* functions without CONFIG_GPIOLIB. However, only a few months
later in b69ac52449c658b7ac40034dc3c5f5f4a71a723d, CONFIG_GPIOLIB, was added
as a dependency, defeating the original purpose of this option. Instead of
that patch, the original commit could have just been reverted (and in fact
was partially so in 403c1d0be5ccbd750d25c59d8358843a81e52e3b). Further,
since this option has a dependency on HAS_IOMEM, even though it does not
require it, it causes build failures when !HAS_IOMEM (e.g. in a uml build).
Fix that by completely removing the option, in essence completing the
reversion of the original commit.
---

In the original version of this patch (http://marc.info/?l=linux-gpio&m=147874300313315&w=2),
I had kept the option, and just fixed the build failure. However,
Linus Walleij pointed out (and the git history agrees) that this
option is now obsolete and should just be removed.

Also, while here I should note that there was a `might_sleep();` in the
stub for `devm_gpio_free`, that was not reintroduced when the stub was
brought back. Not sure this makes a difference, it felt worth pointing
out to the maintainers.

 drivers/gpio/Kconfig  | 4 ----
 drivers/gpio/Makefile | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d011cb8..ed37e59 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -22,10 +22,6 @@ menuconfig GPIOLIB
 
 if GPIOLIB
 
-config GPIO_DEVRES
-	def_bool y
-	depends on HAS_IOMEM
-
 config OF_GPIO
 	def_bool y
 	depends on OF
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index ab28a2d..d074c22 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -2,7 +2,7 @@
 
 ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG
 
-obj-$(CONFIG_GPIO_DEVRES)	+= devres.o
+obj-$(CONFIG_GPIOLIB)		+= devres.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib.o
 obj-$(CONFIG_GPIOLIB)		+= gpiolib-legacy.o
 obj-$(CONFIG_OF_GPIO)		+= gpiolib-of.o
-- 
2.9.3


