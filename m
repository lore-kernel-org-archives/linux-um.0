Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CiGAd-0000Ub-Tr for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Dec 2004 09:57:39 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CiGAc-0001QM-Hx for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Dec 2004 09:57:39 -0800
From: domen@coderock.org
Message-Id: <20041225175730.0F2C61ED41@trashy.coderock.org>
Subject: [uml-devel] [patch 04/13] delete unused file
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 25 Dec 2004 18:57:40 +0100
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/include/asm-um/archparam-ppc.h |   41 --------------------------------------
 1 files changed, 41 deletions(-)

diff -L include/asm-um/archparam-ppc.h -puN include/asm-um/archparam-ppc.h~remove_file-include_asm_um_archparam_ppc.h /dev/null
--- kj/include/asm-um/archparam-ppc.h
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,41 +0,0 @@
-#ifndef __UM_ARCHPARAM_PPC_H
-#define __UM_ARCHPARAM_PPC_H
-
-/********* Bits for asm-um/elf.h ************/
-
-#define ELF_PLATFORM (0)
-
-#define ELF_ET_DYN_BASE (0x08000000)
-
-/* the following stolen from asm-ppc/elf.h */
-#define ELF_NGREG	48	/* includes nip, msr, lr, etc. */
-#define ELF_NFPREG	33	/* includes fpscr */
-/* General registers */
-typedef unsigned long elf_greg_t;
-typedef elf_greg_t elf_gregset_t[ELF_NGREG];
-
-/* Floating point registers */
-typedef double elf_fpreg_t;
-typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
-
-#define ELF_DATA        ELFDATA2MSB
-#define ELF_ARCH	EM_PPC
-
-/********* Bits for asm-um/delay.h **********/
-
-typedef unsigned int um_udelay_t;
-
-/********* Bits for asm-um/hw_irq.h **********/
-
-struct hw_interrupt_type;
-
-/********* Bits for asm-um/hardirq.h **********/
-
-#define irq_enter(cpu, irq) hardirq_enter(cpu)
-#define irq_exit(cpu, irq) hardirq_exit(cpu)
-
-/********* Bits for asm-um/string.h **********/
-
-#define __HAVE_ARCH_STRRCHR
-
-#endif
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
