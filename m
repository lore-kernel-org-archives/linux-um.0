Return-Path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 29 Sep 2012 21:04:55 +0200
Message-Id: <1348945495-1334-1-git-send-email-geert@linux-m68k.org>
Subject: [PATCH] um: Remove obsolete UM_* definitions
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

  - UM_ELF_CLASS and UM_ELFCLASS32 became unused in commit
    b743ac54e54ca18fb7164a97cc77cf1ccee0b0f7 ("um: disable scan_elf_aux()
    on x86_64"),
  - UM_ELFCLASS64 was never used, but only added for consistency with
    UM_ELFCLASS32,
  - UM_NR_CPUS became unused in commit
    e6a2d1f7024f93e4622cd7ba633666a63ccce49e *"uml: clean up
    sig_handler_common_skas"),

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/um/include/shared/common-offsets.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 2df313b..57853d4 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -7,12 +7,6 @@ DEFINE(UM_KERN_PAGE_MASK, PAGE_MASK);
 DEFINE(UM_KERN_PAGE_SHIFT, PAGE_SHIFT);
 DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
 
-DEFINE(UM_ELF_CLASS, ELF_CLASS);
-DEFINE(UM_ELFCLASS32, ELFCLASS32);
-DEFINE(UM_ELFCLASS64, ELFCLASS64);
-
-DEFINE(UM_NR_CPUS, NR_CPUS);
-
 DEFINE(UM_GFP_KERNEL, GFP_KERNEL);
 DEFINE(UM_GFP_ATOMIC, GFP_ATOMIC);
 
-- 
1.7.0.4


