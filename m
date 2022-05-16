Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqdGh-008rYn-Dk
 for linux-um@lists.infradead.org; Mon, 16 May 2022 16:08:25 +0000
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-e5e433d66dso20712680fac.5
 for <linux-um@lists.infradead.org>; Mon, 16 May 2022 09:08:22 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com.
 [209.85.167.176]) by smtp.gmail.com with ESMTPSA id
 k19-20020a056870571300b000f169cbbb32sm4715596oap.43.2022.05.16.09.08.21
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 09:08:21 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id i66so19120286oia.11
 for <linux-um@lists.infradead.org>; Mon, 16 May 2022 09:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com>
 <YoJZVZl/MH0KiE/J@alley> <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com>
In-Reply-To: <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 16 May 2022 09:02:10 -0700
Message-ID: <CAE=gft7ds+dHfEkRz8rnSH1EbTpGTpKbi5Wxj9DW0Jr5mX_j4w@mail.gmail.com>
Subject: Re: [PATCH 19/30] panic: Add the panic hypervisor notifier list
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
Cc: Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>, Julius Werner <jwerner@chromium.org>, Scott Branden <scott.branden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Sebastian Reichel <sre@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, Kees Cook <keescook@chromium.org>, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, vgoyal@redhat.com, vkuznets@redhat.com, Will Deacon <will@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Andrea Parri <parri.andrea@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Norris <computersforpeace@gmail.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, Dexuan Cui <decui@microsoft.com>, Doug Berger <opendmb@gmail.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hari Bathini <hbathini@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Justin Chen <justinpopo6@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Lee Jones <lee.jones@linaro.org>, Markus Mayer <mmayer@broadcom.com>, Michael Ellerman <mpe@ellerman.id.au>, Mihai Carabas <mihai.carabas@oracle.com>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Shile Zhang <shile.zhang@linux.alibaba.com>, Stephen Hemminger <sthemmin@microsoft.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>, Wei Liu <wei.liu@kernel.org>, zhenwei pi <pizhenwei@bytedance.com>, Stephen Boyd <swboyd@chromium.org>

On Mon, May 16, 2022 at 8:07 AM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> Thanks for the review!
>
> I agree with the blinking stuff, I can rework and add all LED/blinking
> stuff into the loop list, it does make sense. I'll comment a bit in the
> others below...
>
> On 16/05/2022 11:01, Petr Mladek wrote:
> > [...]
> >> --- a/arch/mips/sgi-ip22/ip22-reset.c
> >> +++ b/arch/mips/sgi-ip22/ip22-reset.c
> >> @@ -195,7 +195,7 @@ static int __init reboot_setup(void)
> >>      }
> >>
> >>      timer_setup(&blink_timer, blink_timeout, 0);
> >> -    atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
> >> +    atomic_notifier_chain_register(&panic_hypervisor_list, &panic_block);
> >
> > This notifier enables blinking. It is not much safe. It calls
> > mod_timer() that takes a lock internally.
> >
> > This kind of functionality should go into the last list called
> > before panic() enters the infinite loop. IMHO, all the blinking
> > stuff should go there.
> > [...]
> >> --- a/arch/mips/sgi-ip32/ip32-reset.c
> >> +++ b/arch/mips/sgi-ip32/ip32-reset.c
> >> @@ -145,7 +144,7 @@ static __init int ip32_reboot_setup(void)
> >>      pm_power_off = ip32_machine_halt;
> >>
> >>      timer_setup(&blink_timer, blink_timeout, 0);
> >> -    atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
> >> +    atomic_notifier_chain_register(&panic_hypervisor_list, &panic_block);
> >
> > Same here. Should be done only before the "loop".
> > [...]
>
> Ack.
>
>
> >> --- a/drivers/firmware/google/gsmi.c
> >> +++ b/drivers/firmware/google/gsmi.c
> >> @@ -1034,7 +1034,7 @@ static __init int gsmi_init(void)
> >>
> >>      register_reboot_notifier(&gsmi_reboot_notifier);
> >>      register_die_notifier(&gsmi_die_notifier);
> >> -    atomic_notifier_chain_register(&panic_notifier_list,
> >> +    atomic_notifier_chain_register(&panic_hypervisor_list,
> >>                                     &gsmi_panic_notifier);
> >
> > I am not sure about this one. It looks like some logging or
> > pre_reboot stuff.
> >
>
> Disagree here. I'm looping Google maintainers, so they can comment.
> (CCed Evan, David, Julius)
>
> This notifier is clearly a hypervisor notification mechanism. I've fixed
> a locking stuff there (in previous patch), I feel it's low-risk but even
> if it's mid-risk, the class of such callback remains a perfect fit with
> the hypervisor list IMHO.

This logs a panic to our "eventlog", a tiny logging area in SPI flash
for critical and power-related events. In some cases this ends up
being the only clue we get in a Chromebook feedback report that a
panic occurred, so from my perspective moving it to the front of the
line seems like a good idea.

-Evan

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

