Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161109094705.wvtyzpz7j7mqcz2x@pd.tnic>
References: <20161108183956.4521-1-khuey@kylehuey.com> <20161108183956.4521-2-khuey@kylehuey.com>
 <20161109094705.wvtyzpz7j7mqcz2x@pd.tnic>
From: Kyle Huey <me@kylehuey.com>
Date: Thu, 10 Nov 2016 10:17:26 -0800
Message-ID: <CAP045AqhtBH87M8L6O7BLq6P9rYNSTgu1sqFOwgcnOc64bRFug@mail.gmail.com>
Subject: Re: [PATCH v10 1/7] x86/arch_prctl/64: Use SYSCALL_DEFINE2 to define sys_arch_prctl
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, open list <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Nov 9, 2016 at 1:47 AM, Borislav Petkov <bp@suse.de> wrote:
> On Tue, Nov 08, 2016 at 10:39:50AM -0800, Kyle Huey wrote:
>
> <--- Add commit message here.
>
>> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
>> ---
>>  arch/x86/kernel/process_64.c | 3 ++-
>>  arch/x86/um/syscalls_64.c    | 3 ++-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> ...
>
>>  void arch_switch_to(struct task_struct *to)
>>  {
>>       if ((to->thread.arch.fs == 0) || (to->mm == NULL))
>>               return;
>>
>> base-commit: e3a00f68e426df24a5fb98956a1bd1b23943aa1e
>
> This looks like some tracking thing. It gets ignored by tools though...

Yeah despite git format-patch generating it, git doesn't automatically
honor it when applying patches.

- Kyle

