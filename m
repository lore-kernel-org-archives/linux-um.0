Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 8/9] kconfig: move the "Executable file formats" menu to
 fs/Kconfig.binfmt
Date: Sun,  8 Jul 2018 08:20:03 -0700
Message-Id: <20180708152004.21679-9-hch@lst.de>
In-Reply-To: <20180708152004.21679-1-hch@lst.de>
References: <20180708152004.21679-1-hch@lst.de>
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
Cc: Richard Weinberger <richard@nod.at>, Randy Dunlap <rdunlap@infradead.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org

No need to have this in the top-level Kconfig.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 Kconfig           | 2 --
 fs/Kconfig.binfmt | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index a5997d6c2029..48a80beab685 100644
--- a/Kconfig
+++ b/Kconfig
@@ -13,9 +13,7 @@ source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
 
-menu "Executable file formats"
 source "fs/Kconfig.binfmt"
-endmenu
 
 source "mm/Kconfig"
 
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 56df483de619..b795f8da81f3 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -1,3 +1,6 @@
+
+menu "Executable file formats"
+
 config BINFMT_ELF
 	bool "Kernel support for ELF binaries"
 	depends on MMU
@@ -187,3 +190,5 @@ config COREDUMP
 	  This option enables support for performing core dumps. You almost
 	  certainly want to say Y here. Not necessary on systems that never
 	  need debugging or only ever run flawless code.
+
+endmenu
-- 
2.18.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

