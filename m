Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM5Xs-000BVd-UX
 for linux-um@lists.infradead.org; Tue, 16 Mar 2021 08:59:24 +0000
Subject: Re: [PATCH] um: implement flush_cache_vmap/flush_cache_vunmap
References: <20210315233804.d3e52f6a3422.I9672eef7dfa7ce6c3de1ccf7ab8d9aad1fa7f3a6@changeid>
 <27e8fe7b-8567-4489-6af3-cf13ad4ab25a@kot-begemot.co.uk>
 <0d2ce878a618b9ac5868b19ca72ef5d88cd5d3c9.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <a5dbeeb8-e677-9efd-9735-fd93df1d8a0f@kot-begemot.co.uk>
Date: Tue, 16 Mar 2021 08:59:18 +0000
MIME-Version: 1.0
In-Reply-To: <0d2ce878a618b9ac5868b19ca72ef5d88cd5d3c9.camel@sipsolutions.net>
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



On 16/03/2021 08:55, Johannes Berg wrote:
> On Tue, 2021-03-16 at 08:46 +0000, Anton Ivanov wrote:
>>
>> Well spotted.
>>
>> Unless I am mistaken, there may be a slightly better way of doing it.
>>
>> We can implement arch_sync_kernel_mappings() and sync only where the
>> page modified mask says so by setting ARCH_PAGE_TABLE_SYNC_MASK
>>
>> This way flush_cache_* can remain nops as in asm-generic
> 
> Would that actually buy us anything?

It makes flushing conditional on a specific mask from the result of the mapping op. In theory, should be better. In practice - probably more of the same.

> 
> Not that I mind, or even understand the TLB code well, but it seems
> fairly similar?
> 
>> I am going to give that a spin, if it works, I will post it to the list by lunchtime GMT
> 
> Sounds good to me :)
> 
> I also made these patches:
> 
> https://lore.kernel.org/lkml/20210315235453.e3fbb86e99a0.I08a3ee6dbe47ea3e8024956083f162884a958e40@changeid/T/#u
> 
> 
> so my "vmalloc-heavy workload" no longer is vmalloc heavy since it now
> uses kvmalloc and never hits vmalloc, always kmalloc :)

:)

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
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

