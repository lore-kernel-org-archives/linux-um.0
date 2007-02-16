Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HI8Tl-00069n-4G for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 11:10:47 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HI8Tg-0000On-TT
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 11:10:42 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Fri, 16 Feb 2007 20:10:18 +0100
References: <20070215160001.GA6774@avocado.homenet>
	<200702152029.28670.blaisorblade@yahoo.it>
	<20070216170207.GC2427@metaxa.reflex>
In-Reply-To: <20070216170207.GC2427@metaxa.reflex>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702162010.18776.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [UML] fix crash in block layer
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jason Lunz <lunz@falooley.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>

On Friday 16 February 2007 18:02, Jason Lunz wrote:
> On Thu, Feb 15, 2007 at 08:29:28PM +0100, Blaisorblade wrote:
> > The following could be a suggestion, if max_low_pfn is not used between
> > the old and the new moment of assignment (and it seems it is not). This
> > is just an idea however:

> blk_queue_bounce_limit() calls init_emergency_isa_pool() to get dma-zone
> pages to use as bounce buffers when its caller passes a dma_addr limit
> that is less than max_low_pfn. The BLK_BOUNCE_ANY macro is supposed to
> mean "never bounce", and it's defined as:

> #define BLK_BOUNCE_ANY          ((u64)blk_max_pfn << PAGE_SHIFT)

> So it presumes that max_pfn >= max_low_pfn. uml's mem_init() is
> violating this assumption - when uml_reserved is subtracted from
> max_pfn, we end up with max_pfn < max_low_pfn, so BLK_BOUNCE_ANY has the
> opposite of the intended effect. blk_queue_bounce_limit therefore tries
> to create a mempool with zone-dma pages on a no-dma-zone arch and the
> kernel goes BUG().

Thanks for the explaination; but I meant that the meaning of those variables 
and the code to set them was convoluted.

> So I think your idea is correct. It passes my testing - I can still use
> lvm within uml. I have not tested CONFIG_HIGHMEM, but here's an 
> implementation against 2.6.20.

Do not worry for HIGHMEM - I doubt it builds currently; uml_reserved is also 
used for other stuff.

I've also verified that moving the assignment to max_low_pfn to later cannot 
possibly introduce bugs, as max_{low_,}pfn are not used by core kernel code.

> Jeff, please drop my other patch and use this one.

> Signed-off-by: Jason Lunz <lunz@falooley.org>
>
> ---
>  arch/um/kernel/mem.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Index: linux-2.6.20-uml/arch/um/kernel/mem.c
> ===================================================================
> --- linux-2.6.20-uml.orig/arch/um/kernel/mem.c
> +++ linux-2.6.20-uml/arch/um/kernel/mem.c
> @@ -63,8 +63,6 @@
>
>  void mem_init(void)
>  {
> -	max_low_pfn = (high_physmem - uml_physmem) >> PAGE_SHIFT;
> -
>          /* clear the zero-page */
>          memset((void *) empty_zero_page, 0, PAGE_SIZE);
>
> @@ -79,6 +77,7 @@
>
>  	/* this will put all low memory onto the freelists */
>  	totalram_pages = free_all_bootmem();
> +	max_low_pfn = totalram_pages;
>  #ifdef CONFIG_HIGHMEM
>  	totalhigh_pages = highmem >> PAGE_SHIFT;
>  	totalram_pages += totalhigh_pages;

-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
