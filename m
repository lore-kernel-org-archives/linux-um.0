Return-Path: <linux+geert=linux-m68k.org@armlinux.org.uk>
Date: Fri, 8 Nov 2019 17:30:45 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Message-ID: <20191108173045.GY25745@shell.armlinux.org.uk>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106092039.GT4131@hirez.programming.kicks-ass.net>
 <10db6fa1-5b17-ebe6-09e0-6335e09e4db8@arista.com>
 <20191106203440.GH3079@worktop.programming.kicks-ass.net>
 <CAGrbwDRgX1BZoFrVYSXhAeeUKHrB=q3w8jXFPOuRvO7HV4Ciqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGrbwDRgX1BZoFrVYSXhAeeUKHrB=q3w8jXFPOuRvO7HV4Ciqw@mail.gmail.com>
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Dmitry Safonov <dima@arista.com>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Albert Ou <aou@eecs.berkeley.edu>, Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Greentime Hu <green.hu@gmail.com>, Ingo Molnar <mingo@redhat.com>, James Hogan <jhogan@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Burton <paulburton@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon <will@kernel.org>, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>, linux-alpha@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, clang-built-linux@googlegroups.com, Catalin Marinas <catalin.marinas@arm.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, uclinux-h8-devel@lists.sourceforge.jp, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org, Jonas Bonn <jonas@southpole.se>, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net
List-ID: <linux-um.lists.infradead.org>

On Fri, Nov 08, 2019 at 04:28:30PM +0000, Dmitry Safonov wrote:
> On 11/6/19 8:34 PM, Peter Zijlstra wrote:
> > On Wed, Nov 06, 2019 at 04:27:33PM +0000, Dmitry Safonov wrote:
> [..]
> >> Sorry, I should have tried to describe better.
> >>
> >> I'm trying to remove external users of console_loglevel by following
> >> reasons:
> >
> > I suppose since all my machines have 'debug ignore_loglevel
> > earlyprintk=serial,ttyS0,115200 console=ttyS0,115200' I don't have this
> > experience.
> 
> Yeah, I remember you avoid all those functionalities of printk(), fair
> enough. On the other side, regular users and I'm betting most of
> the non-tuned distributions use /proc/sys/kernel/printk by default.
> (Checking on my Arch & Fedora - loglevel 4 from the box)
> 
> >> - changing console_loglevel on SMP means that unwanted messages from
> >> other CPUs will appear (that have lower log level)
> >> - on UMP unwanted messages may appear if the code is preempted while it
> >> hasn't set the console_loglevel back to old
> >> - rising console_loglevel to print wanted message(s) may not work at all
> >> if printk() has being delayed and the console_loglevel is already set
> >> back to old value
> >
> > Sure, frobbing the global console_loglevel is bad.
> >
> >> I also have patches in wip those needs to print backtrace with specific
> >> loglevel (higher when it's critical, lower when it's notice and
> >> shouldn't go to serial console).
> >
> > (everything always should go to serial, serial is awesome :-)
> 
> Personally I agree. Unfortunately, here @Arista there are switches (I'm
> speaking about the order of thousands at least) those have baud-rate 9600.
> It's a bit expensive being elaborate with such setup.
> 
> >> Besides on local tests I see hits those have headers (messages like
> >> "Backtrace: ") without an actual backtrace and the reverse - a backtrace
> >> without a reason for it. It's quite annoying and worth addressing by
> >> syncing headers log levels to backtraces.
> >
> > I suppose I'm surprised there are backtraces that are not important.
> > Either badness happened and it needs printing, or the user asked for it
> > and it needs printing.
> >
> > Perhaps we should be removing backtraces if they're not important
> > instead of allowing to print them as lower loglevels?
> 
> Well, the use-case for lower log-level is that everything goes into logs
> (/var/log/dmesg or /var/log/messages whatever rsyslog has settting).
> 
> That has it's value:
> - after a failure (i.e. panic) messages, those were only signs that
> something goes wrong can be seen in logs which can give ideas what has
> happened.

No they don't.  When the kernel panics, userspace generally stops
running, so rsyslog won't be able to write them to /var/log/messages.

How, by "kernel panics" I mean a real kernel panic, which probably
isn't what you're talking about there.  You are probably talking
about the whole shebang of non-fatal kernel oops, kernel warnings
and the like.  If so, I'd ask you to stop confuzzilating terminology.

If you really want to capture such events, then you need to have the
kernel write the panic to (e.g.) flash - see the mtdoops driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

