Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI8iF-00049M-P8	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:48:55 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EI8iF-0006I3-5z
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 10:48:55 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050921172824.10219.17857.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 03/10] uml: don't redundantly mark pte as newpage
	in pte_modify
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
Date: Wed, 21 Sep 2005 19:28:25 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

pte_modify marks a page as needing flush, which is redundant because the
resulting PTE is still set with set_pte, which already handles that.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-um/pgtable.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/asm-um/pgtable.h b/include/asm-um/pgtable.h
--- a/include/asm-um/pgtable.h
+++ b/include/asm-um/pgtable.h
@@ -346,7 +346,6 @@ static inline void set_pte(pte_t *pteptr
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte_set_val(pte, (pte_val(pte) & _PAGE_CHG_MASK), newprot);
-	if(pte_present(pte)) pte = pte_mknewpage(pte_mknewprot(pte));
 	return pte; 
 }
 



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
