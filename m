Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-8-brendanhiggins@google.com>
 <CACPK8XctCb9Q2RaFVHEDuWxKDXpCWMWs-+vnKZ=SeTa3xRnT_g@mail.gmail.com>
 <CAFd5g45MFYMK-eZWPC5fhm2OkynUXKfArUVhbanYVH+qKRUwPg@mail.gmail.com>
In-Reply-To: <CAFd5g45MFYMK-eZWPC5fhm2OkynUXKfArUVhbanYVH+qKRUwPg@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 27 Jan 2020 01:46:25 -0800
Message-ID: <CAFd5g454tX9zxRAq5T_pDGzcWt7u5r119wjo-BCGVq+=Ej4bGQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] fsi: aspeed: add unspecified HAS_IOMEM dependency
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Joel Stanley <joel@jms.id.au>
Cc: linux-aspeed <linux-aspeed@lists.ozlabs.org>, Andrew Jeffery <andrew@aj.id.au>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Eddie James <eajames@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, Jeremy Kerr <jk@ozlabs.org>, David Gow <davidgow@google.com>, Alistar Popple <alistair@popple.id.au>, linux-fsi@lists.ozlabs.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
List-ID: <linux-um.lists.infradead.org>

On Wed, Dec 11, 2019 at 4:30 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Dec 11, 2019 at 4:12 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Wed, 11 Dec 2019 at 19:28, Brendan Higgins <brendanhiggins@google.com> wrote:
> > >
> > > Currently CONFIG_FSI_MASTER_ASPEED=y implicitly depends on
> > > CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> > > the following build error:
> > >
> > > ld: drivers/fsi/fsi-master-aspeed.o: in function `fsi_master_aspeed_probe':
> > > drivers/fsi/fsi-master-aspeed.c:436: undefined reference to `devm_ioremap_resource'
> > >
> > > Fix the build error by adding the unspecified dependency.
> > >
> > > Reported-by: Brendan Higgins <brendanhiggins@google.com>
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > Nice. I hit this when attempting to force on CONFIG_COMPILE_TEST in
> > order to build some ARM drivers under UM. Do you have plans to fix
> > that too?
>
> The only broken configs I found for UML are all listed on the cover
> letter of this patch. I think fixing COMPILE_TEST on UM could be
> worthwhile. Did you see any brokenness other than what I mentioned on
> the cover letter?
>
> > Do you want to get this in a fix for 5.5?
>
> Preferably, yes.
>
> > Acked-by: Joel Stanley <joel@jms.id.au>

Hey, I know I owe you a reply about debugging your kunitconfig (I'll
try to get to that this week); nevertheless, it looks like this patch
didn't make it into 5.5. Can you make sure it gets into 5.6? It
shouldn't depend on anything else.

Cheers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

