Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [PATCH 4/9] kconfig: include common Kconfig files from top-level
 Kconfig
From: Randy Dunlap <rdunlap@infradead.org>
References: <20180708152004.21679-1-hch@lst.de>
 <20180708152004.21679-5-hch@lst.de>
 <CAK7LNAT5dzU-SOvqwnDs=bn3WA1_fmDj2abETmoHUdUExVF+WA@mail.gmail.com>
 <e36e6b2c-0984-199e-8c19-3ec54b31c12e@infradead.org>
Message-ID: <7d4e0925-3d6b-7698-1ef3-4c66500d8507@infradead.org>
Date: Mon, 16 Jul 2018 23:42:54 -0700
MIME-Version: 1.0
In-Reply-To: <e36e6b2c-0984-199e-8c19-3ec54b31c12e@infradead.org>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Christoph Hellwig <hch@lst.de>
Cc: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>

On 07/16/2018 11:33 PM, Randy Dunlap wrote:
> On 07/11/2018 05:21 AM, Masahiro Yamada wrote:
>> 2018-07-09 0:19 GMT+09:00 Christoph Hellwig <hch@lst.de>:
>>> Instead of duplicating the source statements in every architecture just
>>> do it once in the toplevel Kconfig file.
>>>
>>> Note that with this the inclusion of arch/$(SRCARCH/Kconfig moves out of
>>> the top-level Kconfig into arch/Kconfig so that don't violate ordering
>>> constraits while keeping a sensible menu structure.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>>
>>> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
>>> index dd4f3d3e644f..7ab7b148181b 100644
>>> --- a/arch/sh/Kconfig
>>> +++ b/arch/sh/Kconfig
>>> @@ -168,10 +168,6 @@ config PGTABLE_LEVELS
>>>         default 3 if X2TLB
>>>         default 2
>>>
>>> -source "init/Kconfig"
>>> -
>>> -source "kernel/Kconfig.freezer"
>>> -
>>>  menu "System type"
>>>
>>>  #
>>> @@ -553,8 +549,6 @@ endchoice
>>>
>>>  endif
>>>
>>> -source "arch/sh/mm/Kconfig"
>>
>>
>> I noticed at least sh is broken
>> because "arch/sh/mm/Kconfig" is no longer included by anyone.
>>
>> I am not doing further tests.
>>
> 
> Hi,
> 
> Thanks for noticing that.
> 
> I have tested all $ARCH (except um) with "allmodconfig" and so far, arch/sh/
> is the only one that has a problem.
> 

Well, there are 3 $ARCH-es that have an arch/$ARCH/mm/Kconfig file:
arm, sh, and unicore32.

We can either merge those into arch/$ARCH/Kconfig or we can source
arch/$ARCH/mm/Kconfig for all $ARCH (where most of these files will be
empty).

Christoph, thoughts/ideas?


> 
>>
>> Please test *ALL* architectures.
>>
>> If possible, matrix tests (arch, config-target), where
>> arch = arm, arm64, ...
>> config-target = allyesconfig, allnoconfig, alldefconfig, ...
>>
>>
>> Note:
>> scripts/diffconf is helpful.
>>
> 
> 


-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

