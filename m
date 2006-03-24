Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMrH6-0006ui-68 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:44:40 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FMrH2-0000gy-5N
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:44:40 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: TLS support - status - need for re-testing
References: <200603230317.48384.blaisorblade@yahoo.it>
	<200603241243.34687.blaisorblade@yahoo.it>
	<20060324173247.GD5400@ccure.user-mode-linux.org>
In-Reply-To: <20060324173247.GD5400@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241944.24941.blaisorblade@yahoo.it>
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
Date: Fri, 24 Mar 2006 19:44:24 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>

On Friday 24 March 2006 18:32, Jeff Dike wrote:
> On Fri, Mar 24, 2006 at 12:43:33PM +0100, Blaisorblade wrote:
> > We discussed this time ago, and read the description of the patch:

> > > global-ldt-sem - We should be using mutexes now, not semaphores
> >
> > That's your patch, but below I drop this.
>
> My patch predates mutexes.
>
> But you still use semaphores, and that should be updated.

We'll do it at some time, there's no hurry for that; or they'll do it anyway 
before ripping out semaphores.

> It's simpler.  A single global lock is simpler than a lock in every
> datastructure.

My only doubt (I'd almost swear it doesn't happen) is if two locks of two 
different structures are ever taken. That would fail.

About locking, I've discovered that sigio_lock must use spin_lock_irqsave() 
instead of spin_lock; currently with Mutex debugging I get hangs on that 
spinlock, but on UP currently you get a race between process context and 
interrupt context.

The failing case is when that lock is taken in process context, then an 
interrupt is triggered whose handler takes again that. In fact, for mutual 
exclusion between process context and irq context an spin_lock_irq{,save} is 
_always_ recommended.

Only problem will be to check for sleepers in process context - there could be 
many ones.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
