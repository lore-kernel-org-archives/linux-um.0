Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tabbott@MIT.EDU>) id 1Mq6IQ-0001ar-Lo
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Sep 2009 14:24:46 +0000
Received: from biscayne-one-station.mit.edu ([18.7.7.80])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mq6IO-0001yB-BF
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Sep 2009 14:24:46 +0000
From: Tim Abbott <tabbott@ksplice.com>
Date: Tue, 22 Sep 2009 10:22:25 -0400
Message-Id: <1253629347-23119-12-git-send-email-tabbott@ksplice.com>
In-Reply-To: <1253629347-23119-1-git-send-email-tabbott@ksplice.com>
References: <1253629347-23119-1-git-send-email-tabbott@ksplice.com>
Subject: [uml-devel] [PATCH 11/13] um: Clean up linker script using standard
	macros.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tim Abbott <tabbott@ksplice.com>, Jeff Dike <jdike@addtoit.com>, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Signed-off-by: Tim Abbott <tabbott@ksplice.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/um/include/asm/common.lds.S |   29 ++++++-----------------------
 arch/um/kernel/dyn.lds.S         |    9 ++-------
 arch/um/kernel/uml.lds.S         |   26 ++++++--------------------
 3 files changed, 14 insertions(+), 50 deletions(-)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index 37ecc55..ac55b9e 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -16,11 +16,7 @@
 
   . = ALIGN(4096);
   .note : { *(.note.*) }
-  __ex_table : {
-	__start___ex_table = .;
-	*(__ex_table)
-	__stop___ex_table = .;
-  }
+  EXCEPTION_TABLE(0)
 
   BUG_TABLE
 
@@ -43,28 +39,17 @@
   }
 	
   .init.setup : {
-	__setup_start = .;
-	*(.init.setup)
-	__setup_end = .;
+	INIT_SETUP(0)
   }
 
-  . = ALIGN(32);
-  .data.percpu : {
-	__per_cpu_start = . ;
-	*(.data.percpu)
-	__per_cpu_end = . ;
-  }
+  PERCPU(32)
 	
   .initcall.init : {
-	__initcall_start = .;
-	INITCALLS
-	__initcall_end = .;
+	INIT_CALLS
   }
 
   .con_initcall.init : {
-	__con_initcall_start = .;
-	*(.con_initcall.init)
-	__con_initcall_end = .;
+	CON_INITCALL
   }
 
   .uml.initcall.init : {
@@ -118,8 +103,6 @@
 
    . = ALIGN(4096);
   .init.ramfs : {
-	__initramfs_start = .;
-	*(.init.ramfs)
-	__initramfs_end = .;
+	INIT_RAM_FS
   }
 
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index 715a188..7fcad58 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -16,11 +16,7 @@ SECTIONS
   _text = .;
   _stext = .;
   __init_begin = .;
-  .init.text : {
-	_sinittext = .;
-	INIT_TEXT
-	_einittext = .;
-  }
+  INIT_TEXT_SECTION(PAGE_SIZE)
 
   . = ALIGN(PAGE_SIZE);
 
@@ -96,8 +92,7 @@ SECTIONS
   .init_array     : { *(.init_array) }
   .fini_array     : { *(.fini_array) }
   .data           : {
-    . = ALIGN(KERNEL_STACK_SIZE);		/* init_task */
-    *(.data.init_task)
+    INIT_TASK_DATA(KERNEL_STACK_SIZE)
     . = ALIGN(KERNEL_STACK_SIZE);
     *(.data.init_irqstack)
     DATA_DATA
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 2ebd397..e7a6cca 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -22,11 +22,7 @@ SECTIONS
   _text = .;
   _stext = .;
   __init_begin = .;
-  .init.text : {
-	_sinittext = .;
-	INIT_TEXT
-	_einittext = .;
-  }
+  INIT_TEXT_SECTION(PAGE_SIZE)
   . = ALIGN(PAGE_SIZE);
 
   .text      :
@@ -52,8 +48,7 @@ SECTIONS
   init.data : { INIT_DATA }
   .data    :
   {
-    . = ALIGN(KERNEL_STACK_SIZE);		/* init_task */
-    *(.data.init_task)
+    INIT_TASK_DATA(KERNEL_STACK_SIZE)
     . = ALIGN(KERNEL_STACK_SIZE);
     *(.data.init_irqstack)
     DATA_DATA
@@ -81,19 +76,10 @@ SECTIONS
   _edata  =  .;
   PROVIDE (edata = .);
   . = ALIGN(PAGE_SIZE);
-  .sbss      :
-  {
-   __bss_start = .;
-   PROVIDE(_bss_start = .);
-   *(.sbss)
-   *(.scommon)
-  }
-  .bss       :
-  {
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
-  }
+  __bss_start = .;
+  PROVIDE(_bss_start = .);
+  SBSS(0)
+  BSS(0)
   _end = .;
   PROVIDE (end = .);
 
-- 
1.6.3.3


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

