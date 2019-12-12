Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-8-brendanhiggins@google.com>
In-Reply-To: <20191211192742.95699-8-brendanhiggins@google.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 12 Dec 2019 00:12:43 +0000
Message-ID: <CACPK8XctCb9Q2RaFVHEDuWxKDXpCWMWs-+vnKZ=SeTa3xRnT_g@mail.gmail.com>
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: linux-aspeed <linux-aspeed@lists.ozlabs.org>, Andrew Jeffery <andrew@aj.id.au>, Richard Weinberger <richard@nod.at>, jdike@addtoit.com, Eddie James <eajames@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org, Jeremy Kerr <jk@ozlabs.org>, davidgow@google.com, Alistar Popple <alistair@popple.id.au>, linux-fsi@lists.ozlabs.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, anton.ivanov@cambridgegreys.com
List-ID: <linux-um.lists.infradead.org>

On Wed, 11 Dec 2019 at 19:28, Brendan Higgins <brendanhiggins@google.com> wrote:
>
> Currently CONFIG_FSI_MASTER_ASPEED=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
>
> ld: drivers/fsi/fsi-master-aspeed.o: in function `fsi_master_aspeed_probe':
> drivers/fsi/fsi-master-aspeed.c:436: undefined reference to `devm_ioremap_resource'
>
> Fix the build error by adding the unspecified dependency.
>
> Reported-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Nice. I hit this when attempting to force on CONFIG_COMPILE_TEST in
order to build some ARM drivers under UM. Do you have plans to fix
that too?

Do you want to get this in a fix for 5.5?

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

> ---
>  drivers/fsi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
> index 92ce6d85802cc..4cc0e630ab79b 100644
> --- a/drivers/fsi/Kconfig
> +++ b/drivers/fsi/Kconfig
> @@ -55,6 +55,7 @@ config FSI_MASTER_AST_CF
>
>  config FSI_MASTER_ASPEED
>         tristate "FSI ASPEED master"
> +       depends on HAS_IOMEM
>         help
>          This option enables a FSI master that is present behind an OPB bridge
>          in the AST2600.
> --
> 2.24.0.525.g8f36a354ae-goog
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

