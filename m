Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khGGk-0001S7-2C
 for linux-um@lists.infradead.org; Mon, 23 Nov 2020 18:08:54 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94) (envelope-from <johannes@sipsolutions.net>)
 id 1khGGi-00DJsn-0D
 for linux-um@lists.infradead.org; Mon, 23 Nov 2020 19:08:52 +0100
Message-ID: <362501dc4aa835093a5a50b42a4a01d5668f6821.camel@sipsolutions.net>
Subject: Re: [PATCH v3] um: simplify os_idle_sleep() and sleep longer
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 23 Nov 2020 19:08:42 +0100
In-Reply-To: <20201123145759.eda58700e604.I3b692c844a4ca459ee3084334a92ac5ef5b4cec4@changeid>
References: <20201123145759.eda58700e604.I3b692c844a4ca459ee3084334a92ac5ef5b4cec4@changeid>
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
To: linux-um@lists.infradead.org

On Mon, 2020-11-23 at 14:57 +0100, Johannes Berg wrote:
> 
> -void time_travel_sleep(unsigned long long duration)
> +void time_travel_sleep(void)
>  {
> +	unsigned long long duration = NSEC_PER_SEC * 120;
>  	unsigned long long next = time_travel_time + duration;
>  
>  	if (time_travel_mode == TT_MODE_BASIC)
>  		os_timer_disable();
>  
> +	/*
> +	 * In external mode, just tell the external controller we'll
> +	 * (essentially) wait "forever" (S64_MAX because there are
> +	 * some potential wrapping issues.)
> +	 */
> +	if (time_travel_mode == TT_MODE_EXTERNAL)
> +		next = S64_MAX;

Ahrg. That was stupid. I should just make that S64_MAX the default, and
probably in fact crash later if we ever reach that point ...

Otherwise now my suspend/resume only ever suspends for exactly 2
minutes, since the later event added by the fake RTC is, well, later.
I'd either have to loop here, or just start with a later time to start
with.

And really there's no reason _not_ to start with a later time. In a
normally operating system, this is always the fallback, since another
event has been added to the list already to wake up for e.g. the next
10ms (HZ=100) timer.

If you _actually_ hit this, your system is misconfigured in some way, or
you can't actually get it back out of this state anyway since it'd sleep
for millenia (if you had done this in a real system), so crashing on it
seems completely fine. I don't foresee anyone really wanting to test a
few thousand years.


So ... I guess I'll just resent v4 that makes it sleep forever, and
perhaps adds a "you did something stupid so I'll just crash" to when you
suspend without ever having anything to resume from (in time-travel
only, of course.)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

