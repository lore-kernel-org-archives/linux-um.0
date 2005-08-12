Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3eaL-0006XL-KG	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:53 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3eaK-0007aH-5e
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:53 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183634.6588124E7F2@zion.home.lan>
Subject: [uml-devel] [patch 37/39] remap_file_pages protection support: wrong
	"historical" code for review - 1
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
Date: Fri, 12 Aug 2005 20:36:34 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, mingo@elte.hu


From: Ingo Molnar <mingo@elte.hu>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This "fast-path" was contained in the original
remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch from Ingo Molnar*; I think this
code is wrong, but I'm sending it for review anyway, because I'm unsure (and
in fact, in the end I found the reason for this).

What I think is that this patch (done only for filemap_populate, not for
shmem_populate) calls zap_page_range() when installing mappings with PROT_NONE
protection. The purpose is to avoid an useless page lookup; but the PTE's will
be simply marked as absent, not as _PAGE_NONE. So, with this fastpath, pages
would be remapped again in their "default" position.

In this case, probably a possible fix is to add yet another param in
"zap_details" to mark all PTE's as PROT_NONE ones. Using
details->nonlinear_vma has the inconvenient of using
details->{first,last}_index and of leaving file entries unchanged.

* available at
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm1/dropped/remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/filemap.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -puN mm/filemap.c~rfp-wrong2 mm/filemap.c
--- linux-2.6.git/mm/filemap.c~rfp-wrong2	2005-08-12 18:31:32.000000000 +0200
+++ linux-2.6.git-paolo/mm/filemap.c	2005-08-12 18:31:32.000000000 +0200
@@ -1495,6 +1495,15 @@ int filemap_populate(struct vm_area_stru
 	struct page *page;
 	int err;
 
+	/*
+	 * mapping-removal fastpath:
+	 */
+	if ((vma->vm_flags & VM_SHARED) &&
+			(pgprot_val(prot) == pgprot_val(PAGE_NONE))) {
+		zap_page_range(vma, addr, len, NULL);
+		return 0;
+	}
+
 	if (!nonblock)
 		force_page_cache_readahead(mapping, vma->vm_file,
 					pgoff, len >> PAGE_CACHE_SHIFT);
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
