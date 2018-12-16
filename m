Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conuserg-09.nifty.com ([210.131.2.76])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYXYF-00052J-0V
 for linux-um@lists.infradead.org; Sun, 16 Dec 2018 14:37:52 +0000
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] um: remove redundant generic-y
Date: Sun, 16 Dec 2018 23:37:06 +0900
Message-Id: <1544971026-7694-1-git-send-email-yamada.masahiro@socionext.com>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@codeaurora.org>, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Geert Uytterhoeven <geert@linux-m68k.org>

This commit removes redundant generic-y defines in
arch/um/include/asm/Kbuild.

It is redundant to define generic-y when arch-specific implementation
exists in arch/$(ARCH)/include/asm/*.h

Remove the following generic-y:

    hardirq.h
    io.h

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/um/include/asm/Kbuild | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b10dde6..00bcbe2 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -10,9 +10,7 @@ generic-y += exec.h
 generic-y += extable.h
 generic-y += ftrace.h
 generic-y += futex.h
-generic-y += hardirq.h
 generic-y += hw_irq.h
-generic-y += io.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

