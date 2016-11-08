Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 8 Nov 2016 21:06:31 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v10 6/7] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
In-Reply-To: <20161108183956.4521-7-khuey@kylehuey.com>
Message-ID: <alpine.DEB.2.20.1611082007010.3501@nanos>
References: <20161108183956.4521-1-khuey@kylehuey.com> <20161108183956.4521-7-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, 8 Nov 2016, Kyle Huey wrote:
> Intel supports faulting on the CPUID instruction beginning with Ivy Bridge.
> When enabled, the processor will fault on attempts to execute the CPUID
> instruction with CPL>0. Exposing this feature to userspace will allow a
> ptracer to trap and emulate the CPUID instruction.
> 
> When supported, this feature is controlled by toggling bit 0 of
> MSR_MISC_FEATURES_ENABLES. It is documented in detail in Section 2.3.2 of
> http://www.intel.com/content/dam/www/public/us/en/documents/application-notes/virtualization-technology-flexmigration-application-note.pdf

See previous mail.

> +DECLARE_PER_CPU(u64, msr_misc_features_enables_shadow);
> +
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index 97a340d..7d364e4 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -71,9 +71,14 @@ void init_scattered_cpuid_features(struct cpuinfo_x86 *c)
>  	}
>  
>  	for (mb = msr_bits; mb->feature; mb++) {
>  		if (rdmsrl_safe(mb->msr, &msrval))
>  			continue;
>  		if (msrval & (1ULL << mb->bit))
>  			set_cpu_cap(c, mb->feature);
>  	}
> +
> +	if (cpu_has(c, X86_FEATURE_CPUID_FAULT)) {
> +		rdmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
> +		this_cpu_write(msr_misc_features_enables_shadow, msrval);
> +	}

I'm not really happy about this placement. There is more stuff coming up
which affects that MSR, so we should have a central place to handle it.

The most obvious is here:

> +DEFINE_PER_CPU(u64, msr_misc_features_enables_shadow);

void msr_misc_features_enable_init(struct cpuinfo_x86 *c)
{
	u64 val;

	if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, val))
		return;

	this_cpu_write(msr_misc_features_enables_shadow, val);
}

The upcoming ring3 mwait stuff can add its magic to tweak that MSR into
this function.

Stick the call at the end of init_scattered_cpuid_features() for now. I
still need to figure out a proper place for it.

> +static int set_cpuid_mode(struct task_struct *task, unsigned long val)
> +{
> +	/* Only disable_cpuid() if it is supported on this hardware. */

That comment makes no sense.

> +	if (!static_cpu_has(X86_FEATURE_CPUID_FAULT))
> +		return -ENODEV;

Thanks,

	tglx

