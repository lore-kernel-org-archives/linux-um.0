Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 27 Oct 2016 10:21:58 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 5/6] x86/cpufeature: Detect CPUID faulting support
In-Reply-To: <20161019020333.3766-6-khuey@kylehuey.com>
Message-ID: <alpine.DEB.2.20.1610271018180.4817@nanos>
References: <20161019020333.3766-1-khuey@kylehuey.com> <20161019020333.3766-6-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Dmitry Safonov <dsafonov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, 18 Oct 2016, Kyle Huey wrote:
>  
> +static bool supports_cpuid_faulting(void)
> +{
> +	unsigned int lo, hi;
> +
> +	if (rdmsr_safe(MSR_PLATFORM_INFO, &lo, &hi))
> +		return false;
> +
> +	return lo & PLATINFO_CPUID_FAULT;
> +}
> +
>  void init_scattered_cpuid_features(struct cpuinfo_x86 *c)
>  {
>  	u32 max_level;
> @@ -54,4 +64,7 @@ void init_scattered_cpuid_features(struct cpuinfo_x86 *c)
>  		if (regs[cb->reg] & (1 << cb->bit))
>  			set_cpu_cap(c, cb->feature);
>  	}
> +
> +	if (supports_cpuid_faulting())
> +		set_cpu_cap(c, X86_FEATURE_CPUID_FAULT);
>  }

Instead of specific magic for this feature I'd rather like to see something
like the completely untested patch below. That allows us to add MSR based
features trivially in the future.

Thanks,

	tglx

8<------------------------

--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -24,11 +24,18 @@ enum cpuid_regs {
 	CR_EBX
 };
 
+struct msr_bit {
+	u16	feature;
+	u16	msr;
+	u8	bit;
+};
+
 void init_scattered_cpuid_features(struct cpuinfo_x86 *c)
 {
-	u32 max_level;
-	u32 regs[4];
 	const struct cpuid_bit *cb;
+	const struct msr_bit *mb;
+	u32 max_level, regs[4];
+	u64 msrval;
 
 	static const struct cpuid_bit cpuid_bits[] = {
 		{ X86_FEATURE_INTEL_PT,		CR_EBX,25, 0x00000007, 0 },
@@ -42,6 +49,11 @@ void init_scattered_cpuid_features(struc
 		{ 0, 0, 0, 0, 0 }
 	};
 
+	static const struct msr_bit msr_bits[] = {
+		{ X86_FEATURE_CPUID_FAULT,	MSR_PLATFORM_INFO, 31 },
+		{ 0, 0, 0 }
+	};
+
 	for (cb = cpuid_bits; cb->feature; cb++) {
 
 		/* Verify that the level is valid */
@@ -56,4 +68,12 @@ void init_scattered_cpuid_features(struc
 		if (regs[cb->reg] & (1 << cb->bit))
 			set_cpu_cap(c, cb->feature);
 	}
+
+	for (mb = msr_bits; mb->feature; mb++) {
+		if (rdmsrl_safe(mb->msr, &msrval))
+			continue;
+		if (msrval & (1ULL << mb->bit))
+			set_cpu_cap(c, mb->feature);
+	}
+
 }

