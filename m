Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bh4iQ-0002C6-Hd for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jul 2004 03:59:22 -0700
Received: from ppp-62-11-79-149.dialup.tiscali.it ([62.11.79.149]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bh4iO-0003TR-KT for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jul 2004 03:59:22 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040704105929.AD7FB78A@zion.localdomain>
Subject: [uml-devel] [patch 1/1] unit-at-a-time fix,
	for SuSE 9.1 and maybe Mdk 10.0
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
Date: Sun, 04 Jul 2004 12:59:29 +0200
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


This is the 2.4 version of the -fno-unit-at-a-time fix already discussed.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.4.26-paolo/arch/um/Makefile |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN arch/um/Makefile~unit-at-a-time arch/um/Makefile
--- linux-2.4.26/arch/um/Makefile~unit-at-a-time	2004-07-03 21:15:39.000000000 +0200
+++ linux-2.4.26-paolo/arch/um/Makefile	2004-07-04 12:59:12.064576192 +0200
@@ -53,6 +53,10 @@ CFLAGS += $(ARCH_CFLAGS) $(CFLAGS-y) -D_
 	-D_LARGEFILE64_SOURCE $(ARCH_INCLUDE) -Derrno=kernel_errno \
 	$(MODE_INCLUDE)
 
+check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
+CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
+
 LINKFLAGS += -r
 
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
_


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
