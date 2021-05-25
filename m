Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Waiman Long <llong@redhat.com>
Subject: Re: [PATCH] LOCKDEP: use depends on LOCKDEP_SUPPORT instead of $ARCH
 list
References: <20210517034430.9569-1-rdunlap@infradead.org>
 <YKIXBpxyvhzdb1uv@gmail.com>
 <1284b997-b9da-769f-2d36-4d4232c7df88@redhat.com>
 <bfb11ab2-d606-b96e-1979-3bcc3c3adc96@infradead.org>
 <8a4ee5be-ad5c-ca06-dd1a-aa13ccc94906@redhat.com>
 <c8698ce3-4995-efd6-9d1d-095dcac70dc2@infradead.org>
 <09243238-94ba-caca-441e-3fdac0154822@infradead.org>
Message-ID: <3a0fb04c-c640-25db-7e7a-fbdd3b4defb5@redhat.com>
Date: Mon, 24 May 2021 20:05:51 -0400
MIME-Version: 1.0
In-Reply-To: <09243238-94ba-caca-441e-3fdac0154822@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, Waiman Long <llong@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Johannes Berg <johannes@sipsolutions.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

On 5/24/21 5:41 PM, Randy Dunlap wrote:
> On 5/24/21 2:31 PM, Randy Dunlap wrote:
>> On 5/24/21 2:04 PM, Waiman Long wrote:
>>
>>> Is it possible to just get rid of the 2nd depends-on statement?
>>>
>>> The 2nd depends-on line was introduced by commit 7d37cb2c912d ("lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTER"):
>> and I should have looked at that history too. Thanks.
>>
>> Yes, I agree, we can just delete that line...
>>
>> I'll send a v2 and copy the author of commit 7d37cb2c912d as well.
> Hm, as I review that commit, I have to wonder if the previous 'select'
> was correct (if we disregard the Kconfig warning).  If so, then
> FRAME_POINTER is still wanted/needed for some arch-es.
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2779c29d9981..417c3d3e521b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1363,7 +1363,7 @@ config LOCKDEP
>          bool
>          depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>          select STACKTRACE
> -       select FRAME_POINTER if !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86 <<<<<<<<<<<
>
AFAICS, enabling FRAME_POINTER is a debugging aid as it enable more 
precise stacktrace. However, not all archs want to enable FRAME_POINTER 
because of LOCKDEP. Now you are just letting users decide if they want 
FRAME_POINTER or not. Maybe you can modify the help text to mention that.

Cheers,
Longman


