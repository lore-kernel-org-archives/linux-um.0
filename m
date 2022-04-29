Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH 18/30] notifier: Show function names on notifier routines
 if DEBUG_NOTIFIERS is set
Date: Fri, 29 Apr 2022 16:27:42 +0000
Message-ID: <PH0PR21MB302584B93A9F44AF5BA016EAD7FC9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-19-gpiccoli@igalia.com>
In-Reply-To: <20220427224924.592546-19-gpiccoli@igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bhe@redhat.com" <bhe@redhat.com>, "pmladek@suse.com" <pmladek@suse.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "coresight@lists.linaro.org" <coresight@lists.linaro.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "x86@kernel.org" <x86@kernel.org>, "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "kernel@gpiccoli.net" <kernel@gpiccoli.net>, "halves@canonical.com" <halves@canonical.com>, "fabiomirmar@gmail.com" <fabiomirmar@gmail.com>, "alejandro.j.jimenez@oracle.com" <alejandro.j.jimenez@oracle.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "feng.tang@intel.com" <feng.tang@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "hidehiro.kawai.ez@hitachi.com" <hidehiro.kawai.ez@hitachi.com>, "jgross@suse.com" <jgross@suse.com>, "john.ogness@linutronix.de" <john.ogness@linutronix.de>, "keescook@chromium.org" <keescook@chromium.org>, "luto@kernel.org" <luto@kernel.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "paulmck@kernel.org" <paulmck@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "senozhatsky@chromium.org" <senozhatsky@chromium.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>, vkuznets <vkuznets@redhat.com>, "will@kernel.org" <will@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Xiaoming Ni <nixiaoming@huawei.com>
List-ID: <linux-um.lists.infradead.org>

From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Wednesday, April 27,=
 2022 3:49 PM
>=20
> Currently we have a debug infrastructure in the notifiers file, but
> it's very simple/limited. This patch extends it by:
>=20
> (a) Showing all registered/unregistered notifiers' callback names;
>=20
> (b) Adding a dynamic debug tuning to allow showing called notifiers'
> function names. Notice that this should be guarded as a tunable since
> it can flood the kernel log buffer.
>=20
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Xiaoming Ni <nixiaoming@huawei.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>=20
> We have some design decisions that worth discussing here:
>=20
> (a) First of call, using C99 helps a lot to write clear and concise code,=
 but

s/call/all/

> due to commit 4d94f910e79a ("Kbuild: use -Wdeclaration-after-statement") =
we
> have a warning if mixing variable declarations with code. For this patch =
though,
> doing that makes the code way clear, so decision was to add the debug cod=
e
> inside brackets whenever this warning pops up. We can change that, but th=
at'll
> cause more ifdefs in the same function.
>=20
> (b) In the symbol lookup helper function, we modify the parameter passed =
but
> even more, we return it as well! This is unusual and seems unnecessary, b=
ut was
> the strategy taken to allow embedding such function in the pr_debug() cal=
l.
>=20
> Not doing that would likely requiring 3 symbol_name variables to avoid
> concurrency (registering notifier A while calling notifier B) - we rely i=
n
> local variables as a serialization mechanism.
>=20
> We're open for suggestions in case this design is not appropriate;
> thanks in advance!
>=20
>  kernel/notifier.c | 48 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index ba005ebf4730..21032ebcde57 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -7,6 +7,22 @@
>  #include <linux/vmalloc.h>
>  #include <linux/reboot.h>
>=20
> +#ifdef CONFIG_DEBUG_NOTIFIERS
> +#include <linux/kallsyms.h>
> +
> +/*
> + *	Helper to get symbol names in case DEBUG_NOTIFIERS is set.
> + *	Return the modified parameter is a strategy used to achieve
> + *	the pr_debug() functionality - with this, function is only
> + *	executed if the dynamic debug tuning is effectively set.
> + */
> +static inline char *notifier_name(struct notifier_block *nb, char *sym_n=
ame)
> +{
> +	lookup_symbol_name((unsigned long)(nb->notifier_call), sym_name);
> +	return sym_name;
> +}
> +#endif
> +
>  /*
>   *	Notifier list for kernel code which wants to be called
>   *	at shutdown. This is used to stop any idling DMA operations
> @@ -34,20 +50,41 @@ static int notifier_chain_register(struct notifier_bl=
ock **nl,
>  	}
>  	n->next =3D *nl;
>  	rcu_assign_pointer(*nl, n);
> +
> +#ifdef CONFIG_DEBUG_NOTIFIERS
> +	{
> +		char sym_name[KSYM_NAME_LEN];
> +
> +		pr_info("notifiers: registered %s()\n",
> +			notifier_name(n, sym_name));
> +	}
> +#endif
>  	return 0;
>  }
>=20
>  static int notifier_chain_unregister(struct notifier_block **nl,
>  		struct notifier_block *n)
>  {
> +	int ret =3D -ENOENT;
> +
>  	while ((*nl) !=3D NULL) {
>  		if ((*nl) =3D=3D n) {
>  			rcu_assign_pointer(*nl, n->next);
> -			return 0;
> +			ret =3D 0;
> +			break;
>  		}
>  		nl =3D &((*nl)->next);
>  	}
> -	return -ENOENT;
> +
> +#ifdef CONFIG_DEBUG_NOTIFIERS
> +	if (!ret) {
> +		char sym_name[KSYM_NAME_LEN];
> +
> +		pr_info("notifiers: unregistered %s()\n",
> +			notifier_name(n, sym_name));
> +	}
> +#endif
> +	return ret;
>  }
>=20
>  /**
> @@ -80,6 +117,13 @@ static int notifier_call_chain(struct notifier_block =
**nl,
>  			nb =3D next_nb;
>  			continue;
>  		}
> +
> +		{
> +			char sym_name[KSYM_NAME_LEN];
> +
> +			pr_debug("notifiers: calling %s()\n",
> +				 notifier_name(nb, sym_name));
> +		}
>  #endif
>  		ret =3D nb->notifier_call(nb, val, v);
>=20
> --
> 2.36.0


