Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CG0PK-0002wo-Lh for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 12:28:02 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CG0PI-0005H4-S6 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 12:28:02 -0700
Message-Id: <200410081912.i98JCur20479@trolli.pdb.fsc.net>
From: bodo.stroesser@fujitsu-siemens.com
Subject: [uml-devel] Implement vsyscall/sysenter, patch 4/4
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
Date: Fri, 08 Oct 2004 21:12:56 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com, blaisorblade_spam@yahoo.it

Comlete the dump with the vsyscall-information, if a vsyscall-page
is available.


Signed-off-by: Bodo Stroesser <bodo.stroesser@fujitsu-siemens.com>

---


--- linux-2.6.9-rc2-orig/include/asm-um/archparam-i386.h	2004-09-13 07:33:11.000000000 +0200
+++ linux-2.6.9-rc2/include/asm-um/archparam-i386.h	2004-10-05 16:15:44.488592605 +0200
@@ -88,22 +88,18 @@
  * Dumping its extra ELF program headers includes all the other information
  * a debugger needs to easily find how the vsyscall DSO was being used.
  */
-#if 0
-#define ELF_CORE_EXTRA_PHDRS		(VSYSCALL_EHDR->e_phnum)
-#endif
-
-#undef ELF_CORE_EXTRA_PHDRS
+#define ELF_CORE_EXTRA_PHDRS						      \
+	(vsyscall_ehdr ? (((struct elfhdr *)vsyscall_ehdr)->e_phnum) : 0 )
 
-#if 0
 #define ELF_CORE_WRITE_EXTRA_PHDRS					      \
-do {									      \
-	const struct elf_phdr *const vsyscall_phdrs =			      \
-		(const struct elf_phdr *) (VSYSCALL_BASE		      \
-					   + VSYSCALL_EHDR->e_phoff);	      \
+if ( vsyscall_ehdr ) {							      \
+	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
+	const struct elf_phdr *const phdrp =				      \
+		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
 	int i;								      \
 	Elf32_Off ofs = 0;						      \
-	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
-		struct elf_phdr phdr = vsyscall_phdrs[i];		      \
+	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
+		struct elf_phdr phdr = phdrp[i];			      \
 		if (phdr.p_type == PT_LOAD) {				      \
 			ofs = phdr.p_offset = offset;			      \
 			offset += phdr.p_filesz;			      \
@@ -113,23 +109,19 @@
 		phdr.p_paddr = 0; /* match other core phdrs */		      \
 		DUMP_WRITE(&phdr, sizeof(phdr));			      \
 	}								      \
-} while (0)
+}
 #define ELF_CORE_WRITE_EXTRA_DATA					      \
-do {									      \
-	const struct elf_phdr *const vsyscall_phdrs =			      \
-		(const struct elf_phdr *) (VSYSCALL_BASE		      \
-					   + VSYSCALL_EHDR->e_phoff);	      \
+if ( vsyscall_ehdr ) {							      \
+	const struct elfhdr *const ehdrp = (struct elfhdr *)vsyscall_ehdr;    \
+	const struct elf_phdr *const phdrp =				      \
+		(const struct elf_phdr *) (vsyscall_ehdr + ehdrp->e_phoff);   \
 	int i;								      \
-	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
-		if (vsyscall_phdrs[i].p_type == PT_LOAD)		      \
-			DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,	      \
-				   vsyscall_phdrs[i].p_filesz);		      \
+	for (i = 0; i < ehdrp->e_phnum; ++i) {				      \
+		if (phdrp[i].p_type == PT_LOAD)				      \
+			DUMP_WRITE((void *) phdrp[i].p_vaddr,		      \
+				   phdrp[i].p_filesz);			      \
 	}								      \
-} while (0)
-#endif
-
-#undef ELF_CORE_WRITE_EXTRA_PHDRS
-#undef ELF_CORE_WRITE_EXTRA_DATA
+}
 
 #define R_386_NONE	0
 #define R_386_32	1


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
