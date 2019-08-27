Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2Tpw-00021s-NN
 for linux-um@lists.infradead.org; Tue, 27 Aug 2019 05:16:10 +0000
Subject: Re: [PATCH] arch: um: implement memory protection
References: <20190823225831.23517-1-johannes@sipsolutions.net>
 <d929dc9c60b46ac222ca847fe8df7c0640713e4a.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <7d0c1f45-e245-fbab-1335-5d978c4f255b@kot-begemot.co.uk>
Date: Tue, 27 Aug 2019 06:15:58 +0100
MIME-Version: 1.0
In-Reply-To: <d929dc9c60b46ac222ca847fe8df7c0640713e4a.camel@sipsolutions.net>
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



On 25/08/2019 08:41, Johannes Berg wrote:
> On Sat, 2019-08-24 at 00:58 +0200, Johannes Berg wrote:
>>
>> Note that you can now enable CONFIG_DEBUG_RODATA_TEST,
>> but it's broken as the fixup is broken - it'll just
>> crash with
>>
>>   Kernel panic - not syncing: Segfault with no mm
> 
> It just occurred to me that I need to check what happens if it's
> actually userspace talking the fault or something, maybe if it
> erroneously tries to copy_o_user() with a read-only kernel address or
> so.
> 
> Don't want to cause a panic() in that case, after all.
> 
> IOW, I'd feel much happier about this if I could make
> CONFIG_DEBUG_RODATA_TEST work after all, but I gave up after an hour or
> so of poking the exception handlers and trying to figure out how I could
> make fixup tables work on UML. It might mean doing copy_from_user() in

Copy from/to user in UML have embedded tlb lookups. I did a couple of 
tweaks on them earlier in the year. I do not think they are a feasible 
target for a rewrite in asm without redoing once more the actual tlb.

That one is tough, in fact very tough. I think I have squeezed nearly 
everything that could be squeezed out of the current design, any further 
improvements can come only from a redesign from the whole uml mm and/or 
trying to integrate host ksm by default.

A.

> assembly, which would be annoying.
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
Anton R Ivanov

http://www.kot-begemot.co.uk

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

