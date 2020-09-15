Return-Path: <torvalds@linuxfoundation.org>
MIME-Version: 1.0
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87bli75t7v.fsf@nanos.tec.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2020 10:35:20 -0700
Message-ID: <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Content-Type: text/plain; charset="UTF-8"
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, alpha <linux-alpha@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Tue, Sep 15, 2020 at 1:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> OTOH, having a working 'preemptible()' or maybe better named
> 'can_schedule()' check makes tons of sense to make decisions about
> allocation modes or other things.

No. I think that those kinds of decisions about actual behavior are
always simply fundamentally wrong.

Note that this is very different from having warnings about invalid
use. THAT is correct. It may not warn in all configurations, but that
doesn't matter: what matters is that it warns in common enough
configurations that developers will catch it.

So having a warning in "might_sleep()" that doesn't always trigger,
because you have a limited configuration that can't even detect the
situation, that's fine and dandy and intentional.

But having code like

       if (can_schedule())
           .. do something different ..

is fundamentally complete and utter garbage.

It's one thing if you test for "am I in hardware interrupt context".
Those tests aren't great either, but at least they make sense.

But a driver - or some library routine - making a difference based on
some nebulous "can I schedule" is fundamentally and basically WRONG.

If some code changes behavior, it needs to be explicit to the *caller*
of that code.

So this is why GFP_ATOMIC is fine, but "if (!can_schedule())
do_something_atomic()" is pure shite.

And I am not IN THE LEAST interested in trying to help people doing
pure shite. We need to fix them. Like the crypto code is getting
fixed.

                   Linus

