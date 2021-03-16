Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM6yW-000Pkj-5N
 for linux-um@lists.infradead.org; Tue, 16 Mar 2021 10:30:58 +0000
Subject: Re: [PATCH] um: implement arch_sync_kernel_mappings
References: <20210316095841.5837-1-anton.ivanov@cambridgegreys.com>
 <8d38e204acf8fbd1de42890ff8a351cbe689c1d3.camel@sipsolutions.net>
 <3481c369-05f2-dfff-4bf1-2a8af83b1686@cambridgegreys.com>
 <da2f077a9d28851ac532e1518922350b69bd6086.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <a8217f23-6d16-a7f4-b3be-36f43ccf4f5c@cambridgegreys.com>
Date: Tue, 16 Mar 2021 10:30:53 +0000
MIME-Version: 1.0
In-Reply-To: <da2f077a9d28851ac532e1518922350b69bd6086.camel@sipsolutions.net>
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



On 16/03/2021 10:19, Johannes Berg wrote:
> On Tue, 2021-03-16 at 10:02 +0000, Anton Ivanov wrote:
>>> Want me to test it (without the kvmalloc)?
>>
>> Yes :)
> 
> This patch doesn't seem to improve vmalloc performance at all.

Bugger...

I was looking at it from this perspective.

flush_cache_vmap is invoked out of here right after a map_kernel_range_noflush():

https://elixir.bootlin.com/linux/latest/source/mm/vmalloc.c#L320

If I understand the invocation correctly your patch results in a full flush for the mapped range each time it is mapped.

The invocation of map_kernel_range_noflush() actually has a built-in facility for a partial flush - it is exactly arch_sync_page_mappings and it is invoked here: https://elixir.bootlin.com/linux/latest/source/mm/vmalloc.c#L314

This makes the flush dependent on the level of modification - to be functionally equivalent to your patch it is an OR of all page levels which looked way too brutal :(

That's why I tried it using only PMD. That looks like not enough :(

Can you try tweaking the mask? Available masks are defined here: https://elixir.bootlin.com/linux/latest/source/include/linux/pgtable.h#L1474

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

