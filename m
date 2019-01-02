Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gejgO-0005tX-9b
 for linux-um@lists.infradead.org; Wed, 02 Jan 2019 16:47:54 +0000
Subject: Re: [PATCH] um: writev needs <sys/uio.h>
References: <20181227073324.10090-1-hch@lst.de>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <887b21fe-e79a-7291-9527-c52a74ff02c8@cambridgegreys.com>
Date: Wed, 2 Jan 2019 16:47:46 +0000
MIME-Version: 1.0
In-Reply-To: <20181227073324.10090-1-hch@lst.de>
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
To: Christoph Hellwig <hch@lst.de>, richard@nod.at
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org



On 12/27/18 7:33 AM, Christoph Hellwig wrote:
> vector_user.c doesn't compile without this for me.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/um/drivers/vector_user.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> index 3d8cdbdb4e66..41eefbcdc86f 100644
> --- a/arch/um/drivers/vector_user.c
> +++ b/arch/um/drivers/vector_user.c
> @@ -25,6 +25,7 @@
>   #include <linux/if_packet.h>
>   #include <sys/socket.h>
>   #include <sys/wait.h>
> +#include <sys/uio.h>
>   #include <linux/virtio_net.h>
>   #include <netdb.h>
>   #include <stdlib.h>
> 
Acked-by: Anton Ivanov <anton.ivanov at cambridgegreys.com>
-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

