Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUdBW-0003Q7-2G	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 21:14:30 -0700
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DUdBU-0002iT-Ea	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 21:14:29 -0700
Message-ID: <427D921F.8070602@yahoo.com.au>
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
References: <20050507182728.GA29592@in.ibm.com>
	<1115524211.17482.23.camel@localhost.localdomain>
In-Reply-To: <1115524211.17482.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sun, 08 May 2005 14:14:23 +1000
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: vatsa@in.ibm.com, schwidefsky@de.ibm.com, jdike@addtoit.com, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Rusty Russell wrote:
> On Sat, 2005-05-07 at 23:57 +0530, Srivatsa Vaddagiri wrote:
> 
>>Two solutions have been proposed so far:
>>
>>	A. As per Nick's suggestion, impose a max limit (say some 100 ms or
>>	   say a second, Nick?) on how long a idle CPU can avoid taking

Yeah probably something around that order of magnitude. I suspect
there will fast be a point where either you'll get other timers
going off more frequently, and / or you simply get very quickly
diminishing returns on the amount of power saving gained from
increasing the period.

>>	   local-timer ticks. As a result, the load imbalance could exist only
>>	   for this max duration, after which the sleeping CPU will wake up
>>	   and balance itself. If there is no imbalance, it can go and sleep
>>	   again for the max duration.
>>
>> 	   For ex, lets say a idle CPU found that it doesn't have any near timer
>>	   for the next 1 minute. Instead of letting it sleep for 1 minute in
>>	   a single stretch, we let it sleep in bursts of 100 msec (or whatever
>>	   is the max. duration chosen). This still is better than having
>>	   the idle CPU take HZ ticks a second.
>>
>>	   As a special case, when all the CPUs of an image go idle, we
>>	   could consider completely shutting off local timer ticks
>>	   across all CPUs (till the next non-timer interrupt).
>>
>>
>>	B. Don't impose any max limit on how long a idle CPU can sleep.
>>	   Here we let the idle CPU sleep as long as it wants. It is
>>	   woken up by a "busy" CPU when it detects an imbalance. The
>>	   busy CPU acts as a watchdog here. If there are no such
>>	   busy CPUs, then it means that nobody will acts as watchdogs
>>	   and idle CPUs sleep as long as they want. A possible watchdog
>>	   implementation has been discussed at:
>>
>>	http://marc.theaimsgroup.com/?l=linux-kernel&m=111287808905764&w=2
> 
> 
> My preference would be the second: fix the scheduler so it doesn't rely
> on regular polling.

It is not so much a matter of "fixing" the scheduler as just adding
more heuristics. When are we too busy? When should we wake another
CPU? What if that CPU is an SMT sibling? What if it is across the
other side of the topology, and other CPUs closer to it are busy
as well? What if they're busy but not as busy as we are? etc.

We've already got that covered in the existing periodic pull balancing,
so instead of duplicating this logic and moving this extra work to busy
CPUs, we can just use the existing framework.

At least we should try method A first, and if that isn't good enough
(though I suspect it will be), then think about adding more complexity
to the scheduler.

>  However, as long as the UP case runs with no timer
> interrupts when idle, many people will be happy (eg. most embedded).
> 

Well in the UP case, both A and B should basically degenerate to the
same thing.

Probably the more important case for the scheduler is to be able to
turn off idle SMP hypervisor clients, Srivatsa?

-- 
SUSE Labs, Novell Inc.




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
