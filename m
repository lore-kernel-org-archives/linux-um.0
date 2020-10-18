Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
In-Reply-To: <20200817091617.28119-1-allen.cryptic@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 18 Oct 2020 23:50:00 +0200
Message-ID: <CAFLxGvxsHD6zvTJSHeo2gaoRQfjUPZ6M=5BirOObHFjGqnzfew@mail.gmail.com>
Subject: Re: [PATCH] arch: um: convert tasklets to use new tasklet_setup() API
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
To: Allen Pais <allen.cryptic@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-atm-general@lists.sourceforge.net, manohar.vanga@gmail.com, Dave Airlie <airlied@linux.ie>, Allen Pais <allen.lkml@gmail.com>, linux-hyperv@vger.kernel.org, DRI mailing list <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Maxim Levitsky <maximlevitsky@gmail.com>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, jassisinghbrar@gmail.com, 3chas3@gmail.com, intel-gfx@lists.freedesktop.org, kuba@kernel.org, mporter@kernel.crashing.org, Jeff Dike <jdike@addtoit.com>, Kees Cook <keescook@chromium.org>, Alex Dubov <oakad@yahoo.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-input@vger.kernel.org, linux-um <linux-um@lists.infradead.org>, linux-block@vger.kernel.org, Mark Brown <broonie@kernel.org>, openipmi-developer@lists.sourceforge.net, mitch@sfgoth.com, linux-arm-kernel@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, linux-parisc@vger.kernel.org, netdev@vger.kernel.org, martyn@welchs.me.uk, dmitry.torokhov@gmail.com, linux-mmc@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, alex.bou9@gmail.com, stefanr@s5r6.in-berlin.de, Daniel Vetter <daniel@ffwll.ch>, linux-ntb@googlegroups.com, Romain Perier <romain.perier@gmail.com>, Shawn Guo <shawnguo@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Aug 17, 2020 at 11:17 AM Allen Pais <allen.cryptic@gmail.com> wrote:
>
> From: Allen Pais <allen.lkml@gmail.com>
>
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.
>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  arch/um/drivers/vector_kern.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Anton, can you please review this patch?

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

