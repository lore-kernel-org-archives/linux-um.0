Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from helcar.hmeau.com ([216.24.177.18] helo=deadmen.hmeau.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iiCNu-0006V8-6u
 for linux-um@lists.infradead.org; Fri, 20 Dec 2019 07:07:39 +0000
Date: Fri, 20 Dec 2019 15:07:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v1 4/7] crypto: inside-secure: add unspecified HAS_IOMEM
 dependency
Message-ID: <20191220070722.p7iciqehyr3j5uqs@gondor.apana.org.au>
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-5-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191211192742.95699-5-brendanhiggins@google.com>
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
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, davidgow@google.com, "David S. Miller" <davem@davemloft.net>, anton.ivanov@cambridgegreys.com

On Wed, Dec 11, 2019 at 11:27:39AM -0800, Brendan Higgins wrote:
> Currently CONFIG_CRYPTO_DEV_SAFEXCEL=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
> 
> ld: drivers/crypto/inside-secure/safexcel.o: in function `safexcel_probe':
> drivers/crypto/inside-secure/safexcel.c:1692: undefined reference to `devm_platform_ioremap_resource'
> 
> Fix the build error by adding the unspecified dependency.
> 
> Reported-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/crypto/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

