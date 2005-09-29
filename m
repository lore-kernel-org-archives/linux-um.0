Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EL3yq-0007pw-KB	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:22:08 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EL3ym-0004QJ-BH
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:22:08 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Clearing kmalloc_ok during shutdown is broken -
	malloc will clear our data.
References: <200509281346.23592.blaisorblade@yahoo.it>
	<20050928201243.GA13636@ccure.user-mode-linux.org>
In-Reply-To: <20050928201243.GA13636@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509291407.30152.blaisorblade@yahoo.it>
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
Date: Thu, 29 Sep 2005 14:07:29 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 28 September 2005 22:12, Jeff Dike wrote:
> On Wed, Sep 28, 2005 at 01:46:15PM +0200, Blaisorblade wrote:
> > And I am wondering about whether the recent "eactivate_all_fds failed,
> > errno = 9"

> I found this one, although I didn't notice the missing 'd'.
Hmm, after saying that I saw that 'd' again.
In my experience with 2.6.13, it normally works, except when panicking (I 
triggered with sysrq t, and got the failure).

If it isn't a memory corruption, which I suspected, then we're ok.
> It turns out 
> that close_chan closes file descriptors, but never freed the associated
> IRQs.
So deactivate_all_fds() tries to close them again...
> > But still, Jeff, how can we expect that malloc won't stomp over all our
> > data which we preallocated with kmalloc and such?

> Because I leave a decent amount of room between the brk and the start of
> kmalloc-able memory (which is free_pages-d during boot).  It's a couple
> meg, I think.

> No guarantees, of course, but there isn't a lot of mallocing 
> happening.
Ok, this is enough, but could be documented. But we could record the end of 
malloc'able data, and check it, since we're using a wrapper anyway, and 
return NULL + my_printf()* a message if the space is exhausted.

* printf() can overflow kernel stack according to Al Viro, see 
not_configged_chan messages.


> > On the other side, could you explain why you don't like kmalloc in first
> > place? It surely works.

> I'm not sure - let me think about it.  But I fixed that for a reason - it
> was causing a crash somehow, I just don't remember the details.

> > The real solution for this warning is to replace um_kmalloc with
> > malloc(), and set, during shutdown, kmalloc_only_atomic - which would
> > switch
> > __wrap_malloc() from um_kmalloc to um_kmalloc_atomic.

> Yeah, that's userspace code, so it should probably just use malloc.

> > Or better yet, simply test in_atomic() and irqs_disabled() to choose
> > between the atomic and normal versions.

> I don't really like testing in_atomic() because you should generally know
> what context you're running in.
Beyond that, in_atomic() isn't set by spinlocks (at least not normally - it is 
set when preemption is enabled, not for us).

Userspace code calling malloc could miss this knowledge (as in the example 
above). Also userspace is supposed to use malloc, and with malloc there's no 
choice. And finally, surely libc isn't aware of anything such.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
