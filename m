Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUnez-0004Qj-Q2	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2005 08:25:37 -0700
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DUney-0002GC-7x
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2005 08:25:37 -0700
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j48FPURx026475
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 8 May 2005 11:25:30 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	j48FPUB6105350	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 8 May 2005 11:25:30 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j48FPTFj007160
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 8 May 2005 11:25:29 -0400
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Message-ID: <20050508152611.GA28956@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050507182728.GA29592@in.ibm.com> <m1vf5tvo8b.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vf5tvo8b.fsf@muc.de>
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
Date: Sun, 8 May 2005 20:56:11 +0530
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, rusty@rustcorp.com.au, schwidefsky@de.ibm.com, jdike@addtoit.com, akpm@osdl.org, mingo@elte.hu, rmk+lkml@arm.linux.org.uk, nickpiggin@yahoo.com.au, Dipankar <dipankar@in.ibm.com>

On Sun, May 08, 2005 at 03:31:00PM +0200, Andi Kleen wrote:
> I think the best way is to let other CPUs handle the load balancing
> for idle CPUs. Basically when a CPU goes fully idle then you mark
> this in some global data structure, 

nohz_cpu_mask already exists for this purpose.

> and CPUs doing load balancing after doing their own thing look for others 
> that need to be balanced too and handle them too. 

This is precisely what I had proposed in my watchdog implementation.

> When no CPU is left non idle then nothing needs to be load balanced anyways. 
> When a idle CPU gets a task it just gets an reschedule IPI as usual, that 
> wakes it up. 

True.

> 
> I call this the "scoreboard".
> 
> The trick is to evenly load balance the work over the remaining CPUs.
> Something simple like never doing work for more than 1/idlecpus is
> probably enough. 

Well, there is this imbalance_pct which acts as a trigger threshold before
which load balance won't happen.  I do take this into account before
waking up the sleeping idle cpu (the same imbalance_pct logic would 
have been followed by the idle CPU if it were to continue taking timer
ticks).

So I guess your 1/idlecpus and the imbalance_pct may act on parallel lines.

> In theory one could even use machine NUMA topology
> information for this, but that would be probably overkill for the
> first implementation.
> 
> With the scoreboard implementation CPus could be virtually idle
> forever, which I think is best for virtualization.
> 
> BTW we need a very similar thing for RCU too.

RCU is taken care of already, except it is broken. There is a small
race which is not fixed. Following patch (which I wrote aainst 2.6.10 kernel
maybe) should fix that race. I intend to post this patch after test
agaist more recent kernel.


--- kernel/rcupdate.c.org	2005-02-11 11:38:47.000000000 +0530
+++ kernel/rcupdate.c	2005-02-11 11:44:08.000000000 +0530
@@ -199,8 +199,11 @@ static void rcu_start_batch(struct rcu_c
  */
 static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp, struct rcu_state *rsp)
 {
+	cpumask_t tmpmask;
+
 	cpu_clear(cpu, rsp->cpumask);
-	if (cpus_empty(rsp->cpumask)) {
+	cpus_andnot(tmpmask, rsp->cpumask, nohz_cpu_mask);
+	if (cpus_empty(tmpmask)) {
 		/* batch completed ! */
 		rcp->completed = rcp->cur;
 		rcu_start_batch(rcp, rsp, 0);



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
