Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kojpo-0000cr-6e
 for linux-um@lists.infradead.org; Mon, 14 Dec 2020 09:08:01 +0000
Subject: Re: [PATCH v4 2/7] um: enable the use of optimized xor routines in UML
References: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
 <20201211174559.26010-3-anton.ivanov@cambridgegreys.com>
 <eaba0159c3925f367e42fd17dcf85b829a703666.camel@sipsolutions.net>
 <d8eb09bd-a8ff-72f1-7ea9-54342935bd60@cambridgegreys.com>
 <419748449d7e47922fb59335e1b2a44789080066.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <9dd00b95-ec4a-ac5d-fffa-a5c3fdabcfbb@cambridgegreys.com>
Date: Mon, 14 Dec 2020 09:07:53 +0000
MIME-Version: 1.0
In-Reply-To: <419748449d7e47922fb59335e1b2a44789080066.camel@sipsolutions.net>
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


On 11/12/2020 22:00, Johannes Berg wrote:
> On Fri, 2020-12-11 at 21:57 +0000, Anton Ivanov wrote:
>>>> --- /dev/null
>>>> +++ b/arch/um/include/asm/xor-x86.h
>>>> @@ -0,0 +1 @@
>>>> +../../../x86/include/asm/xor.h
>>> Do these really need to be symlinks? Last I looked, it seemed that
>>> arch/x86/include/asm/ is actually in the include path?
>> It is included, but it is included quite far down the list.
> I see. So you're saying basically we'll get asm-generic/xor.h before the
> x86 version, and then we're getting the worst possible implementation,
> right?
>
>> We pick up a few things out of there, but if we leave them "as is" they
>> all default to their least optimized versions. The results clearly
>> demonstrate that too - 30% difference on 64 bit and > 100% on 32 bit.
> Right.
>
>> This is because we do not perform alternatives substitution. Our
>> "alternatives" processing function in the UML startup is a noop.
> Oh, so we *do* get x86, but compatibility with ancient CPUs?

I had a look at the alternatives processing in x86 once again. The exact definition of what we get to use is: "ancient, buggy CPUs in SMP mode".

So in addition to using one of the worst case scenario implementations, we also do not do patching of SMP verbiage to UP where appropriate which is done on x86.

I just had a go at trying to reuse the aforementioned alternatives processing "as is" from the x86 tree.

This is pretty much a no-go from the start. We can't use it. It relies on "owning" int handlers and generating int instructions in places. If I understand it correctly, it will interfere with gdb by doing its own INT 3 work. Key parts of it are also "if-defed away" from us at present.

IMHO - it will have to be rewritten mostly from scratch for UML.

I will have a look if we can reuse the cpu feature and bug definitions instead of using our own. This will allow us to reuse the bits which relate to crypto - xor, etc as those are cases/ifdefs instead of alternatives.

A.

>
>> My idea was to override that to the extent possible and get whatever
>> mileage is possible without that.
> Makes sense.
>
>> I can give it a try to see how it looks if I use the x86 feature table
>> and other bits which are picked up from there, but working with that is
>> like pulling teeth without anaesthetic.
>>
>> On the positive side this means that we can copy the alternatives code
>> on x86.
>>
>> I can give it another go. I tried early on and it was a bit painful.
> Yeah, no, not sure ...
>
> Maybe just doing something like
>
> #include "../../../x86/include/asm/xor.h"
>
> would be acceptable? It seems a bit better to me in the sense of being
> more obvious than the symlinks... but dunno.
>
> johannes
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

