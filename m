Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkQYO-0007IL-8a
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 11:44:12 +0000
Message-ID: <1a63db4f17cf5067fcbeccbee0effea1a84fb088.camel@sipsolutions.net>
Subject: Re: [PATCH 7/7] um: simplify IRQ handling code
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 02 Dec 2020 12:43:52 +0100
In-Reply-To: <6cbfb799d0889dc2d34d7c773a42305d025c615b.camel@sipsolutions.net>
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <20201123205446.6370687fa983.I811873233b8d71fbde9154b84c85b498521e3b12@changeid>
 <96e31171-965d-c1d7-282e-b1b0bec6b73f@kot-begemot.co.uk>
 <4ebc9f4069082c1fa3606fc636f15c664bc0af60.camel@sipsolutions.net>
 <02516224-6caf-c947-3410-0fcdc6e7204e@kot-begemot.co.uk>
 <6cbfb799d0889dc2d34d7c773a42305d025c615b.camel@sipsolutions.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org

On Wed, 2020-12-02 at 12:29 +0100, Johannes Berg wrote:
> 
> I'm still digging and trying to build a test case, but if you have a
> test case at hand .. I wonder if IRQ aliasing happened - if you remove
> the "goto out;" in free_irq_by_irq_and_dev(), does that help?

That wasn't it, but I can reproduce now.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

