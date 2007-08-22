Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1INxhw-0002G6-IG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 14:25:44 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1INxhv-0008KC-U4
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 14:25:44 -0700
Date: Wed, 22 Aug 2007 17:25:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070822212528.GA14473@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/2] UML - Fix linker script alignment bugs
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
To: Andrew Morton <akpm@osdl.org>
Cc: giedrius@su.lt, Alberto Pires de Oliveira Neto <apon1@terra.com.br>, Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Fix a class of bugs in the UML linker scripts which caused section
boundary variables to sometimes not line up with their sections.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/dyn.lds.S    |   12 ++--
 arch/um/kernel/uml.lds.S    |   11 ++-
 include/asm-um/common.lds.S |  128 +++++++++++++++++++++++++++-----------------
 3 files changed, 92 insertions(+), 59 deletions(-)

Index: linux-2.6.22/arch/um/kernel/dyn.lds.S
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/dyn.lds.S	2007-08-17 13:36:34.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/dyn.lds.S	2007-08-17 13:37:30.000000000 -0400
@@ -69,11 +69,13 @@ SECTIONS
     *(.gnu.warning)
 
     . = ALIGN(4096);
-    __syscall_stub_start = .;
-    *(.__syscall_stub*)
-    __syscall_stub_end = .;
-    . = ALIGN(4096);
   } =0x90909090
+  . = ALIGN(4096);
+  .syscall_stub : {
+	__syscall_stub_start = .;
+	*(.__syscall_stub*)
+	__syscall_stub_end = .;
+  }
   .fini           : {
     KEEP (*(.fini))
   } =0x90909090
@@ -136,8 +138,8 @@ SECTIONS
   .got            : { *(.got.plt) *(.got) }
   _edata = .;
   PROVIDE (edata = .);
-  __bss_start = .;
   .bss            : {
+   __bss_start = .;
    *(.dynbss)
    *(.bss .bss.* .gnu.linkonce.b.*)
    *(COMMON)
Index: linux-2.6.22/arch/um/kernel/uml.lds.S
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/uml.lds.S	2007-08-17 13:36:34.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/uml.lds.S	2007-08-17 13:37:30.000000000 -0400
@@ -37,12 +37,13 @@ SECTIONS
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
     *(.gnu.linkonce.t*)
+  }
 
-    . = ALIGN(4096);
-    __syscall_stub_start = .;
-    *(.__syscall_stub*)
-    __syscall_stub_end = .;
-    . = ALIGN(4096);
+  . = ALIGN(4096);
+  .syscall_stub : {
+	__syscall_stub_start = .;
+	*(.__syscall_stub*)
+	__syscall_stub_end = .;
   }
 
   #include "asm/common.lds.S"
Index: linux-2.6.22/include/asm-um/common.lds.S
===================================================================
--- linux-2.6.22.orig/include/asm-um/common.lds.S	2007-08-17 13:36:34.000000000 -0400
+++ linux-2.6.22/include/asm-um/common.lds.S	2007-08-17 13:37:30.000000000 -0400
@@ -16,82 +16,112 @@
 
   . = ALIGN(4096);
   .note : { *(.note.*) }
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+  __ex_table : {
+	__start___ex_table = .;
+	*(__ex_table)
+	__stop___ex_table = .;
+  }
 
   BUG_TABLE
 
-  __uml_setup_start = .;
-  .uml.setup.init : { *(.uml.setup.init) }
-  __uml_setup_end = .;
+  .uml.setup.init : {
+	__uml_setup_start = .;
+	*(.uml.setup.init)
+	__uml_setup_end = .;
+  }
 	
-  __uml_help_start = .;
-  .uml.help.init : { *(.uml.help.init) }
-  __uml_help_end = .;
+  .uml.help.init : {
+	__uml_help_start = .;
+	*(.uml.help.init)
+	__uml_help_end = .;
+  }
 	
-  __uml_postsetup_start = .;
-  .uml.postsetup.init : { *(.uml.postsetup.init) }
-  __uml_postsetup_end = .;
+  .uml.postsetup.init : {
+	__uml_postsetup_start = .;
+	*(.uml.postsetup.init)
+	__uml_postsetup_end = .;
+  }
 	
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
+  .init.setup : {
+	__setup_start = .;
+	*(.init.setup)
+	__setup_end = .;
+  }
 
   . = ALIGN(32);
-  __per_cpu_start = . ; 
-  .data.percpu : { *(.data.percpu) }
-  __per_cpu_end = . ;
+  .data.percpu : {
+	__per_cpu_start = . ;
+	*(.data.percpu)
+	__per_cpu_end = . ;
+  }
 	
-  __initcall_start = .;
   .initcall.init : {
+	__initcall_start = .;
 	INITCALLS
+	__initcall_end = .;
+  }
+
+  .con_initcall.init : {
+	__con_initcall_start = .;
+	*(.con_initcall.init)
+	__con_initcall_end = .;
   }
-  __initcall_end = .;
 
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
-
-  __uml_initcall_start = .;
-  .uml.initcall.init : { *(.uml.initcall.init) }
-  __uml_initcall_end = .;
+  .uml.initcall.init : {
+	__uml_initcall_start = .;
+	*(.uml.initcall.init)
+	__uml_initcall_end = .;
+  }
   __init_end = .;
 
   SECURITY_INIT
 
-  __exitcall_begin = .;
-  .exitcall : { *(.exitcall.exit) }
-  __exitcall_end = .;
-
-  __uml_exitcall_begin = .;
-  .uml.exitcall : { *(.uml.exitcall.exit) }
-  __uml_exitcall_end = .;
+  .exitcall : {
+	__exitcall_begin = .;
+	*(.exitcall.exit)
+	__exitcall_end = .;
+  }
+
+  .uml.exitcall : {
+	__uml_exitcall_begin = .;
+	*(.uml.exitcall.exit)
+	__uml_exitcall_end = .;
+  }
 
   . = ALIGN(4);
-  __alt_instructions = .;
-  .altinstructions : { *(.altinstructions) }
-  __alt_instructions_end = .;
+  .altinstructions : {
+	__alt_instructions = .;
+	*(.altinstructions)
+	__alt_instructions_end = .;
+  }
   .altinstr_replacement : { *(.altinstr_replacement) }
   /* .exit.text is discard at runtime, not link time, to deal with references
      from .altinstructions and .eh_frame */
   .exit.text : { *(.exit.text) }
   .exit.data : { *(.exit.data) }
 
-  __preinit_array_start = .;
-  .preinit_array : { *(.preinit_array) }
-  __preinit_array_end = .;
-  __init_array_start = .;
-  .init_array : { *(.init_array) }
-  __init_array_end = .;
-  __fini_array_start = .;
-  .fini_array : { *(.fini_array) }
-  __fini_array_end = .;
+  .preinit_array : {
+	__preinit_array_start = .;
+	*(.preinit_array)
+	__preinit_array_end = .;
+  }
+  .init_array : {
+	__init_array_start = .;
+	*(.init_array)
+	__init_array_end = .;
+  }
+  .fini_array : {
+	__fini_array_start = .;
+	*(.fini_array)
+	__fini_array_end = .;
+  }
 
    . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
+  .init.ramfs : {
+	__initramfs_start = .;
+	*(.init.ramfs)
+	__initramfs_end = .;
+  }
 
   /* Sections to be discarded */
   /DISCARD/ : {

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
