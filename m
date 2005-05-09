Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DV1js-0001Pa-Dg	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2005 23:27:36 -0700
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DV1jq-0006aD-Pw	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2005 23:27:36 -0700
Message-ID: <427F02CE.7080108@yahoo.com.au>
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
References: <20050507182728.GA29592@in.ibm.com>
	<1115524211.17482.23.camel@localhost.localdomain>
	<427D921F.8070602@yahoo.com.au> <20050508121932.GA3055@in.ibm.com>
In-Reply-To: <20050508121932.GA3055@in.ibm.com>
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
Date: Mon, 09 May 2005 16:27:26 +1000
To: vatsa@in.ibm.com
Cc: Rusty Russell <rusty@rustcorp.com.au>, schwidefsky@de.ibm.com, jdike@addtoit.com, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Srivatsa Vaddagiri wrote:
> On Sun, May 08, 2005 at 02:14:23PM +1000, Nick Piggin wrote:
> 
>>Yeah probably something around that order of magnitude. I suspect
>>there will fast be a point where either you'll get other timers
>>going off more frequently, and / or you simply get very quickly
>>diminishing returns on the amount of power saving gained from
>>increasing the period.
> 
> 
> I am looking at it from the other perspective also i.e, virtualized
> env. Any amount of unnecessary timer ticks will lead to equivalent amount
> of unnecessary context switches among the guest OSes.
> 

Yep.

> 
>>It is not so much a matter of "fixing" the scheduler as just adding
>>more heuristics. When are we too busy? When should we wake another
>>CPU? What if that CPU is an SMT sibling? What if it is across the
>>other side of the topology, and other CPUs closer to it are busy
>>as well? What if they're busy but not as busy as we are? etc.
>>
>>We've already got that covered in the existing periodic pull balancing,
>>so instead of duplicating this logic and moving this extra work to busy
>>CPUs, we can just use the existing framework.
> 
> 
> I don't think we have to duplicate the logic, just "reuse" whatever logic
> exists (in find_busiest_group etc). However I do agree there is movement

OK, that may possibly be an option... however:

> of extra work to busy CPUs, but that is only to help the idle CPU sleep longer.
> Whether it justifies the additional complexity or not is what this RFC is
> about I guess!
> 

Yeah, this is a bit worrying. In general we should not be loading
up busy CPUs with any more work, and sleeping idle CPUs should be
done as a blunt "slowpath" operation. Ie. something that works well
enough.

> FWIW, I have also made some modifications in the original proposal 
> for reducing the watchdog workload (instead of the same non-idle cpu waking 
> up all the sleeping CPUs it finds in the same rebalance_tick, the task
> is spread over multiple non-idle tasks in different rebalance_ticks).
> New (lightly tested) patch is in the mail below.
> 

Mmyeah, I'm not a big fan :)

I could probably find some time to do my implementation if you have
a complete working patch for eg. UML.

> 
> 
>>At least we should try method A first, and if that isn't good enough
>>(though I suspect it will be), then think about adding more complexity
>>to the scheduler.
> 
> 
> What would be good to measure between the two approaches is the CPU utilization 
> (over a period of time - say 10 hrs) of somewhat lightly loaded SMP guest OSes 
> (i.e some CPUs are idle and other CPUs of the same guest are not idle), when 
> multiple such guest OSes are running simultaneously on the same box.  This 
> means I need a port of VST to UML :(
> 

Yeah that would be good.

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
