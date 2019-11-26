Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZWRq-0001OZ-K7
 for linux-um@lists.infradead.org; Tue, 26 Nov 2019 08:43:52 +0000
Message-ID: <de90b04151bafee083727c9769833932788cf428.camel@sipsolutions.net>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 26 Nov 2019 09:43:36 +0100
In-Reply-To: <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
 <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
 <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>, Hajime Tazaki <thehajime@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Conrad Meyer <cem@freebsd.org>, Octavian Purdila <tavi.purdila@gmail.com>, linux-um@lists.infradead.org, Akira Moroo <retrage01@gmail.com>, Patrick Collins <pscollins@google.com>, linux-kernel-library@freelists.org, Michael Zimmermann <sigmaepsilon92@gmail.com>, Yuan Liu <liuyuan@google.com>

On Mon, 2019-11-25 at 23:07 +0100, Richard Weinberger wrote:
> On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
> > From: Octavian Purdila <tavi.purdila@gmail.com>
> > 
> > Add helpers for implementing host virtio devices. It uses the memory
> > mapped I/O helpers to interact with the Linux MMIO virtio transport
> > driver and offers support to setup and add a new virtio device,
> > dispatch requests from the incoming queues as well as support for
> > completing requests.
> > 
> > All added virtio devices are stored in lkl_virtio_devs as strings, per
> > the Linux MMIO virtio transport driver command line specification.
> 
> Did you checkout arch/um/drivers/virtio_uml.c?
> Why is this driver needed?

This isn't really a driver, this is virtio *device-side* code. Our
virtio_uml is *guest-side* code, and only speaks vhost-user.

I'm not sure how MMIO devices could possibly work though, does LKL
intercept MMIO somehow?

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

