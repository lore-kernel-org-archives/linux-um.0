Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/10] kconfig: use a menu in arch/Kconfig to reduce clutter
Date: Tue, 31 Jul 2018 13:39:33 +0200
Message-Id: <20180731113935.6105-9-hch@lst.de>
In-Reply-To: <20180731113935.6105-1-hch@lst.de>
References: <20180731113935.6105-1-hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org, Richard Weinberger <richard@nod.at>, Randy Dunlap <rdunlap@infradead.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Ley Foon Tan <lftan@altera.com>

From: Randy Dunlap <rdunlap@infradead.org>

Put everything in arch/Kconfig into a General options menu
so that they don't clutter up the main/major/primary list of
menu options.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index cddd0faae4cb..6cf1b17a8df2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -9,6 +9,8 @@
 #
 source "arch/$(SRCARCH)/Kconfig"
 
+menu "General architecture-dependent options"
+
 config CRASH_CORE
 	bool
 
@@ -981,3 +983,5 @@ config REFCOUNT_FULL
 	  security flaw exploits.
 
 source "kernel/gcov/Kconfig"
+
+endmenu
-- 
2.18.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

