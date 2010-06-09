Return-Path: <xiyou.wangcong@gmail.com>
Date: Wed, 9 Jun 2010 17:32:57 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [uml-devel] [PATCH resend] um, hweight: Fix UML boot crash
Message-ID: <20100609093257.GA6292@cr0.nay.redhat.com>
References: <4C0F4B00.4090307@panasas.com>
 <4C0F4C40.5020207@panasas.com>
 <AANLkTinwQmWP-rFu9e-ns5twsZwZjuSLi5vcll55ZZhx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTinwQmWP-rFu9e-ns5twsZwZjuSLi5vcll55ZZhx@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Boaz Harrosh <bharrosh@panasas.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Jun 09, 2010 at 10:46:01AM +0200, Geert Uytterhoeven wrote:
>On Wed, Jun 9, 2010 at 10:09, Boaz Harrosh <bharrosh@panasas.com> wrote:
>> On 06/09/2010 11:04 AM, Boaz Harrosh wrote:
>>> From: Borislav Petkov <bp@alien8.de>
>>>
>>> Obviously UML cannot stomach callee reg-saving trickery
>>> introduced with d61931d89be506372d01a90d1755f6d0a9fafe2d
>>> (x86: Add optimized popcnt variants) and oopses during boot:
>>> http://marc.info/?l=linux-kernel&m=127522065202435&w=2
>>>
>>> Redirect arch_hweight.h include from the x86 portion to the generic
>>> arch_hweight.h which is a fallback to the software hweight routines.
>>>
>>> LKML-Reference: <201005271944.09541.toralf.foerster@gmx.de>
>>> Signed-off-by: Borislav Petkov <bp@alien8.de>
>
>Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
>> who's going to push this ASAP. I was just (again) 3/4 through a bisect
>> on 2.6.35-rc2. When I finally realized "Hey that patch, I forgot".
>> (My concentration is not what it used to be)
>>
>> Please push this, someone
>
>Peter, are you happy with this?
>Although we still don't know why UML cannot grok it, it does fix a
>regression in post-2.6.34.
>

Usually Andrew should take UML patches.

