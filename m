Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBqH3-0003Rc-AP for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2005 00:22:33 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DBqH1-0008Cx-KP
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2005 00:22:33 -0800
Received: from knoppix (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j2H9Zt9D027375
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Mar 2005 04:36:02 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200503170219.38388.rob@landley.net>
Subject: [uml-devel] [patch] Remove unnecessary config symbol from makefile.
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
Date: Thu, 17 Mar 2005 02:19:38 -0500
To: user-mode-linux-devel@lists.sourceforge.net

There can be only one!

Signed-off-by: Rob Landley <rob@landley.net>


diff -ur linux-2.6.11/arch/um/Kconfig linux-2.6.11.new/arch/um/Kconfig
--- linux-2.6.11/arch/um/Kconfig	2005-03-02 01:38:09.000000000 -0600
+++ linux-2.6.11.new/arch/um/Kconfig	2005-03-16 17:38:54.000000000 -0600
@@ -75,11 +75,6 @@
 	default y
 	depends on MODE_TT || STATIC_LINK
 
-config LD_SCRIPT_DYN
-	bool
-	default y
-	depends on !LD_SCRIPT_STATIC
-
 config NET
 	bool "Networking support"
 	help
diff -ur linux-2.6.11/arch/um/Makefile linux-2.6.11.new/arch/um/Makefile
--- linux-2.6.11/arch/um/Makefile	2005-03-02 01:38:12.000000000 -0600
+++ linux-2.6.11.new/arch/um/Makefile	2005-03-16 17:55:36.997564112 -0600
@@ -90,7 +90,7 @@
 define archhelp
   echo '* linux		- Binary kernel image (./linux) - for backward'
   echo '		   compatibility only, this creates a hard link to the'
-  echo '		   real kernel binary, the the "vmlinux" binary you'
+  echo '		   real kernel binary, the "vmlinux" binary you'
   echo '		   find in the kernel root.'
 endef
 
@@ -99,11 +99,8 @@
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
 	$(ARCH_DIR)/kernel/vmlinux.lds.S
 
-LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
-
-LD_SCRIPT-$(CONFIG_LD_SCRIPT_STATIC) := uml.lds.S
-LD_SCRIPT-$(CONFIG_LD_SCRIPT_DYN) := dyn.lds.S
+LINK-y += $(if $(CONFIG_LD_SCRIPT_STATIC),-static,-Wl,-rpath,/lib)
+LD_SCRIPT-y += $(if $(CONFIG_LD_SCRIPT_STATIC),uml.lds.S,dyn.lds.S)
 
 CPP_MODE-$(CONFIG_MODE_TT) := -DMODE_TT
 CONFIG_KERNEL_STACK_ORDER ?= 2


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
