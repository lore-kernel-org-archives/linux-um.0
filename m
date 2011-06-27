Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Date: Tue, 28 Jun 2011 00:15:31 +0200
Message-Id: <1309212931-19772-4-git-send-email-richard@nod.at>
In-Reply-To: <1309212931-19772-1-git-send-email-richard@nod.at>
References: <1309212931-19772-1-git-send-email-richard@nod.at>
Subject: [PATCH 4/4] um: Reinstate kernel version in generated .config
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Geert Uytterhoeven <geert@linux-m68k.org>

commit 0954828fcbf3bd13d593499b16b901a4e801b0b9 ("kconfig: replace
KERNELVERSION usage by the mainmenu's prompt") made the kernel version
disappear from the generated .config file when configuring for UML.
As UML's Kconfig doesn't have a mainmenu, kconfig falls back to the
default string "Linux Kernel Configuration".

Add a suitable mainmenu to the main UML Kconfig file to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.x86 |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/um/Kconfig.x86 b/arch/um/Kconfig.x86
index 8aae429..d31ecf3 100644
--- a/arch/um/Kconfig.x86
+++ b/arch/um/Kconfig.x86
@@ -1,3 +1,5 @@
+mainmenu "User Mode Linux/$SUBARCH $KERNELVERSION Kernel Configuration"
+
 source "arch/um/Kconfig.common"
 
 menu "UML-specific options"
-- 
1.7.5.4


