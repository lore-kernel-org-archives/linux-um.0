Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 04/30] firmware: google: Convert regular spinlock into
 trylock on panic path
In-Reply-To: <20220510132015.38923cb2@gandalf.local.home>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-5-gpiccoli@igalia.com>
 <CAE=gft5Pq25L4KFoPWbftkPF-JN1ex2yws77mMJ4GQnn9W0L2g@mail.gmail.com>
 <adcf6d0e-c37c-6ede-479e-29959d03d8c0@igalia.com> <YnpOv4hAPV4b+6v4@alley>
 <20220510132015.38923cb2@gandalf.local.home>
Date: Tue, 10 May 2022 21:46:38 +0206
Message-ID: <87h75xkwg9.fsf@jogness.linutronix.de>
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
To: Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Evan Green <evgreen@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, Kees Cook <keescook@chromium.org>, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, senozhatsky@chromium.org, Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, vgoyal@redhat.com, vkuznets@redhat.com, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, David Gow <davidgow@google.com>, Julius Werner <jwerner@chromium.org>

On 2022-05-10, Steven Rostedt <rostedt@goodmis.org> wrote:
>> As already mentioned in the other reply, panic() sometimes stops the
>> other CPUs using NMI, for example, see kdump_nmi_shootdown_cpus().
>> 
>> Another situation is when the CPU using the lock ends in some
>> infinite loop because something went wrong. The system is in
>> an unpredictable state during panic().
>> 
>> I am not sure if this is possible with the code under gsmi_dev.lock
>> but such things really happen during panic() in other subsystems.
>> Using trylock in the panic() code path is a good practice.
>
> I believe that Peter Zijlstra had a special spin lock for NMIs or
> early printk, where it would not block if the lock was held on the
> same CPU. That is, if an NMI happened and paniced while this lock was
> held on the same CPU, it would not deadlock. But it would block if the
> lock was held on another CPU.

Yes. And starting with 5.19 it will be carrying the name that _you_ came
up with (cpu_sync):

printk_cpu_sync_get_irqsave()
printk_cpu_sync_put_irqrestore()

John

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

