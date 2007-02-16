Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HI88I-0003xj-1e for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 10:48:34 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HI88F-0003BD-Ab
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 10:48:33 -0800
Date: Fri, 16 Feb 2007 13:40:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070216184048.GA7481@ccure.user-mode-linux.org>
References: <20070215160001.GA6774@avocado.homenet>
	<20070215170916.GC5641@ccure.user-mode-linux.org>
	<200702152029.28670.blaisorblade@yahoo.it>
	<20070216170207.GC2427@metaxa.reflex>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070216170207.GC2427@metaxa.reflex>
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
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>

On Fri, Feb 16, 2007 at 12:02:08PM -0500, Jason Lunz wrote:
> I agree - I have only a vague idea about what uml_reserved means.

This is ancient code - after a quick look through it, I think what is
happening is this:
	Early in boot, there are both libc and kernel (bootmem) memory
allocations happening.  We can't redirect malloc to kmalloc yet, so
mallocs are allowed to happen until kmalloc is running.  This requires
that the memory setup code leave some empty room in the address space
for malloc to grow into.  The end of this area is uml_reserved.
	When we are ready to turn on kmalloc, the rest of UML physical
memory (beyond uml_reserved) was already available to the bootmem
allocator, and it is just released to the page allocator.  The area
that wasn't malloced by libc is released separately to the page
allocator.
	At that point, uml_reserved loses its meaning, since memory on
either side of it is treated identically by the page allocator.

> Jeff, please drop my other patch and use this one.

OK.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
