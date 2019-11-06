Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 6 Nov 2019 21:34:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Message-ID: <20191106203440.GH3079@worktop.programming.kicks-ass.net>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106092039.GT4131@hirez.programming.kicks-ass.net>
 <10db6fa1-5b17-ebe6-09e0-6335e09e4db8@arista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10db6fa1-5b17-ebe6-09e0-6335e09e4db8@arista.com>
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
To: Dmitry Safonov <dima@arista.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ia64@vger.kernel.org, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, James Hogan <jhogan@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Ingo Molnar <mingo@kernel.org>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-xtensa@linux-xtensa.org, Vasily Gorbik <gor@linux.ibm.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, linux-m68k@lists.linux-m68k.org, Stafford Horne <shorne@gmail.com>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>, Douglas Anderson <dianders@chromium.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Will Deacon <will@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Brian Cain <bcain@codeaurora.org>, Christian Borntraeger <borntraeger@de.ibm.com>, kgdb-bugreport@lists.sourceforge.net, linux-snps-arc@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@alien8.de>, Jeff Dike <jdike@addtoit.com>, Steven Rostedt <rostedt@goodmis.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Greentime Hu <green.hu@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>, "David S. Miller" <davem@davemloft.net>, Rich Felker <dalias@libc.org>, Petr Mladek <pmladek@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jonas Bonn <jonas@southpole.se>, Richard Weinberger <richard@nod.at>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Mark Salter <msalter@redhat.com>, Albert Ou <aou@eecs.berkeley.edu>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Paul Walmsley <paul.walmsley@sifive.com>, Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Jason Wessel <jason.wessel@windriver.com>, nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org

On Wed, Nov 06, 2019 at 04:27:33PM +0000, Dmitry Safonov wrote:
> Hi Peter,
> 
> On 11/6/19 9:20 AM, Peter Zijlstra wrote:
> > On Wed, Nov 06, 2019 at 03:04:51AM +0000, Dmitry Safonov wrote:
> >> Add log level argument to show_stack().
> >> Done in three stages:
> >> 1. Introducing show_stack_loglvl() for every architecture
> >> 2. Migrating old users with an explicit log level
> >> 3. Renaming show_stack_loglvl() into show_stack()
> >>
> >> Justification:
> >> o It's a design mistake to move a business-logic decision
> >>   into platform realization detail.
> >> o I have currently two patches sets that would benefit from this work:
> >>   Removing console_loglevel jumps in sysrq driver [1]
> >>   Hung task warning before panic [2] - suggested by Tetsuo (but he
> >>   probably didn't realise what it would involve).
> >> o While doing (1), (2) the backtraces were adjusted to headers
> >>   and other messages for each situation - so there won't be a situation
> >>   when the backtrace is printed, but the headers are missing because
> >>   they have lesser log level (or the reverse).
> >> o As the result in (2) plays with console_loglevel for kdb are removed.
> > 
> > I really don't understand that word salad. Why are you doing this?
> > 
> 
> Sorry, I should have tried to describe better.
> 
> I'm trying to remove external users of console_loglevel by following
> reasons:

I suppose since all my machines have 'debug ignore_loglevel
earlyprintk=serial,ttyS0,115200 console=ttyS0,115200' I don't have this
experience.

> - changing console_loglevel on SMP means that unwanted messages from
> other CPUs will appear (that have lower log level)
> - on UMP unwanted messages may appear if the code is preempted while it
> hasn't set the console_loglevel back to old
> - rising console_loglevel to print wanted message(s) may not work at all
> if printk() has being delayed and the console_loglevel is already set
> back to old value

Sure, frobbing the global console_loglevel is bad.

> I also have patches in wip those needs to print backtrace with specific
> loglevel (higher when it's critical, lower when it's notice and
> shouldn't go to serial console).

(everything always should go to serial, serial is awesome :-)

> Besides on local tests I see hits those have headers (messages like
> "Backtrace: ") without an actual backtrace and the reverse - a backtrace
> without a reason for it. It's quite annoying and worth addressing by
> syncing headers log levels to backtraces.

I suppose I'm surprised there are backtraces that are not important.
Either badness happened and it needs printing, or the user asked for it
and it needs printing.

Perhaps we should be removing backtraces if they're not important
instead of allowing to print them as lower loglevels?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

