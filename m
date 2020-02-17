Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j3bEA-0000cm-Av
 for linux-um@lists.infradead.org; Mon, 17 Feb 2020 07:54:04 +0000
Subject: Re: [PATCH] um: vector: Avoid NULL ptr deference if transport is unset
References: <20200216213624.800463-1-sjoerd.simons@collabora.co.uk>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <74c04f11-4b67-d1a7-7d05-197a229b245c@cambridgegreys.com>
Date: Mon, 17 Feb 2020 07:53:50 +0000
MIME-Version: 1.0
In-Reply-To: <20200216213624.800463-1-sjoerd.simons@collabora.co.uk>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On 16/02/2020 21:36, Sjoerd Simons wrote:
> When the transport option of a vec isn't set strncmp ends up being
> called on a NULL pointer. Better not do that.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 
> ---
> 
>   arch/um/drivers/vector_kern.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 0ff86391f77d..ca90666c0b61 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -198,6 +198,9 @@ static int get_transport_options(struct arglist *def)
>   	long parsed;
>   	int result = 0;
>   
> +	if (transport == NULL)
> +		return -EINVAL;
> +
>   	if (vector != NULL) {
>   		if (kstrtoul(vector, 10, &parsed) == 0) {
>   			if (parsed == 0) {
> 
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

