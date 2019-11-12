Return-Path: <sergey.senozhatsky.work@gmail.com>
Date: Tue, 12 Nov 2019 11:17:47 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Message-ID: <20191112021747.GA68506@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <13e72b62-c842-8ed5-5b41-bc1692b28f53@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13e72b62-c842-8ed5-5b41-bc1692b28f53@arista.com>
To: Dmitry Safonov <dima@arista.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Albert Ou <aou@eecs.berkeley.edu>, Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Greentime Hu <green.hu@gmail.com>, Ingo Molnar <mingo@redhat.com>, James Hogan <jhogan@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Burton <paulburton@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon <will@kernel.org>, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>, linux-alpha@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, clang-built-linux@googlegroups.com, Catalin Marinas <catalin.marinas@arm.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, uclinux-h8-devel@lists.sourceforge.jp, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org, Jonas Bonn <jonas@southpole.se>, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net
List-ID: <linux-um.lists.infradead.org>

On (19/11/11 19:47), Dmitry Safonov wrote:
[..]
> I don't see how bits on task_struct or in per-cpu are easier than
> supplying a log level parameter down the stack.
> How would it work if sysrq_handle_crash() called by key-press?
> How would that interact with deferred printing?
> How would it make visible prints from current context, but not from
> something that preempted it?

[..]

per-context log_level works pretty much the same way as per-message
log_level.

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
static DEFINE_PER_CPU(int, cpu_loglevels[4]); // @INITME.. LOGLEVEL_DEBUG + 1?

static int __printing_context(void)
{
	unsigned int preempt = preempt_count();

	if (!(preempt & (NMI_MASK | HARDIRQ_MASK | SOFITRQ_OFFSET)))
		return 0;
	if (preempt & SOFITRQ_OFFSET)
		return 1;
	if (preempt & HARDIRQ_MASK)
		return 2;
	return 3;
}

static int adj_context_loglevel(int level)
{
	int ctx = __printing_context();
	int cpu_level = this_cpu_read(cpu_loglevels[ctx]);

	// this one is important
	if (level == LOGLEVEL_SCHED)
		return level;
	// we are not in emergency context
	if (cpu_level == LOGLEVEL_DEBUG + 1)
		return level;
	// we better not override these
	if (LOGLEVEL_EMERG <= level && level <= LOGLEVEL_ERR)
		return level;
	return cpu_level;
}

void printk_emergency_enter(int log_level)
{
	int ctx;

	preempt_disable();
	ctx = __printing_context();
	this_cpu_write(cpu_loglevels[ctx], log_level);
}

void printk_emergency_exit(void)
{
	int ctx = __printing_context();

	this_cpu_write(cpu_loglevels[ctx], LOGLEVEL_DEBUG + 1);
	preempt_enable();
}

void vprintk_emit(...)
{
	level = adj_context_loglevel(level);
}
//
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
//
static void __show_stack(struct task_struct *task, unsigned long *sp)
{
	printk();
	...
	printk();
}

void show_stack(struct task_struct *task, unsigned long *sp, int log_level)
{
	printk_emergency_enter(log_level);
	__show_stack(task, sp);
	printk_emergency_exit();
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //

show_stack() never schedules, disabling preemption around it should
not change anything. Should it be interrupted, we will handle it via
preempt count.

printk_emergency_enter(log_level) handles every printk() that
__show_stack() and friends do. Not worse than printk("%s Stack", lvl);
all over the place.

> What I'm going to do - is to fix all build and reported issues, I'll
> send v2 this week and feel free to NAK it, I will forget about those
> patches and won't be offended.

Lovely.
And - no, I'm not going to NAK platform specific changes. Just so you know.

*All* I'm talking about is an alternative, less "go and touch a ton of
platform code" approach. The argument "I patched so many files that I'm
not even going to discuss anything now" is not productive, to say the
least. Hope this clarifies.

	-ss

