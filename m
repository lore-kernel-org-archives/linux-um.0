Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4C167289.9040909@panasas.com>
Date: Mon, 14 Jun 2010 21:18:49 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH resend] um, hweight: Fix UML boot crash
References: <4C0F4B00.4090307@panasas.com>	<4C0F4C40.5020207@panasas.com> <AANLkTinwQmWP-rFu9e-ns5twsZwZjuSLi5vcll55ZZhx@mail.gmail.com> <4C0FDD8C.2020704@zytor.com> <4C1653FF.3080108@panasas.com> <4C165BCF.4030507@zytor.com>
In-Reply-To: <4C165BCF.4030507@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Borislav Petkov <bp@alien8.de>, =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/14/2010 07:41 PM, H. Peter Anvin wrote:
> On 06/14/2010 09:08 AM, Boaz Harrosh wrote:
>> On 06/09/2010 09:29 PM, H. Peter Anvin wrote:
>>> On 06/09/2010 01:46 AM, Geert Uytterhoeven wrote:
>>>>
>>>> Peter, are you happy with this?
>>>> Although we still don't know why UML cannot grok it, it does fix a
>>>> regression in post-2.6.34.
>>>>
>>>
>>> Yes, I'll push it.
>>>
>>> 	-hpa
>>
>> Peter hi.
>>
>> Why have we missed that patch from -rc3. This is so *not fun* to keep
>> out-of-tree patches. Specially when working with lots of other people's
>> trees.
>>
>> Please push it ASAP
>> Boaz
> 
> We made the decision of not pushing our queue for -rc3 because Linus
> specifically wanted only critical fixes for -rc3.  We will push it for
> -rc4 for when Linus returns.
> 
> Also, you may want to consider moderating your tone.
> 

I did not meant any disrespect. I totally understand, I meant it as a
a team member, that wants to help. I deeply regret if I offended you
in any way, please forgive me.

And, for My uml it is a very critical, "*can not* boot without", patch.
I wish it could be pushed apart from any other patchset.

Thanks
Boaz

> 	-hpa
> 

