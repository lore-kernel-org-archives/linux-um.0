Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xCIf-0004Yt-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 14:14:53 -0700
Received: from brmea-mail-2.sun.com ([192.18.98.43])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xCIf-0004d1-3K
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 10 Sep 2003 14:14:53 -0700
From: Marc.Herbert@ens-lyon.fr
Message-ID: <Pine.GSO.4.10.10309102222360.23842-100000@reiser>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] in 2.6.0-test5: module.c:79:`R_386_32' undeclared
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 10 Sep 2003 23:14:35 +0200 (MEST)
To: user-mode-linux-devel@lists.sourceforge.net


When trying to compile the latest 2.6.0-test5, I get the following error:

arch/um/sys-i386/module.c: In function `apply_relocate':
arch/um/sys-i386/module.c:79: `R_386_32' undeclared (first use in this function)

A closer look seems to give a explanation: contrary to 2.4.X, in 2.6,
"R_386_32" is defined in "arch-i386/elf.h" and not in "linux/elf.h"
anymore.

The attached patch (adding R_386 macros to
"include/asm-um/archparam-i386.h") solves this issue. So my question
becomes : how do you guys people succeeded in compiling 2.6.0-test5 ?!
What did I missed ?


Cheers,

Marc.


Notes:
arch/um/sys-i386/module.c: symbolic link to arch/i386/kernel/module.c
include/asm: symbolic link to asm-um
include/asm-um/archparam.h: symbolic link to archparam-i386.h


  --------

--- include/asm-um/archparam-i386.h	2003/09/10 21:02:28	1.1
+++ include/asm-um/archparam-i386.h	2003/09/10 21:02:41
@@ -35,6 +35,19 @@
 
 /* Shamelessly stolen from include/asm-i386/elf.h */
 
+#define R_386_NONE	0
+#define R_386_32	1
+#define R_386_PC32	2
+#define R_386_GOT32	3
+#define R_386_PLT32	4
+#define R_386_COPY	5
+#define R_386_GLOB_DAT	6
+#define R_386_JMP_SLOT	7
+#define R_386_RELATIVE	8
+#define R_386_GOTOFF	9
+#define R_386_GOTPC	10
+#define R_386_NUM	11
+
 #define ELF_CORE_COPY_REGS(pr_reg, regs) do {	\
 	pr_reg[0] = PT_REGS_EBX(regs);		\
 	pr_reg[1] = PT_REGS_ECX(regs);		\






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
