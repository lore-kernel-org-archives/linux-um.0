Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v8 7/7] KVM: x86: virtualize cpuid faulting
References: <20161101013749.4003-1-khuey@kylehuey.com>
 <20161101013749.4003-8-khuey@kylehuey.com>
 <273805880.9973234.1478010366977.JavaMail.zimbra@redhat.com>
 <alpine.DEB.2.20.1611011233100.14687@nanos>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b51938b-aa81-6bc5-2d66-0ef8c17dafdf@redhat.com>
Date: Tue, 1 Nov 2016 23:51:46 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1611011233100.14687@nanos>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kyle Huey <me@kylehuey.com>, Robert O'Callahan <robert@ocallahan.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>



On 01/11/2016 19:33, Thomas Gleixner wrote:
> On Tue, 1 Nov 2016, Paolo Bonzini wrote:
> 
>>
>>> +	vcpu->arch.cpuid_fault = false;
>>
>> This should be conditional on "if (!init_event)".  Most MSRs are untouched
>> on an INIT IPI.
>>
>> Otherwise looks good.  The patch is independent of the rest, so I would
>> prefer to take it through the KVM tree.
>>
> 
> It depends on the FEATURE_ENABLES MSR define, which is part of that series.

Sure, I usually time my pull request anyway so that generic arch stuff
goes in first (KVM comes after architectures in linux-next, too).  If
only the first 6 patches are included in tip, I can handle the seventh
myself.

Paolo

