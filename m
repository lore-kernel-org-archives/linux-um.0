Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
Subject: Re: [PATCH 24/30] panic: Refactor the panic path
Date: Mon, 9 May 2022 15:16:08 +0000
Message-ID: <TYAPR01MB6507D01F5694BC33628BB7DB95C69@TYAPR01MB6507.jpnprd01.prod.outlook.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-25-gpiccoli@igalia.com>
In-Reply-To: <20220427224924.592546-25-gpiccoli@igalia.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bhe@redhat.com" <bhe@redhat.com>, "pmladek@suse.com" <pmladek@suse.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "coresight@lists.linaro.org" <coresight@lists.linaro.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "x86@kernel.org" <x86@kernel.org>, "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "kernel@gpiccoli.net" <kernel@gpiccoli.net>, "halves@canonical.com" <halves@canonical.com>, "fabiomirmar@gmail.com" <fabiomirmar@gmail.com>, "alejandro.j.jimenez@oracle.com" <alejandro.j.jimenez@oracle.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "feng.tang@intel.com" <feng.tang@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "mikelley@microsoft.com" <mikelley@microsoft.com>, "hidehiro.kawai.ez@hitachi.com" <hidehiro.kawai.ez@hitachi.com>, "jgross@suse.com" <jgross@suse.com>, "john.ogness@linutronix.de" <john.ogness@linutronix.de>, "keescook@chromium.org" <keescook@chromium.org>, "luto@kernel.org" <luto@kernel.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "paulmck@kernel.org" <paulmck@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "senozhatsky@chromium.org" <senozhatsky@chromium.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, "will@kernel.org" <will@kernel.org>, "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>

Sorry for the delayed response. Unfortunately, I had 10 days holidays
until yesterday...

>  .../admin-guide/kernel-parameters.txt         |  42 ++-
>  include/linux/panic_notifier.h                |   1 +
>  kernel/kexec_core.c                           |   8 +-
>  kernel/panic.c                                | 292 +++++++++++++-----
>  .../selftests/pstore/pstore_crash_test        |   5 +-
>  5 files changed, 252 insertions(+), 96 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3f1cc5e317ed..8d3524060ce3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
...snip...
> @@ -3784,6 +3791,33 @@
>                         timeout < 0: reboot immediately
>                         Format: <timeout>
> 
> +       panic_notifiers_level=
> +                       [KNL] Set the panic notifiers execution order.
> +                       Format: <unsigned int>
> +                       We currently have 4 lists of panic notifiers; based
> +                       on the functionality and risk (for panic success) the
> +                       callbacks are added in a given list. The lists are:
> +                       - hypervisor/FW notification list (low risk);
> +                       - informational list (low/medium risk);
> +                       - pre_reboot list (higher risk);
> +                       - post_reboot list (only run late in panic and after
> +                       kdump, not configurable for now).
> +                       This parameter defines the ordering of the first 3
> +                       lists with regards to kdump; the levels determine
> +                       which set of notifiers execute before kdump. The
> +                       accepted levels are:
> +                       0: kdump is the first thing to run, NO list is
> +                       executed before kdump.
> +                       1: only the hypervisor list is executed before kdump.
> +                       2 (default level): the hypervisor list and (*if*

Hmmm, why are you trying to change default setting?

Based on the current design of kdump, it's natural to put what the
handlers for these level 1 and level 2 handlers do in
machine_crash_shutdown(), as these are necessary by default, right?

Or have you already tried that and figured out it's difficult in some
reason and reached the current design? If so, why is that difficult?
Could you point to if there is already such discussion online?

kdump is designed to perform as little things as possible before
transferring the execution to the 2nd kernel in order to increase
reliability. Just detour to panic() increases risks of kdump failure
in the sense of increasing the executed codes in the abnormal
situation, which is very the note in the explanation of
crash_kexec_post_notifiers.

Also, the current implementation of crash_kexec_post_notifiers uses
the panic notifier, but this is not from the technical
reason. Ideally, it should have been implemented in the context of
crash_kexec() independently of panic().

That is, it looks to me that, in addition to changing design of panic
notifier, you are trying to integrate shutdown code of the crash kexec
and the panic paths. If so, this is a big design change for kdump.
I'm concerned about increase of reliability. I'd like you to discuss
them carefully.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

