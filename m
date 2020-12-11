Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knqPf-0008TT-NY
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 21:57:20 +0000
Subject: Re: [PATCH v4 2/7] um: enable the use of optimized xor routines in UML
References: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
 <20201211174559.26010-3-anton.ivanov@cambridgegreys.com>
 <eaba0159c3925f367e42fd17dcf85b829a703666.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <d8eb09bd-a8ff-72f1-7ea9-54342935bd60@cambridgegreys.com>
Date: Fri, 11 Dec 2020 21:57:15 +0000
MIME-Version: 1.0
In-Reply-To: <eaba0159c3925f367e42fd17dcf85b829a703666.camel@sipsolutions.net>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at

On 11/12/2020 20:07, Johannes Berg wrote:
>> +++ b/arch/um/include/asm/fpu/api.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#ifndef _ASM_UM_FPU_API_H
>> +#define _ASM_UM_FPU_API_H
>> +
>> +/* Copyright (c) 2020 Cambridge Greys Ltd
>> + * Copyright (c) 2020 Red Hat Inc.
>> + * A set of "dummy" defines to allow the direct inclusion
>> + * of x86 optimized copy, xor, etc routines into the
>> + * UML code tree. */
>> +
>> +#define kernel_fpu_begin() (void)0
>> +#define kernel_fpu_end() (void)0
> I think I would prefer those to be static inlines, but YMMV.
>
> johannes
>
>> diff --git a/arch/um/include/asm/xor-x86.h b/arch/um/include/asm/xor-x86.h
>> new file mode 120000
>> index 000000000000..beff7de6890d
>> --- /dev/null
>> +++ b/arch/um/include/asm/xor-x86.h
>> @@ -0,0 +1 @@
>> +../../../x86/include/asm/xor.h
> Do these really need to be symlinks? Last I looked, it seemed that
> arch/x86/include/asm/ is actually in the include path?

It is included, but it is included quite far down the list.

We pick up a few things out of there, but if we leave them "as is" they 
all default to their least optimized versions. The results clearly 
demonstrate that too - 30% difference on 64 bit and > 100% on 32 bit.

This is because we do not perform alternatives substitution. Our 
"alternatives" processing function in the UML startup is a noop.

My idea was to override that to the extent possible and get whatever 
mileage is possible without that.

I can give it a try to see how it looks if I use the x86 feature table 
and other bits which are picked up from there, but working with that is 
like pulling teeth without anaesthetic.

On the positive side this means that we can copy the alternatives code 
on x86.

I can give it another go. I tried early on and it was a bit painful.

A.

>
>> --- a/arch/um/include/asm/xor.h
>> +++ b/arch/um/include/asm/xor.h
>> @@ -1,7 +1,22 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>> -#include <asm-generic/xor.h>
>> +#ifndef _ASM_UM_XOR_H
>> +#define _ASM_UM_XOR_H
>> +
>> +#ifdef CONFIG_64BIT
>> +#undef CONFIG_X86_32
>> +#else
>> +#define CONFIG_X86_32 1
>> +#endif
>> +
>> +#include <asm/cpufeature.h>
>> +#include <asm/xor-x86.h>
> and thus this could just be
>
> #include_next <asm/xor.h>
>
> without the symlink?
>
>> diff --git a/arch/um/include/asm/xor_32.h b/arch/um/include/asm/xor_32.h
>> new file mode 120000
>> index 000000000000..8a0894e996d7
>> --- /dev/null
>> +++ b/arch/um/include/asm/xor_32.h
>
> And the others don't exist in um anyway, so probably aren't needed?
>
> But maybe I'm confused about the include path, I didn't double-check
> now.
>
> johannes
>
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

