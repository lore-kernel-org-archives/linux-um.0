Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v3 19/29] x86: um, annotate data appropriatelly
Date: Fri, 21 Apr 2017 16:12:55 +0200
Message-Id: <20170421141305.25180-19-jslaby@suse.cz>
In-Reply-To: <20170421141305.25180-1-jslaby@suse.cz>
References: <20170421141305.25180-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Use the new SYM_DATA_START and SYM_DATA_END_LABEL macros for vdso_start.

We get:
  0000  2376 OBJECT  GLOBAL DEFAULT    4 vdso_start
  0948     0 OBJECT  GLOBAL DEFAULT    4 vdso_end

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net
---
 arch/x86/um/vdso/vdso.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/vdso/vdso.S b/arch/x86/um/vdso/vdso.S
index 1cb468adacbb..f8b9f46c546d 100644
--- a/arch/x86/um/vdso/vdso.S
+++ b/arch/x86/um/vdso/vdso.S
@@ -1,10 +1,10 @@
 #include <linux/init.h>
+#include <linux/linkage.h>
 
 __INITDATA
 
-	.globl vdso_start, vdso_end
-vdso_start:
+SYM_DATA_START(vdso_start)
 	.incbin "arch/x86/um/vdso/vdso.so"
-vdso_end:
+SYM_DATA_END_LABEL(vdso_start, SYM_V_GLOBAL, vdso_end)
 
 __FINIT
-- 
2.12.2


