Return-Path: <SRS0=n35v=ZF=goodmis.org=rostedt@kernel.org>
Date: Wed, 13 Nov 2019 10:44:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Message-ID: <20191113104446.419e4d8a@gandalf.local.home>
In-Reply-To: <20191106232512.GU25745@shell.armlinux.org.uk>
References: <20191106030542.868541-1-dima@arista.com>
	<20191106092039.GT4131@hirez.programming.kicks-ass.net>
	<10db6fa1-5b17-ebe6-09e0-6335e09e4db8@arista.com>
	<20191106203440.GH3079@worktop.programming.kicks-ass.net>
	<20191106232512.GU25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Albert Ou <aou@eecs.berkeley.edu>, Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Greentime Hu <green.hu@gmail.com>, Ingo Molnar <mingo@redhat.com>, James Hogan <jhogan@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Burton <paulburton@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon <will@kernel.org>, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>, linux-alpha@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, clang-built-linux@googlegroups.com, Catalin Marinas <catalin.marinas@arm.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, uclinux-h8-devel@lists.sourceforge.jp, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org, Jonas Bonn <jonas@southpole.se>, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net
List-ID: <linux-um.lists.infradead.org>

On Wed, 6 Nov 2019 23:25:13 +0000
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

> On Wed, Nov 06, 2019 at 09:34:40PM +0100, Peter Zijlstra wrote:
> > I suppose I'm surprised there are backtraces that are not important.
> > Either badness happened and it needs printing, or the user asked for it
> > and it needs printing.  
> 
> Or utterly meaningless.
> 
> > Perhaps we should be removing backtraces if they're not important
> > instead of allowing to print them as lower loglevels?  
> 
> Definitely!  WARN_ON() is well overused - and as is typical, used
> without much thought.  Bound to happen after Linus got shirty about
> BUG_ON() being over used.  Everyone just grabbed the next nearest thing
> to assert().
> 
> As a kind of example, I've recently come across one WARN_ON() in a
> driver subsystem (that shall remain nameless at the moment) which very
> likely has multiple different devices on a platform.  The WARN_ON()
> triggers as a result of a problem with the hardware, but because it's a
> WARN_ON(), you've no idea which device has a problem.  The backtrace is
> mostly meaningless.  So you know that a problem has occurred, but the
> kernel prints *useless* backtrace to let you know, and totally omits
> the *useful* information.
> 

I would like to bring up a topic for the next maintainers summit
(although I may not even be there), that we define a clear use of
WARN_ON(). I use it only if the code does something I do not expect it
to do, and is considered a bug in the code if it triggers. But it
appears that some drivers use it for "oh I didn't realize this hardware
does something I didn't expect". And is ignored when the warn on is
triggered and reported, with "you have buggy hardware" but my hardware
appears to work just fine!

-- Steve

