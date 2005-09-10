Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EE9ik-0006mE-Pp	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:04:58 -0700
Received: from ppp-62-11-72-160.dialup.tiscali.it ([62.11.72.160]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EE9ij-0002cx-4w	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:04:58 -0700
Message-Id: <20050910174627.569839000@zion.home.lan>
References: <20050910174452.907256000@zion.home.lan>
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Content-Disposition: inline;
	filename=uml-add-dwarf-sections-to-static-link-script
Subject: [uml-devel] [patch 2/7] i386 / uml: add dwarf sections to static link
	script
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
Date: Sat, 10 Sep 2005 19:44:54 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, Sam Ravnborg <sam@ravnborg.org>, Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

Inside the linker script, insert the code for DWARF debug info sections. This
may help GDB'ing a Uml binary. Actually, it seems that ld is able to guess
what I added correctly, but normal linker scripts include this section so it
should be correct anyway adding it.

On request by Sam Ravnborg <sam@ravnborg.org>, I've added it to
asm-generic/vmlinux.lds.s. I've also moved there the stabs debug section,
used the new macro in i386 linker script and added DWARF debug section to
that.

In the truth, I've not been able to verify the difference in GDB behaviour
after this change (I've seen large improvements with another patch). This
may depend on my binutils version, older one may have worse defaults.

However, this section is present in normal linker script, so add it at
least for the sake of cleanness.

Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/i386/kernel/vmlinux.lds.S    |   11 +++--------
 arch/um/kernel/dyn.lds.S          |   37 ++++--------------------------------
 arch/um/kernel/uml.lds.S          |   14 +++++---------
 include/asm-generic/vmlinux.lds.h |   38 +++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -144,12 +144,7 @@ SECTIONS
 	*(.exitcall.exit)
 	}
 
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
+  STABS_DEBUG
+
+  DWARF_DEBUG
 }
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -146,37 +146,8 @@ SECTIONS
   }
   _end = .;
   PROVIDE (end = .);
-   /* Stabs debugging sections.  */
-  .stab          0 : { *(.stab) }
-  .stabstr       0 : { *(.stabstr) }
-  .stab.excl     0 : { *(.stab.excl) }
-  .stab.exclstr  0 : { *(.stab.exclstr) }
-  .stab.index    0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment       0 : { *(.comment) }
-  /* DWARF debug sections.
-     Symbols in the DWARF debugging sections are relative to the beginning
-     of the section so we begin them at 0.  */
-  /* DWARF 1 */
-  .debug          0 : { *(.debug) }
-  .line           0 : { *(.line) }
-  /* GNU DWARF 1 extensions */
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  /* DWARF 1.1 and DWARF 2 */
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  /* DWARF 2 */
-  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
-  .debug_abbrev   0 : { *(.debug_abbrev) }
-  .debug_line     0 : { *(.debug_line) }
-  .debug_frame    0 : { *(.debug_frame) }
-  .debug_str      0 : { *(.debug_str) }
-  .debug_loc      0 : { *(.debug_loc) }
-  .debug_macinfo  0 : { *(.debug_macinfo) }
-  /* SGI/MIPS DWARF 2 extensions */
-  .debug_weaknames 0 : { *(.debug_weaknames) }
-  .debug_funcnames 0 : { *(.debug_funcnames) }
-  .debug_typenames 0 : { *(.debug_typenames) }
-  .debug_varnames  0 : { *(.debug_varnames) }
+
+  STABS_DEBUG
+
+  DWARF_DEBUG
 }
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -93,14 +93,10 @@ SECTIONS
    *(.bss)
    *(COMMON)
   }
-  _end = . ;
+  _end = .;
   PROVIDE (end = .);
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
+
+  STABS_DEBUG
+
+  DWARF_DEBUG
 }
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -103,3 +103,41 @@
 		VMLINUX_SYMBOL(__kprobes_text_start) = .;		\
 		*(.kprobes.text)					\
 		VMLINUX_SYMBOL(__kprobes_text_end) = .;
+
+		/* DWARF debug sections.
+		Symbols in the DWARF debugging sections are relative to
+		the beginning of the section so we begin them at 0.  */
+#define DWARF_DEBUG							\
+		/* DWARF 1 */						\
+		.debug          0 : { *(.debug) }			\
+		.line           0 : { *(.line) }			\
+		/* GNU DWARF 1 extensions */				\
+		.debug_srcinfo  0 : { *(.debug_srcinfo) }		\
+		.debug_sfnames  0 : { *(.debug_sfnames) }		\
+		/* DWARF 1.1 and DWARF 2 */				\
+		.debug_aranges  0 : { *(.debug_aranges) }		\
+		.debug_pubnames 0 : { *(.debug_pubnames) }		\
+		/* DWARF 2 */						\
+		.debug_info     0 : { *(.debug_info			\
+				.gnu.linkonce.wi.*) }			\
+		.debug_abbrev   0 : { *(.debug_abbrev) }		\
+		.debug_line     0 : { *(.debug_line) }			\
+		.debug_frame    0 : { *(.debug_frame) }			\
+		.debug_str      0 : { *(.debug_str) }			\
+		.debug_loc      0 : { *(.debug_loc) }			\
+		.debug_macinfo  0 : { *(.debug_macinfo) }		\
+		/* SGI/MIPS DWARF 2 extensions */			\
+		.debug_weaknames 0 : { *(.debug_weaknames) }		\
+		.debug_funcnames 0 : { *(.debug_funcnames) }		\
+		.debug_typenames 0 : { *(.debug_typenames) }		\
+		.debug_varnames  0 : { *(.debug_varnames) }		\
+
+		/* Stabs debugging sections.  */
+#define STABS_DEBUG							\
+		.stab 0 : { *(.stab) }					\
+		.stabstr 0 : { *(.stabstr) }				\
+		.stab.excl 0 : { *(.stab.excl) }			\
+		.stab.exclstr 0 : { *(.stab.exclstr) }			\
+		.stab.index 0 : { *(.stab.index) }			\
+		.stab.indexstr 0 : { *(.stab.indexstr) }		\
+		.comment 0 : { *(.comment) }

--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
