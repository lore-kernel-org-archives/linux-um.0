Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBF4CD11DD
	for <linux-um@archiver.kernel.org>; Fri, 29 Mar 2024 10:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uPUqPHiAYDsvF7c6mpbUarOnTLvyyWG07eUiOIJt2gQ=; b=rlMGxyDkUS5tScdhYbLF5AGkzc
	KtL+h76JUQF3ZqwLKxGFarDI8Hf7WhirVGgWdZRnLJtmD1cyNcip8S3wRnlEVtOv1HCs4u9VCesOJ
	SMr54XmQMPhNZ9dSI3BFi8KZHNJsnw11c4yxJamrNoZQ+1IJxmOG+6IijdWcxdKf3ez/CuX4SJ81C
	sl9e+y5mg4tcTgasXtcZ7vKRdGAtHBBc5KQSrWqFGH1/WnhL3w4fEXY4U9Zlx+5fxddpuG2FSg0Re
	2oKWfhKjGj1aIXjzOzHjLDXFYysWTERh8MuMt8QucN848aPRlC4Go3miYaPkdQPrxqSeE9xtDqk6I
	ir6qwHxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rq9SU-000000002NM-0n3i;
	Fri, 29 Mar 2024 10:27:38 +0000
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rq9SQ-000000002LS-2ceI
	for linux-um@lists.infradead.org;
	Fri, 29 Mar 2024 10:27:36 +0000
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-513d212f818so1993691e87.2
        for <linux-um@lists.infradead.org>; Fri, 29 Mar 2024 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711708050; x=1712312850; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPUqPHiAYDsvF7c6mpbUarOnTLvyyWG07eUiOIJt2gQ=;
        b=sAuXhUUOMlkUM1LdY2GoeVX5HzTJ9IhfCn+IUnZZUthPI4UXlR9pO7GMNC884E/BXg
         ebbS96SPBJsngYZYJJ06VYEBy72+XYJNYFu8f6Iieg2lV/n+8YQn5OShYS1++zHKDeFC
         mAYFt+n4gBwmekfOdWUfO+3HGHqEjNRd/6LfyE7Gh1oxkjcEzjySKC1++J6K4/pNNbke
         2Zr3KVCCig5BJzbKBNptWeQQscCrh422xp44o8i3crkOS1Fkt1tPLSITF9+ZmujNOvqH
         5Sk/aGt25uwZiO131bFbREQ4WXjBXwAETWyBSolZCZYrI0Cfx6F9XQSc3hauCCBn4FjE
         mVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708050; x=1712312850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPUqPHiAYDsvF7c6mpbUarOnTLvyyWG07eUiOIJt2gQ=;
        b=CZzvo3Rl7xbV1cmSPUTCl+xfDrnjcCNP6h+9IIDe3BcX2CLqBPgutvv9pQ+qR/L8OU
         fSW1doSZbjl4nV3n0RBcYUOQN9I8PpopXajMW/OmgImCXAfNSBxe/hPMvkxF+6XYQZ9k
         9f6XwE/7B/TT4WcpSm0y+FDpHmbSEVdl0yalf4+rjqjWDak2fVVIP7DC+tSk0uJ32kHM
         V0k/SKrx3OMr9JHBq8c97JDqZ1DMzrb4NfKwcVC+86awgSb4aMXPk9vL2b+JHH9NDKAV
         g+Cha0z2mdIcMXTOMXkrFaPFKWhrWg92LQ4qhiPUwQSipRszFQkNUZgDXJOGvK64Olie
         OGEA==
X-Forwarded-Encrypted: i=1; AJvYcCUFIk0v1LWrLAW/iyLzpxw3PlZvj5PdJpB161xnAibH9BrXO1s2NfHxT6JQBL7+siwGIMq64Oc9zJYSDdjRVPAeIjpzwUp76boCfIPR
X-Gm-Message-State: AOJu0Yw56T31kX4MvTUheBGCvuhOgwwHL0nJMSeFlPHyjR81WJCcyswf
	46bBk3utSEsIQmMf7iL/WYVLYE8aMvrTHTH3zBLgJYg1HyjSL6zvS4sxA/bZxWY4jSqtZV4T5cP
	cmuGtIKeg6+ZCyHp29Wh+oH/D7DoPfrhpVeQMLA==
X-Google-Smtp-Source: AGHT+IGkJetMoIDH9w2TQurNFFXLK7XsHfl+lPbtCC+0MeMFYTkyF7Alb8el7pzIkiwo9JvBX9h3ULKBGoxrg4XKpUU=
X-Received: by 2002:a05:6512:33ce:b0:513:af27:df1c with SMTP id
 d14-20020a05651233ce00b00513af27df1cmr1559870lfg.11.1711708050041; Fri, 29
 Mar 2024 03:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org> <20240327-module-owner-virtio-v1-9-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-9-0feffab77d99@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 29 Mar 2024 11:27:19 +0100
Message-ID: <CAMRc=McY6PJj7fmLkNv07ogcYq=8fUb2o6w2uA1=D9cbzyoRoA@mail.gmail.com>
Subject: Re: [PATCH 09/22] gpio: virtio: drop owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, virtualization@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	netdev@vger.kernel.org, v9fs@lists.linux.dev, kvm@vger.kernel.org, 
	linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_032734_689568_C360281A 
X-CRM114-Status: GOOD (  18.13  )
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

On Wed, Mar 27, 2024 at 1:45=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> virtio core already sets the .owner, so driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Depends on the first patch.
> ---
>  drivers/gpio/gpio-virtio.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index fcc5e8c08973..9fae8e396c58 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -653,7 +653,6 @@ static struct virtio_driver virtio_gpio_driver =3D {
>         .remove                 =3D virtio_gpio_remove,
>         .driver                 =3D {
>                 .name           =3D KBUILD_MODNAME,
> -               .owner          =3D THIS_MODULE,
>         },
>  };
>  module_virtio_driver(virtio_gpio_driver);
>
> --
> 2.34.1
>

Applied, thanks!

Bart

