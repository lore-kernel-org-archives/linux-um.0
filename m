Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifUGS-0003Pv-4G
 for linux-um@lists.infradead.org; Thu, 12 Dec 2019 19:36:45 +0000
Received: by mail-wr1-x441.google.com with SMTP id g17so4056248wro.2
 for <linux-um@lists.infradead.org>; Thu, 12 Dec 2019 11:36:43 -0800 (PST)
Date: Thu, 12 Dec 2019 20:36:39 +0100
From: LABBE Corentin <clabbe@baylibre.com>
Subject: Re: [PATCH v1 5/7] crypto: amlogic: add unspecified HAS_IOMEM
 dependency
Message-ID: <20191212193639.GA25451@Red>
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-6-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191211192742.95699-6-brendanhiggins@google.com>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, davidgow@google.com, linux-amlogic@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, anton.ivanov@cambridgegreys.com

On Wed, Dec 11, 2019 at 11:27:40AM -0800, Brendan Higgins wrote:
> Currently CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
> 
> ld: drivers/crypto/amlogic/amlogic-gxl-core.o: in function `meson_crypto_probe':
> drivers/crypto/amlogic/amlogic-gxl-core.c:240: undefined reference to `devm_platform_ioremap_resource'
> 
> Fix the build error by adding the unspecified dependency.
> 
> Reported-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/crypto/amlogic/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/amlogic/Kconfig b/drivers/crypto/amlogic/Kconfig
> index b90850d18965f..cf95476026708 100644
> --- a/drivers/crypto/amlogic/Kconfig
> +++ b/drivers/crypto/amlogic/Kconfig
> @@ -1,5 +1,6 @@
>  config CRYPTO_DEV_AMLOGIC_GXL
>  	tristate "Support for amlogic cryptographic offloader"
> +	depends on HAS_IOMEM
>  	default y if ARCH_MESON
>  	select CRYPTO_SKCIPHER
>  	select CRYPTO_ENGINE

Acked-by: Corentin Labbe <clabbe@baylibre.com>

Thanks

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

