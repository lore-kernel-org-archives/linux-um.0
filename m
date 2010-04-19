Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 5/5] uml: Clean up asm/system.h
Date: Mon, 19 Apr 2010 23:53:08 +0200
Message-Id: <e89d636e305d095f5919c0e22cf92159c4067018.1271713955.git.jan.kiszka@web.de>
In-Reply-To: <cover.1271713955.git.jan.kiszka@web.de>
References: <cover.1271713955.git.jan.kiszka@web.de>
In-Reply-To: <cover.1271713955.git.jan.kiszka@web.de>
References: <cover.1271713955.git.jan.kiszka@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Remove duplicates and unused prototypes.

Signed-off-by: Jan Kiszka <jan.kiszka@web.de>
---
 arch/um/include/asm/system.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/system.h b/arch/um/include/asm/system.h
index 753346e..93af1cf 100644
--- a/arch/um/include/asm/system.h
+++ b/arch/um/include/asm/system.h
@@ -3,11 +3,8 @@
 
 #include "sysdep/system.h"
 
-extern void *switch_to(void *prev, void *next, void *last);
-
 extern int get_signals(void);
 extern int set_signals(int enable);
-extern int get_signals(void);
 extern void block_signals(void);
 extern void unblock_signals(void);
 
-- 
1.6.0.2

