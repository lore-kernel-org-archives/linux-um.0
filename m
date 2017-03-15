Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <201703150911.v2F9BsT1004205@mail.zytor.com>
Date: Wed, 15 Mar 2017 02:11:48 -0700
In-Reply-To: <CALCETrXrjDKosaVbq=oBLz-dWLLFom771zMSyZWsCFXxKN__RQ@mail.gmail.com>
References: <20161108183956.4521-1-khuey@kylehuey.com> <20161108183956.4521-7-khuey@kylehuey.com> <30f2ec3e-d0c8-8dd2-837f-3380237d843c@zytor.com> <CALCETrXrjDKosaVbq=oBLz-dWLLFom771zMSyZWsCFXxKN__RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v10 6/7] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Kyle Huey <me@kylehuey.com>, Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, Linux.FS.Devel@zytor.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

<linux-fsdevel@vger.kernel.org>,"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,kvm list <kvm@vger.kernel.org>
From: hpa@zytor.com
Message-ID: <E47D06A9-AFDA-4A9D-8539-9CC5AB19B395@zytor.com>

On March 14, 2017 12:23:40 PM PDT, Andy Lutomirski <luto@amacapital.net> wrote:
>On Tue, Mar 14, 2017 at 12:01 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> and at least theoretically we
>> could be indirecting though the ->stack pointer for every one if gcc
>> can't tell it won't have changed (we really need to get thread_info
>> moved into the task_struct allocation and away from the kernel stack,
>> especially since on x86 the pointer is the same size as the vestigial
>> structure it points to.)
>
>Solved by use of time machine:
>
>commit 15f4eae70d365bba26854c90b6002aaabb18c8aa
>Author: Andy Lutomirski <luto@kernel.org>
>Date:   Tue Sep 13 14:29:25 2016 -0700
>
>    x86: Move thread_info into task_struct
>
>
>:)

My apologies, -ESTALEBRAINCACHE...
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

