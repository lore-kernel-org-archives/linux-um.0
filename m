Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 20 Dec 2019 15:07:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v1 5/7] crypto: amlogic: add unspecified HAS_IOMEM
 dependency
Message-ID: <20191220070728.h27vroaumpbzupdr@gondor.apana.org.au>
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
Cc: richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>, davidgow@google.com, linux-amlogic@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, anton.ivanov@cambridgegreys.com

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

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

