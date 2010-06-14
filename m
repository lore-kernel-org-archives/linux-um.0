Return-Path: <hpa@zytor.com>
Message-ID: <4C165BCF.4030507@zytor.com>
Date: Mon, 14 Jun 2010 09:41:51 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH resend] um, hweight: Fix UML boot crash
References: <4C0F4B00.4090307@panasas.com>	<4C0F4C40.5020207@panasas.com> <AANLkTinwQmWP-rFu9e-ns5twsZwZjuSLi5vcll55ZZhx@mail.gmail.com> <4C0FDD8C.2020704@zytor.com> <4C1653FF.3080108@panasas.com>
In-Reply-To: <4C1653FF.3080108@panasas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Borislav Petkov <bp@alien8.de>, =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/14/2010 09:08 AM, Boaz Harrosh wrote:
> On 06/09/2010 09:29 PM, H. Peter Anvin wrote:
>> On 06/09/2010 01:46 AM, Geert Uytterhoeven wrote:
>>>
>>> Peter, are you happy with this?
>>> Although we still don't know why UML cannot grok it, it does fix a
>>> regression in post-2.6.34.
>>>
>>
>> Yes, I'll push it.
>>
>> 	-hpa
> 
> Peter hi.
> 
> Why have we missed that patch from -rc3. This is so *not fun* to keep
> out-of-tree patches. Specially when working with lots of other people's
> trees.
> 
> Please push it ASAP
> Boaz

We made the decision of not pushing our queue for -rc3 because Linus
specifically wanted only critical fixes for -rc3.  We will push it for
-rc4 for when Linus returns.

Also, you may want to consider moderating your tone.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


