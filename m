Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C2DC54E67
	for <linux-um@archiver.kernel.org>; Wed, 27 Mar 2024 12:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EPamPBtPxW6+pkIV3m4EaBMhb46zDx5KgvXpbm+zagg=; b=HFtuVXj/eZVjL8NSmSlNAmvNnv
	htUYJ3JeTWBXUeRLPejNfCKsrrDCI2VMFMG4n0SJITSwmHCCoYdWNdSPQmGJim+9Nr0Myn0XGGR46
	uA/KIrUrJMslQijzY9h6UMJZavZT7dan49KRPTJGnv04icKsU8zW4k74HAUhqXV4dLGpPIZu2wplF
	loyY41SLGG9tJCXIKrj7z7DEh/USAA5IQPXN1au78Ik1/QGDyV3GNHCaDpsbWoZqSfteQpadveeDE
	6rP/allQ216+PQPiPzvnA3akwNE1Wb89pZhkaYnReh1fqd4GtdVQNizY7vAAm+m67WdxPdYz+Ny4K
	hSedMw3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSdd-00000008xxN-2wSA;
	Wed, 27 Mar 2024 12:44:17 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSdF-00000008xqJ-2JIc
	for linux-um@lists.infradead.org;
	Wed, 27 Mar 2024 12:43:55 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso807151666b.1
        for <linux-um@lists.infradead.org>; Wed, 27 Mar 2024 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543431; x=1712148231; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPamPBtPxW6+pkIV3m4EaBMhb46zDx5KgvXpbm+zagg=;
        b=OAtfPhHUi6rl8yzvSENSroelmHZPrIdHaq3Xvi6zRFQjzAvn69xrFtplQV4d8qiPB0
         dnR5KHguI6xTEV+dCZ9R4Koyti8G1fo729D48RcbmOse9wV4wNYZKRkzWv1oT60rq4mG
         R+Khz+SwLIvnhz27J9PfsN+u3qUDZQ3uXoi6whsGLS5VgJT7VfUcs0ha8hzZeWWPcgqz
         hJXcLn30aGzzjXYMzs3cweoGSELlscvyJC5LYnnvsNYarKNMY7BzMgvUCP5lq3Obd11S
         vqAwGNer/aAp/3bZodooqAwJpeOjB2PoC4eadrTjOdBtH2fwC/V1A1exyMdPWY7FQIUE
         ZXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543431; x=1712148231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPamPBtPxW6+pkIV3m4EaBMhb46zDx5KgvXpbm+zagg=;
        b=VRcO5L6Ls+10LwQgyr56PBaTZtg6S/do1YPN6Kpy6A5+wyh8d/SGMonQSjutMiamo0
         YFbeQlRdDg80W+JKa3lY4n7wGz658nOu3XuupzKwFoyG4q70x1Su+UTtPc/DsZwRYWeR
         GFfYEB6s9JPuQxrYA7XxLgWjYjdq5l3sCJSwEw7aVtA5oV/aem/H7KbgC2iWD37dw8NY
         aBf0Hy3dfL2nrDYDNzkhRd/jPEisbV7gUzGTT9fIkZyjCyNvLi/WuYNqCn9nGFHD/xKz
         C+FSyhZ7gEhQayUEZKty1QuYpjbGxY2N8PvC83d/h6dKOpUu/dwUDjBJf2Q4V/Gn5NP/
         Frfg==
X-Forwarded-Encrypted: i=1; AJvYcCWXu3nccorGV27I9L/R8jeGaGQlWcgcGFmUS82NrInWty9zEjOqkuXy8brv0Tnq0uJvt8PM0V2v7yCtfO1sUHvbpmBUhJ4DLi+7GTiX
X-Gm-Message-State: AOJu0YyoGLBQ2EvZyroguvTc3ShWiQL/VzIll1BuPGhm3hQrwdlR+yK5
	43bVnrDoYszaC+3SVastB52QMX2/6ldYiOh9sKomA2bxiaRwAZ7SyR5YOBho+N8=
X-Google-Smtp-Source: AGHT+IHIawhEWmM18csReaNkfj7KE+Mr23K/ZLmHctiSwGk/x/WXWLAILVQsaMoVXgQQh7ZH8TvBtg==
X-Received: by 2002:a17:906:4e83:b0:a47:31aa:142d with SMTP id v3-20020a1709064e8300b00a4731aa142dmr835338eju.70.1711543430493;
        Wed, 27 Mar 2024 05:43:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:43:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:40:59 +0100
Subject: [PATCH 06/22] virtio_console: drop owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-6-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev, 
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=CUCGqZGlbwrgPkwPeA7fzEXfYZ5lWG+kw/qtWPfvSV4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPfhSNGa7v+KPC1Mr5GnTmrNcEwnc0tCa4FH
 m0oKKQdogaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT3wAKCRDBN2bmhouD
 17JlD/9KDr1Aax5X0o90P0yI2bf6cpve6MUh89ettR4omfAVd37Dod/vJ5UZ8YDgCWHVdzBE/lN
 pkmFzT2vbc1UL6oCj+BMBllZkbpmCkDtEvx3lol59Tz/OZUoXhv/8bDFpoyPwhLuwZBSu9GaBm7
 jl1D1sPVUPu5TFBwDqMVJPE9lNuBgpiPUVLh1Mw1LJM7U5PbFDz/797HaHICwxQCgs4Le/bzO6d
 NaHj5gx2JeWEPUyXNeThuz8Ltawko6tEtFZge1cW7WSCzRcoN7Bu3A2w3C+gsxSygfVZh9UMCaI
 F4wfQuj2fV04UAi5+OceMmgcvWbaizvgRFeaq9jC6oKv8tXcdTdgyWZb2R9kxYRYXsqdvFT49uf
 4EDLAt5abOVCXpJs2XF1Zsb6GMBJvPT8N6ur8Qx989vDOSbTxlC2I2J4pqHjgEoIpyS1EArc7xy
 cTGt0MceTl4TFQWnHh4l048GQyvV2ehpWlx9SLMDxZ2x2d/b/y07ik5mDHIZgd6e4GpGE5CwPuT
 f8/PBIExnfmQgxh6AycTHxwwJ0Ngy4B2R+bS3MR08Htxndq3Nrpu1U65K0m8WDKubEy4zaMN+kr
 hoFfKJUXhyFBrtl+Fehgcb19zQ4HSvsCzidVzGuXw4xvn+gVKRFbr3ZYDaPGyWFacIDHIhCFdn1
 FeGFa/txQr7dGRw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_054353_721549_0DC6F30F 
X-CRM114-Status: GOOD (  11.67  )
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

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/char/virtio_console.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 035f89f1a251..d9ee2dbc7eab 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2173,7 +2173,6 @@ static struct virtio_driver virtio_console = {
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
 	.driver.name =	KBUILD_MODNAME,
-	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.probe =	virtcons_probe,
 	.remove =	virtcons_remove,
@@ -2188,7 +2187,6 @@ static struct virtio_driver virtio_rproc_serial = {
 	.feature_table = rproc_serial_features,
 	.feature_table_size = ARRAY_SIZE(rproc_serial_features),
 	.driver.name =	"virtio_rproc_serial",
-	.driver.owner =	THIS_MODULE,
 	.id_table =	rproc_serial_id_table,
 	.probe =	virtcons_probe,
 	.remove =	virtcons_remove,

-- 
2.34.1


