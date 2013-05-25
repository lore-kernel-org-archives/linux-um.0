Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <51A0989A.6070100@nagafix.co.uk>
Date: Sat, 25 May 2013 17:55:22 +0700
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: UML build broken since 3.0.75 (also affects 3.2.x)
To: stable@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus' vm patches broke the UML build in 3.0.75 onwards:

  CC      mm/memory.o
mm/memory.c: In function =91vm_iomap_memory=92:
mm/memory.c:2363:2: error: implicit declaration of function
=91io_remap_pfn_range=92 [-Werror=3Dimplicit-function-declaration]
cc1: some warnings being treated as errors
make[1]: *** [mm/memory.o] Error 1
make: *** [mm] Error 2


This fix is just a copy of what is found in later kernels.
Compiled and boot tested both 3.0.80 and 3.2.45, x86_64 and i386.

Signed-off-by: Antoine Martin <antoine@nagafix.co.uk>

--- a/arch/um/include/asm/pgtable.h	2013-05-25 09:20:51.420000000 +0000
+++ b/arch/um/include/asm/pgtable.h	2013-04-29 00:36:01.000000000 +0000
@@ -69,6 +69,8 @@
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY |
_PAGE_ACCESSED)
 #define PAGE_KERNEL_EXEC	__pgprot(__PAGE_KERNEL_EXEC)

+#define io_remap_pfn_range	remap_pfn_range
+
 /*
  * The i386 can't do page protection for execute, and considers that
the same
  * are read.
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

