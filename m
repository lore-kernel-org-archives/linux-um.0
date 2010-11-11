Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] um: mark CONFIG_HIGHMEM as broken
Date: Fri, 12 Nov 2010 00:18:08 +0100
Message-Id: <1289517488-17628-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Currently CONFIG_HIGHMEM is broken on User Mode Linux.
I'm not sure if it worked ever.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.um |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/Kconfig.um b/arch/um/Kconfig.um
index 50d6aa2..f8d1d0d 100644
--- a/arch/um/Kconfig.um
+++ b/arch/um/Kconfig.um
@@ -131,7 +131,7 @@ config NR_CPUS
 
 config HIGHMEM
 	bool "Highmem support (EXPERIMENTAL)"
-	depends on !64BIT && EXPERIMENTAL
+	depends on !64BIT && BROKEN
 	default n
 	help
 	  This was used to allow UML to run with big amounts of memory.
-- 
1.6.6.1

