Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v4 0/6] x86/arch_prctl Add ARCH_[GET|SET]_CPUID for controlling the CPUID instruction
Date: Sun, 18 Sep 2016 21:17:12 -0700
Message-Id: <20160919041718.4608-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Dmitry Safonov <dsafonov@virtuozzo.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Len Brown <len.brown@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

rr (http://rr-project.org/), a userspace record-and-replay reverse-
execution debugger, would like to trap and emulate the CPUID instruction.
This would allow us to a) mask away certain hardware features that rr does
not support (e.g. RDRAND) and b) enable trace portability across machines
by providing constant results.

Newer Intel CPUs (Ivy Bridge and later) can fault when CPUID is executed at
CPL > 0.  Expose this capability to userspace as a new pair of arch_prctls,
ARCH_GET_CPUID and ARCH_SET_CPUID, with two values, ARCH_CPUID_ENABLE and
ARCH_CPUID_SIGSEGV.

The following changes have been made since v3:

Patch 1 was split into patches 1-4, patches 2 and 3 became patches 5 and 6, respectively.

Patch 1:
- Use SYSCALL_DEFINE in UML.

Patch 2:
- More descriptive commit message.

Patch 3:
- More decriptive commit message.
- Name the common arch_prctl function do_arch_prctl instead of
  do_arch_prctl_common

Patch 4:
- Move the 32-bit syscall entry point to process_32.c, place the compat
  entry point in process_64.c

Patch 5 (previously Patch 2):
- More descriptive commit message.
- Prefix the #define for the cpuid faulting bit with PLATINFO
- supports_cpuid_faulting returns bool
- Rearrange supports_cpuid_faulting to avoid linebreaks

Patch 6 (previously Patch 3):
- ARCH_GET_CPUID now takes 0 for the second argument, and returns the
  result directly.
- arch_post_exec is now a #define, called from setup_new_exec
- The test now uses errx
- The test now checks that ARCH_GET_CPUID returns ARCH_CPUID_SIGSEGV after
  fork()


