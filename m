Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C406FC3ABC3
	for <linux-um@archiver.kernel.org>; Fri,  9 May 2025 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=83z+puPX/obQ7qvIFAWfUW24vYJvLx9zxaEVATRZT0c=; b=Ung8dfPwNXBLk2Aal/EqyEtRSy
	LerMKrP07om06FpJS1DFTc91t7eFq6NA2mHCr67FbLmnnTCEN1j0+aHeU2/KJsgrATGdAD3rjg6ch
	Ds6IRwLe0BPz2Ik+kbTAehQ6tjRcuzeN9dXGiCvn9VZzIW9VczURMMjFRfTZBc+36O7iosngJOZFX
	DSkI7g9aeOCdOVLZoy8CQcKz64YBpts89jLuMzrtPwqYUib3DriOCMs684UDxahabpHBXvV15mcHt
	oN8gH8PXewb29CKK0gYtczQszu7AKzYBDmquJjvV1cPBTb+4su/ih3xyXnZvRD1N9/ZfSQKCWBdKI
	Mvk9CUfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDJqT-000000034OF-0OiG;
	Fri, 09 May 2025 09:16:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDJIT-00000002xIN-1DBQ
	for linux-um@lists.infradead.org;
	Fri, 09 May 2025 08:41:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 07D775C68EC;
	Fri,  9 May 2025 08:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0252DC4CEE4;
	Fri,  9 May 2025 08:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746780092;
	bh=YhoZQ5OYQ/UTvTMR4AgPd2uAE5i+RB+fKHKGmCgwscI=;
	h=From:To:Cc:Subject:Date:From;
	b=MWaDjrFJPBCu5ORNnwm/y625gwXqZAQTeX5EqJycQuT4X/VzQDdpcxwlFJyfxds2D
	 ZKtDeSv8zbyQx02d97ycFDebgApuNUhBPwxaSlmfOnwgv3F/tLX0DR5rIvQ0JSyvZR
	 5DiodK1a21yvu9gMRs6cJU5QmIkSiC+SBa76ys0Acv7kKCevZ/uxmfycpJV1uRh1+x
	 DLB3/8pvwH55ZWjbvZyqjuZRfMkdTQWb47ZgTbmYzmBb19x5XQ4dwCTy15zEAM5xIU
	 HFl4VTHewOIE4pO0HzDZ+HkPxa7D3Z5+9wp/PATC9bPMehuMRpRX4Fyt4vzS8ddENn
	 D7k/U0/YxBoaw==
From: Arnd Bergmann <arnd@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	David Gow <davidgow@google.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] um: stop using PCI port I/O
Date: Fri,  9 May 2025 10:40:52 +0200
Message-Id: <20250509084125.1488601-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_014133_426225_29087333 
X-CRM114-Status: GOOD (  12.12  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

arch/um is one of the last users of CONFIG_GENERIC_IOMAP, but upon
closer look it appears that the PCI host bridge does not register
any port I/O, and the absense of both custom inb/outb functions and
a PCI_IOBASE constant means that actually trying to use port I/O
results on a NULL pointer access.

Build testing with clang confirms this by warning about this exact
problem:

include/asm-generic/io.h:549:31: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
  549 |         val = __raw_readb(PCI_IOBASE + addr);
      |                           ~~~~~~~~~~ ^

Remove all the Kconfig selects that refer to legacy port I/O
and instead just build the normal MMIO path that is emulated
by the virtio PCI host.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/um/Kconfig         |  6 ------
 arch/um/kernel/Makefile |  1 -
 arch/um/kernel/ioport.c | 13 -------------
 3 files changed, 20 deletions(-)
 delete mode 100644 arch/um/kernel/ioport.c

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 79509c7f39de..f08e8a7fac93 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -52,13 +52,7 @@ config NO_IOMEM
 config UML_IOMEM_EMULATION
 	bool
 	select INDIRECT_IOMEM
-	select HAS_IOPORT
 	select GENERIC_PCI_IOMAP
-	select GENERIC_IOMAP
-	select NO_GENERIC_PCI_IOPORT_MAP
-
-config NO_IOPORT_MAP
-	def_bool !UML_IOMEM_EMULATION
 
 config ISA
 	bool
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 4df1cd0d2017..4669db2aa9be 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -25,7 +25,6 @@ obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_OF) += dtb.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
-obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
 
 USER_OBJS := config.o
 
diff --git a/arch/um/kernel/ioport.c b/arch/um/kernel/ioport.c
deleted file mode 100644
index 7220615b3beb..000000000000
--- a/arch/um/kernel/ioport.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2021 Intel Corporation
- * Author: Johannes Berg <johannes@sipsolutions.net>
- */
-#include <asm/iomap.h>
-#include <asm-generic/pci_iomap.h>
-
-void __iomem *__pci_ioport_map(struct pci_dev *dev, unsigned long port,
-			       unsigned int nr)
-{
-	return NULL;
-}
-- 
2.39.5


