Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khbSz-0004bT-Ir
 for linux-um@lists.infradead.org; Tue, 24 Nov 2020 16:46:58 +0000
Message-ID: <ebcb1d02478af06d0bb368a338b63752fe6c1d68.camel@sipsolutions.net>
Subject: Re: [PATCH 0/7 um: IRQ handling cleanups
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 24 Nov 2020 17:46:55 +0100
In-Reply-To: <9f8f7c56-5c63-8281-4766-3821cbe6f6a7@kot-begemot.co.uk>
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <3812c8af-edc1-a2ff-96e5-0ad96e85411b@kot-begemot.co.uk>
 <d7b1ec1bbb6995e801c3e7c54c7bb88dcffc54db.camel@sipsolutions.net>
 <293beb66b8293056a1a34ca1bc3b78900bb4d638.camel@sipsolutions.net>
 <cdf91602-b6d8-3347-4d02-747b87fac4b3@kot-begemot.co.uk>
 <61a9da79-da79-d779-78be-af30f88b6f05@kot-begemot.co.uk>
 <425d0c637bff893c89ee9374e6f741bbace89f27.camel@sipsolutions.net>
 <9f8f7c56-5c63-8281-4766-3821cbe6f6a7@kot-begemot.co.uk>
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

On Tue, 2020-11-24 at 16:45 +0000, Anton Ivanov wrote:
> 
> > > That is where ->purge was coming from.
> > I have no idea what ->purge is? :)
> 
> One of the flags on the IRQ info structure.
> 
> You killed that in c0b17c371b43bddcd2fbfe643ce6a6c84347c013 "simplify IRQ handling code"

And didn't even remember, oops. I'll check.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

