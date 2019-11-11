Return-Path: <sergey.senozhatsky.work@gmail.com>
Date: Mon, 11 Nov 2019 10:23:36 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Message-ID: <20191111012336.GA85185@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Albert Ou <aou@eecs.berkeley.edu>, Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Greentime Hu <green.hu@gmail.com>, Ingo Molnar <mingo@redhat.com>, James Hogan <jhogan@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Burton <paulburton@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon <will@kernel.org>, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>, linux-alpha@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, clang-built-linux@googlegroups.com, Catalin Marinas <catalin.marinas@arm.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, uclinux-h8-devel@lists.sourceforge.jp, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org, Jonas Bonn <jonas@southpole.se>, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net
List-ID: <linux-um.lists.infradead.org>

On (19/11/08 14:04), Petr Mladek wrote:
[..]
> I agree that it is complicated to pass the loglevel as
> a parameter. It would be better define the default
> log level for a given code section. It might be stored
> in task_struct for the normal context and in per-CPU
> variables for interrupt contexts.

I do recall that we talked about per-CPU printk state bit which would
start/end "just print it" section. We probably can extend it to "just
log_store" type of functionality. Doesn't look like a very bad idea.
"This task/context is in trouble, whatever it printk()-s is important".

Per-console loglevel also might help sometimes. Slower consoles would
->write() only critical messages, faster consoles everything.

Passing log_level as part of message payload, which printk machinery
magically hides is not entirely exciting. What we have in the code
now - printk("%s blah\n", lvl) - is not what we see in the logs.
Because the leading '%s' becomes special. And printk()/sprintf()
documentation should reflect that: '%s' prints a string, but sometimes
it doesn't.

	-ss

