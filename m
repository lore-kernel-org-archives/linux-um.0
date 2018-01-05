Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH -next] um: vector: fix missing unlock on error in
 vector_net_open()
References: <1515136972-58532-1-git-send-email-weiyongjun1@huawei.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <e7f77323-5a4e-288f-8319-e670a8de5480@cambridgegreys.com>
Date: Fri, 5 Jan 2018 10:12:20 +0000
MIME-Version: 1.0
In-Reply-To: <1515136972-58532-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, dan.carpenter@oracle.com
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Wei,

I just double-checked.

This issue has been fixed in a patch submitted by Dan Carpenter on 09th 
Dec 2017 which I acknowledged on 11th Dec 2017 and which should be in 
Richard's queue to be applied.

It should at some point show up in Linux-next.

Best Regards and once again, thanks for looking into it.

A.


On 01/05/18 07:22, Wei Yongjun wrote:
> Add the missing unlock before return from function vector_net_open()
> in the error handling case.
>
> Fixes: ad1f62ab2bd4 ("High Performance UML Vector Network Driver")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   arch/um/drivers/vector_kern.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index d1d5301..bb83a2d 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1156,8 +1156,10 @@ static int vector_net_open(struct net_device *dev)
>   	struct vector_device *vdevice;
>   
>   	spin_lock_irqsave(&vp->lock, flags);
> -	if (vp->opened)
> +	if (vp->opened) {
> +		spin_unlock_irqrestore(&vp->lock, flags);
>   		return -ENXIO;
> +	}
>   	vp->opened = true;
>   	spin_unlock_irqrestore(&vp->lock, flags);
>
>

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/


