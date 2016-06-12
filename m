Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] um: Enable TRACE_IRQFLAGS_SUPPORT
Date: Sun, 12 Jun 2016 22:04:54 +0200
Message-Id: <1465761894-27078-2-git-send-email-richard@nod.at>
In-Reply-To: <1465761894-27078-1-git-send-email-richard@nod.at>
References: <1465761894-27078-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, daniel.wagner@bmw-carit.de, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Now we have everything we need, so enable
TRACE_IRQFLAGS_SUPPORT.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.common | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index cc00134..85f14a8 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -30,10 +30,9 @@ config PCI
 config PCMCIA
 	bool
 
-# Yet to do!
 config TRACE_IRQFLAGS_SUPPORT
 	bool
-	default n
+	default y
 
 config LOCKDEP_SUPPORT
 	bool
-- 
2.7.3


