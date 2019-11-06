Return-Path: <dima@arista.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
From: Dmitry Safonov <dima@arista.com>
Message-ID: <de8a397d-8660-4ace-9626-127debcf43a7@arista.com>
Date: Wed, 6 Nov 2019 16:12:01 +0000
MIME-Version: 1.0
In-Reply-To: <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Albert Ou <aou@eecs.berkeley.edu>, Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Greentime Hu <green.hu@gmail.com>, Ingo Molnar <mingo@redhat.com>, James Hogan <jhogan@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Burton <paulburton@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon <will@kernel.org>, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>, linux-alpha@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, clang-built-linux@googlegroups.com, Catalin Marinas <catalin.marinas@arm.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, uclinux-h8-devel@lists.sourceforge.jp, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org, Jonas Bonn <jonas@southpole.se>, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net
List-ID: <linux-um.lists.infradead.org>

On 11/6/19 8:35 AM, Petr Mladek wrote:
> On Wed 2019-11-06 03:04:51, Dmitry Safonov wrote:
>> Add log level argument to show_stack().
>> Done in three stages:
>> 1. Introducing show_stack_loglvl() for every architecture
>> 2. Migrating old users with an explicit log level
>> 3. Renaming show_stack_loglvl() into show_stack()
>>
>> Justification:
>> o It's a design mistake to move a business-logic decision
>>   into platform realization detail.
>> o I have currently two patches sets that would benefit from this work:
>>   Removing console_loglevel jumps in sysrq driver [1]
> 
> Just to clarify. The problem in sysrq driver is a bit different.
> It modifies console_loglevel to show even less important message
> on the console.
> 
> IMHO, it should be solved by printing the header line with pr_error().
> It is not ideal. A cleaner solution might be to introduce another
> loglevel that will always get pushed to the console. But I am
> not sure if it is worth this single line.

I believe why it's not done - there is a comment in sysrq code that said
the userspace relies on the loglevel of sysrq messages (and may trigger
alerts from emerg/err log level):
  * Raise the apparent loglevel to maximum so that the sysrq header
  * is shown to provide the user with positive feedback.  We do not
  * simply emit this at KERN_EMERG as that would change message
  * routing in the consumers of /proc/kmsg.

But I don't mind any solution.

>>   Hung task warning before panic [2] - suggested by Tetsuo (but he
>>   probably didn't realise what it would involve).
>> o While doing (1), (2) the backtraces were adjusted to headers
>>   and other messages for each situation - so there won't be a situation
>>   when the backtrace is printed, but the headers are missing because
>>   they have lesser log level (or the reverse).
>> o As the result in (2) plays with console_loglevel for kdb are removed.
> 
>> The least important for upstream, but maybe still worth to note that
>> every company I've worked in so far had an off-list patch to print
>> backtrace with the needed log level (but only for the architecture they
>> cared about).
>> If you have other ideas how you will benefit from show_stack() with
>> a log level - please, reply to this cover letter.
> 
> I agree with all the other justification.
> 
> I would add. The backtrace is really useful for debugging. It should
> be possible to print it even in less critical situations.
> 
> I am afraid that many people use WARN() for this purpose. But WARN()
> is not always appropriate. WARN() misuse huts when panic_on_warn
> option is used.

Thanks, Petr.

-- 
          Dmitry

