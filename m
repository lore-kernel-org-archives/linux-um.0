Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EBIwR-00081X-4V	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Sep 2005 14:19:19 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EBIwQ-0004BE-HY
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Sep 2005 14:19:19 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050902201749.GA9104@ccure.user-mode-linux.org>
References: <20050728185655.9C6ADA3@zion.home.lan>
	<20050730160218.GB4585@ccure.user-mode-linux.org>
	<200508102137.28414.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508102137.28414.blaisorblade@yahoo.it>
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
Date: Fri, 2 Sep 2005 16:17:49 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Aug 10, 2005 at 09:37:28PM +0200, Blaisorblade wrote:
> Also look, on the "set_pte" theme, at the attached patch. 

+       WARN_ON(!pte_young(*pte) || pte_write(*pte) && !pte_dirty(*pte));

This one has been firing on me, and I decided to figure out why.  The
culprit is this code in do_no_page:

	if (pte_none(*page_table)) {
		if (!PageReserved(new_page))
			inc_mm_counter(mm, rss);

		flush_icache_page(vma, new_page);
		entry = mk_pte(new_page, vma->vm_page_prot);
		if (write_access)
			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
		set_pte_at(mm, address, page_table, entry);

The first mk_pte immediately sets the pte to the protection limits of
the VMA, regardless of the access type.  So, if it's a read access on
a writeable page, we get a writeable, but not dirty pte, since the
mkdirty never happens.  The exercises the warning you added.

This seems somewhat bogus to me.  If we set the pte protection to its
limits, then the maybe_mkwrite is unneccesary.  

If we are the process in this address space, and we have a write
access, then the maybe_mkwrite doesn't do anything because the pte is
already writeable because the VMA has to be writeable, or we would
have been faulted already.

If we are a debugger changing the process memory, then the vma may be
read-only, and maybe_mkwrite is explicitly a no-op in this case.

This doesn't seem to harm our dirty bit emulation.  fix_range_common
checks the dirty and accessed bits and disables read and write
protection as appropriate.

So, it seems like the warning could be dropped, or perhaps made more
selective, like checking for is_write == 0 and VM_WRITE, but then the
test is getting complicated.

				Heff


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
