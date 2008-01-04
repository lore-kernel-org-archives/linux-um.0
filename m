Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Fri, 4 Jan 2008 11:37:11 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080104163711.GA5743@c2.user-mode-linux.org>
References: <4773F11D.7060803@BitWagon.com> <477AAFA1.9060807@BitWagon.com>
	<20080102152838.GA5629@c2.user-mode-linux.org>
	<477C134C.3080107@BitWagon.com>
	<20080103051857.GA12453@c2.user-mode-linux.org>
	<Pine.LNX.4.64.0801031706000.27528@anakin>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801031706000.27528@anakin>
Subject: Re: [uml-devel] running UserModeLinux under Valgrind(memcheck)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: valgrind-developers@lists.sourceforge.net, John Reiser <jreiser@BitWagon.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jan 03, 2008 at 05:08:23PM +0100, Geert Uytterhoeven wrote:
> I think he means how to handle the following from include/linux/gfp.h in
> valgrind:
> 
>     struct page *alloc_pages(gfp_t gfp_mask, unsigned int order);
>     unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
> 
>     void __free_pages(struct page *page, unsigned int order);
>     void free_pages(unsigned long addr, unsigned int order);

Oh yeah, good point.

The unsigned long ones are easy - they are addresses disguised as
numbers.

You have to tell valgrind somehow that the object size is
	(1 << order) * PAGE_SIZE

About the struct page ones - I see two possibilities.

1 - You communicate to valgrind somehow that there is a mapping
between the page struct and the virtual address it represents.  There
is a is no page_to_virt (although there is a virt_to_page), but one
would be easy to add.  For UML, it amounts to
	uml_physmem + (page - mem_map) * PAGE_SIZE

2 - You can insist that UML defines WANT_PAGE_VIRTUAL which, if I'm
reading the code correctly, will set page->virtual to the address
represented by the page.  Valgrind then somehow has to know how to
reach into the page struct and get the address.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
