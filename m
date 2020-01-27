Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-3-brendanhiggins@google.com>
 <20200109162303.35f4f0a3@xps13>
 <CAFd5g47VLB6zOJsSySAYrJie8hj-OkvOC89-z2b9xMBZ2bxvYA@mail.gmail.com>
 <20200125162803.5a2375d7@xps13>
In-Reply-To: <20200125162803.5a2375d7@xps13>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 27 Jan 2020 11:00:33 -0800
Message-ID: <CAFd5g46=wDEMVHqQ-iq31qCxoH_X+4g=+MMx_vA=ujWrF2mfEw@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] mtd: rawnand: add unspecified HAS_IOMEM dependency
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Boris Brezillon <bbrezillon@kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org, David Gow <davidgow@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Piotr Sroka <piotrs@cadence.com>
List-ID: <linux-um.lists.infradead.org>

On Sat, Jan 25, 2020 at 7:28 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Brendan,
>
> Brendan Higgins <brendanhiggins@google.com> wrote on Fri, 24 Jan 2020
> 18:12:12 -0800:
>
> > On Thu, Jan 9, 2020 at 7:23 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Brendan,
> > >
> > > Brendan Higgins <brendanhiggins@google.com> wrote on Wed, 11 Dec 2019
> > > 11:27:37 -0800:
> > >
> > > > Currently CONFIG_MTD_NAND_CADENCE implicitly depends on
> > > > CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> > > > the following build error:
> > > >
> > > > ld: drivers/mtd/nand/raw/cadence-nand-controller.o: in function `cadence_nand_dt_probe.cold.31':
> > > > drivers/mtd/nand/raw/cadence-nand-controller.c:2969: undefined reference to `devm_platform_ioremap_resource'
> > > > ld: drivers/mtd/nand/raw/cadence-nand-controller.c:2977: undefined reference to `devm_ioremap_resource'
> > > >
> > > > Fix the build error by adding the unspecified dependency.
> > > >
> > > > Reported-by: Brendan Higgins <brendanhiggins@google.com>
> > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > ---
> > >
> > > Sorry for the delay.
> > >
> > > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > It looks like my change has not been applied to nand/next; is this the
> > branch it should be applied to? I have also verified that this patch
> > isn't in linux-next as of Jan 24th.
> >
> > Is mtd/linux the correct tree for this? Or do I need to reach out to
> > someone else?
>
> When I sent my Acked-by I supposed someone else would pick the patch,
> but there is actually no dependency with all the other patches so I
> don't know why I did it... Sorry about that. I'll take it anyway in my
> PR for 5.6.

No worries, thanks!

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

