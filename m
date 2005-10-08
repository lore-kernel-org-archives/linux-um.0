Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOOFz-0002HS-G8	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Oct 2005 16:37:35 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EOOFy-0005wA-0p
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Oct 2005 16:37:35 -0700
Received: from localhost.localdomain (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j991811f004985
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 8 Oct 2005 21:08:01 -0400
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2gFSDklF/+MjXTU"
Message-Id: <200510081837.26059.rob@landley.net>
Subject: [uml-devel] [PATCH] slight UML config simplification.
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
Date: Sat, 8 Oct 2005 18:37:25 -0500
To: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_2gFSDklF/+MjXTU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Since -tt mode is going to go the way of the dodo when -skas0 stabilizies (and 
-skas0 "works for me"), start making options that only affect -tt mode depend 
on -tt mode (and group them together).

Start with "nesting level".

Rob

Signed-off-by: Rob Landley <rob@landley.net>


--Boundary-00=_2gFSDklF/+MjXTU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="thing.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="thing.patch"

--- linux-2.6.13.1/arch/um/Kconfig	2005-09-09 21:42:58.000000000 -0500
+++ linux-2.6.13.1-new/arch/um/Kconfig	2005-10-08 18:24:33.968546648 -0500
@@ -63,6 +63,23 @@
 	chroot, and you disable CONFIG_MODE_TT, you probably want to say Y
 	here.
 
+config NEST_LEVEL
+	int "Nesting level"
+	default "0"
+	depends on MODE_TT
+	help
+        This is set to the number of layers of UMLs that this UML will be run
+        in.  Normally, this is zero, meaning that it will run directly on the
+        host.  Setting it to one will build a UML that can run inside a UML
+        that is running on the host.  Generally, if you intend this UML to run
+        inside another UML, set CONFIG_NEST_LEVEL to one more than the host
+        UML.
+
+        Note that if the hosting UML has its CONFIG_KERNEL_HALF_GIGS set to
+        greater than one, then the guest UML should have its CONFIG_NEST_LEVEL
+        set to the host's CONFIG_NEST_LEVEL + CONFIG_KERNEL_HALF_GIGS.
+        Only change this if you are running nested UMLs.
+
 config MODE_SKAS
 	bool "Separate Kernel Address Space support"
 	default y
@@ -223,22 +240,6 @@
 	depends on SMP
 	default "32"
 
-config NEST_LEVEL
-	int "Nesting level"
-	default "0"
-	help
-        This is set to the number of layers of UMLs that this UML will be run
-        in.  Normally, this is zero, meaning that it will run directly on the
-        host.  Setting it to one will build a UML that can run inside a UML
-        that is running on the host.  Generally, if you intend this UML to run
-        inside another UML, set CONFIG_NEST_LEVEL to one more than the host
-        UML.
-
-        Note that if the hosting UML has its CONFIG_KERNEL_HALF_GIGS set to
-        greater than one, then the guest UML should have its CONFIG_NEST_LEVEL
-        set to the host's CONFIG_NEST_LEVEL + CONFIG_KERNEL_HALF_GIGS.
-        Only change this if you are running nested UMLs.
-
 config KERNEL_HALF_GIGS
 	int "Kernel address space size (in .5G units)"
 	default "1"

--Boundary-00=_2gFSDklF/+MjXTU--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
