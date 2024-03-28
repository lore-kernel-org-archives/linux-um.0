Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7959C54E64
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPjQD/vT8EW8FIsS5EhEUvjw7Yq2DPw74odbleQjQC0=; b=ca3FRPVFrrx3295G0OczDxd20m
	MsqClret78aIzm1UMHnYQGBR9AxVUMLCZiKccsaofDyZxQMtrWaqjbs2cvIakAEZrYNruf1sNFoKz
	wzGuT0pKFw7m65r9YnOrHswpMTw2bSalC6Z/upzv7cwGiaIsKR66EjQVcS1cwYRQuQUWce/yua13d
	CHP2SDiDQSQsIDrXgwoQ7r03DUARhKGFY/Dr6hLD6lNB5jqYahBUdfly42SXLWcy/XsuDG1LDKrN3
	Ro+rxNMa+jkCZUWoP2uLSIjaOdirv3mpPos0hBckWfhoQTmckP7wvtGZLJTeyqc6dgw2sBen1L8E0
	WbRpco/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprqe-0000000EXwN-0W9g;
	Thu, 28 Mar 2024 15:39:24 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprqa-0000000EXu1-0MYf
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 15:39:21 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ea80de0e97so827745b3a.2
        for <linux-um@lists.infradead.org>; Thu, 28 Mar 2024 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711640358; x=1712245158; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mPjQD/vT8EW8FIsS5EhEUvjw7Yq2DPw74odbleQjQC0=;
        b=Uvu6FBgIhahYPC0ve1OJ9KAaeYMZ8bSN4C4MzIVvnfiKZlsrzp9JmqB+MBgvkZWlOR
         u9pUqFWvUZUhCtwu1HL2YdMCBLogk8ofCTvNM64ehJchAX3NOmUb89oAbBgjufqKPGVi
         LWRhshhpaZy41y/ZXHARneO+IxLg8STaKFOYw3nfysnPH3kw3JEpYzUxHNXaXBWRpbME
         LjTdpmodFwzg9hQcd6G3ptpjOBECMjC2m9ZwiD9cEEdgmIMy2WFKXZwDtQjWbiwmVeHP
         McdfchlssXMXHih23+DomOHhALmBCAdR+2QumFEQG+CBKVhOxJSje88KM4vuheAKqR3X
         nocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711640358; x=1712245158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPjQD/vT8EW8FIsS5EhEUvjw7Yq2DPw74odbleQjQC0=;
        b=QGfWRW8SGy1Ikv6RNqI8fc8k0pjfyrxoc3oo5p4EjcYGwIXA4vQLoM+he8AkcQbv2s
         kLe3g4pYKihmgTKR6UgHJSs5YNBkQwmB31BcZhHsQTgqQ+r1R4NWVOVpYf4LBGviKrHL
         VA2TlsIqiUtCjJqpa//s156aLmelA53n0+50giFnV+wCkC8Pbwuew4snhNuQSPGDxV4D
         alESO6t2dyhO/zbXTEJhiSRNt95QcRuleqwWKJHTlFZ/qdY33HA8mqMfob9NyGoI6rMY
         NnZOwC1XR7AgUo9ZTj0QJkWeXpwabpOQDu+xhSDwRRkP9eMXf3jyOpjf8aif9si1YLm5
         mfpg==
X-Forwarded-Encrypted: i=1; AJvYcCVOklraZN9KqptX7J8sJQZtFhGyZ5cK9mLw62QUH6Xlgd49lqk70dV3Di3YZ88flMAYDEge/6pXXjVXBgQxgKxN6ZIXNUILUgn1Pbqp
X-Gm-Message-State: AOJu0Yy/s7ibMC1MxvNc9Ve6zemjznzStCCQP6A6dsuy3ZZJv+hOSnBt
	qQo0lCyXIqHi76h8+54Cb9nVOKiJ3QYW7sVFMqpTJyF+leMIPWU/cSBqnHIBa2c=
X-Google-Smtp-Source: AGHT+IGhUQYINGDQ7hWfiGCoXweY10vLCz/e/x+HjJ8dVvYs43ivIcKXZCgoqnZGIv+19J3DIwIpug==
X-Received: by 2002:a05:6a00:a12:b0:6ea:92a7:fb82 with SMTP id p18-20020a056a000a1200b006ea92a7fb82mr3800870pfh.27.1711640357806;
        Thu, 28 Mar 2024 08:39:17 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ff63:c57b:4625:b68c])
        by smtp.gmail.com with ESMTPSA id e2-20020aa798c2000000b006ea923678a6sm1505830pfm.137.2024.03.28.08.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:39:17 -0700 (PDT)
Date: Thu, 28 Mar 2024 09:39:10 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gonglei <arei.gonglei@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Kalle Valo <kvalo@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev,
	kvm@vger.kernel.org, linux-wireless@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 19/22] rpmsg: virtio: drop owner assignment
Message-ID: <ZgWPHntosUk+5qac@p14s>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
 <20240327-module-owner-virtio-v1-19-0feffab77d99@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-module-owner-virtio-v1-19-0feffab77d99@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_083920_269130_867B0D73 
X-CRM114-Status: GOOD (  17.77  )
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

On Wed, Mar 27, 2024 at 01:41:12PM +0100, Krzysztof Kozlowski wrote:
> virtio core already sets the .owner, so driver does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Depends on the first patch.
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 1062939c3264..e9e8c1f7829f 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -1053,7 +1053,6 @@ static struct virtio_driver virtio_ipc_driver = {
>  	.feature_table	= features,
>  	.feature_table_size = ARRAY_SIZE(features),
>  	.driver.name	= KBUILD_MODNAME,
> -	.driver.owner	= THIS_MODULE,
>  	.id_table	= id_table,
>  	.probe		= rpmsg_probe,
>  	.remove		= rpmsg_remove,

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> -- 
> 2.34.1
> 

