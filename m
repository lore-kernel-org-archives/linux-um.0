Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 Nov 2016 14:34:14 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v10 6/7] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
In-Reply-To: <20161109132114.3ujq2wkhsm4kcytz@pd.tnic>
Message-ID: <alpine.DEB.2.20.1611091425042.3501@nanos>
References: <20161108183956.4521-1-khuey@kylehuey.com> <20161108183956.4521-7-khuey@kylehuey.com> <alpine.DEB.2.20.1611082007010.3501@nanos> <20161109132114.3ujq2wkhsm4kcytz@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: Kyle Huey <me@kylehuey.com>, Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, 9 Nov 2016, Borislav Petkov wrote:

> On Tue, Nov 08, 2016 at 09:06:31PM +0100, Thomas Gleixner wrote:
> > The upcoming ring3 mwait stuff can add its magic to tweak that MSR into
> > this function.
> > 
> > Stick the call at the end of init_scattered_cpuid_features() for now. I
> > still need to figure out a proper place for it.
> 
> So Thomas and I discussed this more on IRC and I think we can get rid
> of the MSR iterating in scattered.c and integrate both the R3 MWAIT and
> CPUID faulting like this:

I agree mostly.
 
> ---
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index fcd484d2bb03..5c38a85af2e7 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -452,6 +457,39 @@ static void intel_bsp_resume(struct cpuinfo_x86 *c)
>  	init_intel_energy_perf(c);
>  }
>  
> +static void init_misc_enables(struct cpuinfo_x86 *c)
> +{
> +	u64 val, misc_en;
> +
> +	if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &misc_en))
> +		return;
> +
> +	misc_en &= ~MSR_MISC_ENABLES_CPUID_FAULT_ENABLE;

I rather prefer to write this MSR to 0 right away and just enable the bits
which we really support.

Whatever Intel comes up with next, e.g. faulting of random other
instructions or whatever (mis)feature they think is valuable, will lead to
a debugging nightmare if some incompetent BIOS writer sets the bit and the
kernel does not know about it.

Yes, I know that there might be bits forced to 1 at some point in the
future, but let's deal with that when it happens.

Right now I can enable the CPUID FAULT bit on my broadwell and watch user
space programs die unexpectedly without a hint why. Simply because it's not
documented in the SDM. So we rather be safe than surprised.

@hpa: Thoughts?

Thanks,

	tglx

