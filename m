Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVHFD-0000hp-TB	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:00:59 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DVHFB-0007P7-Tp	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:00:59 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ak+fCf8UlUzbPtv"
Message-Id: <200505100049.36069.blaisorblade@yahoo.it>
Subject: [uml-devel] Compile failure of 2.6.12-rc4 fixed
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
Date: Tue, 10 May 2005 00:49:33 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

--Boundary-00=_Ak+fCf8UlUzbPtv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Boys, since somebody reported this:

 applying the following empty patch (which removes elf.h) fixes the 2.6.12-rc4 
compilation. Jeff, possibly removing --no-timestamps from the quilt options 
for REFRESH will fix this issue (which I verified various times in your 
patches, but which now caused a real problem). Jeff, please make sure that 
your patches remove files even when applied simply by patch. Possibly upgrade 
quilt if needed.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_Ak+fCf8UlUzbPtv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="uml-remove-elf-h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-remove-elf-h.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-um/elf.h |  169 +++++++++++++++++++++++++++++++
 1 files changed, 169 insertions(+)

diff -puN include/asm-um/elf.h~uml-remove-elf-h include/asm-um/elf.h
--- linux-2.6.git/include/asm-um/elf.h~uml-remove-elf-h	2005-05-10 00:24:44.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/elf.h	2005-05-09 23:48:31.000000000 +0200
@@ -0,0 +1,169 @@
+/*
+ * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+#ifndef __UM_ELF_I386_H
+#define __UM_ELF_I386_H
+
+#include "user.h"
+
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
+typedef unsigned long elf_greg_t;
+
+#define ELF_NGREG (sizeof (struct user_regs_struct) / sizeof(elf_greg_t))
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+
+typedef struct user_i387_struct elf_fpregset_t;
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x) \
+	(((x)->e_machine == EM_386) || ((x)->e_machine == EM_486))
+
+#define ELF_CLASS	ELFCLASS32
+#define ELF_DATA        ELFDATA2LSB
+#define ELF_ARCH        EM_386
+
+#define ELF_PLAT_INIT(regs, load_addr) do { \
+	PT_REGS_EBX(regs) = 0; \
+	PT_REGS_ECX(regs) = 0; \
+	PT_REGS_EDX(regs) = 0; \
+	PT_REGS_ESI(regs) = 0; \
+	PT_REGS_EDI(regs) = 0; \
+	PT_REGS_EBP(regs) = 0; \
+	PT_REGS_EAX(regs) = 0; \
+} while(0)
+
+#define USE_ELF_CORE_DUMP
+#define ELF_EXEC_PAGESIZE 4096
+
+#define ELF_ET_DYN_BASE (2 * TASK_SIZE / 3)
+
+/* Shamelessly stolen from include/asm-i386/elf.h */
+
+#define ELF_CORE_COPY_REGS(pr_reg, regs) do {	\
+	pr_reg[0] = PT_REGS_EBX(regs);		\
+	pr_reg[1] = PT_REGS_ECX(regs);		\
+	pr_reg[2] = PT_REGS_EDX(regs);		\
+	pr_reg[3] = PT_REGS_ESI(regs);		\
+	pr_reg[4] = PT_REGS_EDI(regs);		\
+	pr_reg[5] = PT_REGS_EBP(regs);		\
+	pr_reg[6] = PT_REGS_EAX(regs);		\
+	pr_reg[7] = PT_REGS_DS(regs);		\
+	pr_reg[8] = PT_REGS_ES(regs);		\
+	/* fake once used fs and gs selectors? */	\
+	pr_reg[9] = PT_REGS_DS(regs);		\
+	pr_reg[10] = PT_REGS_DS(regs);		\
+	pr_reg[11] = PT_REGS_SYSCALL_NR(regs);	\
+	pr_reg[12] = PT_REGS_IP(regs);		\
+	pr_reg[13] = PT_REGS_CS(regs);		\
+	pr_reg[14] = PT_REGS_EFLAGS(regs);	\
+	pr_reg[15] = PT_REGS_SP(regs);		\
+	pr_reg[16] = PT_REGS_SS(regs);		\
+} while(0);
+
+extern long elf_aux_hwcap;
+#define ELF_HWCAP (elf_aux_hwcap)
+
+extern char * elf_aux_platform;
+#define ELF_PLATFORM (elf_aux_platform)
+
+#define SET_PERSONALITY(ex, ibcs2) do ; while(0)
+
+extern unsigned long vsyscall_ehdr;
+extern unsigned long vsyscall_end;
+extern unsigned long __kernel_vsyscall;
+
+#define VSYSCALL_BASE vsyscall_ehdr
+#define VSYSCALL_END vsyscall_end
+
+/*
+ * This is the range that is readable by user mode, and things
+ * acting like user mode such as get_user_pages.
+ */
+#define FIXADDR_USER_START      VSYSCALL_BASE
+#define FIXADDR_USER_END        VSYSCALL_END
+
+/*
+ * Architecture-neutral AT_ values in 0-17, leave some room
+ * for more of them, start the x86-specific ones at 32.
+ */
+#define AT_SYSINFO		32
+#define AT_SYSINFO_EHDR		33
+
+#define ARCH_DLINFO						\
+do {								\
+	if ( vsyscall_ehdr ) {					\
+		NEW_AUX_ENT(AT_SYSINFO,	__kernel_vsyscall);	\
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, vsyscall_ehdr);	\
+	}							\
+} while (0)
+
+/*
+ * These macros parameterize elf_core_dump in fs/binfmt_elf.c to write out
+ * extra segments containing the vsyscall DSO contents.  Dumping its
+ * contents makes post-mortem fully interpretable later without matching up
+ * the same kernel and hardware config to see what PC values meant.
+ * Dumping its extra ELF program headers includes all the other information
+ * a debugger needs to easily find how the vsyscall DSO was being used.
+ */
+#define ELF_CORE_EXTRA_PHDRS						      \
+	(vsyscall_ehdr ? (((struct elfhdr *)vsyscall_ehdr)->e_phnum) : 0 )
+
+#define ELF_CORE_WRITE_EXTRA_PHDRS					      \
+if ( vsyscall_ehdr ) {							      \
+	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
+	const struct elf_phdr *const phdrp =				      \
+		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
+	int i;								      \
+	Elf32_Off ofs = 0;						      \
+	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
+		struct elf_phdr phdr = phdrp[i];			      \
+		if (phdr.p_type == PT_LOAD) {				      \
+			ofs = phdr.p_offset = offset;			      \
+			offset += phdr.p_filesz;			      \
+		}							      \
+		else							      \
+			phdr.p_offset += ofs;				      \
+		phdr.p_paddr = 0; /* match other core phdrs */		      \
+		DUMP_WRITE(&phdr, sizeof(phdr));			      \
+	}								      \
+}
+#define ELF_CORE_WRITE_EXTRA_DATA					      \
+if ( vsyscall_ehdr ) {							      \
+	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
+	const struct elf_phdr *const phdrp =				      \
+		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
+	int i;								      \
+	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
+		if (phdrp[i].p_type == PT_LOAD)				      \
+			DUMP_WRITE((void *) phdrp[i].p_vaddr,		      \
+				   phdrp[i].p_filesz);			      \
+	}								      \
+}
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
_

--Boundary-00=_Ak+fCf8UlUzbPtv--




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
