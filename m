Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B70C61CE8
	for <linux-um@archiver.kernel.org>; Sun, 15 Jun 2025 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4w6TUDubicdI6nzFdYUMl9qS6qTSXww2iwVU2tvfOPA=; b=YLebtcVaJ289ANTuUZC5ODzZso
	FVp8zmKlj4Yl7TKFLvdcCEI+js+XwnLsRZKBDwdBI5MnW4/sN0AkW2ERYi7PbJofao+jvtgQOPyRS
	oxEXB57dz6IHk7QmIrJ00XAT7vhHS5hnnmETwCD0CZVlAfGzTqOZv4LSI38tpETxjrrfQuZB/SIJc
	L3Nx869C4E/C0i0GbDEUBN4L5mlt5W9sJyu3WZ2umVpmU515AoEFlLjse0N7kwxWI7tkGBNUUN5NM
	nCKvXBI9VrgIQb4SJKjdTv05mJfj2Ye/Ltlv6aOkmGvSB0PjfrAonOkVwr89SavYDRteWQSgWq3uh
	AtpDiXtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQsDn-00000002jnl-20m8;
	Sun, 15 Jun 2025 18:36:47 +0000
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQsDk-00000002jnW-0m5b;
	Sun, 15 Jun 2025 18:36:44 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Mattia Dongili <malattia@linux.it>,
	platform-driver-x86@vger.kernel.org,
	linux-um@lists.infradead.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] sonypi: add depends on HAS_IOPORT
Date: Sun, 15 Jun 2025 11:36:40 -0700
Message-ID: <20250615183642.902070-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The sonypi driver uses inb()/outb() without depending on HAS_IOPORT,
which leads to build errors since kernel v6.13-rc1:
commit 6f043e757445 ("asm-generic/io.h: Remove I/O port accessors
for HAS_IOPORT=n")

Add the HAS_IOPORT dependency to prevent the build errors.

(Found in ARCH=um allmodconfig builds)

In function ‘inb_p’,
    inlined from ‘sonypi_call2’ at ../drivers/char/sonypi.c:651:2:
include/asm-generic/io.h:542:14: error: call to ‘_inb’ declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
  542 | #define _inb _inb
drivers/char/sonypi.c: In function ‘sonypi_call2’:
include/asm-generic/io.h:596:15: error: call to ‘_outb’ declared with attribute error: outb() requires CONFIG_HAS_IOPORT
  596 | #define _outb _outb

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Mattia Dongili <malattia@linux.it>
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-616-rc1.orig/drivers/char/Kconfig
+++ lnx-616-rc1/drivers/char/Kconfig
@@ -237,7 +237,7 @@ config APPLICOM
 
 config SONYPI
 	tristate "Sony Vaio Programmable I/O Control Device support"
-	depends on X86_32 && PCI && INPUT
+	depends on X86_32 && PCI && INPUT && HAS_IOPORT
 	depends on ACPI_EC || !ACPI
 	help
 	  This driver enables access to the Sony Programmable I/O Control
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494 # v6.16-rc1

