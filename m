Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cx9d6-0004W5-I5 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:36 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cx9d5-0000zG-O1 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 12:00:36 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050204183555.DC7E29BCB8@zion>
Subject: [uml-devel] [patch 7/8] uml: fix STATIC_LINK compilation [before
	2.6.11]
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
Date: Fri, 04 Feb 2005 19:35:55 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Jeff Dike <jdike@addtoit.com>

This fixes a bug which assumes that __binary_start starts on a page
boundary, which isn't true when UML is configured to load into the normal
executable area.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/mem.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/mem.c~uml-fix-load-low arch/um/kernel/mem.c
--- linux-2.6.11/arch/um/kernel/mem.c~uml-fix-load-low	2005-02-04 06:45:31.750294120 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/mem.c	2005-02-04 06:45:31.753293664 +0100
@@ -79,7 +79,7 @@ void mem_init(void)
 	uml_reserved = brk_end;
 
 	/* Fill in any hole at the start of the binary */
-	start = (unsigned long) &__binary_start;
+	start = (unsigned long) &__binary_start & PAGE_MASK;
 	if(uml_physmem != start){
 		map_memory(uml_physmem, __pa(uml_physmem), start - uml_physmem,
 			   1, 1, 0);
_


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
