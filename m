Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 3 Jan 2008 17:08:23 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <20080103051857.GA12453@c2.user-mode-linux.org>
Message-ID: <Pine.LNX.4.64.0801031706000.27528@anakin>
References: <4773F11D.7060803@BitWagon.com> <477AAFA1.9060807@BitWagon.com>
	<20080102152838.GA5629@c2.user-mode-linux.org>
	<477C134C.3080107@BitWagon.com>
	<20080103051857.GA12453@c2.user-mode-linux.org>
MIME-Version: 1.0
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
To: Jeff Dike <jdike@addtoit.com>
Cc: valgrind-developers@lists.sourceforge.net, John Reiser <jreiser@BitWagon.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, 3 Jan 2008, Jeff Dike wrote:
> On Wed, Jan 02, 2008 at 02:42:20PM -0800, John Reiser wrote:
> > In particular, I'm confused by allocations
> > which return a "page": either "struct page *", or a "char *" with
> > an aligned group of char of size PAGE_SIZE in the virtual address space.
> > Help?
> 
> Examples?  I don't know what exactly you're referring to, nor what the
> problem is.

I think he means how to handle the following from include/linux/gfp.h in
valgrind:

    struct page *alloc_pages(gfp_t gfp_mask, unsigned int order);
    unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);

    void __free_pages(struct page *page, unsigned int order);
    void free_pages(unsigned long addr, unsigned int order);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
