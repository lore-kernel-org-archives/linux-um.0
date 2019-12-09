Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieGgs-00054V-BB
 for linux-um@lists.infradead.org; Mon, 09 Dec 2019 10:55:00 +0000
Message-ID: <db33800253f071a1cfbb91f413af59e73faa6775.camel@sipsolutions.net>
Subject: Re: [PATCH] virtio: Work around frames incorrectly marked as gso
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 09 Dec 2019 11:54:46 +0100
In-Reply-To: <20191209104824.17059-1-anton.ivanov@cambridgegreys.com>
References: <20191209104824.17059-1-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com, netdev@vger.kernel.org
Cc: jasowang@redhat.com, mst@redhat.com, linux-um@lists.infradead.org, virtualization@lists.linux-foundation.org


>  		else if (sinfo->gso_type & SKB_GSO_TCPV6)
>  			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
> -		else
> -			return -EINVAL;
> +		else {
> +			if (skb->data_len == 0)
> +				hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;


maybe use "else if" like in the before? yes, it's a different type of
condition, but braces look a bit unnatural here to me at least

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

