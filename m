Return-Path: <richard@nod.at>
Message-ID: <5373CE18.20103@nod.at>
Date: Wed, 14 May 2014 22:12:08 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <cover.1399678795.git.joe@perches.com> <5373C996.7000409@nod.at> <1400098041.30384.22.camel@joe-AO725>
In-Reply-To: <1400098041.30384.22.camel@joe-AO725>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/4] UserModeLinux: Message logging neatening
To: Joe Perches <joe@perches.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 14.05.2014 22:07, schrieb Joe Perches:
> On Wed, 2014-05-14 at 21:52 +0200, Richard Weinberger wrote:
>> Am 10.05.2014 01:43, schrieb Joe Perches:
>>> Joe Perches (4):
>>>   UserModeLinux: Convert UM_KERN_<LEVEL> to KERN_<LEVEL>
>>>   UserModeLinux: Remove unused #defines of UM_KERN_<LEVEL>
>>>   UserModeLinux: Use a more current logging style
>>>   UserModeLinux: Convert printks to pr_<level>
> 
>> Thank you Joe!
>> I'll queue your patches for 3.16.
> 
> (adding Geert to cc's)
> 
> Hi Richard.
> 
> Please queue only patches 1 and 2.
> 
> Patches 3 and 4 are currently defective.
> These need a bit of rework to compile appropriately.

Oh, I thought you have tested your patches. :-(

Thanks,
//richard

