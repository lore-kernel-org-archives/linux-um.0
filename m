Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9wQP-0008Ga-55
 for linux-um@lists.infradead.org; Mon, 16 Sep 2019 19:12:43 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1i9wQJ-0003mi-Kg
 for linux-um@lists.infradead.org; Mon, 16 Sep 2019 21:12:31 +0200
Message-ID: <d960106777e366f5598150b5aaa30c95e600f32b.camel@sipsolutions.net>
Subject: Re: [PATCH] um: virtio: remove device on disconnect
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 16 Sep 2019 21:12:30 +0200
In-Reply-To: <1568639186-I0f2810aee05af27171c2dcd9a495f70397da8b35@changeid>
References: <1568639186-I0f2810aee05af27171c2dcd9a495f70397da8b35@changeid>
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
To: linux-um@lists.infradead.org

On Mon, 2019-09-16 at 15:06 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If the connection drops, just remove the device, we don't try
> to recover from this right now.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  arch/um/drivers/virtio_uml.c | 57 +++++++++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index fc8c52cff5aa..1705fad4ad8f 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -42,6 +42,13 @@
>  #define to_virtio_uml_device(_vdev) \
>  	container_of(_vdev, struct virtio_uml_device, vdev)
>  
> +struct virtio_uml_platform_data {

Looks like I messed up the rebase and this patch is missing the removal
of the old definition of this struct...

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

