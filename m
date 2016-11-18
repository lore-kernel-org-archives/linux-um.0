Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161118072723.GA15912@gmail.com>
References: <20161117020610.5302-1-khuey@kylehuey.com> <20161117020610.5302-3-khuey@kylehuey.com>
 <20161118072723.GA15912@gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Fri, 18 Nov 2016 08:39:14 -0800
Message-ID: <CAP045ArxVDmmV7MJZKLABi_qNSqoWJGxhz_a5jpn8HAJqBuDyQ@mail.gmail.com>
Subject: Re: [PATCH v12 2/7] x86/arch_prctl/64: Rename do_arch_prctl to do_arch_prctl_64
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, open list <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Nov 17, 2016 at 11:27 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kyle Huey <me@kylehuey.com> wrote:
>
>> In order to introduce new arch_prctls that are not 64 bit only, rename the
>> existing 64 bit implementation to do_arch_prctl_64(). Also rename the second
>> argument to arch_prctl(), which will no longer always be an address.
>
>>  #ifdef CONFIG_X86_64
>>  void entry_SYSCALL_64(void);
>> +long do_arch_prctl_64(struct task_struct *task, int code, unsigned long arg2);
>>  #endif
>
> Could you please also rename the weirdly named 'code' argument to 'option',
> to be in line with the existing sys_prctl() interface nomenclature?

arch_prctl consistently uses 'code' throughout the kernel and in the
main page.  This renaming should probably be done separately if
desired.

- Kyle

