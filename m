Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntrHE-00BHQi-Gv
	for linux-um@lists.infradead.org; Wed, 25 May 2022 13:42:18 +0000
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A1DE3F044
	for <linux-um@lists.infradead.org>; Wed, 25 May 2022 13:42:15 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k5-20020a05600c1c8500b003974c5d636dso2877694wms.1
        for <linux-um@lists.infradead.org>; Wed, 25 May 2022 06:42:15 -0700 (PDT)
From: Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH] x86/um: Kconfig: Fix indentation
Date: Wed, 25 May 2022 15:42:11 +0200
Message-Id: <20220525134211.54417-1-juerg.haefliger@canonical.com>
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
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Juerg Haefliger <juerg.haefliger@canonical.com>

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/x86/um/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 1bcd42c53039..186f13268401 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -32,12 +32,12 @@ config 3_LEVEL_PGTABLES
 	bool "Three-level pagetables" if !64BIT
 	default 64BIT
 	help
-	Three-level pagetables will let UML have more than 4G of physical
-	memory.  All the memory that can't be mapped directly will be treated
-	as high memory.
+	  Three-level pagetables will let UML have more than 4G of physical
+	  memory.  All the memory that can't be mapped directly will be treated
+	  as high memory.
 
-	However, this it experimental on 32-bit architectures, so if unsure say
-	N (on x86-64 it's automatically enabled, instead, as it's safe there).
+	  However, this it experimental on 32-bit architectures, so if unsure say
+	  N (on x86-64 it's automatically enabled, instead, as it's safe there).
 
 config ARCH_HAS_SC_SIGNALS
 	def_bool !64BIT
-- 
2.32.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

