Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <5ed2ca7a-5bf3-f101-a1f4-9a320c79f5a0@igalia.com>
Date: Wed, 18 May 2022 10:24:39 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 19/30] panic: Add the panic hypervisor notifier list
Content-Language: en-US
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com> <YoJZVZl/MH0KiE/J@alley>
 <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com>
 <CAE=gft7ds+dHfEkRz8rnSH1EbTpGTpKbi5Wxj9DW0Jr5mX_j4w@mail.gmail.com>
 <YoOi9PFK/JnNwH+D@alley> <b9ec2fc8-216f-f261-8417-77b6dd95e25c@igalia.com>
 <YoShZVYNAdvvjb7z@alley>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YoShZVYNAdvvjb7z@alley>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Evan Green <evgreen@chromium.org>, David Gow <davidgow@google.com>, Julius Werner <jwerner@chromium.org>, Scott Branden <scott.branden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Sebastian Reichel <sre@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, Kees Cook <keescook@chromium.org>, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, vgoyal@redhat.com, vkuznets@redhat.com, Will Deacon <will@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Andrea Parri <parri.andrea@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Norris <computersforpeace@gmail.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, Dexuan Cui <decui@microsoft.com>, Doug Berger <opendmb@gmail.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hari Bathini <hbathini@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Justin Chen <justinpopo6@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Lee Jones <lee.jones@linaro.org>, Markus Mayer <mmayer@broadcom.com>, Michael Ellerman <mpe@ellerman.id.au>, Mihai Carabas <mihai.carabas@oracle.com>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Shile Zhang <shile.zhang@linux.alibaba.com>, Stephen Hemminger <sthemmin@microsoft.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>, Wei Liu <wei.liu@kernel.org>, zhenwei pi <pizhenwei@bytedance.com>, Stephen Boyd <swboyd@chromium.org>

On 18/05/2022 04:33, Petr Mladek wrote:
> [...]
> Anyway, I would distinguish it the following way.
> 
>   + If the notifier is preserving kernel log then it should be ideally
>     treated as kmsg_dump().
> 
>   + It the notifier is saving another debugging data then it better
>     fits into the "hypervisor" notifier list.
> 
>

Definitely, I agree - it's logical, since we want more info in the logs,
and happens some notifiers running in the informational list do that,
like ftrace_on_oops for example.


> Regarding the reliability. From my POV, any panic notifier enabled
> in a generic kernel should be reliable with more than 99,9%.
> Otherwise, they should not be in the notifier list at all.
> 
> An exception would be a platform-specific notifier that is
> called only on some specific platform and developers maintaining
> this platform agree on this.
> 
> The value "99,9%" is arbitrary. I am not sure if it is realistic
> even in the other code, for example, console_flush_on_panic()
> or emergency_restart(). I just want to point out that the border
> should be rather high. Otherwise we would back in the situation
> where people would want to disable particular notifiers.
> 

Totally agree, these percentages are just an example, 50% is ridiculous
low reliability in my example heheh

But some notifiers deep dive in abstraction layers (like regmap or GPIO
stuff) and it's hard to determine the probability of a lock issue (take
a spinlock already taken inside regmap code and live-lock forever, for
example). These are better to run, if possible, later than kdump or even
info list.

Thanks again for the good analysis Petr!
Cheers,


Guilherme



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

