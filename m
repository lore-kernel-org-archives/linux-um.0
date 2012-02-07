Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Tue,  7 Feb 2012 01:22:46 +0100
Message-Id: <1328574170-2286-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 1/5] Introduce CONFIG_GENERIC_IO
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk, Artem.Bityutskiy@linux.intel.com, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

There are situations where CONFIG_HAS_IOMEM is too restrictive.
For example CONFIG_MTD_NAND_NANDSIM depends on CONFIG_HAS_IOMEM
but it works perfectly fine if an architecture without io memory
just includes asm-generic/io.h or implements everything defined in it.
UML is such a corner case.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 lib/Kconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index d69d321..c3c4c1c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -26,6 +26,10 @@ config GENERIC_IOMAP
 	bool
 	select GENERIC_PCI_IOMAP
 
+config GENERIC_IO
+	boolean
+	default n
+
 config CRC_CCITT
 	tristate "CRC-CCITT functions"
 	help
@@ -221,6 +225,7 @@ config BTREE
 config HAS_IOMEM
 	boolean
 	depends on !NO_IOMEM
+	select GENERIC_IO
 	default y
 
 config HAS_IOPORT
-- 
1.7.6

