Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkQMZ-0005gz-Ad
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 11:32:00 +0000
Subject: Re: [PATCH 7/7] um: simplify IRQ handling code
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <20201123205446.6370687fa983.I811873233b8d71fbde9154b84c85b498521e3b12@changeid>
 <96e31171-965d-c1d7-282e-b1b0bec6b73f@kot-begemot.co.uk>
 <4ebc9f4069082c1fa3606fc636f15c664bc0af60.camel@sipsolutions.net>
 <02516224-6caf-c947-3410-0fcdc6e7204e@kot-begemot.co.uk>
 <6cbfb799d0889dc2d34d7c773a42305d025c615b.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <b93242b0-5088-4534-8f8e-1d92b68eb9f4@kot-begemot.co.uk>
Date: Wed, 2 Dec 2020 11:31:53 +0000
MIME-Version: 1.0
In-Reply-To: <6cbfb799d0889dc2d34d7c773a42305d025c615b.camel@sipsolutions.net>
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



On 02/12/2020 11:29, Johannes Berg wrote:
> On Wed, 2020-12-02 at 09:03 +0000, Anton Ivanov wrote:
>>
>> raw sockets on a vEth pair.
>>
>> I avoid tap as it does not exercise the full vector IO code for now.
>> One day I will find a way to extract from the kernel the underlying
>> socket which tap uses internally and it will become 100% equivalent to
>> the other transports.
> 
> OK, thanks.
> 
>>>> Try to ifup/ifdown the vecX interface inside the UML.
>>>>
>>>> With master it works fine. With this patch it fails.
>>> How does it fail?
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 401 at arch/um/kernel/irq.c:177 um_request_irq+0xff/0x22e
> 
> Hm, interesting. So that means the IRQ was still busy after
> vector_net_close()?
> 
> I'm still digging and trying to build a test case, but if you have a
> test case at hand .. I wonder if IRQ aliasing happened - if you remove
> the "goto out;" in free_irq_by_irq_and_dev(), does that help?
> 
> 
> johannes
> 
> 

I think we should just handle EPOLLHUP and do an IRQ + fd disable if it HUPS.

This way a close will always be handled correctly regardless of where and how it closed.

I am about to try a patch on top of your 7 which does that.

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

