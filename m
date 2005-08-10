Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3ZEH-0003tZ-Nf	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 06:05:45 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E3ZEE-0001ta-Ug
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 06:05:45 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050728185655.9C6ADA3@zion.home.lan>
	<20050730160218.GB4585@ccure.user-mode-linux.org>
In-Reply-To: <20050730160218.GB4585@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4dl+CYIGr7ynbeS"
Message-Id: <200508102137.28414.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [patch 1/3] uml: share page bits handling between 2
	and 3 level pagetables
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
Date: Wed, 10 Aug 2005 21:37:28 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_4dl+CYIGr7ynbeS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 30 July 2005 18:02, Jeff Dike wrote:
> On Thu, Jul 28, 2005 at 08:56:53PM +0200, blaisorblade@yahoo.it wrote:
> > As obvious, a "core code nice cleanup" is not a "stability-friendly
> > patch" so usual care applies.
>
> These look reasonable, as they are what we discussed in Ottawa.
>
> I'll put them in my tree and see if I see any problems.  I would
> suggest sending these in early after 2.6.13 if they seem OK.
Just noticed: you can drop them (except the first, which is a nice cleanup).

set_pte handles that, and include/asm-generic/pgtable.h uses coherently 
set_pte_at. I've checked UML by examining "grep pte", and either mk_pte or 
set_pte are used.

Exceptions: fixaddr_user_init (but that should be ok as we shouldn't map it 
actually), pte_modify() (which handles that only for present pages).

But pte_modify is used with set_pte, so probably we could as well drop that 
handling.

Also look, on the "set_pte" theme, at the attached patch. I realized this when 
I needed those lines to work - I was getting a segfault loop.

After using set_pte(), things worked. I have now an almost perfectly working 
implementation of remap_file_pages with protection support.
There will probably be some other things to update, like swapping locations, 
but I can't get this kernel to fail (it's easier to find bugs in the 
test-program, it grew quite complex).

And, I'd like to note, original Ingo's version *DID NOT* work properly (it was 
not safe against swapout, it didn't allow write-protecting a page 
successfully).

I'm going to clean up the code and write changelogs, to send then the patches 
for -mm (hoping the page fault scalability patches don't get in the way).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_4dl+CYIGr7ynbeS
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-avoid-already-done-dirtying.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="uml-avoid-already-done-dirtying.patch"


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The PTE returned from handle_mm_fault is already marked as dirty and accessed
if needed.
Also, since this is not set with set_pte() (which sets NEWPAGE and NEWPROT as
needed), this wouldn't work anyway.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN arch/um/kernel/trap_kern.c~uml-avoid-already-done-dirtying arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~uml-avoid-already-done-dirtying	2005-08-10 19:21:13.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-08-10 19:21:13.000000000 +0200
@@ -83,8 +83,7 @@ survive:
 		pte = pte_offset_kernel(pmd, address);
 	} while(!pte_present(*pte));
 	err = 0;
-	*pte = pte_mkyoung(*pte);
-	if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
+	WARN_ON(!pte_young(*pte) || pte_write(*pte) && !pte_dirty(*pte));
 	flush_tlb_page(vma, address);
 out:
 	up_read(&mm->mmap_sem);
_

--Boundary-00=_4dl+CYIGr7ynbeS--


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
