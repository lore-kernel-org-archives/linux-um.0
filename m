Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J3GJM-00050W-AD for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Dec 2007 11:35:04 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J3GJJ-0002SQ-Gy
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Dec 2007 11:35:04 -0800
Date: Fri, 14 Dec 2007 14:34:54 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071214193454.GB7852@c2.user-mode-linux.org>
References: <4762BDEF.2040003@BitWagon.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4762BDEF.2040003@BitWagon.com>
Subject: Re: [uml-devel] Why does mem_init call map_cb twice?
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
To: John Reiser <jreiser@BitWagon.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Dec 14, 2007 at 09:31:27AM -0800, John Reiser wrote:
> In arch/um/kernel/mem.c, mem_init calls map_cb twice:
> once directly and once indirectly via initial_thread_cb.  Why?
> 
> -----
> void mem_init(void)
> {
>         /* clear the zero-page */
>         memset((void *) empty_zero_page, 0, PAGE_SIZE);
> 
>         /* Map in the area just after the brk now that kmalloc is about
>          * to be turned on.
>          */
>         brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
>         map_cb(NULL);
>         initial_thread_cb(map_cb, NULL);
> -----

It's a bug.  That's left over from the tt mode days, when the kernel
ran in the same address spaces as its processes and there was a
separate thread ptracing everything.  The tracing thread address space
needed to be kept in sync with the others, and this was one part of
that.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
