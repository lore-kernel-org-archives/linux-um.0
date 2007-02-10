Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HGgK8-0001t2-Tz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Feb 2007 10:54:52 -0800
Received: from mbox.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HGgK7-0000wR-89
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Feb 2007 10:54:48 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sat, 10 Feb 2007 18:27:16 +0100
Message-Id: <11711284362893-git-send-email-blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH] uml: fix pte_mkread setting page read/write
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Fix the fact that pte_mkread set _PAGE_RW instead of _PAGE_USER (the logic is
copied from i386 in most place, so it is really as bad as you're thinking).

Thus currently page tables are more permissive than they should.

Such a change may trigger other latent bugs, so be careful with this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/include/asm-um/pgtable.h
===================================================================
--- linux-2.6.git.orig/include/asm-um/pgtable.h
+++ linux-2.6.git/include/asm-um/pgtable.h
@@ -270,7 +270,7 @@ static inline pte_t pte_wrprotect(pte_t 
 
 static inline pte_t pte_mkread(pte_t pte)
 { 
-	pte_set_bits(pte, _PAGE_RW);
+	pte_set_bits(pte, _PAGE_USER);
 	return(pte_mknewprot(pte)); 
 }
 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
