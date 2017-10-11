Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAP045AoC+z73gkAShdkxQyY0FV0m+eW+sLH73Rvjq7wjwX2ytA@mail.gmail.com>
References: <20170320081628.18952-1-khuey@kylehuey.com> <20170320081628.18952-10-khuey@kylehuey.com>
 <CANRm+Cys9jhHr6uWkUkUbAqFPQid1AkERG2-j1qt4-VNTkqjQg@mail.gmail.com> <CAP045AoC+z73gkAShdkxQyY0FV0m+eW+sLH73Rvjq7wjwX2ytA@mail.gmail.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 11 Oct 2017 14:25:57 +0800
Message-ID: <CANRm+CyfBNY-BUGgCDkxK0pq-bocw8hib_DJ=FstJ5RqzT2LSA@mail.gmail.com>
Subject: Re: [PATCH v16 09/10] x86/arch_prctl: Selftest for ARCH_[GET|SET]_CPUID
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2017-10-11 11:56 GMT+08:00 Kyle Huey <me@kylehuey.com>:
> On Tue, Oct 10, 2017 at 8:35 PM, Wanpeng Li <kernellwp@gmail.com> wrote:
>> Hi Kyle,
>> 2017-03-20 16:16 GMT+08:00 Kyle Huey <me@kylehuey.com>:
>>> Test disabling and reenabling the cpuid instruction via the new arch_prctl
>>> ARCH_SET_CPUID, retrieving the current state via ARCH_GET_CPUID, and the
>>> expected behaviors across fork() and exec().
>>>
>>> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
>>> ---
>>>  tools/testing/selftests/x86/Makefile      |   2 +-
>>>  tools/testing/selftests/x86/cpuid_fault.c | 251 ++++++++++++++++++++++++++++++
>>
>> I'm not sure why this commit is not merged to upstream. I test
>> 4.14-rc3 w/ this testcase on a haswell client, however I encounter the
>> below splat, any idea?
>
> Thanks for pointing out that this never got merged.  That's quite
> disappointing, especially after reviewers insisted I write this test.
>
> The failure you're seeing is because the values of ARCH_GET_CPUID and
> ARCH_SET_CPUID changed and the values hardcoded in the test are no
> longer accurate.  If you set them to the correct values (0x1011 and
> 0x1012 respectively) the test should pass.

It works, thanks Kyle.

Regards,
Wanpeng Li

