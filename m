Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 6 Nov 2019 23:25:13 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Message-ID: <20191106232512.GU25745@shell.armlinux.org.uk>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106092039.GT4131@hirez.programming.kicks-ass.net>
 <10db6fa1-5b17-ebe6-09e0-6335e09e4db8@arista.com>
 <20191106203440.GH3079@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191106203440.GH3079@worktop.programming.kicks-ass.net>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Dmitry Safonov <dima@arista.com>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ia64@vger.kernel.org, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, James Hogan <jhogan@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Ingo Molnar <mingo@kernel.org>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-xtensa@linux-xtensa.org, Vasily Gorbik <gor@linux.ibm.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, linux-m68k@lists.linux-m68k.org, Stafford Horne <shorne@gmail.com>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>, Douglas Anderson <dianders@chromium.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Will Deacon <will@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Brian Cain <bcain@codeaurora.org>, Christian Borntraeger <borntraeger@de.ibm.com>, kgdb-bugreport@lists.sourceforge.net, linux-snps-arc@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@alien8.de>, Jeff Dike <jdike@addtoit.com>, Steven Rostedt <rostedt@goodmis.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Greentime Hu <green.hu@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>, "David S. Miller" <davem@davemloft.net>, Rich Felker <dalias@libc.org>, Petr Mladek <pmladek@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jonas Bonn <jonas@southpole.se>, Richard Weinberger <richard@nod.at>, x86@kernel.org, clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Mark Salter <msalter@redhat.com>, Albert Ou <aou@eecs.berkeley.edu>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Paul Walmsley <paul.walmsley@sifive.com>, Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Jason Wessel <jason.wessel@windriver.com>, nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org

On Wed, Nov 06, 2019 at 09:34:40PM +0100, Peter Zijlstra wrote:
> I suppose I'm surprised there are backtraces that are not important.
> Either badness happened and it needs printing, or the user asked for it
> and it needs printing.

Or utterly meaningless.

> Perhaps we should be removing backtraces if they're not important
> instead of allowing to print them as lower loglevels?

Definitely!  WARN_ON() is well overused - and as is typical, used
without much thought.  Bound to happen after Linus got shirty about
BUG_ON() being over used.  Everyone just grabbed the next nearest thing
to assert().

As a kind of example, I've recently come across one WARN_ON() in a
driver subsystem (that shall remain nameless at the moment) which very
likely has multiple different devices on a platform.  The WARN_ON()
triggers as a result of a problem with the hardware, but because it's a
WARN_ON(), you've no idea which device has a problem.  The backtrace is
mostly meaningless.  So you know that a problem has occurred, but the
kernel prints *useless* backtrace to let you know, and totally omits
the *useful* information.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

