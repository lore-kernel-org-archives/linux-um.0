Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp1.axis.com ([195.60.68.17])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSi4m-00HKp3-Ll
 for linux-um@lists.infradead.org; Fri, 11 Mar 2022 16:25:14 +0000
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [RFC v1 04/10] roadtest: add base config
Date: Fri, 11 Mar 2022 17:24:39 +0100
Message-ID: <20220311162445.346685-5-vincent.whitchurch@axis.com>
In-Reply-To: <20220311162445.346685-1-vincent.whitchurch@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
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
To: linux-kernel@vger.kernel.org
Cc: kernel@axis.com, Vincent Whitchurch <vincent.whitchurch@axis.com>, devicetree@vger.kernel.org, linux-um@lists.infradead.org, shuah@kernel.org, brendanhiggins@google.com, linux-kselftest@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org

Add the base config options for the roadtest kernel (generated with
"savedefconfig").

roadtest uses a single kernel for all tests and the drivers under test
are built as modules.  Additional config options are added by merging
config fragments from each subsystems' test directory.

The kernel is built with several debug options to catch more problems
during testing.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../roadtest/roadtest/tests/base/config       | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 tools/testing/roadtest/roadtest/tests/base/config

diff --git a/tools/testing/roadtest/roadtest/tests/base/config b/tools/testing/roadtest/roadtest/tests/base/config
new file mode 100644
index 000000000000..c1952d047c8e
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/base/config
@@ -0,0 +1,84 @@
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_EXPERT=y
+CONFIG_HOSTFS=y
+CONFIG_UML_TIME_TRAVEL_SUPPORT=y
+CONFIG_NULL_CHAN=y
+CONFIG_PORT_CHAN=y
+CONFIG_PTY_CHAN=y
+CONFIG_TTY_CHAN=y
+CONFIG_XTERM_CHAN=y
+CONFIG_CON_CHAN="pts"
+CONFIG_SSL=y
+CONFIG_SSL_CHAN="pts"
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_VIRTIO_UML=y
+CONFIG_UML_PCI_OVER_VIRTIO=y
+CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID=1234
+CONFIG_GCOV_KERNEL=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_BINFMT_MISC=m
+# CONFIG_COMPACTION is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_OF=y
+# CONFIG_INPUT is not set
+CONFIG_LEGACY_PTY_COUNT=32
+CONFIG_HW_RANDOM=y
+# CONFIG_HW_RANDOM_IXP4XX is not set
+# CONFIG_HW_RANDOM_STM32 is not set
+# CONFIG_HW_RANDOM_MESON is not set
+# CONFIG_HW_RANDOM_CAVIUM is not set
+# CONFIG_HW_RANDOM_MTK is not set
+# CONFIG_HW_RANDOM_EXYNOS is not set
+# CONFIG_HW_RANDOM_NPCM is not set
+# CONFIG_HW_RANDOM_KEYSTONE is not set
+CONFIG_RANDOM_TRUST_BOOTLOADER=y
+CONFIG_I2C=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_VIRTIO=y
+CONFIG_I2C_STUB=m
+CONFIG_PPS=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_VIRTIO=y
+CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_RTC_CLASS=y
+# CONFIG_RTC_HCTOSYS is not set
+# CONFIG_RTC_SYSTOHC is not set
+CONFIG_RTC_DEBUG=y
+# CONFIG_RTC_NVMEM is not set
+CONFIG_VIRTIO_INPUT=y
+# CONFIG_BCM_VIDEOCORE is not set
+CONFIG_QUOTA=y
+CONFIG_AUTOFS4_FS=m
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_NLS=y
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_CRC32C=y
+CONFIG_CRYPTO_JITTERENTROPY=y
+CONFIG_CRC16=y
+CONFIG_PRINTK_TIME=y
+CONFIG_PRINTK_CALLER=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_DEBUG_INFO=y
+CONFIG_FRAME_WARN=1024
+CONFIG_READABLE_ASM=y
+CONFIG_DEBUG_FS=y
+CONFIG_UBSAN=y
+CONFIG_PAGE_EXTENSION=y
+CONFIG_DEBUG_OBJECTS=y
+CONFIG_DEBUG_OBJECTS_FREE=y
+CONFIG_DEBUG_OBJECTS_TIMERS=y
+CONFIG_DEBUG_OBJECTS_WORK=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_ENABLE_DEFAULT_TRACERS=y
-- 
2.34.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

