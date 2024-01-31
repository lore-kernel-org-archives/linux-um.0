Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A09FC47258
	for <linux-um@archiver.kernel.org>; Wed, 31 Jan 2024 11:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4SCD0rDarmz1iy62b4hdqUoGkjxINJp7K5S+g5qjGms=; b=GxI+53S6J/fY81xRjjMlBla9ot
	o830m91qNGIvoOGr1pJ8VY3PBopK3t3cuGLoKPGzzlyFbgXigaf67qfZClUziuItaYbNKEWNS+qMa
	9dfnFjhz8LCjIMFXYKEdYH5Hgulk9e56FCpt9gXOi8Gnu5DeKrzTYZ9Q4v4Qz6RvYU1rMySsvJ7N+
	c0FzanQqyiz0MVuyyEWsSEwqN7PPt18ErIlaQoTpw97GLxBRMQIctysFk4ZGwZaPSS1sRX4R7fRI7
	6iyqiEwu/GcBAtpPnoyJOiQOl7Eqvwbd7IGS6eCurQvGniy9KQGV6q1xE4SJC9p5PTN0KZFss5VI3
	+r8/Eo0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV8NO-00000002xuj-2L7i;
	Wed, 31 Jan 2024 11:03:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV8NM-00000002xtr-1jgi
	for linux-um@bombadil.infradead.org;
	Wed, 31 Jan 2024 11:03:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:Date:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4SCD0rDarmz1iy62b4hdqUoGkjxINJp7K5S+g5qjGms=; b=XoMJyvTI6OhW1IR3w6lJ0aBMEG
	HZX7r5tAA3aEhETbYwP4qVdySJc9u1d7Kbkw9re+pwWnWf5IhRpiTd6NMxDL8xwPLFjiib7j+sK8+
	cEPJcLg2ow9stqpbOGJSiD6plDeBqywXiBW+wjlBfnJcV1aOaz0wthKmML6PtwpW6whyB7XVXoAPo
	atac1jYoQgIBbHAg1m5Mw90P5IDMBMka7Slk5uSjiGAqYi+E+3ndGJyiAyxlyVVTQY6YwedKMzf01
	/mJfTI9RKk223wOszN4Ic+WNAjc1zJvsDKzwMf4RP3Hp6ozE7Jyz1H4ZwuYX/xg3NixN2Z0Dd+xcM
	Rfvy3fvQ==;
Received: from mgamail.intel.com ([198.175.65.10])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV8NJ-00000008zty-0cDd
	for linux-um@lists.infradead.org;
	Wed, 31 Jan 2024 11:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706699006; x=1738235006;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=w5tD2hF6VL4scoYvTlWDh0fos6f759HiGvpQ7AYLjAI=;
  b=EvVcEaSTJFyQHuIK/5IbVhCVxHcLriahsqxHmIFnjk34IFkVpP0LR+A7
   OMd25m8bu42DV3Z1coXKLYyZOxoxiKNC4E6ZhemumAfHrFTfuLp7gSHZK
   5hQxokQRXqCDR4LBWBAjOkfA533Ey2ryfvYhjEbEY/vAUwWj+y1R7ZUur
   oZOBLIWdKchw6EiUXyB3ZhAnHMTxarxrOy/wm+JbAWurly++cl4eMNgKS
   BBGMK8f0KEIklr0Y7Ro98HizMt6hAdecYaFMfMLQOxct/EgPX/c02lnGX
   b8XQjZRaXids+Vng2+KvZekfHOkSZMalRACHZTOl50s3iXJ7AmUKg3bkL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="16947165"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="16947165"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:03:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="30460973"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.167])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:03:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 31 Jan 2024 13:03:04 +0200 (EET)
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
    Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
    Johannes Berg <johannes@sipsolutions.net>, 
    "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Vadim Pasternak <vadimp@nvidia.com>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Mathieu Poirier <mathieu.poirier@linaro.org>, 
    Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
    Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
    Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
    Daniel Borkmann <daniel@iogearbox.net>, 
    Jesper Dangaard Brouer <hawk@kernel.org>, 
    John Fastabend <john.fastabend@gmail.com>, 
    Benjamin Berg <benjamin.berg@intel.com>, 
    Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
    Netdev <netdev@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
    kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH vhost 08/17] virtio: vring_new_virtqueue(): pass struct
 instead of multi parameters
In-Reply-To: <20240130114224.86536-9-xuanzhuo@linux.alibaba.com>
Message-ID: <bcd0e35e-e9a3-48b5-fc0a-117ba997439a@linux.intel.com>
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-9-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_110325_631059_68A76CF3 
X-CRM114-Status: GOOD (  10.92  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, 30 Jan 2024, Xuan Zhuo wrote:

> Just like find_vqs(), it is time to refactor the
> vring_new_virtqueue(). We pass the similar struct to
> vring_new_virtqueue.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> index 98ff808d6f0c..37f8c5d34285 100644
> --- a/tools/virtio/vringh_test.c
> +++ b/tools/virtio/vringh_test.c

> @@ -391,7 +391,7 @@ static int parallel_test(u64 features,
>  				/* Swallow all notifies at once. */
>  				if (read(to_guest[0], buf, sizeof(buf)) < 1)
>  					break;
> -				
> +
>  				receives++;
>  				virtqueue_disable_cb(vq);
>  				continue;
> @@ -424,7 +424,7 @@ static int parallel_test(u64 features,
>  				continue;
>  			if (read(to_guest[0], buf, sizeof(buf)) < 1)
>  				break;
> -				
> +

Two unrelated space changes. Please remove them from this patch.


-- 
 i.


