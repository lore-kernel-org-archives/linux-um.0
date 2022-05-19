Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <edbaa4fa-561c-6f5e-f2ab-43ae68acaede@igalia.com>
Date: Thu, 19 May 2022 09:19:31 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 19/30] panic: Add the panic hypervisor notifier list
Content-Language: en-US
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com> <YoJZVZl/MH0KiE/J@alley>
 <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com> <YoOpyW1+q+Z5as78@alley>
 <d72b9aab-675c-ac89-b73a-b1de4a0b722d@igalia.com>
 <81878a67-21f1-fee8-1add-f381bc8b05df@broadcom.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <81878a67-21f1-fee8-1add-f381bc8b05df@broadcom.com>
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
To: Scott Branden <scott.branden@broadcom.com>, Petr Mladek <pmladek@suse.com>, Sebastian Reichel <sre@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Desmond yan <desmond.yan@broadcom.com>
Cc: David Gow <davidgow@google.com>, Evan Green <evgreen@chromium.org>, Julius Werner <jwerner@chromium.org>, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, akpm@linux-foundation.org, bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, Andrea Parri <parri.andrea@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Norris <computersforpeace@gmail.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, Dexuan Cui <decui@microsoft.com>, Doug Berger <opendmb@gmail.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hari Bathini <hbathini@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Justin Chen <justinpopo6@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Lee Jones <lee.jones@linaro.org>, Markus Mayer <mmayer@broadcom.com>, Michael Ellerman <mpe@ellerman.id.au>, Mihai Carabas <mihai.carabas@oracle.com>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Shile Zhang <shile.zhang@linux.alibaba.com>, Stephen Hemminger <sthemmin@microsoft.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>, Wei Liu <wei.liu@kernel.org>, zhenwei pi <pizhenwei@bytedance.com>

On 18/05/2022 19:17, Scott Branden wrote:
> Hi Guilherme,
> 
> +Desmond
> [...] 
>>>> I'm afraid it breaks kdump if this device is not reset beforehand - it's
>>>> a doorbell write, so not high risk I think...
>>>>
>>>> But in case the not-reset device can be probed normally in kdump kernel,
>>>> then I'm fine in moving this to the reboot list! I don't have the HW to
>>>> test myself.
>>>
>>> Good question. Well, it if has to be called before kdump then
>>> even "hypervisor" list is a wrong place because is not always
>>> called before kdump.
>> [...]
> We register to the panic notifier so that we can kill the VK card ASAP
> to stop DMAing things over to the host side.  If it is not notified then
> memory may not be frozen when kdump is occurring.
> Notifying the card on panic is also needed to allow for any type of 
> reset to occur.
> 
> So, the only thing preventing moving the notifier later is the chance
> that memory is modified while kdump is occurring.  Or, if DMA is 
> disabled before kdump already then this wouldn't be an issue and the 
> notification to the card (to allow for clean resets) can be done later.

Hi Scott / Desmond, thanks for the detailed answer! Is this adapter
designed to run in x86 only or you have other architectures' use cases?

I'm not expert on that, but I guess whether DMA is "kept" or not depends
a bit if IOMMU is used. IIRC, there was a copy of the DMAR table in
kdump (at least for Intel IOMMU). Also, devices are not properly
quiesced on kdump IIUC, we don't call shutdown/reset handlers, they're
skip due to the crash nature - so there is a risk of devices doing bad
things in the new kernel.

With that said, and given this is a lightweight notifier that ideally
should run ASAP, I'd keep this one in the hypervisor list. We can
"adjust" the semantic of this list to include lightweight notifiers that
reset adapters.

With that said, Petr has a point - not always such list is going to be
called before kdump. So, that makes me think in another idea: what if we
have another list, but not on panic path, but instead in the custom
crash_shutdown()? Drivers could add callbacks there that must execute
before kexec/kdump, no matter what.

Let me know your thoughts Scott / Desmond / Petr and all interested parties.
Cheers,


Guilherme

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

