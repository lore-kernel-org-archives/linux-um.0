Return-Path: <linux-pm-owner@vger.kernel.org>
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH 02/30] ARM: kexec: Disable IRQs/FIQs also on crash CPUs
 shutdown path
Date: Fri, 29 Apr 2022 16:26:02 +0000
Message-ID: <PH0PR21MB3025F5AADF3CCEF714585912D7FC9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-3-gpiccoli@igalia.com>
In-Reply-To: <20220427224924.592546-3-gpiccoli@igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bhe@redhat.com" <bhe@redhat.com>, "pmladek@suse.com" <pmladek@suse.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "coresight@lists.linaro.org" <coresight@lists.linaro.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "x86@kernel.org" <x86@kernel.org>, "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "kernel@gpiccoli.net" <kernel@gpiccoli.net>, "halves@canonical.com" <halves@canonical.com>, "fabiomirmar@gmail.com" <fabiomirmar@gmail.com>, "alejandro.j.jimenez@oracle.com" <alejandro.j.jimenez@oracle.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "feng.tang@intel.com" <feng.tang@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "hidehiro.kawai.ez@hitachi.com" <hidehiro.kawai.ez@hitachi.com>, "jgross@suse.com" <jgross@suse.com>, "john.ogness@linutronix.de" <john.ogness@linutronix.de>, "keescook@chromium.org" <keescook@chromium.org>, "luto@kernel.org" <luto@kernel.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "paulmck@kernel.org" <paulmck@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "senozhatsky@chromium.org" <senozhatsky@chromium.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>, vkuznets <vkuznets@redhat.com>, "will@kernel.org" <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Russell King <linux@armlinux.org.uk>
List-ID: <linux-um.lists.infradead.org>

From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Wednesday, April 27,=
 2022 3:49 PM
>=20
> Currently the regular CPU shutdown path for ARM disables IRQs/FIQs
> in the secondary CPUs - smp_send_stop() calls ipi_cpu_stop(), which
> is responsible for that. This makes sense, since we're turning off
> such CPUs, putting them in an endless busy-wait loop.
>=20
> Problem is that there is an alternative path for disabling CPUs,
> in the form of function crash_smp_send_stop(), used for kexec/panic
> paths. This functions relies in a SMP call that also triggers a

s/functions relies in/function relies on/

> busy-wait loop [at machine_crash_nonpanic_core()], but *without*
> disabling interrupts. This might lead to odd scenarios, like early
> interrupts in the boot of kexec'd kernel or even interrupts in
> other CPUs while the main one still works in the panic path and
> assumes all secondary CPUs are (really!) off.
>=20
> This patch mimics the ipi_cpu_stop() interrupt disable mechanism
> in the crash CPU shutdown path, hence disabling IRQs/FIQs in all
> secondary CPUs in the kexec/panic path as well.
>=20
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  arch/arm/kernel/machine_kexec.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_ke=
xec.c
> index f567032a09c0..ef788ee00519 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -86,6 +86,9 @@ void machine_crash_nonpanic_core(void *unused)
>  	set_cpu_online(smp_processor_id(), false);
>  	atomic_dec(&waiting_for_crash_ipi);
>=20
> +	local_fiq_disable();
> +	local_irq_disable();
> +
>  	while (1) {
>  		cpu_relax();
>  		wfe();
> --
> 2.36.0


