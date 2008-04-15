Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jlr7r-0003DQ-Dp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 12:47:31 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user68583)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jlr7p-0005qH-La
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 12:47:31 -0700
References: <87k5jcqmh8.fsf@hades.wkstn.nix>
	<20080414144052.GA7186@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Tue, 15 Apr 2008 20:47:08 +0100
In-Reply-To: <20080414144052.GA7186@c2.user-mode-linux.org> (Jeff Dike's
	message of "Mon, 14 Apr 2008 10:40:52 -0400")
Message-ID: <87y77elx37.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] Lockups with the fixed timer code :/
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
Cc: Thomas Gleixner <tglx@timesys.com>, user-mode-linux-devel@lists.sourceforge.net

On 14 Apr 2008, Jeff Dike spake thusly:
> Below is another patch for you to try.  I spent most of last week
> chasing this one.  The symptoms are somewhat similar to yours -
> intermittent UML hangs, although not with UML spinning, and it still
> pings.

Having not quite the same symptoms is interesting.

I added instrumentation to spot huge offsets on the offchance that it
was going negative... whereupon it ceased to hang for an entire week
after a week of dying multiple times a day :/

> The problem is NTP adjusting the multiplier part of the clock-provided
> cycles-to-ns conversion function.  UML pretended to have a ns clock,
> with a multiplier of 1.  When NTP adjusted that down in order to slow
> down the clock, that became 0, and time stopped.

Oh, I didn't think that clock_interval might be *variable*. So much for
my instrumentation hack then. :)

... hang on, wouldn't this only happen if you had NTP running on your
guest? (I don't. For that matter, *why* would you have NTP running on
your guest? The guest just gets the time of day from the host anyway!)

(And why does the clocksource system allow NTP to reduce the clock
interval so far that it becomes zero anyway? Shouldn't this be barred?
What am I missing?)

> The fix below is to switch to a usec clock, with a multiplier of 1000,
> which can be adjusted with much more granualarity.

OK, trying that. (I'll extend the instrumentation patch to watch for
zero cycle_interval as well, and see what happens. With luck nothing
will happen except that the crashes will stop... except that they
already *have* stopped for me. Annoying.)

-- 
`The rest is a tale of post and counter-post.' --- Ian Rawlings
                                                   describes USENET

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
