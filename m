Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krgAA-0005Ko-Qq
 for linux-um@lists.infradead.org; Tue, 22 Dec 2020 11:49:11 +0000
In-Reply-To: <20201221022434.21725-1-thehajime@gmail.com>
From: "Christopher Obbard" <chris.obbard@collabora.com>
Date: Tue, 22 Dec 2020 11:49:05 +0000
MIME-Version: 1.0
Message-ID: <5f11-5fe1dd00-6d-1cae2c20@60061556>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH=5D?==?utf-8?q?_um=3A?=
 =?utf-8?q?_ubd=3A?= fix command line handling of ubd
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
Cc: richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, anton.ivanov@cambridgegreys.com

Hi Hajime,

Doh! Thanks for sorting out this regression!
 
On Monday, 21 December, 2020 02:24 GMT, Hajime Tazaki <thehajime@gmail.com> wrote: 
> This commit fixes a regression to handle command line parameters of ubd.
> With a simple line "./linux ubd0="./disk-ext4.img", it fails at
> ubd_setup_common().  The commit adds additional checks to the variables
> in order to properly parse the paremeters which previously worked.
> 
> Fixes: ef3ba87cb7c9 ("um: ubd: Set device serial attribute from
> cmdline")
> Cc: Christopher Obbard <chris.obbard@collabora.com>
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>

Acked-by: Christopher Obbard <chris.obbard@collabora.com>

> ---
>  arch/um/drivers/ubd_kern.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 13b1fe694b90..bd16b17ba4d6 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -375,11 +375,11 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
>  		file = NULL;
>  
>  	backing_file = strsep(&str, ",:");
> -	if (*backing_file == '\0')
> +	if (backing_file && *backing_file == '\0')
>  		backing_file = NULL;
>  
>  	serial = strsep(&str, ",:");
> -	if (*serial == '\0')
> +	if (serial && *serial == '\0')
>  		serial = NULL;
>  
>  	if (backing_file && ubd_dev->no_cow) {
> -- 
> 2.17.2
>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

