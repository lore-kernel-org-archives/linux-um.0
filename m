Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kf0UF-0008WK-T5
 for linux-um@lists.infradead.org; Tue, 17 Nov 2020 12:53:32 +0000
Subject: Re: [PATCH] um: borrow bitops from the x86 tree
References: <20201116144426.8415-1-anton.ivanov@cambridgegreys.com>
 <a5ad1be201a7488bdc317bc72776f1465347504f.camel@sipsolutions.net>
 <d2817ac8-e4a9-5d88-468e-03705e986b6e@cambridgegreys.com>
 <cc3181a27ff19403db94385b42ec4a1feb60a965.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <cd43d9fd-c1e8-d10d-1b39-d1893eb0cdc3@cambridgegreys.com>
Date: Tue, 17 Nov 2020 12:53:26 +0000
MIME-Version: 1.0
In-Reply-To: <cc3181a27ff19403db94385b42ec4a1feb60a965.camel@sipsolutions.net>
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

On 17/11/2020 12:11, Johannes Berg wrote:
> On Tue, 2020-11-17 at 11:46 +0000, Anton Ivanov wrote:
>>
>> My usual test is:
>>
>>    time busybox find /usr/lib/ -type f -exec cat {} > /dev/null \;
>>
>> I discard the first run and use only runs from fs cache.
> 
> Oh. I didn't even run the timing inside. I ran it *outside*, something
> like
> 
> time ./linux args... init=/path/to/test-script.sh

I usually do a full set of tests on fs access, device IO access and a 
netperf after each patch.

Based on them it looks like it is worth it.

The more interesting question is - is this the right organization?

We have stuff in multiple places now - arch/x86/um , arch/um, etc.

IMHO, we should probably look at getting it organized so that all 
sub-arches are under the um tree at some point.

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

