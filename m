Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 19 May 2022 09:03:52 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 19/30] panic: Add the panic hypervisor notifier list
Message-ID: <YoXr2AD+Jc/ukUhJ@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com>
 <YoJZVZl/MH0KiE/J@alley>
 <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com>
 <YoOpyW1+q+Z5as78@alley> <YoSnGmBJ3kYs5WMf@alley>
 <fbbd0a8d-2ef4-4a39-4b75-354918e85778@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fbbd0a8d-2ef4-4a39-4b75-354918e85778@igalia.com>
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
Cc: David Gow <davidgow@google.com>, Evan Green <evgreen@chromium.org>, Julius Werner <jwerner@chromium.org>, Scott Branden <scott.branden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, akpm@linux-foundation.org, bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, Andrea Parri <parri.andrea@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Norris <computersforpeace@gmail.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, Dexuan Cui <decui@microsoft.com>, Doug Berger <opendmb@gmail.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hari Bathini <hbathini@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Justin Chen <justinpopo6@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Lee Jones <lee.jones@linaro.org>, Markus Mayer <mmayer@broadcom.com>, Michael Ellerman <mpe@ellerman.id.au>, Mihai Carabas <mihai.carabas@oracle.com>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Shile Zhang <shile.zhang@linux.alibaba.com>, Stephen Hemminger <sthemmin@microsoft.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>, Wei Liu <wei.liu@kernel.org>, zhenwei pi <pizhenwei@bytedance.com>

On Wed 2022-05-18 10:16:20, Guilherme G. Piccoli wrote:
> On 18/05/2022 04:58, Petr Mladek wrote:
> > [...]
> >> I does similar things like kmsg_dump() so it should be called in
> >> the same location (after info notifier list and before kdump).
> >>
> >> A solution might be to put it at these notifiers at the very
> >> end of the "info" list or make extra "dump" notifier list.
> > 
> > I just want to point out that the above idea has problems.
> > Notifiers storing kernel log need to be treated as kmsg_dump().
> > In particular, we would  need to know if there are any.
> > We do not need to call "info" notifier list before kdump
> > when there is no kernel log dumper registered.
> > 
> 
> Notifiers respect the priority concept, which is just a number that
> orders the list addition (and the list is called in order).
> 
> I've used the last position to panic_print() [in patch 25] - one idea
> here is to "reserve" the last position (represented by INT_MIN) for
> notifiers that act like kmsg_dump(). I couldn't find any IIRC, but that
> doesn't prevent us to save this position and comment about that.

I would ignore it for now. If anyone would want to safe the log
then they would need to read it. They will most likely use
the existing kmsg_dump() infastructure. In fact, they should
use it to avoid a code duplication.

Best Regards,
Petr

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

