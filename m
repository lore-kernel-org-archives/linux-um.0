Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DEHn8-0008I7-6l for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 18:09:46 -0800
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DEHn7-00044o-RX for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 18:09:46 -0800
Message-ID: <42422165.20505@yahoo.com.au>
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [uml-devel] [patch 02/12] uml: cpu_relax fix
References: <20050322162121.4295D2125C@zion>
	<4241A2C0.2050206@fujitsu-siemens.com>
	<200503240250.38153.blaisorblade@yahoo.it>
In-Reply-To: <200503240250.38153.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Thu, 24 Mar 2005 13:09:41 +1100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

Blaisorblade wrote:
> On Wednesday 23 March 2005 18:09, Bodo Stroesser wrote:
> 
>>blaisorblade@yahoo.it wrote:
>>
>>>Use rep_nop instead of barrier for cpu_relax, following $(SUBARCH)'s
>>>doing that (i.e. i386 and x86_64).
>>
>>IIRC, Jeff had the idea, to use sched_yield() for this (from a discussion
>>on #uml).
> 
> Hmm, makes sense, but this is to benchmark well... I remember from early 
> discussions on 2.6 scheduler that using sched_yield might decrease 
> performance (IIRC starve the calling application).
> 

Typically, for places where cpu_relax is used, sched_yield would be
a poor fit. So yes it could easily reduce performance.

> Also, that call should be put inside the idle loop, not for cpu_relax, which 
> is very different, since it is used (for instance) in kernel/spinlock.c for 
> spinlocks, and in such things. The "Pause" opcode is explicitly recommended 
> (by Intel manuals, I don't recall why) for things like spinlock loops, and 
> using yield there would be bad.
> 

The other thing is that sched_yield won't relax at all if you are the
only thing running, it will be a busy wait. So again, maybe not a great
fit for the idle loop either.





-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
