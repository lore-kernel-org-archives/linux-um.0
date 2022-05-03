Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <adcf6d0e-c37c-6ede-479e-29959d03d8c0@igalia.com>
Date: Tue, 3 May 2022 16:12:09 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 04/30] firmware: google: Convert regular spinlock into
 trylock on panic path
Content-Language: en-US
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-5-gpiccoli@igalia.com>
 <CAE=gft5Pq25L4KFoPWbftkPF-JN1ex2yws77mMJ4GQnn9W0L2g@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAE=gft5Pq25L4KFoPWbftkPF-JN1ex2yws77mMJ4GQnn9W0L2g@mail.gmail.com>
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
To: Evan Green <evgreen@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com, pmladek@suse.com, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, Kees Cook <keescook@chromium.org>, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, vgoyal@redhat.com, vkuznets@redhat.com, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, David Gow <davidgow@google.com>, Julius Werner <jwerner@chromium.org>

On 03/05/2022 15:03, Evan Green wrote:
> [...]
> gsmi_shutdown_reason() is a common function called in other scenarios
> as well, like reboot and thermal trip, where it may still make sense
> to wait to acquire a spinlock. Maybe we should add a parameter to
> gsmi_shutdown_reason() so that you can get your change on panic, but
> we don't convert other callbacks into try-fail scenarios causing us to
> miss logs.
> 

Hi Evan, thanks for your feedback, much appreciated!
What I've done in other cases like this was to have a helper checking
the spinlock in the panic notifier - if we can acquire that, go ahead
but if not, bail out. For a proper example of an implementation, check
patch 13 of the series:
https://lore.kernel.org/lkml/20220427224924.592546-14-gpiccoli@igalia.com/ .

Do you agree with that, or prefer really a parameter in
gsmi_shutdown_reason() ? I'll follow your choice =)


> Though thinking more about it, is this really a Good Change (TM)? The
> spinlock itself already disables interrupts, meaning the only case
> where this change makes a difference is if the panic happens from
> within the function that grabbed the spinlock (in which case the
> callback is also likely to panic), or in an NMI that panics within
> that window. The downside of this change is that if one core was
> politely working through an event with the lock held, and another core
> panics, we now might lose the panic log, even though it probably would
> have gone through fine assuming the other core has a chance to
> continue.

My feeling is that this is a good change, indeed - a lot of places are
getting changed like this, in this series.

Reasoning: the problem with your example is that, by default, secondary
CPUs are disabled in the panic path, through an IPI mechanism. IPIs take
precedence and interrupt the work in these CPUs, effectively
interrupting the "polite work" with the lock held heh

Then, such CPU is put to sleep and we finally reach the panic notifier
hereby discussed, in the main CPU. If the other CPU was shut-off *with
the lock held*, it's never finishing such work, so the lock is never to
be released. Conclusion: the spinlock can't be acquired, hence we broke
the machine (which is already broken, given it's panic) in the path of
this notifier.
This should be really rare, but..possible. So I think we should protect
against this scenario.

We can grab others' feedback if you prefer, and of course you have the
rights to refuse this change in the gsmi code, but from my
point-of-view, I don't see any advantage in just assume the risk,
specially since the change is very very simple.

Cheers,


Guilherme

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

