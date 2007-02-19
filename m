Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJH0G-0001N6-5y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Feb 2007 14:29:00 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HJH0E-0005oH-IA
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Feb 2007 14:29:00 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Mon, 19 Feb 2007 23:28:31 +0100
References: <20070215160001.GA6774@avocado.homenet>
	<20070216170207.GC2427@metaxa.reflex>
	<20070216184048.GA7481@ccure.user-mode-linux.org>
In-Reply-To: <20070216184048.GA7481@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702192328.32202.blaisorblade@yahoo.it>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Jason Lunz <lunz@falooley.org>, user-mode-linux-devel@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>

On Friday 16 February 2007 19:40, Jeff Dike wrote:
> On Fri, Feb 16, 2007 at 12:02:08PM -0500, Jason Lunz wrote:
> > I agree - I have only a vague idea about what uml_reserved means.
>
> This is ancient code - after a quick look through it, I think what is
> happening is this:
> 	Early in boot, there are both libc and kernel (bootmem) memory
> allocations happening.  We can't redirect malloc to kmalloc yet, so
> mallocs are allowed to happen until kmalloc is running.  This requires
> that the memory setup code leave some empty room in the address space
> for malloc to grow into.  The end of this area is uml_reserved.
> 	When we are ready to turn on kmalloc, the rest of UML physical
> memory (beyond uml_reserved) was already available to the bootmem
> allocator, and it is just released to the page allocator.  The area
> that wasn't malloced by libc is released separately to the page
> allocator.

I was also curious about the "high_physmem - uml_physmem" difference, which I 
now guess I understand - and about seeing this documented so that redundant 
vars could be deleted.

> 	At that point, uml_reserved loses its meaning, since memory on
> either side of it is treated identically by the page allocator.

But the purpose of:
        uml_reserved = brk_end;
is probably to restore this meaning: after this, uml_reserved marks again the 
end of the reserved memory, right?

And now that you explain this me, I'm wondering.
How do things work when kmalloc_ok is disabled (i.e. initial_thread_cb)? I 
thought all reserved memory would stay reserved for the whole UML kernel 
lifetime.
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
