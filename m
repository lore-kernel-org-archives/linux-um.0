Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hV1Tq-0000ta-J7
 for linux-um@lists.infradead.org; Sun, 26 May 2019 22:19:05 +0000
Message-ID: <6a6dd0548031aedc34044d89953e4c8c9d7e45f5.camel@sipsolutions.net>
Subject: Re: [PATCH v2 5/5] arch: um: support virtual time
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 27 May 2019 00:18:57 +0200
In-Reply-To: <CAFLxGvza1da-q=XakFimKc-aZd5M9bSxtNZdvLmTz5_Ck1HJ3Q@mail.gmail.com>
 (sfid-20190526_235537_530411_48770A6E)
References: <20190506123939.21091-1-johannes@sipsolutions.net>
 <20190506123939.21091-6-johannes@sipsolutions.net>
 <CAFLxGvza1da-q=XakFimKc-aZd5M9bSxtNZdvLmTz5_Ck1HJ3Q@mail.gmail.com>
 (sfid-20190526_235537_530411_48770A6E)
Mime-Version: 1.0
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: j@w1.fi, linux-um@lists.infradead.org

On Sun, 2019-05-26 at 23:55 +0200, Richard Weinberger wrote:

> > Add a mode - CONFIG_UML_VIRTUAL_TIME_SUPPORT - to support such
> > behavior; it needs to be enabled with the "virtual-time" option
> > passed to the UML invocation.
> 
> I like this feature!
> Is "virtual time" a common name for such a mode?

I have no idea, sorry. If you find any references to this being done
elsewhere, we can certainly rename it. A colleague pointed me to various
network simulation papers which play with the clock, but I don't recall
seeing a good name for this (but it's also past midnight, so ...)

> To me "virtual time" reads like a clock that runs with different speed or is in
> some other way untangled from the host.
> What you have implement is time traveling. ;-)

True :-)

I have a version of this that even implements "infinite CPU power" by
completely eliding the calls to the host timer (which lets us do
preemption). This has a large number of issues, but also found a few
bugs already, e.g.
https://github.com/bcopeland/wmediumd/commit/414bee49eda82046b61e0a3cd583d235ebd3f017

The biggest issue is that nothing actually takes time, and so things
like

https://bugs.python.org/issue37026

result. When I make just reading out the time take 10 ns or so, things
like that go away.

It still has issues, like kernel work queues won't run until userspace
is completely quiescent, which is clearly unrealistic. Trying to model
some time into the syscall now, so that can "take" some time and the
scheduler will run kernel threads, but it's not really clear to me yet
how that can be made to work. It should solve this problem though.

The reason I'm interested in that is that it completely decouples the
code from the real time, e.g. if I run a ton of debug code somewhere, it
won't affect my "timing", and thus not cause differences in the test
execution.

> > +++ b/arch/um/os-Linux/time.c
> > @@ -15,8 +15,27 @@
> >  #include <os.h>
> >  #include <string.h>
> >  #include <timer-internal.h>
> > +#include <generated/autoconf.h>
> > 
> >  static timer_t event_high_res_timer = 0;
> > +#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
> > +unsigned long long virtual_time;
> > +unsigned long long timer_expiry;
> > +static enum {
> > +       TMR_DIS,
> > +       TMR_ONE,
> > +       TMR_INT,
> > +} timer_mode;
> 
> You set the timer mode in the os_*-functions, this works because the only user
> is UML's posix-timer.
> Is there a reason why you didn't install most virtual time hooks in
> the itimer_* functions?
> This feels more natural to me and would keep the os_*-functions
> stateless and generic.

Can't really say I had a good reason for that. It's probably just the
place I could actually reason best about - and in the case of my non-
preemptible mode (that I described above) really be sure nothing was
calling any real timers :-)

It could totally be done in the itimer_* functions, but then also has to
be in arch_cpu_idle() I guess, to be done in the kernel side (rather
than in the host side in os_*).

> > +#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
> > +       timer_mode = TMR_INT;
> > +       timer_expiry = virtual_time + nsec;
> > +#endif
> > 
> 
> Can we please have a static inline helper for this?
> ...to avoid more ifdefs in C files.

Sure. Not sure it's worth putting it into a header file, but it could
be, even common code with the similar code you pointed out, declared at
the top of the C file with the other ifdefs.

> >  long long os_nsecs(void)
> >  {
> >         struct timespec ts;
> > 
> > +#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
> > +       if (virtual_time_enabled)
> > +               return virtual_time;
> > +#endif
> > 
> 
> Do we need the ifdef here?
> If CONFIG_UML_VIRTUAL_TIME_SUPPORT is disabled, virtual_time_enabled
> should never be non-zero/true.

Yeah, some variable are ifdef'ed out so this wouldn't compile, but if
you prefer I can remove those ifdefs and this can always be compiled.

> >  void os_idle_sleep(unsigned long long nsecs)
> >  {
> > +#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
> > +       unsigned long long next = virtual_time + nsecs;
> > +       struct itimerspec stop = {}, cfg;
> > +#endif
> >         struct timespec ts = {
> >                 .tv_sec  = nsecs / UM_NSEC_PER_SEC,
> >                 .tv_nsec = nsecs % UM_NSEC_PER_SEC
> > @@ -117,6 +157,32 @@ void os_idle_sleep(unsigned long long nsecs)
> >         /*
> >          * Relay the signal if clock_nanosleep is interrupted.
> >          */
> > -       if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL))
> > +       if (!virtual_time_enabled) {
> > +               if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL))
> > +                       deliver_alarm();
> > +               return;
> > +       }
> > +
> > +#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
> > +       timer_settime(event_high_res_timer, 0, &stop, &cfg);
> > +
> > +       if (timer_mode != TMR_DIS && timer_expiry < next) {
> > +               if (timer_mode == TMR_ONE)
> > +                       timer_mode = TMR_DIS;
> > +               /* virtual_time will be adjusted in timer_handler() */
> >                 deliver_alarm();
> > +               return;
> > +       }
> > +
> > +       virtual_time = next;
> > +
> > +       if (timer_mode != TMR_DIS) {
> > +               unsigned long long remaining = timer_expiry - virtual_time;
> > +
> > +               cfg.it_value.tv_sec = remaining / UM_NSEC_PER_SEC;
> > +               cfg.it_value.tv_nsec = remaining % UM_NSEC_PER_SEC;
> > +
> > +               timer_settime(event_high_res_timer, 0, &cfg, NULL);
> > +       }
> > +#endif
> 
> Please split the function to get rid of the ifdefs.

Hmm. We need an ifdef there somewhere anyway.

If you dislike the ifdefs so much and wanted to keep the if in
os_nsecs() anyway maybe I should just remove the Kconfig option entirely
and just let the runtime configuration control it?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

