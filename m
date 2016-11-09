Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 Nov 2016 14:21:14 +0100
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v10 6/7] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Message-ID: <20161109132114.3ujq2wkhsm4kcytz@pd.tnic>
References: <20161108183956.4521-1-khuey@kylehuey.com>
 <20161108183956.4521-7-khuey@kylehuey.com>
 <alpine.DEB.2.20.1611082007010.3501@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.20.1611082007010.3501@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kyle Huey <me@kylehuey.com>, Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Nov 08, 2016 at 09:06:31PM +0100, Thomas Gleixner wrote:
> The upcoming ring3 mwait stuff can add its magic to tweak that MSR into
> this function.
> 
> Stick the call at the end of init_scattered_cpuid_features() for now. I
> still need to figure out a proper place for it.

So Thomas and I discussed this more on IRC and I think we can get rid
of the MSR iterating in scattered.c and integrate both the R3 MWAIT and
CPUID faulting like this:

---
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fcd484d2bb03..5c38a85af2e7 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -452,6 +457,39 @@ static void intel_bsp_resume(struct cpuinfo_x86 *c)
 	init_intel_energy_perf(c);
 }
 
+static void init_misc_enables(struct cpuinfo_x86 *c)
+{
+	u64 val, misc_en;
+
+	if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &misc_en))
+		return;
+
+	misc_en &= ~MSR_MISC_ENABLES_CPUID_FAULT_ENABLE;
+
+	if (!rdmsrl_safe(MSR_PLATFORM_INFO, &val)) {
+		if (val & PLATINFO_CPUID_FAULT_BIT)
+			set_cpu_cap(c, X86_FEATURE_CPUID_FAULT);
+	}
+
+	wrmsrl(MSR_MISC_FEATURES_ENABLES, misc_en);
+	this_cpu_write(msr_misc_features_enables_shadow, misc_en);
+}
+
 static void init_intel(struct cpuinfo_x86 *c)
 {
 	unsigned int l2 = 0;
@@ -565,6 +603,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 		detect_vmx_virtcap(c);
 
 	init_intel_energy_perf(c);
+
+	init_misc_enables(c);
 }
 
 #ifdef CONFIG_X86_32
---

Please redo your patchset and add the detection to init_intel() like above.

Also, let's call that MSR mask MSR_MISC_ENABLES_CPUID_FAULT_ENABLE like
the rest of the bits in msr-index.h

Thanks.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

