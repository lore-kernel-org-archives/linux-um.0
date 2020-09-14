Return-Path: <torvalds@linuxfoundation.org>
MIME-Version: 1.0
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
In-Reply-To: <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Sep 2020 15:37:49 -0700
Message-ID: <CAHk-=wjOV6f_ddg+QVCF6RUe+pXPhSR2WevnNyOs9oT+q2ihEA@mail.gmail.com>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Content-Type: text/plain; charset="UTF-8"
To: Thomas Gleixner <tglx@linutronix.de>, Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, alpha <linux-alpha@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Sep 14, 2020 at 3:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ard and Herbert added to participants: see
> chacha20poly1305_crypt_sg_inplace(), which does
>
>         flags = SG_MITER_TO_SG;
>         if (!preemptible())
>                 flags |= SG_MITER_ATOMIC;
>
> introduced in commit d95312a3ccc0 ("crypto: lib/chacha20poly1305 -
> reimplement crypt_from_sg() routine").

As far as I can tell, the only reason for this all is to try to use
"kmap()" rather than "kmap_atomic()".

And kmap() actually has the much more complex "might_sleep()" tests,
and apparently the "preemptible()" check wasn't even the proper full
debug check, it was just a complete hack to catch the one that
triggered.

From a quick look, that code should probably just get rid of
SG_MITER_ATOMIC entirely, and alwayse use kmap_atomic().

kmap_atomic() is actually the faster and proper interface to use
anyway (never mind that any of this matters on any sane hardware). The
old kmap() and kunmap() interfaces should generally be avoided like
the plague - yes, they allow sleeping in the middle and that is
sometimes required, but if you don't need that, you should never ever
use them.

We used to have a very nasty kmap_atomic() that required people to be
very careful and know exactly which atomic entry to use, and that was
admitedly quite nasty.

So it _looks_ like this code started using kmap() - probably back when
kmap_atomic() was so cumbersome to use - and was then converted
(conditionally) to kmap_atomic() rather than just changed whole-sale.
Is there actually something that wants to use those sg_miter functions
and sleep?

Because if there is, that choice should come from the outside, not
from inside lib/scatterlist.c trying to make some bad guess based on
the wrong thing entirely.

                 Linus

