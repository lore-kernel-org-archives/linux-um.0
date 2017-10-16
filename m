Return-Path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] um: Restore symbol versions for __memcpy and memcpy
Date: Mon, 16 Oct 2017 12:02:32 +0200
Message-Id: <1508148152-2965-1-git-send-email-geert@linux-m68k.org>
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

If CONFIG_MODVERSIONS=y:

    WARNING: EXPORT symbol "__memcpy" [vmlinux] version generation failed, symbol will not be versioned.
    WARNING: EXPORT symbol "memcpy" [vmlinux] version generation failed, symbol will not be versioned.

Add <asm/asm-prototypes.h>, including the generic version, so that
genksyms knows the types of these symbols and can generate CRCs for
them.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/um/include/asm/asm-prototypes.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 arch/um/include/asm/asm-prototypes.h

diff --git a/arch/um/include/asm/asm-prototypes.h b/arch/um/include/asm/asm-prototypes.h
new file mode 100644
index 0000000000000000..5898a26daa0dd4fa
--- /dev/null
+++ b/arch/um/include/asm/asm-prototypes.h
@@ -0,0 +1 @@
+#include <asm-generic/asm-prototypes.h>
-- 
2.7.4


