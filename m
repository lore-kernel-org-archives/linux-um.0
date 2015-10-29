Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <saurabh.truth@gmail.com>
 <1446103672-28864-1-git-send-email-saurabh.truth@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5631DD29.60000@nod.at>
Date: Thu, 29 Oct 2015 09:47:37 +0100
MIME-Version: 1.0
In-Reply-To: <1446103672-28864-1-git-send-email-saurabh.truth@gmail.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2] um: net: replace GFP_KERNEL with GFP_ATOMIC when
 spinlock is held
To: Saurabh Sengar <saurabh.truth@gmail.com>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 29.10.2015 um 08:27 schrieb Saurabh Sengar:
> replace GFP_KERNEL with GFP_ATOMIC while spinlock is held,
> as code while holding a spinlock should be atomic.
> GFP_KERNEL may sleep and can cause deadlock,
> where as GFP_ATOMIC may fail but certainly avoids deadlock

As UML does not support SMP nor PREEMPT this is a non issue,
spinlocks are a NOP.
But for the sake of completeness you are right, the code needs
fixing.

> Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
> ---
> v2: correcting the subject
> 
>  arch/um/drivers/net_kern.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
> index f70dd54..7d4b709 100644
> --- a/arch/um/drivers/net_kern.c
> +++ b/arch/um/drivers/net_kern.c
> @@ -388,16 +388,22 @@ static const struct net_device_ops uml_netdev_ops = {
>  static int driver_registered;
>  
>  static void eth_configure(int n, void *init, char *mac,
> -			  struct transport *transport)
> +			  struct transport *transport, bool atomic)

Why do you need this atomic variable? Can't you just pass gfp_mask around?

Thanks,
//richard
