Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjNkT-0001O9-SD for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jan 2004 11:10:45 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AjNez-0004YC-6a
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jan 2004 11:05:05 -0800
Received: from hirsch.in-berlin.de (localhost [127.0.0.1])
	by hirsch.in-berlin.de (8.12.10/8.12.10/Debian-6) with ESMTP id
	i0LJ51rC023448 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Jan 2004 20:05:01 +0100
Received: (from uucp@localhost)
	by hirsch.in-berlin.de (8.12.10/8.12.10/Debian-5) with UUCP id
	i0LJ51KB023426 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jan 2004 20:05:01 +0100
Received: from bytesex.org (kraxel@localhost [127.0.0.1])
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) with ESMTP id i0LIwgnW003821
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Jan 2004 19:58:42 +0100
Received: (from kraxel@localhost)
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) id i0LIwgNS003820
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jan 2004 19:58:42 +0100
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040121185842.GA3811@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] selinux build fix
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
Date: Wed, 21 Jan 2004 19:58:42 +0100
To: uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

the linker script needs a fix to make uml build with selinux enabled.

  Gerd

Index: linux-um-2.6.2-rc1/include/asm-um/common.lds.S
===================================================================
--- linux-um-2.6.2-rc1.orig/include/asm-um/common.lds.S	2004-01-21 13:19:18.000000000 +0100
+++ linux-um-2.6.2-rc1/include/asm-um/common.lds.S	2004-01-21 19:32:39.000000000 +0100
@@ -64,6 +64,7 @@
   __uml_initcall_start = .;
   .uml.initcall.init : { *(.uml.initcall.init) }
   __uml_initcall_end = .;
+  SECURITY_INIT
   __init_end = .;
 
   __exitcall_begin = .;


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
