Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAVHM-00050w-Lm
 for linux-um@lists.infradead.org; Wed, 18 Sep 2019 08:25:38 +0000
Message-ID: <06bdd645f5f9832ec37e6e50e12602fa6661cca9.camel@sipsolutions.net>
Subject: Re: CONFIG_COMPAT for UM?
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 18 Sep 2019 10:25:33 +0200
In-Reply-To: <bd6edd3b-f0e3-c3e8-1b2a-e1395dcaf6aa@kot-begemot.co.uk>
References: <60f73376da11640d5b335512f052a583fd784fd8.camel@sipsolutions.net>
 <76d688c3-3d8b-fb59-3ad4-ef8dd9c023be@kot-begemot.co.uk>
 <b3507d24-ebd9-8e7f-25a8-61c1891c37d4@kot-begemot.co.uk>
 <5dad6c3e76e474b9f43df99ea235eb77389ce63f.camel@sipsolutions.net>
 <bd6edd3b-f0e3-c3e8-1b2a-e1395dcaf6aa@kot-begemot.co.uk>
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

> > Yeah, I guess I could run as a 32-bit instance, but I'd rather actually
> > use a 64-bit instance. 
> 
> Not if you want to run many of them.

Probably not more than a dozen I guess?

> The 3-level page tables in 64 bit spin up a whole raft threads making it 
> unfeasible. Compared to that the 32 bit uses 5 threads in total per 
> instance.

I'm probably missing something, how are threads related to page tables?

I can see how that would use more memory, but where do threads come in?

> I have tried a couple of times to figure out a way to make the 64 bit 
> drop down to two-level for small instances like f.e running OpenWRT with 
> 64 or 128MB RAM, but it does not work.
> 
> To be honest, I was not trying very hard :)

:)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

