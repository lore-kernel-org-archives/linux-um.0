Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1qGp-0007HQ-IU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Mar 2004 09:16:27 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B1pXy-0003XX-CS
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Mar 2004 08:30:06 -0800
Message-Id: <200403121730.i2CHU7Zl002882@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH] Finish fixing core dumps under 2.6.4
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
Date: Fri, 12 Mar 2004 12:30:07 -0500
To: wstearns@pobox.com, user-mode-linux-devel@lists.sourceforge.net

The patch below adds more core dumping fixes.  I missed a couple of things
in the 2.6.4 patch yesterday.

Apply with patch -l since this is a cut'n'paste from an xterm.

				Jeff

===== include/asm-um/archparam-i386.h 1.9 vs edited =====
--- 1.9/include/asm-um/archparam-i386.h Wed Mar 10 01:06:27 2004
+++ edited/include/asm-um/archparam-i386.h      Wed Mar 10 23:30:48 2004
@@ -91,7 +91,9 @@
 #define ELF_CORE_EXTRA_PHDRS           (VSYSCALL_EHDR->e_phnum)
 #endif
 
-#define ELF_CORE_EXTRA_PHDRS           0
+#undef ELF_CORE_EXTRA_PHDRS
+
+#if 0
 #define ELF_CORE_WRITE_EXTRA_PHDRS                                           \
 do {                                                                         \
        const struct elf_phdr *const vsyscall_phdrs =                         \
@@ -123,6 +125,10 @@
                                   vsyscall_phdrs[i].p_filesz);               \
        }                                                                     \
 } while (0)
+#endif
+
+#undef ELF_CORE_WRITE_EXTRA_PHDRS
+#undef ELF_CORE_WRITE_EXTRA_DATA
 
 #define R_386_NONE     0
 #define R_386_32       1



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
