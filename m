Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EBsni-000763-UZ	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Sep 2005 04:36:42 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EBsnf-0006Nh-Ep
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Sep 2005 04:36:43 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 1/3] uml: share page bits handling between
	2 and 3 level pagetables
References: <20050728185655.9C6ADA3@zion.home.lan>
	<200508102137.28414.blaisorblade@yahoo.it>
	<20050902201749.GA9104@ccure.user-mode-linux.org>
In-Reply-To: <20050902201749.GA9104@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509041333.30466.blaisorblade@yahoo.it>
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
Date: Sun, 4 Sep 2005 13:33:30 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Friday 02 September 2005 22:17, Jeff Dike wrote:
> On Wed, Aug 10, 2005 at 09:37:28PM +0200, Blaisorblade wrote:
> > Also look, on the "set_pte" theme, at the attached patch.

> +       WARN_ON(!pte_young(*pte) || pte_write(*pte) && !pte_dirty(*pte));

> This one has been firing on me, and I decided to figure out why.  The
> culprit is this code in do_no_page:

> 	if (pte_none(*page_table)) {
> 		if (!PageReserved(new_page))
> 			inc_mm_counter(mm, rss);
>
> 		flush_icache_page(vma, new_page);
> 		entry = mk_pte(new_page, vma->vm_page_prot);
> 		if (write_access)
> 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> 		set_pte_at(mm, address, page_table, entry);
>
> The first mk_pte immediately sets the pte to the protection limits of
> the VMA, regardless of the access type.

> So, if it's a read access on 
> a writeable page, we get a writeable, but not dirty pte, since the
> mkdirty never happens.  The exercises the warning you added.
Thanks for noticing - I had really this doubt when writing some code (in the 
patch, I've added a dirty PTEs on read accesses because I was unsure, and 
even because of my warning).

> This seems somewhat bogus to me.  If we set the pte protection to its
> limits, then the maybe_mkwrite is unneccesary.

> This doesn't seem to harm our dirty bit emulation.  fix_range_common
> checks the dirty and accessed bits and disables read and write
> protection as appropriate.

> So, it seems like the warning could be dropped, or perhaps made more
> selective, like checking for is_write == 0 and VM_WRITE, but then the
> test is getting complicated.

No, just replace pte_write() with is_write, as below. They might not coincide, 
but if on a write fault we return with a clean PTE, we'll loop indefinitely 
(experienced while hacking on remap_f_p), so the warning above is definitely 
correct.

       WARN_ON(!pte_young(*pte) || is_write && !pte_dirty(*pte));
> 				Heff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
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
