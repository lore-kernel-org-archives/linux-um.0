Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUqJs-0007NP-SC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 09:43:44 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CUqJr-00005z-NN for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 09:43:44 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041118172304.02EE055C9B@zion.localdomain>
Subject: [uml-devel] [patch 1/1] uml: partial KBUILD_OUTPUT fix
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
Date: Thu, 18 Nov 2004 18:23:04 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Start fixing KBUILD_OUTPUT support for UML. These changes are trivial and
no-ops when this feature is not enabled - the "hard part" of this support is
under discussion because it's hard to do properly (UML uses both shipped and
build-generated headers from a lot of different directories, and for good
reasons).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/um/Makefile~uml-KBUILD_OUTPUT-fix arch/um/Makefile
--- linux-2.6.10-rc/arch/um/Makefile~uml-KBUILD_OUTPUT-fix	2004-11-18 18:18:20.916697608 +0100
+++ linux-2.6.10-rc-paolo/arch/um/Makefile	2004-11-18 18:18:20.918697304 +0100
@@ -29,14 +29,14 @@ MAKEFILE-$(CONFIG_MODE_TT) += Makefile-t
 MAKEFILE-$(CONFIG_MODE_SKAS) += Makefile-skas
 
 ifneq ($(MAKEFILE-y),)
-  include $(addprefix $(ARCH_DIR)/,$(MAKEFILE-y))
+  include $(addprefix $(srctree)/$(ARCH_DIR)/,$(MAKEFILE-y))
 endif
 
 ARCH_INCLUDE	:= -I$(ARCH_DIR)/include
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
-include $(ARCH_DIR)/Makefile-$(SUBARCH)
-include $(ARCH_DIR)/Makefile-os-$(OS)
+include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
+include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
_


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
