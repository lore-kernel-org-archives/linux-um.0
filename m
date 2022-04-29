Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-22-gpiccoli@igalia.com>
In-Reply-To: <20220427224924.592546-22-gpiccoli@igalia.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 29 Apr 2022 09:04:39 -0700
Message-ID: <CAMo8BfKzA+oy-Qun9-aO3xCr4Jy_rfdjYqMX=W9xONCSX8O51Q@mail.gmail.com>
Subject: Re: [PATCH 21/30] panic: Introduce the panic pre-reboot notifier list
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
Cc: Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com, Petr Mladek <pmladek@suse.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, netdev <netdev@vger.kernel.org>, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>, xen-devel@lists.xenproject.org, "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, d.hatayama@jp.fujitsu.com, Dave Hansen <dave.hansen@linux.intel.com>, dyoung@redhat.com, feng.tang@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, Kees Cook <keescook@chromium.org>, Andrew Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, paulmck@kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, stern@rowland.harvard.edu, Thomas Gleixner <tglx@linutronix.de>, vgoyal@redhat.com, vkuznets@redhat.com, Will Deacon <will@kernel.org>, Alex Elder <elder@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Chris Zankel <chris@zankel.net>, Christian Borntraeger <borntraeger@linux.ibm.com>, Corey Minyard <minyard@acm.org>, Dexuan Cui <decui@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>, Haiyang Zhang <haiyangz@microsoft.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, James Morse <james.morse@arm.com>, Johannes Berg <johannes@sipsolutions.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Matt Turner <mattst88@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Richard Henderson <rth@twiddle.net>, Richard Weinberger <richard@nod.at>, Robert Richter <rric@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Sven Schnelle <svens@linux.ibm.com>, Tony Luck <tony.luck@intel.com>, Vasily Gorbik <gor@linux.ibm.com>, Wei Liu <wei.liu@kernel.org>

On Wed, Apr 27, 2022 at 3:55 PM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> This patch renames the panic_notifier_list to panic_pre_reboot_list;
> the idea is that a subsequent patch will refactor the panic path
> in order to better split the notifiers, running some of them very
> early, some of them not so early [but still before kmsg_dump()] and
> finally, the rest should execute late, after kdump. The latter ones
> are now in the panic pre-reboot list - the name comes from the idea
> that these notifiers execute before panic() attempts rebooting the
> machine (if that option is set).
>
> We also took the opportunity to clean-up useless header inclusions,
> improve some notifier block declarations (e.g. in ibmasm/heartbeat.c)
> and more important, change some priorities - we hereby set 2 notifiers
> to run late in the list [iss_panic_event() and the IPMI panic_event()]
> due to the risks they offer (may not return, for example).
> Proper documentation is going to be provided in a subsequent patch,
> that effectively refactors the panic path.

[...]

>  arch/xtensa/platforms/iss/setup.c     |  4 ++--For xtensa:

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

