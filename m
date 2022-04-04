Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbLe7-00EqsR-Je
 for linux-um@lists.infradead.org; Mon, 04 Apr 2022 12:17:25 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: UML time-travel warning from __run_timers
In-Reply-To: <85f7ce7bc7ddcf1f67b52375b7fabaca8d254e5a.camel@sipsolutions.net>
References: <20220330110156.GA9250@axis.com>
 <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
 <877d86m978.ffs@tglx>
 <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
 <87pmlykksj.ffs@tglx>
 <ff314e8556aba7e231ab80c46b30701142e82a43.camel@sipsolutions.net>
 <87ee2dl041.ffs@tglx>
 <85f7ce7bc7ddcf1f67b52375b7fabaca8d254e5a.camel@sipsolutions.net>
Date: Mon, 04 Apr 2022 14:17:15 +0200
Message-ID: <871qydjb5g.ffs@tglx>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>

On Mon, Apr 04 2022 at 10:37, Johannes Berg wrote:
> On Mon, 2022-04-04 at 10:32 +0200, Thomas Gleixner wrote:
>> --- a/kernel/time/timer.c
>> +++ b/kernel/time/timer.c
>> @@ -1724,9 +1724,8 @@ static inline void __run_timers(struct t
>>  		/*
>>  		 * The only possible reason for not finding any expired
>>  		 * timer at this clk is that all matching timers have been
>> -		 * dequeued.
>> +		 * dequeued or no timer has been ever queued.
>>  		 */
>> -		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
>> 
>
> So I'm pretty sure we don't even need to test a patch simply removing
> the WARN_ON_ONCE() since the entire problem Vincent reported was hitting
> the WARN_ON_ONCE :)

:)

> (And I'm pretty sure I did at some point test some additional condition
> inside it)
>
> Are you going to merge that patch?

Let me write a coherent changelog.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

