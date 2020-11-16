Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefh5-00014M-Cw
 for linux-um@lists.infradead.org; Mon, 16 Nov 2020 14:41:24 +0000
Subject: Re: [PATCH] um: "borrow" cmpxchg from x86 tree in UML
References: <20201113115437.14325-1-anton.ivanov@cambridgegreys.com>
 <e22c7628-29a7-6dea-1707-948f89334a79@cambridgegreys.com>
 <934d3df1539e43b7cc4e7fa2a22d806215ed5b8c.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <ac76160d-5244-c199-f30a-a24bd984ff91@cambridgegreys.com>
Date: Mon, 16 Nov 2020 14:41:16 +0000
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
>>
>> I think that was it. Or to be more exact, I hope that was it.
>>
>> I went a few times through asm-generic and that looks like all the
>> bits which are worth implementing for a uniprocessor architecture as a
>> replacement for their generic equivalents.
> 
> It seems that word-at-a-time.h with CONFIG_DCACHE_WORD_ACCESS might
> be worthwhile as well?
> 
> Also perhaps bug.h; there are a lot of BUG_ON/WARN_ON and similar
> things, and especially the _ONCE part looks better there?
> 
> ftrace is probably not worth the effort ...
> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

There is one more which makes for a surprisingly big difference - a couple of more % on find /usr -type f -exec cat {} > /dev/null \;

bitops.h

Actually, it is not that surprising, fs and memory which are exercised this way have bitops all over the place.

Patch coming shortly.

I also have a patch to switch to proper cmpxchg in the futex/uaccess, but that has to go in after everything else. If atomics and cmpxchg have not gone in, it actually does more harm than good.

A.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

