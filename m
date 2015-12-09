Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <56674E18.7020905@nod.at>
 <CA+55aFx53MbO2HrVkrMr4K-8DU2gJTsmpaEECT3i4prUjcMUng@mail.gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5667E9F0.9070102@nod.at>
Date: Wed, 9 Dec 2015 09:44:32 +0100
MIME-Version: 1.0
In-Reply-To: <CA+55aFx53MbO2HrVkrMr4K-8DU2gJTsmpaEECT3i4prUjcMUng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [GIT PULL] UML fixes for 4.4-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, the arch/x86 maintainers <x86@kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

Am 09.12.2015 um 02:35 schrieb Linus Torvalds:
> On Tue, Dec 8, 2015 at 1:39 PM, Richard Weinberger <richard@nod.at> wrote:
>>
>> This pull request contains various bug fixes, most of them are
>> fall out from the merge window.
>>
>> Richard Weinberger (2):
>>       um: Fix fpstate handling
> 
> Ugh. This is very ugly. It's apparently the result of commit
> 530e5c827182 ("x86/headers: Make sigcontext pointers bit independent")
> and apparently nobody noticed the uml fallout.
> 
> I've pulled, but I wanted the x86 people involved to be aware of this
> ugly corner. I wonder if there might be some way for uml to continue
> to use that fpstate entry as a pointer, at least when the wordsize
> matches (which it will)?

I agree. One way to get rid of the ugliness would be rewriting UML's
FP code. The code is very old and doing it like x86 does would be a
good thing anyway. But that's nothing I'll do at this stage of development.
That's material for the next merge window.

Thanks,
//richard
