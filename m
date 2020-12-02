Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkQkn-00089P-3l
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 11:57:02 +0000
Subject: Re: [PATCH 7/7] um: simplify IRQ handling code
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <20201123205446.6370687fa983.I811873233b8d71fbde9154b84c85b498521e3b12@changeid>
 <96e31171-965d-c1d7-282e-b1b0bec6b73f@kot-begemot.co.uk>
 <4ebc9f4069082c1fa3606fc636f15c664bc0af60.camel@sipsolutions.net>
 <02516224-6caf-c947-3410-0fcdc6e7204e@kot-begemot.co.uk>
 <6cbfb799d0889dc2d34d7c773a42305d025c615b.camel@sipsolutions.net>
 <b93242b0-5088-4534-8f8e-1d92b68eb9f4@kot-begemot.co.uk>
 <7cee8105ff3a771fc0c3f7a4e4849da4ca2912a1.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <e3aca9bc-9c01-179e-8755-48cd8c7ad4c8@kot-begemot.co.uk>
Date: Wed, 2 Dec 2020 11:56:57 +0000
MIME-Version: 1.0
In-Reply-To: <7cee8105ff3a771fc0c3f7a4e4849da4ca2912a1.camel@sipsolutions.net>
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


On 02/12/2020 11:32, Johannes Berg wrote:
> On Wed, 2020-12-02 at 11:31 +0000, Anton Ivanov wrote:
>> I think we should just handle EPOLLHUP and do an IRQ + fd disable if it HUPS.
>>
>> This way a close will always be handled correctly regardless of where and how it closed.
> Yes, but that's sort of a separate thing?

Yep it is. Parking it for later as it will allow to remove the "free_irqs" cludge.

>
> Also, we probably should disable SIGIO if the IRQ is freed, otherwise
> the FD can keep interrupting us but we don't find anything in the epoll
> set ... But again, a separate cleanup?

I think that deleting the fd from the set should stop that.

Let me think on it. It was clearly being held together by duck tape and baling wire and it needs fixing. You got most of it which is grand, we just need to finish it.

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

