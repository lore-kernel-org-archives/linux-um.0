Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUco5-00014M-Oa	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 20:50:17 -0700
Received: from ozlabs.org ([203.10.76.45])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DUco3-0007G1-T9
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 20:50:17 -0700
From: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20050507182728.GA29592@in.ibm.com>
References: <20050507182728.GA29592@in.ibm.com>
Content-Type: text/plain
Message-Id: <1115524211.17482.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [RFC] (How to) Let idle CPUs sleep
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
Date: Sun, 08 May 2005 13:50:10 +1000
To: vatsa@in.ibm.com
Cc: schwidefsky@de.ibm.com, jdike@addtoit.com, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>, rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, 2005-05-07 at 23:57 +0530, Srivatsa Vaddagiri wrote:
> Two solutions have been proposed so far:
> 
> 	A. As per Nick's suggestion, impose a max limit (say some 100 ms or
> 	   say a second, Nick?) on how long a idle CPU can avoid taking
> 	   local-timer ticks. As a result, the load imbalance could exist only
> 	   for this max duration, after which the sleeping CPU will wake up
> 	   and balance itself. If there is no imbalance, it can go and sleep
> 	   again for the max duration.
> 
>  	   For ex, lets say a idle CPU found that it doesn't have any near timer
> 	   for the next 1 minute. Instead of letting it sleep for 1 minute in
> 	   a single stretch, we let it sleep in bursts of 100 msec (or whatever
> 	   is the max. duration chosen). This still is better than having
> 	   the idle CPU take HZ ticks a second.
> 
> 	   As a special case, when all the CPUs of an image go idle, we
> 	   could consider completely shutting off local timer ticks
> 	   across all CPUs (till the next non-timer interrupt).
> 
> 
> 	B. Don't impose any max limit on how long a idle CPU can sleep.
> 	   Here we let the idle CPU sleep as long as it wants. It is
> 	   woken up by a "busy" CPU when it detects an imbalance. The
> 	   busy CPU acts as a watchdog here. If there are no such
> 	   busy CPUs, then it means that nobody will acts as watchdogs
> 	   and idle CPUs sleep as long as they want. A possible watchdog
> 	   implementation has been discussed at:
> 
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=111287808905764&w=2

My preference would be the second: fix the scheduler so it doesn't rely
on regular polling.  However, as long as the UP case runs with no timer
interrupts when idle, many people will be happy (eg. most embedded).

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
