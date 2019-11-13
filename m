Return-Path: <sergey.senozhatsky.work@gmail.com>
Date: Wed, 13 Nov 2019 11:51:50 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Message-ID: <20191113025150.GA101113@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <13e72b62-c842-8ed5-5b41-bc1692b28f53@arista.com>
 <20191112021747.GA68506@google.com>
 <25cb9647-007a-9c18-4784-49c0aef4f54b@arista.com>
 <20191112042546.GA119579@google.com>
 <d828cb62-aeea-4d67-33ba-b3a93ea10a3d@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d828cb62-aeea-4d67-33ba-b3a93ea10a3d@arista.com>
To: Dmitry Safonov <dima@arista.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Albert Ou <aou@eecs.berkeley.edu>, Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Greentime Hu <green.hu@gmail.com>, Ingo Molnar <mingo@redhat.com>, James Hogan <jhogan@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Burton <paulburton@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon <will@kernel.org>, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>, linux-alpha@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, clang-built-linux@googlegroups.com, Catalin Marinas <catalin.marinas@arm.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, uclinux-h8-devel@lists.sourceforge.jp, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org, Jonas Bonn <jonas@southpole.se>, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net
List-ID: <linux-um.lists.infradead.org>

On (19/11/13 02:41), Dmitry Safonov wrote:
[..]
> 
> I don't strongly disagree, but if you look at those results:
> git grep 'printk("%s.*", \(lvl\|level\)'
> 
> it seems to be used in quite a few places.

Yes, you are right, it is used in some places. That's why I said
that I'd prefer to keep that number low (minimize it). But it's
not 0 (that ship has sailed).

	-ss

