Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201611110907.5NXaqPNp%fengguang.wu@intel.com>
References: <20161110234055.8654-7-khuey@kylehuey.com> <201611110907.5NXaqPNp%fengguang.wu@intel.com>
From: Kyle Huey <me@kylehuey.com>
Date: Thu, 10 Nov 2016 17:31:40 -0800
Message-ID: <CAP045AoR2rrvK=m-tfgrGYea9kh_mvVZpPbh3ztd6ogW_Hmh1g@mail.gmail.com>
Subject: Re: [PATCH v11 6/7] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, open list <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Nov 10, 2016 at 5:25 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Kyle,
>
> [auto build test ERROR on ]
>
> url:    https://github.com/0day-ci/linux/commits/Kyle-Huey/x86-arch_prctl-64-Use-SYSCALL_DEFINE2-to-define-sys_arch_prctl/20161111-074631
> base:
> config: x86_64-randconfig-i0-201645 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    arch/x86/built-in.o: In function `set_cpuid_faulting':
>>> process.c:(.text+0xe78e): undefined reference to `msr_misc_features_enables_shadow'
>    process.c:(.text+0xe7a3): undefined reference to `msr_misc_features_enables_shadow'
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Looks like the msr_misc_features_enables_shadow definition needs move
back into process.c (from intel.c).  I'll fix that locally.

- Kyle

