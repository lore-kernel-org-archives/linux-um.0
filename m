Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Date: Sat, 23 Jul 2011 13:21:51 -0300
Message-Id: <1311438111-10961-1-git-send-email-cascardo@holoscopio.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: disable CMPXCHG_DOUBLE as it breaks UML build
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Christoph Lameter <cl@linux.com>, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Commit b789ef518b2a7231b0668c813f677cee528a9d3f tests for cmpxchg_double
support in the SLUB code and it breaks UML builds with SLUB. Since UML
does not support checking for CPU features, disable CMPXCHG_DOUBLE just
like CMPXCHG_LOCAL is disabled for UML.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.x86 |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/um/Kconfig.x86 b/arch/um/Kconfig.x86
index d31ecf3..21bebe6 100644
--- a/arch/um/Kconfig.x86
+++ b/arch/um/Kconfig.x86
@@ -10,6 +10,10 @@ config CMPXCHG_LOCAL
 	bool
 	default n
 
+config CMPXCHG_DOUBLE
+	bool
+	default n
+
 source "arch/x86/Kconfig.cpu"
 
 endmenu
-- 
1.7.5.4

