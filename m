Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IUlca-0005hG-GY for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 08:56:21 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IUlcY-0002h1-Rz
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 08:56:20 -0700
Date: Mon, 10 Sep 2007 11:55:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070910155546.GA14107@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - Fix ELF_CORE_COPY_REGS build botch
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Bunk <bunk@kernel.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

[ This needs to go into 2.6.23 ]

The earlier crash dump fix on x86_64 depended on patches in -mm which
are intended for post-2.6.23.  Without those, it broke the build when
it went into 2.6.23-rc5.

This patch changes the field references in ELF_CORE_COPY_REGS back to
those still used in mainline.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 include/asm-um/elf-x86_64.h |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

Index: linux-2.6.17/include/asm-um/elf-x86_64.h
===================================================================
--- linux-2.6.17.orig/include/asm-um/elf-x86_64.h	2007-09-04 18:22:48.000000000 -0400
+++ linux-2.6.17/include/asm-um/elf-x86_64.h	2007-09-10 11:48:25.000000000 -0400
@@ -67,27 +67,27 @@ typedef struct { } elf_fpregset_t;
 } while (0)
 
 #define ELF_CORE_COPY_REGS(pr_reg, regs)		\
-	(pr_reg)[0] = (regs)->regs.gp[0];			\
-	(pr_reg)[1] = (regs)->regs.gp[1];			\
-	(pr_reg)[2] = (regs)->regs.gp[2];			\
-	(pr_reg)[3] = (regs)->regs.gp[3];			\
-	(pr_reg)[4] = (regs)->regs.gp[4];			\
-	(pr_reg)[5] = (regs)->regs.gp[5];			\
-	(pr_reg)[6] = (regs)->regs.gp[6];			\
-	(pr_reg)[7] = (regs)->regs.gp[7];			\
-	(pr_reg)[8] = (regs)->regs.gp[8];			\
-	(pr_reg)[9] = (regs)->regs.gp[9];			\
-	(pr_reg)[10] = (regs)->regs.gp[10];			\
-	(pr_reg)[11] = (regs)->regs.gp[11];			\
-	(pr_reg)[12] = (regs)->regs.gp[12];			\
-	(pr_reg)[13] = (regs)->regs.gp[13];			\
-	(pr_reg)[14] = (regs)->regs.gp[14];			\
-	(pr_reg)[15] = (regs)->regs.gp[15];			\
-	(pr_reg)[16] = (regs)->regs.gp[16];			\
-	(pr_reg)[17] = (regs)->regs.gp[17];			\
-	(pr_reg)[18] = (regs)->regs.gp[18];			\
-	(pr_reg)[19] = (regs)->regs.gp[19];			\
-	(pr_reg)[20] = (regs)->regs.gp[20];			\
+	(pr_reg)[0] = (regs)->regs.skas.regs[0];			\
+	(pr_reg)[1] = (regs)->regs.skas.regs[1];			\
+	(pr_reg)[2] = (regs)->regs.skas.regs[2];			\
+	(pr_reg)[3] = (regs)->regs.skas.regs[3];			\
+	(pr_reg)[4] = (regs)->regs.skas.regs[4];			\
+	(pr_reg)[5] = (regs)->regs.skas.regs[5];			\
+	(pr_reg)[6] = (regs)->regs.skas.regs[6];			\
+	(pr_reg)[7] = (regs)->regs.skas.regs[7];			\
+	(pr_reg)[8] = (regs)->regs.skas.regs[8];			\
+	(pr_reg)[9] = (regs)->regs.skas.regs[9];			\
+	(pr_reg)[10] = (regs)->regs.skas.regs[10];			\
+	(pr_reg)[11] = (regs)->regs.skas.regs[11];			\
+	(pr_reg)[12] = (regs)->regs.skas.regs[12];			\
+	(pr_reg)[13] = (regs)->regs.skas.regs[13];			\
+	(pr_reg)[14] = (regs)->regs.skas.regs[14];			\
+	(pr_reg)[15] = (regs)->regs.skas.regs[15];			\
+	(pr_reg)[16] = (regs)->regs.skas.regs[16];			\
+	(pr_reg)[17] = (regs)->regs.skas.regs[17];			\
+	(pr_reg)[18] = (regs)->regs.skas.regs[18];			\
+	(pr_reg)[19] = (regs)->regs.skas.regs[19];			\
+	(pr_reg)[20] = (regs)->regs.skas.regs[20];			\
 	(pr_reg)[21] = current->thread.arch.fs;			\
 	(pr_reg)[22] = 0;					\
 	(pr_reg)[23] = 0;					\

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
