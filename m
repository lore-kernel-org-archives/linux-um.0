Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7fd7-00031f-Ca
 for linux-um@lists.infradead.org; Mon, 17 Aug 2020 13:56:54 +0000
Received: by mail-pj1-x1044.google.com with SMTP id ha11so7730745pjb.1
 for <linux-um@lists.infradead.org>; Mon, 17 Aug 2020 06:56:52 -0700 (PDT)
Subject: Re: [PATCH] block: convert tasklets to use new tasklet_setup() API
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
 <20200817091617.28119-2-allen.cryptic@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b5508ca4-0641-7265-2939-5f03cbfab2e2@kernel.dk>
Date: Mon, 17 Aug 2020 06:56:47 -0700
MIME-Version: 1.0
In-Reply-To: <20200817091617.28119-2-allen.cryptic@gmail.com>
Content-Language: en-US
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
To: Allen Pais <allen.cryptic@gmail.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 3chas3@gmail.com, stefanr@s5r6.in-berlin.de, airlied@linux.ie, daniel@ffwll.ch, sre@kernel.org, James.Bottomley@HansenPartnership.com, kys@microsoft.com, deller@gmx.de, dmitry.torokhov@gmail.com, jassisinghbrar@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org, mporter@kernel.crashing.org, alex.bou9@gmail.com, broonie@kernel.org, martyn@welchs.me.uk, manohar.vanga@gmail.com, mitch@sfgoth.com, davem@davemloft.net, kuba@kernel.org
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org, Romain Perier <romain.perier@gmail.com>, keescook@chromium.org, linux-parisc@vger.kernel.org, linux-ntb@googlegroups.com, netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-atm-general@lists.sourceforge.net, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org, linux-block@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>, linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, openipmi-developer@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org

On 8/17/20 2:15 AM, Allen Pais wrote:
> From: Allen Pais <allen.lkml@gmail.com>
> 
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.

Who came up with the idea to add a macro 'from_tasklet' that is just
container_of? container_of in the code would be _much_ more readable,
and not leave anyone guessing wtf from_tasklet is doing.

I'd fix that up now before everything else goes in...

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

