Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v13 0/8] x86/arch_prctl Add ARCH_[GET|SET]_CPUID for controlling the CPUID instruction
Date: Sun, 27 Nov 2016 19:05:13 -0800
Message-Id: <20161128030521.4423-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>
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

Since v12:
Patch 4: x86/syscalls/32: Wire up arch_prctl on x86-32
- compat_sys_arch_prctl prototype has argument names.

Patch 5: x86/cpufeature: Detect CPUID faulting support
- s/init_intel_misc_features_enables/init_intel_misc_features/.
- Added Reviewed-by Borislav.

Patch 6: x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
- Selftest was split out into Patch 7.
- s/msr_misc_features_enables_shadow/msr_misc_features_shadow/.
- ARCH_GET_CPUID now returns its value directly, not in an outparam.
- ARCH_SET_CPUID now takes a simple 0/1 value, ARCH_CPUID_ENABLE and
  ARCH_CPUID_SIGSEGV are gone.
- ARCH_[GET|SET]_CPUID now operate on the enabledness of the CPUID
  instruction, not the CPUID faulting bit. Thus the default return
  value of ARCH_GET_CPUID is 1, and calling ARCH_SET_CPUID with 0
  activates CPUID faulting (and thus disabling the CPUID instruction).

Patch 7: x86/arch_prctl: Selftest for ARCH_[GET|SET]_CPUID
- The self test was updated for the API changes.


