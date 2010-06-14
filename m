Return-Path: <bharrosh@panasas.com>
Message-ID: <4C1653FF.3080108@panasas.com>
Date: Mon, 14 Jun 2010 19:08:31 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH resend] um, hweight: Fix UML boot crash
References: <4C0F4B00.4090307@panasas.com>	<4C0F4C40.5020207@panasas.com> <AANLkTinwQmWP-rFu9e-ns5twsZwZjuSLi5vcll55ZZhx@mail.gmail.com> <4C0FDD8C.2020704@zytor.com>
In-Reply-To: <4C0FDD8C.2020704@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Borislav Petkov <bp@alien8.de>, =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/09/2010 09:29 PM, H. Peter Anvin wrote:
> On 06/09/2010 01:46 AM, Geert Uytterhoeven wrote:
>>
>> Peter, are you happy with this?
>> Although we still don't know why UML cannot grok it, it does fix a
>> regression in post-2.6.34.
>>
> 
> Yes, I'll push it.
> 
> 	-hpa

Peter hi.

Why have we missed that patch from -rc3. This is so *not fun* to keep
out-of-tree patches. Specially when working with lots of other people's
trees.

Please push it ASAP
Boaz

