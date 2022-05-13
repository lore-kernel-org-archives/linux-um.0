Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <1760d499824f9ef053af7a8dac04b48ab7d7fd3d.camel@sipsolutions.net>
Subject: Re: [PATCH 11/30] um: Improve panic notifiers consistency and ordering
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 13 May 2022 16:44:36 +0200
In-Reply-To: <4b003501-f5c3-cd66-d222-88d98c93e141@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-12-gpiccoli@igalia.com> <Ynp2hRodh04K3pzK@alley>
 <4b003501-f5c3-cd66-d222-88d98c93e141@igalia.com>
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
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Petr Mladek <pmladek@suse.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>
Cc: akpm@linux-foundation.org, bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org

On Wed, 2022-05-11 at 17:22 -0300, Guilherme G. Piccoli wrote:
> On 10/05/2022 11:28, Petr Mladek wrote:
> > [...]
> > It is not clear to me why user mode linux should not care about
> > the other notifiers. It might be because I do not know much
> > about the user mode linux.
> > 
> > Is the because they always create core dump or are never running
> > in a hypervisor or ...?
> > 
> > AFAIK, the notifiers do many different things. For example, there
> > is a notifier that disables RCU watchdog, print some extra
> > information. Why none of them make sense here?
> > 
> 
> Hi Petr, my understanding is that UML is a form of running Linux as a
> regular userspace process for testing purposes.

Correct.

> With that said, as soon
> as we exit in the error path, less "pollution" would happen, so users
> can use GDB to debug the core dump for example.
> 
> In later patches of this series (when we split the panic notifiers in 3
> lists) these UML notifiers run in the pre-reboot list, so they run after
> the informational notifiers for example (in the default level).
> But without the list split we cannot order properly, so my gut feeling
> is that makes sense to run them rather earlier than later in the panic
> process...
> 
> Maybe Anton / Johannes / Richard could give their opinions - appreciate
> that, I'm not attached to the priority here, it's more about users'
> common usage of UML I can think of...

It's hard to say ... In a sense I'm not sure it matters?

OTOH something like the ftrace dump notifier (kernel/trace/trace.c)
might still be useful to run before the mconsole and coredump ones, even
if you could probably use gdb to figure out the information.

Personally, I don't have a scenario where I'd care about the trace
buffers though, and most of the others I found would seem irrelevant
(drivers that aren't even compiled, hung tasks won't really happen since
we exit immediately, and similar.)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

