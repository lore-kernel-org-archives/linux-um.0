Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A8RqR-0000p2-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 11 Oct 2003 15:04:16 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A8RqR-00008P-3T
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 11 Oct 2003 15:04:15 -0700
Received: from localhost (henrik@localhost)
	by filer.marasystems.com (8.11.6/8.11.6) with ESMTP id h9BM4BZ14951
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 12 Oct 2003 00:04:11 +0200
From: Henrik Nordstrom <hno@marasystems.com>
Message-ID: <Pine.LNX.4.44.0310120002150.14937-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] __pa() in modules requres to_phys to be exported
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 12 Oct 2003 00:04:11 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

af_packet uses __pa() and thus requires the to_phys symbol to be exported
(__pa() is a macro in um, expanding to a call to to_phys)

Index: arch/um/kernel/ksyms.c
===================================================================
RCS file: /cvsroot/user-mode-linux/linux/arch/um/kernel/ksyms.c,v
retrieving revision 1.33
diff -u -w -p -r1.33 ksyms.c
--- arch/um/kernel/ksyms.c     14 Sep 2003 03:04:10 -0000      1.33
+++ arch/um/kernel/ksyms.c     11 Oct 2003 22:03:32 -0000
@@ -37,6 +37,7 @@ EXPORT_SYMBOL(arch_validate);
 EXPORT_SYMBOL(high_physmem);
 EXPORT_SYMBOL(empty_zero_page);
 EXPORT_SYMBOL(um_virt_to_phys);
+EXPORT_SYMBOL(to_phys);
 EXPORT_SYMBOL(__virt_to_page);
 EXPORT_SYMBOL(to_virt);
 EXPORT_SYMBOL(mode_tt);


Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
