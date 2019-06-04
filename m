Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hY7V4-00061U-Q7
 for linux-um@lists.infradead.org; Tue, 04 Jun 2019 11:21:11 +0000
Received: by mail-lf1-x144.google.com with SMTP id q26so16154944lfc.3
 for <linux-um@lists.infradead.org>; Tue, 04 Jun 2019 04:21:05 -0700 (PDT)
From: Marek Majkowski <marek@cloudflare.com>
Subject: [PATCH] uml: fix kcov crash during startup
Date: Tue,  4 Jun 2019 13:20:50 +0200
Message-Id: <20190604112050.4787-1-marek@cloudflare.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: marek@cloudflare.com

Kcov fails to start when compiled with kcov. Disable KCOV on
arch/uml/kernel/skas.

  $ gdb -q -ex r ./vmlinux
  Program received signal SIGSEGV, Segmentation fault.
  check_kcov_mode (t=<>, needed_mode=<>) at kernel/kcov.c:70
  70		mode = READ_ONCE(t->kcov_mode);

Signed-off-by: Marek Majkowski <marek@cloudflare.com>
---
 arch/um/kernel/skas/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index 0b76d8869c94..5bd3edfcfedf 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -12,4 +12,6 @@ obj-y := clone.o mmu.o process.o syscall.o uaccess.o
 CFLAGS_clone.o := $(CFLAGS_NO_HARDENING)
 UNPROFILE_OBJS := clone.o
 
+KCOV_INSTRUMENT := n
+
 include arch/um/scripts/Makefile.rules
-- 
2.17.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

