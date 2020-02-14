Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2W71-0003n9-6j
 for linux-um@lists.infradead.org; Fri, 14 Feb 2020 08:14:12 +0000
Message-ID: <556e374dd2c4c60b72e21238dd15bd22dedbb38e.camel@sipsolutions.net>
Subject: Re: [PATCH 4/6] um: implement time-travel=ext
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 14 Feb 2020 09:14:08 +0100
In-Reply-To: <m2d0ahwx3q.wl-thehajime@gmail.com>
 (sfid-20200214_063447_318164_2EDFCE53)
References: <20200213132651.20506-1-johannes@sipsolutions.net>
 <20200213132651.20506-5-johannes@sipsolutions.net>
 <m2h7zuwpao.wl-thehajime@gmail.com>
 <e3073fbe7298451467a3a484efad90611df19c9e.camel@sipsolutions.net>
 <m2d0ahwx3q.wl-thehajime@gmail.com> (sfid-20200214_063447_318164_2EDFCE53)
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org


> > On this tool, conceptually, the code is very simple, just keep a sorted
> > "next event" list, and tell the next one that it's their turn.
> 
> I can imagine how it looks like, as I was doing a similar integration
> with kernel code and ns-3 network simulator (which isn't LKL).
> 
> This is just my 2 cents (and may be out of topic for the patch
> review); it would be nice to have an example code of this external
> program.  Since the program is independent from arch/um, this is a
> great opportunity to extend in future.

Right.

> One might wish to implement his/her own scheduler for particular
> purpose; for instance, a randomized error injection into time progress
> to exercise or fuzzing the Linux implementation, or alternate external
> program that can handle multiple UML instances across different nodes
> (it this already possible?).

It's all unix domain sockets now, so no network transparency. Wouldn't
really be hard to make it speak the same protocol over a TCP socket
though, but for UML it seemed a bit beside the point.

> In such case, having a reference implementation would be helpful.

Agree, I'm trying to see how I can get something released.

Perhaps it could be acceptable in the kernel itself, under the tools
folder?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

