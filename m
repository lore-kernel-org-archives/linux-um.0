Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 11 May 2022 13:45:41 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 17/30] tracing: Improve panic/die notifiers
Message-ID: <20220511114541.GC26047@pathway.suse.cz>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-18-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220427224924.592546-18-gpiccoli@igalia.com>
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
Cc: akpm@linux-foundation.org, bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org

On Wed 2022-04-27 19:49:11, Guilherme G. Piccoli wrote:
> Currently the tracing dump_on_oops feature is implemented
> through separate notifiers, one for die/oops and the other
> for panic. With the addition of panic notifier "id", this
> patch makes use of such "id" to unify both functions.
> 
> It also comments the function and changes the priority of the
> notifier blocks, in order they run early compared to other
> notifiers, to prevent useless trace data (like the callback
> names for the other notifiers). Finally, we also removed an
> unnecessary header inclusion.
> 
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9767,38 +9766,46 @@ static __init int tracer_init_tracefs(void)
>  
>  fs_initcall(tracer_init_tracefs);
>  
> -static int trace_panic_handler(struct notifier_block *this,
> -			       unsigned long event, void *unused)
> +/*
> + * The idea is to execute the following die/panic callback early, in order
> + * to avoid showing irrelevant information in the trace (like other panic
> + * notifier functions); we are the 2nd to run, after hung_task/rcu_stall
> + * warnings get disabled (to prevent potential log flooding).
> + */
> +static int trace_die_panic_handler(struct notifier_block *self,
> +				unsigned long ev, void *unused)
>  {
> -	if (ftrace_dump_on_oops)
> +	int do_dump;
> +
> +	if (!ftrace_dump_on_oops)
> +		return NOTIFY_DONE;
> +
> +	switch (ev) {
> +	case DIE_OOPS:
> +		do_dump = 1;
> +		break;
> +	case PANIC_NOTIFIER:
> +		do_dump = 1;
> +		break;

DIE_OOPS and PANIC_NOTIFIER are from different enum.
It feels like comparing apples with oranges here.

IMHO, the proper way to unify the two notifiers is
a check of the @self parameter. Something like:

static int trace_die_panic_handler(struct notifier_block *self,
				unsigned long ev, void *unused)
{
	if (self == trace_die_notifier && val != DIE_OOPS)
		goto out;

	ftrace_dump(ftrace_dump_on_oops);
out:
	return NOTIFY_DONE;
}

Best Regards,
Petr

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

