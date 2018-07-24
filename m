Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/10] kconfig: remove duplicate SWAP symbol defintions
Date: Tue, 24 Jul 2018 19:56:40 +0200
Message-Id: <20180724175646.3621-5-hch@lst.de>
In-Reply-To: <20180724175646.3621-1-hch@lst.de>
References: <20180724175646.3621-1-hch@lst.de>
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
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org, Richard Weinberger <richard@nod.at>, Randy Dunlap <rdunlap@infradead.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@lists.infradead.org, Ley Foon Tan <lftan@altera.com>

microblaze and nios2 define their own always n SWAP symbols.  Remove those
and let the generic defintion do the right thing by adding a new symbol
to disable swap entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/Kconfig | 4 +---
 arch/nios2/Kconfig      | 4 +---
 init/Kconfig            | 9 ++++++++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index d14782100088..cc139d1b1284 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -1,5 +1,6 @@
 config MICROBLAZE
 	def_bool y
+	select ARCH_NO_SWAP
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
@@ -52,9 +53,6 @@ config CPU_LITTLE_ENDIAN
 
 endchoice
 
-config SWAP
-	def_bool n
-
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
 
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 3d4ec88f1db1..3f9d4ef8b20f 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config NIOS2
 	def_bool y
+	select ARCH_NO_SWAP
 	select TIMER_OF
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
@@ -38,9 +39,6 @@ config HAS_DMA
 config FPU
 	def_bool n
 
-config SWAP
-	def_bool n
-
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
 
diff --git a/init/Kconfig b/init/Kconfig
index 041f3a022122..1e69f93b809e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -218,9 +218,16 @@ config DEFAULT_HOSTNAME
 	  but you may wish to use a different default here to make a minimal
 	  system more usable with less configuration.
 
+#
+# For some reason microblaze and nios2 hard code SWAP=n.  Hopefully we can
+# add proper SWAP support to them, in which case this can be remove.
+#
+config ARCH_NO_SWAP
+	bool
+
 config SWAP
 	bool "Support for paging of anonymous memory (swap)"
-	depends on MMU && BLOCK
+	depends on MMU && BLOCK && !ARCH_NO_SWAP
 	default y
 	help
 	  This option allows you to choose whether you want to have support
-- 
2.18.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

