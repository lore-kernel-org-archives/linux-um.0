Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkC40-00056F-DP
 for linux-um@lists.infradead.org; Tue, 01 Dec 2020 20:15:53 +0000
Message-ID: <4ebc9f4069082c1fa3606fc636f15c664bc0af60.camel@sipsolutions.net>
Subject: Re: [PATCH 7/7] um: simplify IRQ handling code
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 01 Dec 2020 21:15:47 +0100
In-Reply-To: <96e31171-965d-c1d7-282e-b1b0bec6b73f@kot-begemot.co.uk>
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <20201123205446.6370687fa983.I811873233b8d71fbde9154b84c85b498521e3b12@changeid>
 <96e31171-965d-c1d7-282e-b1b0bec6b73f@kot-begemot.co.uk>
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

On Mon, 2020-11-30 at 16:30 +0000, Anton Ivanov wrote:
> On 23/11/2020 19:56, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > Reduce dynamic allocations (and thereby cache misses) by simply
> > embedding the registration data for IRQs in the irq_entry, we
> > never supported these being really dynamic anyway as only one
> > was ever allowed ("Trying to reregister ...").
> > 
> > Lockless behaviour is preserved by removing the FD from the poll
> > set appropriately, but we use reg->events to indicate whether or
> > not this entry is used, rather than dynamically allocating them.
> > 
> > Also port the list of IRQ entries to list_head instead of the
> > current open-coded singly-linked list implementation, just for
> > sanity.
> 
> This one is broken. I will look exactly where. It is somewhere in the IRQ delete/re-request logic.
> 
> How to test
> 
> run iperf -s in the UML with a vector network driver.
> 
> run iperf -c to the UML instance from the host in a loop

How do you usually use it? tap device?

> Try to ifup/ifdown the vecX interface inside the UML.
> 
> With master it works fine. With this patch it fails.

How does it fail?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

