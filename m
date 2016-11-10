Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v11 0/7] x86/arch_prctl Add ARCH_[GET|SET]_CPUID for controlling the CPUID instruction
Date: Thu, 10 Nov 2016 15:40:48 -0800
Message-Id: <20161110234055.8654-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

rr (http://rr-project.org/), a userspace record-and-replay reverse-
execution debugger, would like to trap and emulate the CPUID instruction.
This would allow us to a) mask away certain hardware features that rr does
not support (e.g. RDRAND) and b) enable trace portability across machines
by providing constant results.

Newer Intel CPUs (Ivy Bridge and later) can fault when CPUID is executed at
CPL > 0. Expose this capability to userspace as a new pair of arch_prctls,
ARCH_GET_CPUID and ARCH_SET_CPUID, with two values, ARCH_CPUID_ENABLE and
ARCH_CPUID_SIGSEGV.

Since v10:
Patch 1: x86/arch_prctl/64: Use SYSCALL_DEFINE2 to define sys_arch_prctl
- Updated commit message.

Patch 2: x86/arch_prctl/64: Rename do_arch_prctl to do_arch_prctl_64
- Updated commit message.
- Moved do_arch_prctl_64() declaration into the other CONFIG_X86_64 block.
- Renamed previously missed 'addr' parameters for arch_prctl functions.

Patch 3: x86/arch_prctl: Add do_arch_prctl_common
- Updated commit message.

Patch 4: x86/syscalls/32: Wire up arch_prctl on x86-32
- Updated commit message.

Patch 5: x86/cpufeature: Detect CPUID faulting support
- Link to document on bugzilla.kernel.org.
- X86_FEATURE_CPUID_FAULT value changed.
- Detection code moved to intel.c, and is broken out into
  init_intel_misc_features_enables().
- PLATINFO_CPUID_FAULT is now MSR_PLATFORM_INFO_CPUID_FAULT.

Patch 6: x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
- msr_misc_features_enable_shadow definition and initialization moved to
  intel.c
- Initializes MSR_MISC_FEATURES_ENABLES to 0.
- CPUID_FAULT_ENABLE[_BIT] is now MSR_MISC_FEATURES_ENABLES_CPUID_FAULT[_BIT].
- Fixed checkpatch.pl errors for fork()s inside the test file.
- Removed unnecessary comment in set_cpuid_mode.

Patch 7:
- Added Reviewed-By David Matlack.
- Changed various MSR constants to match patches 5 and 6.


