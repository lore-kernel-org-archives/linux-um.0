Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ig5at-0003l3-3j
 for linux-um@lists.infradead.org; Sat, 14 Dec 2019 11:28:20 +0000
Date: Sat, 14 Dec 2019 12:28:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 6/7] staging: axis-fifo: add unspecified HAS_IOMEM
 dependency
Message-ID: <20191214112815.GA3335535@kroah.com>
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-7-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191211192742.95699-7-brendanhiggins@google.com>
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Moses Christopher <moseschristopherb@gmail.com>, devel@driverdev.osuosl.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, davidgow@google.com, anton.ivanov@cambridgegreys.com

On Wed, Dec 11, 2019 at 11:27:41AM -0800, Brendan Higgins wrote:
> Currently CONFIG_XIL_AXIS_FIFO=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
> 
> ld: drivers/staging/axis-fifo/axis-fifo.o: in function `axis_fifo_probe':
> drivers/staging/axis-fifo/axis-fifo.c:809: undefined reference to `devm_ioremap_resource'
> 
> Fix the build error by adding the unspecified dependency.
> 
> Reported-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Saying you reported a problem and then fixed it kind of does a bit of
disservice to the "reported-by:" tag which we normally use only to
credit the people that do not actually fix the problem.

So in the future, no need for this to be there for patches that you
write yourself.

thanks,

greg k-h

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

