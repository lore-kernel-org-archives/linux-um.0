Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bbiq9-0002vs-LZ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Jun 2004 09:37:13 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Bbiq8-0006m5-OR for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Jun 2004 09:37:12 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406191247.19316.blaisorblade_work@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [patch 1/1] Avoid that gcc breaks UML with "unit at a
	time" compilation mode.
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
Date: Sat, 19 Jun 2004 12:47:48 +0200
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>


Avoid that gcc breaks UML with "unit at a time" compilation mode; this patch 
is for 2.6. Please test it.


---

 uml-Dike-linux-2.6.6-paolo/arch/um/Makefile |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/um/Makefile~disable-UnitAtATime arch/um/Makefile
--- uml-Dike-linux-2.6.6/arch/um/Makefile~disable-UnitAtATime	2004-06-19 
11:56:02.000000000 +0200
+++ uml-Dike-linux-2.6.6-paolo/arch/um/Makefile	2004-06-19 11:56:11.000000000 
+0200
@@ -61,6 +61,8 @@ CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSU
 	-D_LARGEFILE64_SOURCE $(ARCH_INCLUDE) -Derrno=kernel_errno \
 	-Dsigprocmask=kernel_sigprocmask $(MODE_INCLUDE)
 
+CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
+
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
 # These are needed for clean and mrproper, since in that case .config is not

_




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
