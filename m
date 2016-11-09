Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 Nov 2016 12:14:53 +0100
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v10 5/7] x86/cpufeature: Detect CPUID faulting support
Message-ID: <20161109111453.hbkm5l6dex5ijh2o@pd.tnic>
References: <20161108183956.4521-1-khuey@kylehuey.com>
 <20161108183956.4521-6-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161108183956.4521-6-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Nov 08, 2016 at 10:39:54AM -0800, Kyle Huey wrote:
> Intel supports faulting on the CPUID instruction beginning with Ivy Bridge.
> When enabled, the processor will fault on attempts to execute the CPUID
> instruction with CPL>0. This will allow a ptracer to emulate the CPUID
> instruction.
> 
> Bit 31 of MSR_PLATFORM_INFO advertises support for this feature. It is
> documented in detail in Section 2.3.2 of
> http://www.intel.com/content/dam/www/public/us/en/documents/application-notes/virtualization-technology-flexmigration-application-note.pdf
> 
> Detect support for this feature and expose it as X86_FEATURE_CPUID_FAULT.
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/asm/cpufeatures.h |  1 +
>  arch/x86/include/asm/msr-index.h   |  2 ++
>  arch/x86/kernel/cpu/scattered.c    | 22 +++++++++++++++++++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index a396292..62962e8 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -184,16 +184,17 @@
>   * Auxiliary flags: Linux defined - For features scattered in various
>   * CPUID levels like 0x6, 0xA etc, word 7.
>   *
>   * Reuse free bits when adding new feature flags!
>   */
>  
>  #define X86_FEATURE_CPB		( 7*32+ 2) /* AMD Core Performance Boost */
>  #define X86_FEATURE_EPB		( 7*32+ 3) /* IA32_ENERGY_PERF_BIAS support */
> +#define X86_FEATURE_CPUID_FAULT ( 7*32+ 4) /* Intel CPUID faulting */

Bit 0 in that leaf is free. Also, bit 4 is already claimed by RDT/CAT/...
whatever that thing is going to be called so please do:

#define X86_FEATURE_CPUID_FAULT ( 7*32+ 0) /* Intel CPUID faulting */

>  
>  #define X86_FEATURE_HW_PSTATE	( 7*32+ 8) /* AMD HW-PState */
>  #define X86_FEATURE_PROC_FEEDBACK ( 7*32+ 9) /* AMD ProcFeedbackInterface */
>  
>  #define X86_FEATURE_INTEL_PT	( 7*32+15) /* Intel Processor Trace */
>  #define X86_FEATURE_AVX512_4VNNIW (7*32+16) /* AVX-512 Neural Network Instructions */
>  #define X86_FEATURE_AVX512_4FMAPS (7*32+17) /* AVX-512 Multiply Accumulation Single precision */

...

>  	for (cb = cpuid_bits; cb->feature; cb++) {
>  
>  		/* Verify that the level is valid */
>  		max_level = cpuid_eax(cb->level & 0xffff0000);
>  		if (max_level < cb->level ||
>  		    max_level > (cb->level | 0xffff))
>  			continue;
>  
>  		cpuid_count(cb->level, cb->sub_leaf, &regs[CR_EAX],
>  			    &regs[CR_EBX], &regs[CR_ECX], &regs[CR_EDX]);
>  
>  		if (regs[cb->reg] & (1 << cb->bit))
>  			set_cpu_cap(c, cb->feature);
>  	}
> +
> +	for (mb = msr_bits; mb->feature; mb++) {
> +		if (rdmsrl_safe(mb->msr, &msrval))
> +			continue;

<--- newline here.

> +		if (msrval & (1ULL << mb->bit))

		if (msrval & BIT_ULL(mb->bit))


> +			set_cpu_cap(c, mb->feature);
> +	}
>  }
> -- 

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

