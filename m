Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk4tc-007Nwz-Pc
 for linux-um@lists.infradead.org; Thu, 28 Apr 2022 14:13:30 +0000
Received: by mail-il1-x12b.google.com with SMTP id z12so2057543ilp.8
 for <linux-um@lists.infradead.org>; Thu, 28 Apr 2022 07:13:24 -0700 (PDT)
Message-ID: <4cae140c-982a-6b9f-661c-4e0fdfa3297b@ieee.org>
Date: Thu, 28 Apr 2022 09:13:19 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 21/30] panic: Introduce the panic pre-reboot notifier list
Content-Language: en-US
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-22-gpiccoli@igalia.com>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20220427224924.592546-22-gpiccoli@igalia.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Alex Elder <elder@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Chris Zankel <chris@zankel.net>, Christian Borntraeger <borntraeger@linux.ibm.com>, Corey Minyard <minyard@acm.org>, Dexuan Cui <decui@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>, Haiyang Zhang <haiyangz@microsoft.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, James Morse <james.morse@arm.com>, Johannes Berg <johannes@sipsolutions.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Matt Turner <mattst88@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Richard Henderson <rth@twiddle.net>, Richard Weinberger <richard@nod.at>, Robert Richter <rric@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Sven Schnelle <svens@linux.ibm.com>, Tony Luck <tony.luck@intel.com>, Vasily Gorbik <gor@linux.ibm.com>, Wei Liu <wei.liu@kernel.org>

On 4/27/22 5:49 PM, Guilherme G. Piccoli wrote:
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
> 
> Cc: Alex Elder <elder@kernel.org>

For "drivers/net/ipa/ipa_smp2p.c":

Acked-by: Alex Elder <elder@kernel.org>

> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Robert Richter <rric@kernel.org>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 

. . .

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

