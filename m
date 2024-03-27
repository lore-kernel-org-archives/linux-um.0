Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29313C47DD9
	for <linux-um@archiver.kernel.org>; Wed, 27 Mar 2024 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AFaFw1OZuXizkw4uNoNpzMqxfCxSvA28jWrn6rdqU5M=; b=kRHAsQVgWm6B83
	W/jR9omJu3N7dD9EQcfbHFsJew6cuDtA3QK2xRwChw8+s8PqXyVlRyzNvjOz9Bz7UrJqMSp0DoqGJ
	uXdMJphyBxOOApQ1Svv/5bgf6znDJe/LJhySF1VfgmFO5UwJeE+MyxQVzGtEc5VUYBVBzNXu0pDlt
	ueyNwQ7ESithjBAeI77altoqBK6vR7ZFqmHtesn/pgv924znqkVRWWreHGJIOg9tO9LgY2nvZU6jq
	Ok+rBjVHmgU2knqMkYMUMo+87NZiBBtk1i0QeyqKaEuhtYYKJXXat8J/566haKcDxpY99Tx7L3wwH
	eNGHm55dt/gO4ErfqlHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSbD-00000008x0p-0rdP;
	Wed, 27 Mar 2024 12:41:47 +0000
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSb7-00000008wwS-1OeD
	for linux-um@lists.infradead.org;
	Wed, 27 Mar 2024 12:41:42 +0000
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2d28051376eso120074981fa.0
        for <linux-um@lists.infradead.org>; Wed, 27 Mar 2024 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543298; x=1712148098; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFaFw1OZuXizkw4uNoNpzMqxfCxSvA28jWrn6rdqU5M=;
        b=VzB2JKx7CVKgPbactfItEhDXBenZWbrZN4LI+1DGr9aLBJIs0BO42my7JQtPvIUxbq
         Xq7di1GX5glDB+MGqtKhnDYz6OtPqcrCBxAVG7x+xAvBl5h2+f5E2LqTcOaCxaC0hOTJ
         u0Cphx1zLAVX8HCZPZZfhey3H8fla2I7pf2AfKV7Wk+N4ZXQFXgKzkOqL7Ie60EZhX6/
         w3hRR74MzBRRUMhfaAPoeZDWtNbAMQLW7bndFmiyoz7SNWxhQJuqFLmqyMbe6IlB3NWs
         cKxh/IR+KCMt1wZrheiy8gqyPSpE4KRFrsOFE/JJB6Ucv73hhJIb0V/Fuy5njgdGcru3
         xO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543298; x=1712148098;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFaFw1OZuXizkw4uNoNpzMqxfCxSvA28jWrn6rdqU5M=;
        b=oIqRid+evEpHAkswNuJQDhF6LvtdvHTXELzqna4YsjZ+sX8jBZtl6DSlgSWaTQfgGq
         WNDKF+PkKeBleSiIHlGYGQ0x11SKO4lj/QVAkhAF60v08uLaEsv14G5IJfSQR1VBD6V7
         I3I0W+Fvkb33Dre06w7S+0ABMKqfAEtQTQMl69q5SSRxrbbKm8LlCSEHWJDkJw4BcX1r
         fol8QKrVAbTG17Nxu5rJzqCseD9y/ZEfg/yuLCmuAhe/oUgpizFPfKOoqqND5lPp22Xx
         5Kh4qKa3yzVlic12GPsTO8cNyhcjku2EsPgAhTE3nKl9LA2ASQO8qL7VLxTQTMaEQSfA
         jf1A==
X-Forwarded-Encrypted: i=1; AJvYcCWID4+aRlbnBdltXaZKK83JeJ0Z+E9yIAvdpGGNDhO1PIAfGqbNpjqKroUXSfKHsMQvDog4CIkS8UCC6cxn9PfQx+Rpho+//iz2Jpxu
X-Gm-Message-State: AOJu0YzCUNvmtdBcGVxa8c1DjsWhc/LM3wCcZrZTQ/V21NHMFyO+0bSW
	jNf/39+jv8btXy2VTlCVmVEFD7AuKeALaJShjFJANv+9PTri6peCGyIZwqkmZ/U=
X-Google-Smtp-Source: AGHT+IFS1x7gpjA7jUKSh2w40PflGxs4LWIU8D0QvTuDe3IphcKfLGKJ6nGMGd9SaTSRJh693GFsRg==
X-Received: by 2002:a2e:3a1a:0:b0:2d6:e148:2463 with SMTP id h26-20020a2e3a1a000000b002d6e1482463mr2074785lja.24.1711543298562;
        Wed, 27 Mar 2024 05:41:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:41:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/22] virtio: store owner from modules with
 register_virtio_driver()
Date: Wed, 27 Mar 2024 13:40:53 +0100
Message-Id: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANUTBGYC/x3MSQqAMAxA0atI1gY0dQCvIi4coga0ldQJxLtbX
 L7F/w94VmEPVfSA8ilenA1I4wj6ubUTowzBQAlliaESVzccC6O7LCueors4zLOiLExn+pYIQrk
 pj3L/17p53w9578lCZQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ZqxqBePx9O0aSeYwWfac5JC18N8WH4wazKZPUDWtyb4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPZS5yGoH1UVP3T0Npm8blJRoVKIHSae5kBq
 HxYGiIbwMaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT2QAKCRDBN2bmhouD
 12zhD/9C6ukv+8iXJ63iu65KAxWO0209no/Zk8V5PPOIg8YWF23fhUh5Tg2IbxFs1SDSIqOKCGf
 078xrARdl7OLN91lsOjjrbjnZZrO+3UXwHxBg6rRfwtkp+kgAzLzR84hoSWqyqlq+JpiqE73Ex1
 fNyOEu1Il2sVbtLvNN9ZvBBGDNN/h7JC9ywVxJ0Fa0LD8kwtsV8pUIgsVva8ILQKkMQBTP09QPM
 7DW97OEmYao/IN0z9JQ8xmwCXf08ciDibfQZ884ZF4dVW/paLFkgw4OyR+22WTqneeBTsJKdlH1
 Os9//BH9zlvxyZG6vpAg3g6NvH7MxigyNbztqSw7Uqw1jx1u1032qs/yjWHbs7c4pNm32w5Sc2U
 BWMIQlsiyt2Gg33SxWybhDqMfp72LBlT04SmQHYDlMTlPA4vvgeUK/H/oYmg/uzy5MM/kx9WGtR
 pNCFFDPI2B6EAqAvrzZWEGv2PVNujF5tHSLKVqxYwXHWIDIqg8LnCgQeizyqp/tqjoQFY7vGlzI
 B3wE5riIQuaCN41Id+3PH7pVc6tEQlepaRhz7jRIFh+JEA53CORhQ62m1PpLMq7z8zNhn+Igsh+
 AB69huA3C3eKILpuFw33OXJybFczTX0Vd0F95nDwyWCahIwaUlrRfoO1JQlJFdOgChtyx0ws9Uf
 xOnSxyBfnZ9hbow==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_054141_417766_620DC6E7 
X-CRM114-Status: GOOD (  10.49  )
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

Merging
=======
All further patches depend on the first virtio patch, therefore please ack
and this should go via one tree: virtio?

Description
===========
Modules registering driver with register_virtio_driver() often forget to
set .owner field.

Solve the problem by moving this task away from the drivers to the core
amba bus code, just like we did for platform_driver in commit
9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Best regards,
Krzysztof

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Krzysztof Kozlowski (22):
      virtio: store owner from modules with register_virtio_driver()
      um: virt-pci: drop owner assignment
      virtio_blk: drop owner assignment
      bluetooth: virtio: drop owner assignment
      hwrng: virtio: drop owner assignment
      virtio_console: drop owner assignment
      crypto: virtio - drop owner assignment
      firmware: arm_scmi: virtio: drop owner assignment
      gpio: virtio: drop owner assignment
      drm/virtio: drop owner assignment
      iommu: virtio: drop owner assignment
      misc: nsm: drop owner assignment
      net: caif: virtio: drop owner assignment
      net: virtio: drop owner assignment
      net: 9p: virtio: drop owner assignment
      net: vmw_vsock: virtio: drop owner assignment
      wireless: mac80211_hwsim: drop owner assignment
      nvdimm: virtio_pmem: drop owner assignment
      rpmsg: virtio: drop owner assignment
      scsi: virtio: drop owner assignment
      fuse: virtio: drop owner assignment
      sound: virtio: drop owner assignment

 Documentation/driver-api/virtio/writing_virtio_drivers.rst | 1 -
 arch/um/drivers/virt-pci.c                                 | 1 -
 drivers/block/virtio_blk.c                                 | 1 -
 drivers/bluetooth/virtio_bt.c                              | 1 -
 drivers/char/hw_random/virtio-rng.c                        | 1 -
 drivers/char/virtio_console.c                              | 2 --
 drivers/crypto/virtio/virtio_crypto_core.c                 | 1 -
 drivers/firmware/arm_scmi/virtio.c                         | 1 -
 drivers/gpio/gpio-virtio.c                                 | 1 -
 drivers/gpu/drm/virtio/virtgpu_drv.c                       | 1 -
 drivers/iommu/virtio-iommu.c                               | 1 -
 drivers/misc/nsm.c                                         | 1 -
 drivers/net/caif/caif_virtio.c                             | 1 -
 drivers/net/virtio_net.c                                   | 1 -
 drivers/net/wireless/virtual/mac80211_hwsim.c              | 1 -
 drivers/nvdimm/virtio_pmem.c                               | 1 -
 drivers/rpmsg/virtio_rpmsg_bus.c                           | 1 -
 drivers/scsi/virtio_scsi.c                                 | 1 -
 drivers/virtio/virtio.c                                    | 6 ++++--
 fs/fuse/virtio_fs.c                                        | 1 -
 include/linux/virtio.h                                     | 7 +++++--
 net/9p/trans_virtio.c                                      | 1 -
 net/vmw_vsock/virtio_transport.c                           | 1 -
 sound/virtio/virtio_card.c                                 | 1 -
 24 files changed, 9 insertions(+), 27 deletions(-)
---
base-commit: 7fdcff3312e16ba8d1419f8a18f465c5cc235ecf
change-id: 20240327-module-owner-virtio-546763b3ca22

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


