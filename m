Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] um: Avoid longjmp/setjmp symbol clashes with
 libpthread.a
References: <20170524003232.14319-1-f.fainelli@gmail.com>
 <e2c13a8b-d0c3-74d1-dd1b-53a56f609c76@nod.at>
 <9f58b41d-ebe4-62a6-1aa4-e9222372ce86@gmail.com>
 <408132c9-6d55-7cba-e09a-f532d7fb9c6f@gmail.com>
 <9617f203-cee2-96cf-aa76-8f42b1a4a9f6@nod.at>
 <2c362d49-9907-7a66-67ef-e196dddea32a@gmail.com>
 <85f8b8c0-cf0e-3c67-c237-be4b045c617b@nod.at>
 <f57b5906-30cc-0fdf-893c-39e4f5202d1b@gmail.com>
 <07b61d6a-33af-be0a-b57c-843196d0d151@nod.at>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8dd50867-312d-8af9-0993-4b5d5c181a58@gmail.com>
Date: Thu, 1 Jun 2017 13:53:27 -0700
MIME-Version: 1.0
In-Reply-To: <07b61d6a-33af-be0a-b57c-843196d0d151@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/01/2017 01:44 PM, Richard Weinberger wrote:
> Am 01.06.2017 um 22:40 schrieb Florian Fainelli:
>>>> Sure, but that seems orthogonal? In the absence of an answer from Eli,
>>>> either you could take my patch or just send reverts of Eli's two
>>>> commits, whichever you prefer.
>>>
>>> Or you and Thomas could investigate. :-)
>>
>> Honestly, I don't know what do you want me to investigate, my host
>> machine is old (2.6.32) and does not support PTRACE_GETREGSET or
>> friends, nor does it have _xstate, so with that, we either don't use
>> those period, which would be a revert, or we just conditionally build
>> support for that (my patch) and everyone is happy.
> 
> This is exactly why we have this mess right now. Everybody is just focusing
> on his own stuff.

No, we have this mess right now because you applied patches before and
now you realize that this broke other people's system based on their
attempts to fix it. Don't blame it on people trying to fix things, this
is the worse possible attitude.

> 
>> I don't know what the issue Thomas is having (he is now CC'd) and I
>> still don't understand why you insist on conflating the symbol clash
>> while statically linking with support for newer x86 FPU stuff...
> 
> The said commits introduced issues, you face some, Thomas is facing some.
> I want them to get fixed or at least understood before we apply new patches.

Well, I would very much like to know what Thomas' issues are, a link to
his findings would be helpful to begin with instead of just waving that
flag.
-- 
Florian

