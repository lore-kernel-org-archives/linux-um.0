Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUU0q-00051x-Tv	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 11:26:52 -0700
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DUU0o-0008VD-9v
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 May 2005 11:26:52 -0700
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j47IQgPC006339
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 7 May 2005 14:26:42 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	j47IQglo112454	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 7 May 2005 14:26:42 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j47IQfj0018597
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 7 May 2005 14:26:42 -0400
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Message-ID: <20050507182728.GA29592@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [RFC] (How to) Let idle CPUs sleep
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
Date: Sat, 7 May 2005 23:57:28 +0530
To: schwidefsky@de.ibm.com, jdike@addtoit.com, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>, Rusty Russell <rusty@rustcorp.com.au>, rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Hello,
	I need some inputs from the community (specifically from virtual
machine and embedded/power-management folks) on something that I am working on.

	This is regarding cutting off the regular timer ticks when a CPU
becomes idle and it does not have any next timer set to expire in the "near"
term. Both CONFIG_VST and CONFIG_NO_IDLE_HZ deal with this. Both embedded and
virtualized platforms (ex: UML/S390) benefit from this. For ex: if 100s
of guest are running on a single box, then cutting off some useless HZ ticks
in the idle CPUs of all guests will lead to efficient use of host CPU's cycles.

Cutting of local timer ticks has an effect on the scheduler load balance
activity and I am trying to see how best to reduce the impact.

Two solutions have been proposed so far:

	A. As per Nick's suggestion, impose a max limit (say some 100 ms or
	   say a second, Nick?) on how long a idle CPU can avoid taking
	   local-timer ticks. As a result, the load imbalance could exist only
	   for this max duration, after which the sleeping CPU will wake up
	   and balance itself. If there is no imbalance, it can go and sleep
	   again for the max duration.

 	   For ex, lets say a idle CPU found that it doesn't have any near timer
	   for the next 1 minute. Instead of letting it sleep for 1 minute in
	   a single stretch, we let it sleep in bursts of 100 msec (or whatever
	   is the max. duration chosen). This still is better than having
	   the idle CPU take HZ ticks a second.

	   As a special case, when all the CPUs of an image go idle, we
	   could consider completely shutting off local timer ticks
	   across all CPUs (till the next non-timer interrupt).


	B. Don't impose any max limit on how long a idle CPU can sleep.
	   Here we let the idle CPU sleep as long as it wants. It is
	   woken up by a "busy" CPU when it detects an imbalance. The
	   busy CPU acts as a watchdog here. If there are no such
	   busy CPUs, then it means that nobody will acts as watchdogs
	   and idle CPUs sleep as long as they want. A possible watchdog
	   implementation has been discussed at:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=111287808905764&w=2

A is obviously more simpler to implement compared to B!
Whether both are more or less equally efficient is something that I dont know.

To help us decide which way to go, could I have some comments from the virtual
machine and embedded folks on which solution they prefer and why?



--


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
