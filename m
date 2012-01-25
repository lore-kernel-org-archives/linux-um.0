Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Wed, 25 Jan 2012 18:23:54 +0100
Message-Id: <1327512234-22578-2-git-send-email-richard@nod.at>
In-Reply-To: <1327512234-22578-1-git-send-email-richard@nod.at>
References: <1327512234-22578-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 2/2] um: Serve io_remap_pfn_range()
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

At some places io_remap_pfn_range() is needed.
UML has to serve it like all other archs do.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/pgtable.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 41474fb..6a3f984 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -69,6 +69,8 @@ extern unsigned long end_iomem;
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
 #define PAGE_KERNEL_EXEC	__pgprot(__PAGE_KERNEL_EXEC)
 
+#define io_remap_pfn_range	remap_pfn_range
+
 /*
  * The i386 can't do page protection for execute, and considers that the same
  * are read.
-- 
1.7.7

