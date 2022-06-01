Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwRul-00HFll-5o
	for linux-um@lists.infradead.org; Wed, 01 Jun 2022 17:13:48 +0000
Message-ID: <360edf352f888f4607e0411df8a994aa087e9db4.camel@sipsolutions.net>
Subject: Re: [PATCH] um: read multiple msg from virtio slave request fd
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 01 Jun 2022 19:13:29 +0200
In-Reply-To: <20220601153722.181427-1-benjamin.beichler@uni-rostock.de>
References: <20220601153722.181427-1-benjamin.beichler@uni-rostock.de>
MIME-Version: 1.0
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
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, jdike@addtoit.com, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, 2022-06-01 at 15:37 +0000, Benjamin Beichler wrote:
> If VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS is activated, the user mode
> linux virtio irq handler only read one msg from the corresponding socket.
> This creates issues, when the device emulation creates multiple call
> requests (e.g. for multiple virtqueues), as the socket buffer tend to fill
> up and the call requests are delayed.
> 
> This creates a deadlock situation, when the device simulation blocks,
> because of sending a msg and the kernel side blocks because of
> synchronously waiting for an acknowledge of kick request.
> 
> Actually inband notifications are meant to be used in combination with the
> time travel protocol, but it is not required, therefore this corner case
> needs to be handled.

Hmm. How did you run into this? Why would a device send many messages
and not wait for ACK, but the kernel side actually waits for ACK? What
would the use case for that be? Seems a bit odd, if both wait for ACK
there shouldn't be an issue?

Anyway, I guess I don't mind fixing this regardless of whether I see a
use case where it could happen :-)


> +++ b/arch/um/drivers/virtio_uml.c
> @@ -363,45 +363,47 @@ static irqreturn_t vu_req_read_message(struct virtio_uml_device *vu_dev,
>  		struct vhost_user_msg msg;
>  		u8 extra_payload[512];
>  	} msg;
> -	int rc;
> -
> -	rc = vhost_user_recv_req(vu_dev, &msg.msg,
> -				 sizeof(msg.msg.payload) +
> -				 sizeof(msg.extra_payload));
> -
> -	if (rc)

This code changed a bit, you should rebase onto the uml tree's for-next
branch.

> +	while (1) {
> +		if (vhost_user_recv_req(vu_dev, &msg.msg,
> +					sizeof(msg.msg.payload)
> +					+ sizeof(msg.extra_payload)))

prefer to keep the + on the previous line.


That said, my attempt at rebasing this made it all fail completely,
maybe you have better luck :)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

