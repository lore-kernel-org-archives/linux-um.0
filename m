Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZMVv-0001J4-6P
 for linux-um@lists.infradead.org; Mon, 25 Nov 2019 22:07:24 +0000
Received: by mail-wr1-x443.google.com with SMTP id s5so20052030wrw.2
 for <linux-um@lists.infradead.org>; Mon, 25 Nov 2019 14:07:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com>
 <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
In-Reply-To: <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 25 Nov 2019 23:07:09 +0100
Message-ID: <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Conrad Meyer <cem@freebsd.org>, Octavian Purdila <tavi.purdila@gmail.com>, linux-um@lists.infradead.org, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, Patrick Collins <pscollins@google.com>, Michael Zimmermann <sigmaepsilon92@gmail.com>, Yuan Liu <liuyuan@google.com>

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> Add helpers for implementing host virtio devices. It uses the memory
> mapped I/O helpers to interact with the Linux MMIO virtio transport
> driver and offers support to setup and add a new virtio device,
> dispatch requests from the incoming queues as well as support for
> completing requests.
>
> All added virtio devices are stored in lkl_virtio_devs as strings, per
> the Linux MMIO virtio transport driver command line specification.

Did you checkout arch/um/drivers/virtio_uml.c?
Why is this driver needed?

Virtio support is rather new in UML, we definitely need a common
code base for LKL and UML regarding to virtio.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

