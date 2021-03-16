Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM6XM-000LX5-E7
 for linux-um@lists.infradead.org; Tue, 16 Mar 2021 10:02:55 +0000
Subject: Re: [PATCH] um: implement arch_sync_kernel_mappings
References: <20210316095841.5837-1-anton.ivanov@cambridgegreys.com>
 <8d38e204acf8fbd1de42890ff8a351cbe689c1d3.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <3481c369-05f2-dfff-4bf1-2a8af83b1686@cambridgegreys.com>
Date: Tue, 16 Mar 2021 10:02:49 +0000
MIME-Version: 1.0
In-Reply-To: <8d38e204acf8fbd1de42890ff8a351cbe689c1d3.camel@sipsolutions.net>
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


On 16/03/2021 09:59, Johannes Berg wrote:
> On Tue, 2021-03-16 at 09:58 +0000, anton.ivanov@cambridgegreys.com
> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> This improves the tlb flushing behavior by syncing modified
>> ranges out of map_kernel_range_noflush in a way which is
>> similar to x86.
> So I take it this replaces my patch?

I get slightly better performance on userspace, etc compared to your patch. It is marginal - sub 1% close to the experimental error.

I am testing different things though :)


> Want me to test it (without the kvmalloc)?

Yes :)

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

