Return-Path: <linux-pm-owner@vger.kernel.org>
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH 19/30] panic: Add the panic hypervisor notifier list
Date: Fri, 29 Apr 2022 17:30:44 +0000
Message-ID: <PH0PR21MB30256260CCF4CAB713BBB11ED7FC9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com>
In-Reply-To: <20220427224924.592546-20-gpiccoli@igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bhe@redhat.com" <bhe@redhat.com>, "pmladek@suse.com" <pmladek@suse.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "coresight@lists.linaro.org" <coresight@lists.linaro.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "x86@kernel.org" <x86@kernel.org>, "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "kernel@gpiccoli.net" <kernel@gpiccoli.net>, "halves@canonical.com" <halves@canonical.com>, "fabiomirmar@gmail.com" <fabiomirmar@gmail.com>, "alejandro.j.jimenez@oracle.com" <alejandro.j.jimenez@oracle.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "feng.tang@intel.com" <feng.tang@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "hidehiro.kawai.ez@hitachi.com" <hidehiro.kawai.ez@hitachi.com>, "jgross@suse.com" <jgross@suse.com>, "john.ogness@linutronix.de" <john.ogness@linutronix.de>, "keescook@chromium.org" <keescook@chromium.org>, "luto@kernel.org" <luto@kernel.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "paulmck@kernel.org" <paulmck@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "senozhatsky@chromium.org" <senozhatsky@chromium.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>, vkuznets <vkuznets@redhat.com>, "will@kernel.org" <will@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Andrea Parri <parri.andrea@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Norris <computersforpeace@gmail.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Gow <davidgow@google.com>, "David S. Miller" <davem@davemloft.net>, Dexuan Cui <decui@microsoft.com>, Doug Berger <opendmb@gmail.com>, Evan Green <evgreen@chromium.org>, Florian Fainelli <f.fainelli@gmail.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hari Bathini <hbathini@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Julius Werner <jwerner@chromium.org>, Justin Chen <justinpopo6@gmail.com>, KY Srinivasan <kys@microsoft.com>, Lee Jones <lee.jones@linaro.org>, Markus Mayer <mmayer@broadcom.com>, Michael Ellerman <mpe@ellerman.id.au>, Mihai Carabas <mihai.carabas@oracle.com>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Scott Branden <scott.branden@broadcom.com>, Sebastian Reichel <sre@kernel.org>, Shile Zhang <shile.zhang@linux.alibaba.com>, Stephen Hemminger <sthemmin@microsoft.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>, Wei Liu <wei.liu@kernel.org>, zhenwei pi <pizhenwei@bytedance.com>
List-ID: <linux-um.lists.infradead.org>

From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Wednesday, April 27,=
 2022 3:49 PM
>=20
> The goal of this new panic notifier is to allow its users to register
> callbacks to run very early in the panic path. This aims hypervisor/FW
> notification mechanisms as well as simple LED functions, and any other
> simple and safe mechanism that should run early in the panic path; more
> dangerous callbacks should execute later.
>=20
> For now, the patch is almost a no-op (although it changes a bit the
> ordering in which some panic notifiers are executed). In a subsequent
> patch, the panic path will be refactored, then the panic hypervisor
> notifiers will effectively run very early in the panic path.
>=20
> We also defer documenting it all properly in the subsequent refactor
> patch. While at it, we removed some useless header inclusions and
> fixed some notifiers return too (by using the standard NOTIFY_DONE).
>=20
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: David Gow <davidgow@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Doug Berger <opendmb@gmail.com>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Justin Chen <justinpopo6@gmail.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Markus Mayer <mmayer@broadcom.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Cc: Mihai Carabas <mihai.carabas@oracle.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Scott Branden <scott.branden@broadcom.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Shile Zhang <shile.zhang@linux.alibaba.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Wang ShaoBo <bobo.shaobowang@huawei.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: zhenwei pi <pizhenwei@bytedance.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  arch/mips/sgi-ip22/ip22-reset.c          | 2 +-
>  arch/mips/sgi-ip32/ip32-reset.c          | 3 +--
>  arch/powerpc/kernel/setup-common.c       | 2 +-
>  arch/sparc/kernel/sstate.c               | 3 +--
>  drivers/firmware/google/gsmi.c           | 4 ++--
>  drivers/hv/vmbus_drv.c                   | 4 ++--
>  drivers/leds/trigger/ledtrig-activity.c  | 4 ++--
>  drivers/leds/trigger/ledtrig-heartbeat.c | 4 ++--
>  drivers/misc/bcm-vk/bcm_vk_dev.c         | 6 +++---
>  drivers/misc/pvpanic/pvpanic.c           | 4 ++--
>  drivers/power/reset/ltc2952-poweroff.c   | 4 ++--
>  drivers/s390/char/zcore.c                | 5 +++--
>  drivers/soc/bcm/brcmstb/pm/pm-arm.c      | 2 +-
>  include/linux/panic_notifier.h           | 1 +
>  kernel/panic.c                           | 4 ++++
>  15 files changed, 28 insertions(+), 24 deletions(-)

[ snip]

>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index f37f12d48001..901b97034308 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1614,7 +1614,7 @@ static int vmbus_bus_init(void)
>  			hv_kmsg_dump_register();
>=20
>  		register_die_notifier(&hyperv_die_report_block);
> -		atomic_notifier_chain_register(&panic_notifier_list,
> +		atomic_notifier_chain_register(&panic_hypervisor_list,
>  						&hyperv_panic_report_block);
>  	}
>=20
> @@ -2843,7 +2843,7 @@ static void __exit vmbus_exit(void)
>  	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
>  		kmsg_dump_unregister(&hv_kmsg_dumper);
>  		unregister_die_notifier(&hyperv_die_report_block);
> -		atomic_notifier_chain_unregister(&panic_notifier_list,
> +		atomic_notifier_chain_unregister(&panic_hypervisor_list,
>  						&hyperv_panic_report_block);
>  	}
>=20

Using the hypervisor_list here produces a bit of a mismatch.  In many cases
this notifier will do nothing, and will defer to the kmsg_dump() mechanism
to notify the hypervisor about the panic.   Running the kmsg_dump()
mechanism is linked to the info_list, so I'm thinking the Hyper-V panic rep=
ort
notifier should be on the info_list as well.  That way the reporting behavi=
or
is triggered at the same point in the panic path regardless of which
reporting mechanism is used.




