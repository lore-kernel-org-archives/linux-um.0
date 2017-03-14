Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Mar 2017 21:36:22 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v15 6/9] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
In-Reply-To: <20170311194702.28754-7-khuey@kylehuey.com>
Message-ID: <alpine.DEB.2.20.1703142112200.3770@nanos>
References: <20170311194702.28754-1-khuey@kylehuey.com> <20170311194702.28754-7-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, 11 Mar 2017, Kyle Huey wrote:
>  static void init_intel_misc_features(struct cpuinfo_x86 *c)
>  {
>  	u64 msr;
>  
> +	if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &msr))
> +		return;
> +
> +	msr = 0;
> +	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
> +	this_cpu_write(msr_misc_features_shadow, msr);
> +
>  	if (!rdmsrl_safe(MSR_PLATFORM_INFO, &msr)) {
>  		if (msr & MSR_PLATFORM_INFO_CPUID_FAULT)
>  			set_cpu_cap(c, X86_FEATURE_CPUID_FAULT);
>  	}
>  
>  	probe_xeon_phi_r3mwait(c);

The way you are doing it breaks the ring3 mwait feature because you
overwrite the R3MWAIT bit the first time you update the MSR on context
switch.

>  }

What you really want is to fixup the r3mwait part:

static void probe_xeon_phi_r3mwait(c)
{
	....
	if (ring3mwait_disabled)
		return;

	set_cpu_cap(c, X86_FEATURE_RING3MWAIT);
	this_cpu_or(msr_misc_features_shadow,
		    1UL << MSR_MISC_FEATURE_ENABLES_RING3MWAIT_BIT);

	if (c == &boot_cpu_data)
		ELF_HWCAP2 |= HWCAP2_RING3MWAIT;
}

and have a function for cpuid fault:

static void init_cpuid_fault(c)
{
  	if (rdmsrl_safe(MSR_PLATFORM_INFO, &msr))
		return;
	if ((msr & MSR_PLATFORM_INFO_CPUID_FAULT))
		set_cpu_cap(c, X86_FEATURE_CPUID_FAULT);
}

and then do:

static void init_intel_misc_features(struct cpuinfo_x86 *c)
{
  	u64 msr;
  
	if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &msr))
		return;

	/* Clear all MISC features */
	this_cpu_write(msr_misc_features_shadow, 0);

	/* Check the features and update the shadow control bits */
	init_cpuid_fault(c);
	probe_xeon_phi_r3mwait(c);

	msr_write(MSR_MISC_FEATURE_ENABLES,
		  this_cpu_read(msr_misc_features_shadow);
}

Hmm?

Thanks,

	tglx

