Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glIFk-0001Ov-Rw
 for linux-um@lists.infradead.org; Sun, 20 Jan 2019 18:55:33 +0000
Subject: Re: [-next] um: Remove duplicated include from vector_user.c
References: <1546485161-142907-1-git-send-email-yuehaibing@huawei.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <cff7d34e-7afa-70cc-427d-ebeaa1e65e73@cambridgegreys.com>
Date: Sun, 20 Jan 2019 18:54:56 +0000
MIME-Version: 1.0
In-Reply-To: <1546485161-142907-1-git-send-email-yuehaibing@huawei.com>
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
To: YueHaibing <yuehaibing@huawei.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org



On 1/3/19 3:12 AM, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   arch/um/drivers/vector_user.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> index d2c17dd..b3f7b3c 100644
> --- a/arch/um/drivers/vector_user.c
> +++ b/arch/um/drivers/vector_user.c
> @@ -16,14 +16,12 @@
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <fcntl.h>
> -#include <sys/types.h>
>   #include <sys/socket.h>
>   #include <net/ethernet.h>
>   #include <netinet/ip.h>
>   #include <netinet/ether.h>
>   #include <linux/if_ether.h>
>   #include <linux/if_packet.h>
> -#include <sys/socket.h>
>   #include <sys/wait.h>
>   #include <sys/uio.h>
>   #include <linux/virtio_net.h>
> @@ -31,7 +29,6 @@
>   #include <stdlib.h>
>   #include <os.h>
>   #include <um_malloc.h>
> -#include <sys/uio.h>
>   #include "vector_user.h"
>   
>   #define ID_GRE 0
> 

Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

