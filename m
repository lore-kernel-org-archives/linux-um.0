Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 14 Jun 2022 16:36:01 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 24/30] panic: Refactor the panic path
Message-ID: <Yqic0R8/UFqTbbMD@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-25-gpiccoli@igalia.com>
 <87fskzuh11.fsf@email.froward.int.ebiederm.org>
 <0d084eed-4781-c815-29c7-ac62c498e216@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0d084eed-4781-c815-29c7-ac62c498e216@igalia.com>
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
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: bhe@redhat.com, d.hatayama@jp.fujitsu.com, "Eric W. Biederman" <ebiederm@xmission.com>, Mark Rutland <mark.rutland@arm.com>, mikelley@microsoft.com, vkuznets@redhat.com, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, will@kernel.org

On Thu 2022-05-26 13:25:57, Guilherme G. Piccoli wrote:
> OK, so it seems we have some points in which agreement exists, and some
> points that there is no agreement and instead, we have antagonistic /
> opposite views and needs. Let's start with the easier part heh
>
> It seems everybody agrees that *we shouldn't over-engineer things*, and
> as per Eric good words: making the panic path more feature-full or
> increasing flexibility isn't a good idea. So, as a "corollary": the
> panic level approach I'm proposing is not a good fit, I'll drop it and
> let's go with something simpler.

Makes sense.

> Another point of agreement seems to be that _notifier lists in the panic
> path are dangerous_, for *2 different reasons*:
> 
> (a) We cannot guarantee that people won't add crazy callbacks there, we
> can plan and document things the best as possible - it'll never be
> enough, somebody eventually would slip a nonsense callback that would
> break things and defeat the planned purpose of such a list;

It is true that notifier lists might allow to add crazy stuff
without proper review more easily. Things added into the core
code would most likely get better review.

But nothing is error-proof. And bugs will happen with any approach.


> (b) As per Eric point, in a panic/crash situation we might have memory
> corruption exactly in the list code / pointers, etc, so the notifier
> lists are, by nature, a bit fragile. But I think we shouldn't consider
> it completely "bollocks", since this approach has been used for a while
> with a good success rate. So, lists aren't perfect at all, but at the
> same time, they aren't completely useless.

I am not able to judge this. Of course, any extra step increases
the risk. I am just not sure how much more complicated it would
be to hardcode the calls. Most of them are architecture
and/or feature specific. And such code is often hard to
review and maintain.

> To avoid using a 4th list,

4th or 5th? We already have "hypervisor", "info", "pre-reboot", and "pre-loop".
The 5th might be pre-crash-exec.

> especially given the list nature is a bit
> fragile, I'd suggest one of the 3 following approaches - I *really
> appreciate feedbacks* on that so I can implement the best solution and
> avoid wasting time in some poor/disliked solution:

Honestly, I am not able to decide what might be better without seeing
the code.

Most things fits pretty well into the 4 proposed lists:
"hypervisor", "info", "pre-reboot", and "pre-loop". IMHO, the
only question is the code that needs to be always called
even before crash_dump.

I suggest that you solve the crash_dump callbacks the way that
looks best to you. Ideally do it in a separate patch so it can be
reviewed and reworked more easily.

I believe that a fresh code with an updated split and simplified
logic would help us to move forward.

Best Regards,
Petr

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

