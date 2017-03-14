Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v10 6/7] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
References: <20161108183956.4521-1-khuey@kylehuey.com>
 <20161108183956.4521-7-khuey@kylehuey.com>
 <30f2ec3e-d0c8-8dd2-837f-3380237d843c@zytor.com>
 <CAP045AqLAQSu3nsQUuv8v1o_8GP_eTJ1U+JKQM==mDLJa_1J2A@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <1acdafa1-4557-b147-ef67-069886255e6c@zytor.com>
Date: Tue, 14 Mar 2017 13:06:53 -0700
MIME-Version: 1.0
In-Reply-To: <CAP045AqLAQSu3nsQUuv8v1o_8GP_eTJ1U+JKQM==mDLJa_1J2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Huey <me@kylehuey.com>
Cc: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, open list <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 03/14/17 12:08, Kyle Huey wrote:
> 
> That's largely what we ended up doing.  See
> https://lkml.org/lkml/2017/2/14/80 and the latest version of this
> patch, https://lkml.org/lkml/2017/3/11/197.
> 

Yes, as I said, my mistake.

I would still like to see an early-out when none of these flags are set
(I just discussed this with tglx on IRC):

if (likely(!((tifp|tifn) &
	(_TIF_BLOCKSTEP|_TIF_NOTSC|_TIF_IO_BITMAP|
         _TIF_NOCPUID|_TIF_USER_RETURN_NOTIFY))))
	return;

The USER_RETURN_NOTIFY could really use some sanity: it is a notifier
chain with a single in-kernel user, which is KVM on x86 only, but we
most likely will need to propagate the flag even if it ends up getting
specialized.

	-hpa



