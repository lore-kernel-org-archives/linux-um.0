Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F5CCD11DD
	for <linux-um@archiver.kernel.org>; Fri, 29 Mar 2024 13:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9b2+syugljaMrrOP++3j3QqL3+aM8ytb7iOaLk3Q4wQ=; b=u5KahVYl1dnFvFnoliURLdxJz3
	LLaIS3CJdD6svibOgIEDUyBH21sl6SgLYxJYH3X4CzWlAg1QidxvJAmOqUij5qw7jaICORljGNoBp
	n9w1d9Zu7qlwATeiAuGBIVM8jJ8gxeTC1h2oFLHq43oGS9PBznxDsrQaWyQWuP7HOwwBNRZdHqFfn
	NCS4fFKp5inwfT0rPbNbcu7HhvrQ5JDw1xudTkSpKYKtBpYgnlcWUDt3OjmKC1q+GrkKzOsH96vXs
	vMVXoo7A+dytyDEdR3uJ3E4zQCUyKVI/wn8S+fiCFUqN/NPPwz1AhHueZLVAma53l10GovTwOA6nQ
	gFmMrlYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqCHv-00000000ex5-0ygg;
	Fri, 29 Mar 2024 13:28:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqCHr-00000000eua-2FpB
	for linux-um@lists.infradead.org;
	Fri, 29 Mar 2024 13:28:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711718930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9b2+syugljaMrrOP++3j3QqL3+aM8ytb7iOaLk3Q4wQ=;
	b=EU5QJfPySFX22Tp5dvUS8YklUJiDT2alo4sHUwlSkO+edUt3zvSgZQbnHxQG/ygKjeY4TE
	JuQZ89yVsnQiHWetliLk2WHrccVVUHXIKVNmVVoktgHgYEk+KS7Y166IxYWJdIxmEHahch
	Je+EPfUmhV4GIhs8Ui/XloIw5Lnqzmo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-VS3nF15qPtKnCsDvbZsR2Q-1; Fri, 29 Mar 2024 09:28:38 -0400
X-MC-Unique: VS3nF15qPtKnCsDvbZsR2Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ed44cb765so1145142f8f.2
        for <linux-um@lists.infradead.org>; Fri, 29 Mar 2024 06:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711718915; x=1712323715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b2+syugljaMrrOP++3j3QqL3+aM8ytb7iOaLk3Q4wQ=;
        b=L/LCe4HjavNNNX0gtG7hTPz+w4R44/BR9NwtuKG+6uKM5ID6dJ1pQgypx6PLrxkJq0
         YjFlChfVRvYMJuQCJ5BfvvDW2EK7uq+Sml7PJ7CeQqmB/kSqzJiFk+ecQXPYZaiM1966
         AFKhtvp3eR2yd6No3BBAxEM9rIb67p3XvfKZ9W6NrjgFyHwFeys2V0LIT3PjZ2oJBE78
         M6/WewaYjwOP7OE5HV4iS9Fk6rZoHzgdu/FHsFyS7tQTXHdKjqLa7TMWuHra3X+t0ZvR
         vE/s+PkbWVvNQ04zwbAh/WqtG2u+IxCK3NgI4bspFn2CicFJazPHNkkYeEPdchGv0yMI
         xdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTPZHqKJAzQl5BAuUv0UXP7P83+vIFiCtLw0fZcVWzO/Jv2vR6bKhlPFM9yT9k+rehmG1xK0yTSzZ9VynETxld7sriIrub/FiftGFO
X-Gm-Message-State: AOJu0YwShSsNSXGZB5ze8DZOjjpO+UQKp59RnaUp1Iul3JGTOKAYpYnL
	q6z5kEFkPqt5ddmonAuaFwrtd1SINE2yRmr6QPQBdPjo97Tvyvh6uJQqiPu7dhCzZ1KeyFKomha
	sdxaPZA3iwfmmQqLpOSXmfghf4NGhgutWEVYIdq+IXeCVSx6Jlx1LajEDYFtvTQ==
X-Received: by 2002:a05:6000:258:b0:343:3e54:6208 with SMTP id m24-20020a056000025800b003433e546208mr405048wrz.55.1711718915562;
        Fri, 29 Mar 2024 06:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0y693U6Mrafzyu7YFm6f17FVsvRLIAvGL111PeLg9URymVxfxN4rrw7+XNw571qiaGR1ycw==
X-Received: by 2002:a05:6000:258:b0:343:3e54:6208 with SMTP id m24-20020a056000025800b003433e546208mr405040wrz.55.1711718915211;
        Fri, 29 Mar 2024 06:28:35 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id e11-20020a056000194b00b00341c6b53358sm4171063wry.66.2024.03.29.06.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 06:28:34 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:28:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Kalle Valo <kvalo@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Anton Yakovlev <anton.yakovlev@opensynergy.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	v9fs@lists.linux.dev, kvm@vger.kernel.org, linux-wireless@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 01/22] virtio: store owner from modules with
 register_virtio_driver()
Message-ID: <e2xy5kjdctpitcrev2byqc5gcwntvsd6pfutrvp3l2kfe3llgs@l2xp5opj7xu2>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
 <20240327-module-owner-virtio-v1-1-0feffab77d99@linaro.org>
 <oaoiehcpkjs3wrhc22pwx676pompxml2z5dcq32a6fvsyntonw@hnohrbbp6wpm>
 <d01cc73e-a365-4ce8-a25f-780ea45bc581@linaro.org>
MIME-Version: 1.0
In-Reply-To: <d01cc73e-a365-4ce8-a25f-780ea45bc581@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_062851_673251_A7BC9478 
X-CRM114-Status: GOOD (  11.69  )
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

On Fri, Mar 29, 2024 at 01:07:31PM +0100, Krzysztof Kozlowski wrote:
>On 29/03/2024 12:42, Stefano Garzarella wrote:
>>> };
>>>
>>> -int register_virtio_driver(struct virtio_driver *driver)
>>> +int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
>>> {
>>> 	/* Catch this early. */
>>> 	BUG_ON(driver->feature_table_size && !driver->feature_table);
>>> 	driver->driver.bus = &virtio_bus;
>>> +	driver->driver.owner = owner;
>>> +
>>
>> `.driver.name =  KBUILD_MODNAME` also seems very common, should we put
>> that in the macro as well?
>
>This is a bit different thing. Every driver is expected to set owner to
>itself (THIS_MODULE), but is every driver name KBUILD_MODNAME?

Nope, IIUC we have 2 exceptions:
- drivers/firmware/arm_scmi/virtio.c
- arch/um/drivers/virt-pci.c

>Remember that this overrides whatever driver actually put there.

They can call __register_virtio_driver() where we can add the `name`
parameter. That said, I don't have a strong opinion, we can leave it
as it is.

Thanks,
Stefano


