Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcWv5-000858-3y
 for linux-um@lists.infradead.org; Tue, 10 Nov 2020 16:55:00 +0000
Subject: Re: [PATCH] um: allow using glibc string functions instead of generics
References: <20201110163034.22963-1-anton.ivanov@cambridgegreys.com>
 <ca9a4a3d2e6c49cc609db33637089e9110662174.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <1437c737-815f-c8ad-b45f-f88f398dadba@cambridgegreys.com>
Date: Tue, 10 Nov 2020 16:54:55 +0000
MIME-Version: 1.0
In-Reply-To: <ca9a4a3d2e6c49cc609db33637089e9110662174.camel@sipsolutions.net>
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



On 10/11/2020 16:40, Johannes Berg wrote:
> On Tue, 2020-11-10 at 16:30 +0000, anton.ivanov@cambridgegreys.com
> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> UML kernel runs as a normal userspace process and can use the
>> optimized glibc strings functions like strcpy, memcpy, etc.
>>
>> The support is optional and is turned on/of using a config
>> option.
>>
>> Using glibc functions results in a slightly smaller executable
>> when linked dynamically as well as anything between 1% and 5%
>> performance improvements.
> 
> Nice! :-)
> 
>> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
>> index 4b799fad8b48..961cf3af3ff0 100644
>> --- a/arch/um/Kconfig
>> +++ b/arch/um/Kconfig
>> @@ -189,6 +189,17 @@ config UML_TIME_TRAVEL_SUPPORT
>>   
>>   	  It is safe to say Y, but you probably don't need this.
>>   
>> +config UML_USE_HOST_STRINGS
>> +	bool
>> +	default y
>> +	prompt "Use glibc strings and memory functions"
>> +	help
>> +	  UML runs as a normal userspace process. As a result it can use
>> +	  the optimized strcpy, memcpy, etc from glibc instead of the
>> +          kernel generic equivalents. This provides some minimal speedup
>> +	  in the 1% or so range for most applications. It also results in
>> +	  a smaller executable.
> 
> Looks like some inconsistent tab/spaces indentation there :)

Will fix it in v2.

> 
>> +++ b/arch/um/os-Linux/string.c
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>> + */
>> +
>> +#include <stddef.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <os_string.h>
>> +
>> +inline char *os_strcpy(char *dest, const char *src)
> 
> those 'inline' annotations seem strange - they can't possibly do
> anything useful here?

Indeed. The compiler inlines them anyway. I can remove that. There is no difference (I tried both).


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

