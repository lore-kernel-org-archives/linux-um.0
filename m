Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCzC-0001bI-0i for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:34 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CpCzA-0001Or-V4 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:33 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113210113.D81F91FEFD@zion>
Subject: [uml-devel] [patch 11/11] uml: update ld scripts to newer binutils
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
Date: Thu, 13 Jan 2005 22:01:13 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


It seems that linker script for userspace software are quite
toolchain-depending, at least because what we use is a merge between builtin
LD scripts (see strings /usr/bin/ld) and normal kernel linking scripts.

Plus, a number of people are having toolchain-related troubles building UML
(even assertion failures on linking, with Gentoo and Fedora 2).

So, let's try to make UML nicer for binutils.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/dyn.lds.S |    3 +++
 linux-2.6.11-paolo/arch/um/kernel/uml.lds.S |   10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/uml.lds.S~uml-update-lds-to-ld-version arch/um/kernel/uml.lds.S
--- linux-2.6.11/arch/um/kernel/uml.lds.S~uml-update-lds-to-ld-version	2005-01-13 05:53:48.582270064 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/uml.lds.S	2005-01-13 05:56:06.458309720 +0100
@@ -7,8 +7,12 @@ jiffies = jiffies_64;
 
 SECTIONS
 {
+  /*This must contain the right address - not quite the default ELF one.*/
+  PROVIDE (__executable_start = START);
   . = START + SIZEOF_HEADERS;
 
+  /* Used in arch/um/kernel/mem.c. Any memory between START and __binary_start
+   * is remapped.*/
   __binary_start = .;
 #ifdef MODE_TT
   .thread_private : {
@@ -20,9 +24,13 @@ SECTIONS
   }
   . = ALIGN(4096);
   .remap : { arch/um/kernel/tt/unmap_fin.o (.text) }
-#endif
+
+  /* We want it only if we are in MODE_TT. In both cases, however, when MODE_TT
+   * is off the resulting binary segfaults.*/
 
   . = ALIGN(4096);		/* Init code and data */
+#endif
+
   _stext = .;
   __init_begin = .;
   .init.text : {
diff -puN arch/um/kernel/dyn.lds.S~uml-update-lds-to-ld-version arch/um/kernel/dyn.lds.S
--- linux-2.6.11/arch/um/kernel/dyn.lds.S~uml-update-lds-to-ld-version	2005-01-13 05:53:48.583269912 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/dyn.lds.S	2005-01-13 05:53:48.616264896 +0100
@@ -7,8 +7,11 @@ jiffies = jiffies_64;
 
 SECTIONS
 {
+  PROVIDE (__executable_start = START);
   . = START + SIZEOF_HEADERS;
   .interp         : { *(.interp) }
+  /* Used in arch/um/kernel/mem.c. Any memory between START and __binary_start
+   * is remapped.*/
   __binary_start = .;
   . = ALIGN(4096);		/* Init code and data */
   _stext = .;
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
