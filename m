Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIB8Y-0004BC-Lo	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 13:24:14 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EIB8U-0005zR-Rs
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 13:24:14 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 07/10] uml: avoid fixing faults while
	atomic
References: <200509211923.21861.blaisorblade@yahoo.it>
	<20050921172908.10219.57644.stgit@zion.home.lan>
	<20050921124957.437cf069.akpm@osdl.org>
In-Reply-To: <20050921124957.437cf069.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509212222.50653.blaisorblade@yahoo.it>
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
Date: Wed, 21 Sep 2005 22:22:50 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 21:49, Andrew Morton wrote:
> "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

> The in_atomic() test in x86's do_page_fault() is in fact a message passed
> into it from filemap.c's kmap_atomic().
Ok, this can be ok, but:
> It has accidental side-effects, 
> such as making copy_to_user() fail if inside spinlocks when
> CONFIG_PREEMPT=y.
Sorry, but should it ever succeed inside spinlocks? I mean, should it ever 
call down() inside spinlocks? (We never do down_trylock, and ever if we did 
the x86 trick, that wouldn't make the whole thing safe at all - they still 
take the spinlock and potentially sleep. And it's legal only if no spinlock 
is held).

Even if spinlocks don't always trigger in_atomic() - which means that we'd 
need to have a better fix for this.

(Btw, I took the above reasoning from something said, as an aside, on LWN.net 
kernel page, about the FUTEX deadlock on mm->mmap_sem of ~ 2.6.8 - yes, it 
wasn't the full truth, but not totally dumb).

> So I think this change is only needed if UML implements kmap_atomic, as in
> arch/i386/mm/highmem.c, which it surely does not do?
NACK, see above.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
