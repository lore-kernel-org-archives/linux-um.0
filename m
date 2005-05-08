Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUlsC-0003gH-CH	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2005 06:31:08 -0700
Received: from one.firstfloor.org ([213.235.205.2])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DUlsA-0004Bm-Hw
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2005 06:31:08 -0700
References: <20050507182728.GA29592@in.ibm.com>
From: Andi Kleen <ak@muc.de>
In-Reply-To: <20050507182728.GA29592@in.ibm.com> (Srivatsa Vaddagiri's
 message of "Sat, 7 May 2005 23:57:28 +0530")
Message-ID: <m1vf5tvo8b.fsf@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Sun, 08 May 2005 15:31:00 +0200
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Srivatsa Vaddagiri <vatsa@in.ibm.com> writes:

> Hello,
> 	I need some inputs from the community (specifically from virtual
> machine and embedded/power-management folks) on something that I am working on.


I think the best way is to let other CPUs handle the load balancing
for idle CPUs. Basically when a CPU goes fully idle then you mark
this in some global data structure, and CPUs doing load balancing
after doing their own thing look for others that need to be balanced
too and handle them too. When no CPU is left non idle then nothing needs
to be load balanced anyways. When a idle CPU gets a task it just gets
an reschedule IPI as usual, that wakes it up. 

I call this the "scoreboard".

The trick is to evenly load balance the work over the remaining CPUs.
Something simple like never doing work for more than 1/idlecpus is
probably enough. In theory one could even use machine NUMA topology
information for this, but that would be probably overkill for the
first implementation.

With the scoreboard implementation CPus could be virtually idle
forever, which I think is best for virtualization.

BTW we need a very similar thing for RCU too.

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
