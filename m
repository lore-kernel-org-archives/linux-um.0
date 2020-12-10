Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knUQk-0003kN-4N
 for linux-um@lists.infradead.org; Thu, 10 Dec 2020 22:28:59 +0000
Received: by mail-qt1-x841.google.com with SMTP id 7so5104960qtp.1
 for <linux-um@lists.infradead.org>; Thu, 10 Dec 2020 14:28:56 -0800 (PST)
MIME-Version: 1.0
References: <20201203153655.9143e9112c12.I0326b116f23cf30c573a54e9a0d9882c5703ef65@changeid>
In-Reply-To: <20201203153655.9143e9112c12.I0326b116f23cf30c573a54e9a0d9882c5703ef65@changeid>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 10 Dec 2020 23:28:44 +0100
Message-ID: <CAFLxGvyTvpsF+Hzcy-2z=cdED_OxVye_jKfmsbeqKPu4evxf3Q@mail.gmail.com>
Subject: Re: [PATCH] um: time-travel: actually apply "free-until" optimisation
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um <linux-um@lists.infradead.org>, Johannes Berg <johannes.berg@intel.com>

On Thu, Dec 3, 2020 at 3:37 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> Due a bug - we never checked the time_travel_ext_free_until value - we
> were always requesting time for every single scheduling. This adds up
> since we make reading time cost 256ns, and it's a fairly common call.
> Fix this.
>
> While at it, also make reading time only cost something when we're not
> currently waiting for our scheduling turn - otherwise things get mixed
> up in a very confusing way. We should never get here, since we're not
> actually running, but it's possible if you stick printk() or such into
> the virtio code that must handle the external interrupts.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  arch/um/kernel/time.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
> index 303565ce8c64..5ac084deac7e 100644
> --- a/arch/um/kernel/time.c
> +++ b/arch/um/kernel/time.c
> @@ -183,6 +183,14 @@ static void time_travel_ext_update_request(unsigned long long time)
>             time == time_travel_ext_prev_request)
>                 return;
>
> +       /*
> +        * if we're running and are allowed to run past the request
> +        * then we don't need to update it either
> +        */
> +       if (!time_travel_ext_waiting && time_travel_ext_free_until_valid &&
> +           time < time_travel_ext_free_until)
> +               return;
> +
>         time_travel_ext_prev_request = time;
>         time_travel_ext_prev_request_valid = true;
>         time_travel_ext_req(UM_TIMETRAVEL_REQUEST, time);
> @@ -217,6 +225,7 @@ static void time_travel_ext_wait(bool idle)
>         };
>
>         time_travel_ext_prev_request_valid = false;
> +       time_travel_ext_free_until_valid = false;
>         time_travel_ext_waiting++;
>
>         time_travel_ext_req(UM_TIMETRAVEL_WAIT, -1);
> @@ -639,7 +648,8 @@ static u64 timer_read(struct clocksource *cs)
>                  * "what do I do next" and onstack event we use to know when
>                  * to return from time_travel_update_time().
>                  */
> -               if (!irqs_disabled() && !in_interrupt() && !in_softirq())
> +               if (!irqs_disabled() && !in_interrupt() && !in_softirq() &&
> +                   !time_travel_ext_waiting)

This will not build with timetravel support disabled.

>                         time_travel_update_time(time_travel_time +
>                                                 TIMER_MULTIPLIER,
>                                                 false);
> --
> 2.26.2
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um



-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

