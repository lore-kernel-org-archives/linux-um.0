Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZWaP-0004lZ-Rs
 for linux-um@lists.infradead.org; Tue, 26 Nov 2019 08:52:43 +0000
Message-ID: <4ebb14dc67ccb70543617ce1f7066f3f27cd11a8.camel@sipsolutions.net>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 26 Nov 2019 09:52:34 +0100
In-Reply-To: <1662825264.98055.1574758225905.JavaMail.zimbra@nod.at>
References: <cover.1573179553.git.thehajime@gmail.com>
 <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
 <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com>
 <de90b04151bafee083727c9769833932788cf428.camel@sipsolutions.net>
 <1662825264.98055.1574758225905.JavaMail.zimbra@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: linux-arch <linux-arch@vger.kernel.org>, cem <cem@freebsd.org>, tavi purdila <tavi.purdila@gmail.com>, linux-um <linux-um@lists.infradead.org>, retrage01 <retrage01@gmail.com>, liuyuan <liuyuan@google.com>, pscollins <pscollins@google.com>, linux-kernel-library@freelists.org, sigmaepsilon92 <sigmaepsilon92@gmail.com>, Hajime Tazaki <thehajime@gmail.com>

On Tue, 2019-11-26 at 09:50 +0100, Richard Weinberger wrote:

> > This isn't really a driver, this is virtio *device-side* code. Our
> > virtio_uml is *guest-side* code, and only speaks vhost-user.
> 
> Sorry, bad wording from my side. I meant with "driver" a kernel component.

Yeah, though arguably this isn't a kernel component, this is a
hypervisor component... We just link them both into the same binary due
to the way UML/LKL work.
 
> > I'm not sure how MMIO devices could possibly work though, does LKL
> > intercept MMIO somehow?
> 
> My point is that UML and LKL should try to do use the same concept/code
> regarding virtio. At the end of day both use virtual devices which use
> facilities from the host.
> If this is really not possible it needs a good explanation.

I think it isn't possible, unless you use vhost-user over a unix domain
socket internally to talk between the kernel (virtio_uml) and hypervisor
(device) components.

In virtio_uml, the device implementation is assumed to be a separate
process with a vhost-user connection. Here in LKL, the virtio device is
part of the "hypervisor", i.e. in the same process.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

