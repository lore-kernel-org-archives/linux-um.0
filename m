Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwhvo-000be1-Gb
 for linux-um@lists.infradead.org; Fri, 25 Jun 2021 09:15:27 +0000
Subject: Re: [PATCH 4/4] um: virtio_uml: fix memory leak on init failures
References: <20210625103436.900a9e962c32.Id45a0d2d0167dd9b6a067b42d791523896574064@changeid>
 <20210625103437.bb82b95035e4.I748b002f0650d0705e6ae6b4c4f4b63face436f7@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <ab85d80c-850b-90a7-1695-4b2120610c67@kot-begemot.co.uk>
Date: Fri, 25 Jun 2021 10:15:19 +0100
MIME-Version: 1.0
In-Reply-To: <20210625103437.bb82b95035e4.I748b002f0650d0705e6ae6b4c4f4b63face436f7@changeid>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>



On 25/06/2021 09:34, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If initialization fails, e.g. because the connection failed,
> we leak the 'vu_dev'. Fix that. Reported by smatch.
> 
> Fixes: 5d38f324993f ("um: drivers: Add virtio vhost-user driver")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/drivers/virtio_uml.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index cb79fe33d84e..d51e445df797 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -1140,7 +1140,7 @@ static int virtio_uml_probe(struct platform_device *pdev)
>   		rc = os_connect_socket(pdata->socket_path);
>   	} while (rc == -EINTR);
>   	if (rc < 0)
> -		return rc;
> +		goto error_free;
>   	vu_dev->sock = rc;
>   
>   	spin_lock_init(&vu_dev->sock_lock);
> @@ -1161,6 +1161,8 @@ static int virtio_uml_probe(struct platform_device *pdev)
>   
>   error_init:
>   	os_close_file(vu_dev->sock);
> +error_free:
> +	kfree(vu_dev);
>   	return rc;
>   }
>   
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

