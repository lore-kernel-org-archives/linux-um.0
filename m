Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM7aV-000WUZ-TL
 for linux-um@lists.infradead.org; Tue, 16 Mar 2021 11:10:14 +0000
Subject: Re: [PATCH] um: implement arch_sync_kernel_mappings
References: <20210316095841.5837-1-anton.ivanov@cambridgegreys.com>
 <8d38e204acf8fbd1de42890ff8a351cbe689c1d3.camel@sipsolutions.net>
 <3481c369-05f2-dfff-4bf1-2a8af83b1686@cambridgegreys.com>
 <5bf5351e9045601b736f0cc5e90627e747283828.camel@sipsolutions.net>
 <2e24819c-5f06-aaf4-eb15-68e2d54a4806@cambridgegreys.com>
 <2946c5d125d9eb9c0307eba99eca1d7fe8f072ae.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <b359276d-d737-55f7-9978-67894adebf08@cambridgegreys.com>
Date: Tue, 16 Mar 2021 11:10:08 +0000
MIME-Version: 1.0
In-Reply-To: <2946c5d125d9eb9c0307eba99eca1d7fe8f072ae.camel@sipsolutions.net>
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



On 16/03/2021 11:04, Johannes Berg wrote:
> On Tue, 2021-03-16 at 10:49 +0000, Anton Ivanov wrote:
>>>> I get slightly better performance on userspace,
>>>> etc compared to your patch. It is marginal -
>>>> sub 1% close to the experimental error.
>>>
>>> Why does that even affect userspace at all, btw? We're talking about
>>> kernel mappings?
>>
>> My userspace tests do heavy IO.
> 
> OK, but even then, my patch should be an improvement on anything that
> needs updated ranges since it avoids the segfault(s), and not really
> make anything worse that *doesn't*?
> 
> But then again, I'm not sure you said that this patch was an improvement
> or not for your workload?

Your patch showed no difference on heavy IO userspace. Roughly the same numbers I usually get.

Syncing pages at a PMD level change showed some marginal improvement on a heavy IO testcase but very close to the margin of error - in the realm of 0.2-0.3%

I would really need to do 20+ runs to have reliable numbers on that to confirm as it is too close to the margin of error.

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

