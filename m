Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v16 0/10] x86/arch_prctl Add ARCH_[GET|SET]_CPUID for controlling the CPUID instruction
Date: Mon, 20 Mar 2017 01:16:18 -0700
Message-Id: <20170320081628.18952-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

rr (http://rr-project.org/), a userspace record-and-replay reverse-
execution debugger, would like to trap and emulate the CPUID instruction.
This would allow us to a) mask away certain hardware features that rr does
not support (e.g. RDRAND) and b) enable trace portability across machines
by providing constant results.

Newer Intel CPUs (Ivy Bridge and later) can fault when CPUID is executed at
CPL > 0. Expose this capability to userspace as a new pair of arch_prctls,
ARCH_GET_CPUID and ARCH_SET_CPUID.

Since v15:
All: Patch 1 is new, and patch 2 is what was previously patch 9. What were
patches 1-8 are now 3-10, in the same order.

Patch 1: (NEW) x86/msr: Rename MISC_FEATURE_ENABLES
- While fixing the conflicts with the ring3 mwait feature, I noticed it
  introduced MSR_MISC_FEATURE_ENABLES, not MSR_MISC_FEATURES_ENABLES.
  This is corrected.

Patch 2: x86/arch_prctl: Rename 'code' argument to 'option'
- Previously patch 9/9, now moved to precede all other arch_prctl patches.
- Fixed a stale file location comment in arch/um/include/shared/os.h.

Patch 7: x86/cpufeature: Detect CPUID faulting support
- Split cpuid faulting code into a separate init_cpuid_fault.
- Gate calling both init_cpuid_fault and probe_xeon_phi_r3mwait on
  a successful rdmsrl_safe(MSR_MISC_FEATURES_ENABLES).

Patch 8: x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
- Fix the bug with ring 3 mwait interactions that tglx noted by
  teaching probe_xeon_phi_r3mwait about the new MSR_MISC_FEATURES_ENABLES
  shadow, making init_intel_misc_features responsible for all MSR writes.


