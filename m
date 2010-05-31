Return-Path: <bharrosh@panasas.com>
Message-ID: <4C03C6D1.2020305@panasas.com>
Date: Mon, 31 May 2010 17:25:21 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] x86, hweight: Fix UML boot crash
References: <201005271944.09541.toralf.foerster@gmx.de>	<20100530193956.GA2498@liondog.tnic>	<20100530201738.GB2498@liondog.tnic> <201005311555.56791.toralf.foerster@gmx.de>
In-Reply-To: <201005311555.56791.toralf.foerster@gmx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: Borislav Petkov <bp@alien8.de>, Borislav Petkov <borislav.petkov@amd.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, "H. Peter Anvin" <hpa@zytor.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 05/31/2010 04:55 PM, Toralf Förster wrote:
> 
> Borislav Petkov wrote at 22:17:38
>> LKML-Reference: <201005271944.09541.toralf.foerster@gmx.de>
>> Signed-off-by: Borislav Petkov <bp@alien8.de>
>> ---
>>  arch/um/include/asm/arch_hweight.h |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/um/include/asm/arch_hweight.h
>>
>> diff --git a/arch/um/include/asm/arch_hweight.h b/arch/um/include/asm/arch_hweight.h
>> new file mode 100644
>> index 0000000..c656cf4
>> --- /dev/null
>> +++ b/arch/um/include/asm/arch_hweight.h
>> @@ -0,0 +1,6 @@
>> +#ifndef _ASM_UM_HWEIGHT_H
>> +#define _ASM_UM_HWEIGHT_H
>> +
>> +#include <asm-generic/bitops/arch_hweight.h>
>> +
>> +#endif
>>
> This patch does not to solve the reported issue by me.
> 

Watch out. It did fix it for me but only after a deep
clean. (mrproper) Makefile does not pick up this dependency.

Also I could not use my 2.6.34 config file. I had to do
make defconfig, and then xconfig all my extra stuff. But
this is regular for any Kernel upgrade and UML.

It does fix my setup. (Wouldn't load before this)
Boaz

