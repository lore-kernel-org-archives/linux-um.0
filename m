Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNxnS-0003xi-Oe for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 10:45:34 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BNxnS-00065m-6v for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 10:45:34 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fHmoAIwg6EvWRVn"
Message-Id: <200405121941.51881.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] [PATCH] [TRIVIAL] Fix make help ARCH=um
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
Date: Wed, 12 May 2004 19:41:51 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>



--Boundary-00=_fHmoAIwg6EvWRVn
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It makes "make help ARCH=um" describe the "linux" target. It also becomes a 
default one (i.e. now
 make ARCH=um
means not only
 make vmlinux modules ARCH=um
but
 make linux modules ARCH=um)

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_fHmoAIwg6EvWRVn
Content-Type: text/x-diff;
  charset="us-ascii";
  name="MakeHelp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="MakeHelp.patch"

--- ./arch/um/Makefile.makeHelp	2004-05-12 18:02:35.000000000 +0200
+++ ./arch/um/Makefile	2004-05-12 19:10:52.000000000 +0200
@@ -207,3 +207,9 @@
 	$(Q)$(MAKE) $(build)=$@
 
 export SUBARCH USER_CFLAGS OS 
+
+all: linux
+
+define archhelp
+  echo  '* linux	- Binary kernel image (./linux)'
+endef

--Boundary-00=_fHmoAIwg6EvWRVn--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
