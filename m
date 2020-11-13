Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kddDL-0007d8-EJ
 for linux-um@lists.infradead.org; Fri, 13 Nov 2020 17:50:24 +0000
Subject: Re: [PATCH] um: "borrow" cmpxchg from x86 tree in UML
References: <20201113115437.14325-1-anton.ivanov@cambridgegreys.com>
 <e22c7628-29a7-6dea-1707-948f89334a79@cambridgegreys.com>
 <934d3df1539e43b7cc4e7fa2a22d806215ed5b8c.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <a7f8c21f-2ef2-aea8-3dd5-32f441267e86@cambridgegreys.com>
Date: Fri, 13 Nov 2020 17:50:18 +0000
MIME-Version: 1.0
In-Reply-To: <934d3df1539e43b7cc4e7fa2a22d806215ed5b8c.camel@sipsolutions.net>
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

On 13/11/2020 15:58, Johannes Berg wrote:
> On Fri, 2020-11-13 at 13:48 +0000, Anton Ivanov wrote:
>> I think that was it. Or to be more exact, I hope that was it.
>>
>> I went a few times through asm-generic and that looks like all the
>> bits which are worth implementing for a uniprocessor architecture as a
>> replacement for their generic equivalents.
> It seems that word-at-a-time.h with CONFIG_DCACHE_WORD_ACCESS might
> be worthwhile as well?

I tried it. It had some references to exception handling which are not 
present in UML so I dropped it for now.

We may get it to work, but it will take some effort. I think it also had 
alternatives in the assembly parts so that means similar problems to 
using x86 memcpy and x86 memmove.

>
> Also perhaps bug.h; there are a lot of BUG_ON/WARN_ON and similar
> things, and especially the _ONCE part looks better there?

There are some advantages there, but the difference between x86 and 
generic does not look to be as drastic as atomics or futex.

We can pull it in.

>
> ftrace is probably not worth the effort ...

Concur.

> johannes
>
>
Brgds,

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

