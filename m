Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAYOw-0007Ln-9I
 for linux-um@lists.infradead.org; Wed, 18 Sep 2019 11:45:39 +0000
Message-ID: <6a7252e06adf38b85901339359b65450ee4fcd6c.camel@sipsolutions.net>
Subject: Re: CONFIG_COMPAT for UM?
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 18 Sep 2019 13:45:29 +0200
In-Reply-To: <5dd98ebf-7da7-ec81-ef65-709c009670a2@kot-begemot.co.uk>
References: <60f73376da11640d5b335512f052a583fd784fd8.camel@sipsolutions.net>
 <76d688c3-3d8b-fb59-3ad4-ef8dd9c023be@kot-begemot.co.uk>
 <b3507d24-ebd9-8e7f-25a8-61c1891c37d4@kot-begemot.co.uk>
 <5dad6c3e76e474b9f43df99ea235eb77389ce63f.camel@sipsolutions.net>
 <bd6edd3b-f0e3-c3e8-1b2a-e1395dcaf6aa@kot-begemot.co.uk>
 <06bdd645f5f9832ec37e6e50e12602fa6661cca9.camel@sipsolutions.net>
 <5dd98ebf-7da7-ec81-ef65-709c009670a2@kot-begemot.co.uk>
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

On Wed, 2019-09-18 at 09:32 +0100, Anton Ivanov wrote:
> On 18/09/2019 09:25, Johannes Berg wrote:
> > > > Yeah, I guess I could run as a 32-bit instance, but I'd rather actually
> > > > use a 64-bit instance.
> > > Not if you want to run many of them.
> > Probably not more than a dozen I guess?
> 
> 256

I just started 255 (yeah, was using a stupid script for IP addresses)
instances co-scheduling simulated time, and it took only 5:42 min for
all of them to run "sleep 600".

Now, yeah, obviously they weren't doing anything. I assume this whole
thread for the page tables really only kicks in when they're working and
faulting.

Also, the simulated time means only one of them really runs at a time,
so perhaps that even helps ...

Anyway, I don't think I'll need virtual labs as big as this, so ...

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

