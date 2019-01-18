Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] um: Remove duplicate headers
References: <5c41e99b.1c69fb81.f240b.506a@mx.google.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <dfdf5e70-f782-d90e-1059-a524a5e72b7d@cambridgegreys.com>
Date: Fri, 18 Jan 2019 19:23:07 +0000
MIME-Version: 1.0
In-Reply-To: <5c41e99b.1c69fb81.f240b.506a@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Sabyasachi Gupta <sabyasachi.linux@gmail.com>, jdike@addtoit.com, richard@nod.at, yuehaibing@huawei.com
Cc: brajeswar.linux@gmail.com, linux-um@lists.infradead.org, jrdr.linux@gmail.com, linux-kernel@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>



On 18/01/2019 14:58, Sabyasachi Gupta wrote:
> Remove sys/socket.h and sys/uio.h which are included more than once
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>   arch/um/drivers/vector_user.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> index d2c17dd..c863921 100644
> --- a/arch/um/drivers/vector_user.c
> +++ b/arch/um/drivers/vector_user.c
> @@ -23,7 +23,6 @@
>   #include <netinet/ether.h>
>   #include <linux/if_ether.h>
>   #include <linux/if_packet.h>
> -#include <sys/socket.h>
>   #include <sys/wait.h>
>   #include <sys/uio.h>
>   #include <linux/virtio_net.h>
> @@ -31,7 +30,6 @@
>   #include <stdlib.h>
>   #include <os.h>
>   #include <um_malloc.h>
> -#include <sys/uio.h>
>   #include "vector_user.h"
>   
>   #define ID_GRE 0
> 

Hi Sabyasachi,

I believe we have an identical patch enqueued already from a couple of 
weeks back.

Best Regards,

A.

