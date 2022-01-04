Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4fPl-00AmlS-Go
 for linux-um@lists.infradead.org; Tue, 04 Jan 2022 08:43:31 +0000
Message-ID: <21fc9b66d15300b19e74b7992baa152173a19162.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] IB/rdmavt: modify rdmavt/qp.c for UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 04 Jan 2022 09:43:17 +0100
In-Reply-To: <6c083f0d-4fea-6339-71ca-6e8fb524e1c0@cambridgegreys.com>
References: <20220102070623.24009-1-rdunlap@infradead.org>
 <20220103230445.GA2592848@nvidia.com>
 <50fa4eca-ce74-431f-8497-273d2c5956f2@infradead.org>
 <6c083f0d-4fea-6339-71ca-6e8fb524e1c0@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Randy Dunlap <rdunlap@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-rdma@vger.kernel.org, linux-um@lists.infradead.org

On Tue, 2022-01-04 at 08:03 +0000, Anton Ivanov wrote:
> > 
> > > Why are you trying to make a HW driver compile on UML? Is there any
> > > way to even use a driver like this in a UML environment?
> > 
> > I'm just trying to clean up lots of UML build errors.
> > I'm quite happy just making the driver depend on !UML.
> > 
> > UML maintainers, what do you think?
> > 
> > Thanks again.
> > 
> 
> I would suggest that we just !UML this driver.
> 
Agree, unless some of the maintainers of this driver actually wants to
build simulation for it for testing or something, it's almost certainly
completely useless.

After all, the reason I enabled PCI on UML was to be able to test - in
simulation - PCI driver code in UML... Most certainly nobody wants to do
that here, so it's pointless to let the driver be compiled.

OTOH, as Christoph points out, that seems like a band-aid for some
really strange code, but it's probably the easiest way to get the build
issue fixed in the short term.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

