Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2GnG-0001EC-DS
 for linux-um@lists.infradead.org; Thu, 13 Feb 2020 15:52:47 +0000
Message-ID: <e3073fbe7298451467a3a484efad90611df19c9e.camel@sipsolutions.net>
Subject: Re: [PATCH 4/6] um: implement time-travel=ext
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 13 Feb 2020 16:52:39 +0100
In-Reply-To: <m2h7zuwpao.wl-thehajime@gmail.com>
 (sfid-20200213_151101_494563_49D1F81B)
References: <20200213132651.20506-1-johannes@sipsolutions.net>
 <20200213132651.20506-5-johannes@sipsolutions.net>
 <m2h7zuwpao.wl-thehajime@gmail.com> (sfid-20200213_151101_494563_49D1F81B)
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

Hi,

> > The protocol for the unix domain socket is defined in the new file
> > include/uapi/linux/um_timetravel.h.
> 
> I was wondering if the source code of the special application (central
> scheduler?) is public (or not) so that we can test on a local machine.

So ... sadly, it's a bit of a sad story right now.

I have one, but it's part of a bigger testing framework that we wrote
(and uses the infrastructure from it), that I haven't been able to
release so far.

On this tool, conceptually, the code is very simple, just keep a sorted
"next event" list, and tell the next one that it's their turn.

For a vhost-user device implementation, it's a bit more complex, as it
needs to be able to handle scheduler messages while waiting for a vhost-
user ACK message, similar to what you can see in the UML vhost-user
code.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

