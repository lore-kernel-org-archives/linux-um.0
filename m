Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3dRA-0002MJ-1H	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 10:35:20 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3dR9-0007fk-Mm
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 10:35:20 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050812170514.GB7448@ccure.user-mode-linux.org>
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
Date: Fri, 12 Aug 2005 13:05:14 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Aug 10, 2005 at 09:37:28PM +0200, Blaisorblade wrote:
> Just noticed: you can drop them (except the first, which is a nice cleanup).
> 
> set_pte handles that, and include/asm-generic/pgtable.h uses coherently 
> set_pte_at. I've checked UML by examining "grep pte", and either mk_pte or 
> set_pte are used.
> 
> Exceptions: fixaddr_user_init (but that should be ok as we shouldn't map it 
> actually), pte_modify() (which handles that only for present pages).
> 
> But pte_modify is used with set_pte, so probably we could as well drop that 
> handling.
> 
> Also look, on the "set_pte" theme, at the attached patch. I realized this when 
> I needed those lines to work - I was getting a segfault loop.

OK, this sounds right.  To recap, we were concerned that when the page
scanner went around clearing dirty (accessed) bits, that
fix_range_common wasn't write (read) protecting the page in order to
emulate the cleared bits.

However, set_pte does set _PAGE_NEWPAGE, which forces the page through
a full update, including dirty/accessed bit emulation.

Correct?

However, I did add some parenthesis to your patch:

	WARN_ON(!pte_young(*pte) || (pte_write(*pte) && !pte_dirty(*pte)));

This seems clearer to me.

So, your pte consolidation patch is still in my tree, the other two
pte patches are dropped.

> After using set_pte(), things worked. I have now an almost perfectly working 
> implementation of remap_file_pages with protection support.
> There will probably be some other things to update, like swapping locations, 
> but I can't get this kernel to fail (it's easier to find bugs in the 
> test-program, it grew quite complex).

Excellent.

> I'm going to clean up the code and write changelogs, to send then the patches 
> for -mm (hoping the page fault scalability patches don't get in the
> way).

Good.

				Jeff


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
