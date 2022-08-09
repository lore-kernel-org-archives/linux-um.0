Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLTe4-005RUz-UV
	for linux-um@lists.infradead.org; Tue, 09 Aug 2022 18:08:02 +0000
Message-ID: <76b5db88b280cccb784209b26fe48799dcb41b13.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: read multiple msg from virtio slave request fd
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 09 Aug 2022 20:07:47 +0200
In-Reply-To: <20220607112714.516408-1-benjamin.beichler@uni-rostock.de>
References: <20220607112714.516408-1-benjamin.beichler@uni-rostock.de>
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
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, 2022-06-07 at 11:27 +0000, Benjamin Beichler wrote:
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
> 
> Anyways, in general it seems to be more natural to consume always all
> messages from a socket, instead of only a single one.
> 
> Fixes: 2cd097ba8c05 ("um: virtio: Implement VHOST_USER_PROTOCOL_F_SLAVE_REQ")
> Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
> 

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>


Sorry, should've sent that earlier.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

