Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGk8o-0008AX-OS
 for linux-um@lists.infradead.org; Mon, 01 Mar 2021 15:07:25 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 1/8] um: allow disabling NO_IOMEM
Date: Mon,  1 Mar 2021 16:07:01 +0100
Message-Id: <20210301160501.0d0898834452.I7b2fad8378e4fde7f26ef06a03980ae2807d81c9@changeid>
In-Reply-To: <20210301150708.244970-1-johannes@sipsolutions.net>
References: <20210301150708.244970-1-johannes@sipsolutions.net>
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
To: linux-um@lists.infradead.org
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

Adjust the kconfig a little to allow disabling NO_IOMEM in UML. To
make an "allyesconfig" with CONFIG_NO_IOMEM=n build, adjust a few
Kconfig things elsewhere and add dummy asm/fb.h and asm/vga.h files.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: use asm-generic for fb.h and vga.h
---
 arch/um/Kconfig                | 4 ++++
 arch/um/include/asm/Kbuild     | 2 ++
 drivers/input/Kconfig          | 1 -
 drivers/input/gameport/Kconfig | 1 +
 drivers/input/joystick/Kconfig | 1 +
 drivers/tty/Kconfig            | 5 ++---
 drivers/video/console/Kconfig  | 2 +-
 7 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index c3030db3325f..20b0640e01b8 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -26,6 +26,10 @@ config MMU
 	default y
 
 config NO_IOMEM
+	bool "disable IOMEM" if EXPERT
+	default y
+
+config NO_IOPORT_MAP
 	def_bool y
 
 config ISA
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index d7492e5a1bbb..10b7228b3aee 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -7,6 +7,7 @@ generic-y += device.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
+generic-y += fb.h
 generic-y += ftrace.h
 generic-y += futex.h
 generic-y += hw_irq.h
@@ -27,3 +28,4 @@ generic-y += trace_clock.h
 generic-y += word-at-a-time.h
 generic-y += kprobes.h
 generic-y += mm_hooks.h
+generic-y += vga.h
diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index ec0e861f185f..5baebf62df33 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -4,7 +4,6 @@
 #
 
 menu "Input device support"
-	depends on !UML
 
 config INPUT
 	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EXPERT
diff --git a/drivers/input/gameport/Kconfig b/drivers/input/gameport/Kconfig
index 4761795cb49f..5a2c2fb3217d 100644
--- a/drivers/input/gameport/Kconfig
+++ b/drivers/input/gameport/Kconfig
@@ -4,6 +4,7 @@
 #
 config GAMEPORT
 	tristate "Gameport support"
+	depends on !UML
 	help
 	  Gameport support is for the standard 15-pin PC gameport. If you
 	  have a joystick, gamepad, gameport card, a soundcard with a gameport
diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 5e38899058c1..b10948bf9551 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -4,6 +4,7 @@
 #
 menuconfig INPUT_JOYSTICK
 	bool "Joysticks/Gamepads"
+	depends on !UML
 	help
 	  If you have a joystick, 6dof controller, gamepad, steering wheel,
 	  weapon control system or something like that you can say Y here
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index e15cd6b5bb99..26648daaaee2 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -12,9 +12,8 @@ if TTY
 
 config VT
 	bool "Virtual terminal" if EXPERT
-	depends on !UML
 	select INPUT
-	default y
+	default y if !UML
 	help
 	  If you say Y here, you will get support for terminal devices with
 	  display and keyboard devices. These are called "virtual" because you
@@ -78,7 +77,7 @@ config VT_CONSOLE_SLEEP
 
 config HW_CONSOLE
 	bool
-	depends on VT && !UML
+	depends on VT
 	default y
 
 config VT_HW_CONSOLE_BINDING
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index ee33b8ec62bb..840d9813b0bc 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -9,7 +9,7 @@ config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC &&  !SUPERH && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32 && !S390
+		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32 && !S390 && !UML
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

