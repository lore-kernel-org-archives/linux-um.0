Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCxnn-00041S-Qc for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 02:36:59 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DCxnk-0002oa-BV for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 02:36:59 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VmGPCZeShaYEnGL"
Message-Id: <200503191904.05870.blaisorblade@yahoo.it>
Subject: [uml-devel] Supporting building on x86-64 host as 32-bit UML
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
Date: Sat, 19 Mar 2005 19:04:02 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>

--Boundary-00=_VmGPCZeShaYEnGL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It is really difficult for the end-user (and tricky for a developer) to build 
a 32-bit UML on a 64-bit host box...

I would like to address this, but I've not definite ideas.

The problems are:

1) how the user must choose what he wants (SUBARCH=i386 can be useful, maybe a 
Kconfig option would be nice - we need to choose the default depending on the 
host arch).

2) using the proper options for the tools (addressed partially by the patch 
below)

3) using the proper headers (asm-i386 instead of asm-x86_64)... Fedora (I 
don't know about SuSE and my Gentoo is 32-bit still) uses some smart headers 
that select the correct version, basing on some macros defined by GCC:

#ifndef __ASM_STUB_SYSTEM_H__
# define __ASM_STUB_SYSTEM_H__
# if defined __x86_64__
#  include <asm-x86_64/system.h>
# endif
# if defined __i386__
#  include <asm-i386/system.h>
# endif
#endif

The problem is that we explicitly refuse to define these macros, like this:

CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)

(from arch/um/Makefile-i386) for which I don't find a valid reason... I first 
thought this was 

diff -puN arch/um/Makefile~uml-build-on-x86_64_as_i386 arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-build-on-x86_64_as_i386    
2004-09-26 19:51:43.000000000 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile  2004-09-26 19:59:17.000000000 
+0200
@@ -34,6 +34,13 @@ endif
 ARCH_INCLUDE   := -I$(ARCH_DIR)/include
 SYS_DIR                := $(ARCH_DIR)/include/sysdep-$(SUBARCH)

+AFLAGS         += -m32
+CFLAGS         += -m32
+LDFLAGS                += -melf_i386
+HOSTCFLAGS     += -m32
+HOSTLDFLAGS    += -m32
+export HOSTLDFLAGS
+
 include $(ARCH_DIR)/Makefile-$(SUBARCH)
 include $(ARCH_DIR)/Makefile-os-$(OS)

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_VmGPCZeShaYEnGL
Content-Type: text/x-diff; charset="us-ascii";
	name="uml-build-on-x86_64_as_i386.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="uml-build-on-x86_64_as_i386.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN arch/um/Makefile~uml-build-on-x86_64_as_i386 arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-build-on-x86_64_as_i386	2004-09-26 19:51:43.000000000 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-09-26 19:59:17.000000000 +0200
@@ -34,6 +34,13 @@ endif
 ARCH_INCLUDE	:= -I$(ARCH_DIR)/include
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
+AFLAGS		+= -m32
+CFLAGS		+= -m32
+LDFLAGS		+= -melf_i386
+HOSTCFLAGS	+= -m32
+HOSTLDFLAGS	+= -m32
+export HOSTLDFLAGS
+
 include $(ARCH_DIR)/Makefile-$(SUBARCH)
 include $(ARCH_DIR)/Makefile-os-$(OS)
 
_

--Boundary-00=_VmGPCZeShaYEnGL--





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
