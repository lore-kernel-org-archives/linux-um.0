Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcuVZ-0006mH-RS
 for linux-um@lists.infradead.org; Wed, 11 Nov 2020 18:06:14 +0000
Subject: Re: [PATCH] um: enable the use of optimized xor routines in UML
References: <20201111150114.23778-1-anton.ivanov@cambridgegreys.com>
 <f6678bb73cd5163521eef21a640cad90408b8f6e.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <87f03a15-4bdf-397a-65ee-5ea0c5448448@cambridgegreys.com>
Date: Wed, 11 Nov 2020 18:06:08 +0000
MIME-Version: 1.0
In-Reply-To: <f6678bb73cd5163521eef21a640cad90408b8f6e.camel@sipsolutions.net>
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



On 11/11/2020 16:43, Johannes Berg wrote:
> On Wed, 2020-11-11 at 15:01 +0000, anton.ivanov@cambridgegreys.com
> wrote:
>>
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
>> +#define CONFIG_X86_32 "Y"
>> +#endif
> 
> Should that be '1' instead of '"Y"' to match what gets into the kernel's
> autoconf.h, i.e. just '#define CONFIG_X86_32 1'?
> 
> Probably just used with #ifdef, but still, the string looks odd.
> 
>> +++ b/arch/um/kernel/um_arch.c
>> @@ -48,9 +48,16 @@ static void __init add_arg(char *arg)
>>    */
>>   struct cpuinfo_um boot_cpu_data = {
>>   	.loops_per_jiffy	= 0,
>> -	.ipi_pipe		= { -1, -1 }
>> +	.ipi_pipe		= { -1, -1 },
>> +	.host_features		= 0
> 
> Don't _really_ need to 0-initialize, but also doesn't hurt :)

Leftover, I was initially initializing a few flags before I added code to read them.

> Might want to add a , at the end to make the next change easier.
> 
>> +const char* host_cpu_feature_names[] = {"mmx", "xmm", "avx", "rep_good", "erms"};
>> +#define MAX_UM_CPU_FEATURES 5
> 
> Why the define rather than ARRAY_SIZE()?

Brain not in gear :)

Gearbox overheated from trying to do checksum in parallel :)

While at it, I think I know why I get some performance gain with glibc even where there are functions optimized in the x86 tree which in theory should provide a gain like for example picking up memcpy from memcpy_64.S

In the kernel, the optimized versions are chosen by patching at runtime via alternatives based on feature bits. That means apply_alternatives() actually doing something.

Apply alternatives in x86 does so: https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/alternative.c#L372

Apply alternatives in UML is a NOOP: https://elixir.bootlin.com/linux/latest/source/arch/um/kernel/um_arch.c#L361

In the absence of working apply_alternatives we default to the first function, which means that for memcpy we use rep dword move + by byte remainder instead of 4x8 blocks as in the optimized version and which is set by default on nearly all 64bit CPUS (rep_good flag).

This will be fairly hard to fix as we have to reimplement the patching of code at runtime same as in the x86 kernel versus whatever we use as feature flags and/or implement the whole x86 flags nightmare so we can reuse the x86 patching code. I am not sure about memory protection here too - this would be in our code segment.

So, actually, for string.h going to glibc which does exactly the same thing (and even has some of the same code in places) is the easiest way out.

> 
> johannes
> 
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

