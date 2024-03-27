Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7FEC47DD9
	for <linux-um@archiver.kernel.org>; Wed, 27 Mar 2024 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OIGX0zkEWaN83RrWauYFLuhRKQU73+opfJC/SaE++k0=; b=QoMgHb1B2H1VAiZtlT/EyXLXiI
	DvJ7YatLk0loB7n0WRZ01BJCVqMhqmlQt15UjNnJsKt1N7B4VU2bP++F1AzYV/3UM/AXg90HDcgKo
	Lfd54byIkbpd5xGu82a1umyle8p3SlPke5BKyyg65nAj+rKtvbHZXDHd+/FwpQ8OTKgG9uE+Ru9O4
	CxE47z6UCACGMC97QQBN6kGa6Ev8m+iLljmywqiHK/l9LAGF/ytkM98b4U+w/iLpEWoy7BuqpAGmO
	5UXn6SDb4bij0PGIX6XapC87dKfEvQ668WpwYTr9MqeIiyjqUWVYcLfMoyj7NWBc05du1C1I7xSM2
	7LHORruA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSeq-00000008yL7-0BZk;
	Wed, 27 Mar 2024 12:45:32 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSem-00000008yIV-28ng
	for linux-um@lists.infradead.org;
	Wed, 27 Mar 2024 12:45:29 +0000
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-515a81928a1so5827596e87.3
        for <linux-um@lists.infradead.org>; Wed, 27 Mar 2024 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543527; x=1712148327; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIGX0zkEWaN83RrWauYFLuhRKQU73+opfJC/SaE++k0=;
        b=YYvhNrc8Fpn+MqcojVaa6wa//l+gihqcISMFsbVooWHH7utj54cKZSQIbZubbAN5Xq
         FP/KfVUMpcatNafwibv0oe9mLFGp9eES55/1kgDr1YOEEuAE/edf8sWCMJmBpDtTbmof
         h8KzBLmhIAZfN14Y8r7egq5bpeC9X4sJ0MZ4GoCZbt8eb2No0LmxP2C6/PdKcLd4kgn6
         F9wQwxsI6ZeBKoiycH8b/Sanda/cP3KlW/WL4c1MIM/rr48TIam55A4wkXFGBE7uJE4E
         6gglRYaLg4nioZXTTW9OszE6EAJakONRYiisMnWs9e86+djBk7Y+TD4m7bKk/CpaKjf5
         8hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543527; x=1712148327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIGX0zkEWaN83RrWauYFLuhRKQU73+opfJC/SaE++k0=;
        b=imgV3iJN8GMIBqdV+DaV7+QBKMZMX2qpvBP1TDdwpTKe+eDKO1QJ2lEGHhpXV5eUeu
         AIOlbvb5hCfmPcflD/EWxcBmsL3x5wVylBT9iea8OMwmm19mVMAtBMd1WbHnNjqX7+7R
         +aVUjZ8A/Vyh7MK5L32/NkIn+hbq9m0zsUlUW8HcJ92sZw0BQ2h1Th6C7gAZN0OwVQTB
         BvY/JwwWbSD+t5OKd3nPprh4aucCXg21RSf8exN3GvXYbOMTphnoUC4sFLwfxoP7uZjr
         8oWlhNEbFjUKzRNlphE2d9vd/DIpPPDUI/Y1yP/+KsSLRMx+5g6YbG7eZVz6Rvz5RP07
         aUIg==
X-Forwarded-Encrypted: i=1; AJvYcCXSO8dz07dAtgU+MplvpAR3B2if5/8SwqbjJH1t5jfIOckAV0YuHRrcLvKzvapv9r6jIjjdkk2RjPmQyUVn60vN81/y4vQF/ojKkdfv
X-Gm-Message-State: AOJu0YxRqempY4OnGkEMzuigRu52j8RJq/jDJs8nnpi5giEWfMNLAaYn
	Rede62uHA1DhKHNvu6dWPf/eVTPf3aqc/Ng79aZ0+zRAWyJNbZLJQhDdfo1y4fY=
X-Google-Smtp-Source: AGHT+IFTe6KK5NzzAQw6DLzrYupzSMTGssF+U7deLYZAVBSrCE4A0Uj/ENe1tzZVoUoWNlZVC8fZZg==
X-Received: by 2002:a19:5e10:0:b0:513:e14d:15e1 with SMTP id s16-20020a195e10000000b00513e14d15e1mr2258015lfb.57.1711543526649;
        Wed, 27 Mar 2024 05:45:26 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:45:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:41:03 +0100
Subject: [PATCH 10/22] drm/virtio: drop owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-10-0feffab77d99@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=794;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=nkRw+hEyffQkd47xH6yhTGRY43bQKFbnoktzkBjZ19w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPi5ln/NE6yYKe/g2hSdNaOWNown5itxMAzc
 cWpPjO510+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT4gAKCRDBN2bmhouD
 11JMD/9Dt0RXRxFqSwBoM243YFGwfb5rVSQTy5OQh673qccdjX4eVM7SH9KlmSEgdTRMu4skrvI
 TfWq6TFqSZmtEnLc+eNLQkIfdFU+wIY2BonQcKxwqaCVqKm5g0IFaZ07Cdol7LLV4bzHyqatim9
 YT9oVJlOnK6xwmVsULUXLNqldmTbnAjwDv/8saYEC/2HwNY6MdGJxwZuMEdCfTtd4S7BIs1Igp3
 Kd1gVLGKaUTYSbKGotlfnWBfXe+leesFc8cG2JNru47NKJ9dPuIOzgc6BpoGvAZPvD/cGGCmJR1
 V7mEZK1DEES84YfWjv7MUh3LAH4N2q+eelTKo7zg/E3uZx35ujWPAfSWc4M2LoAFVKs6yBPBdV3
 G7sGHXO3ijYLapANaowLjkLX2F+idzDM0PHiKDJzKg4vHGd0DKxKtEU+556d8L4FRriH6NHgtRO
 f2CiZT8Lxy97gIjC+CP4ASmNGWXNHrSNcw5kJ3xBkIf4EIaZOZfym/vTS9bZdLBHt7vcnAnjnsv
 YvU49CRKoalhEetDEz31X9vW2OpnC4ihmhy6KNGzG3Q85EQX7G0ltCu8IlYsqkGB25rpP79kdG3
 h6bMp4fQteqgCj4rtFzlGJkrOXJ/U9k9jcDUnvZtNzm/kvSDib52qqN37X7Asb5pv/RYggWh6DE
 bcqvemCVVipRGCg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_054528_607049_86CB6995 
X-CRM114-Status: GOOD (  11.71  )
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
 drivers/gpu/drm/virtio/virtgpu_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 9539aa28937f..188e126383c2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -154,7 +154,6 @@ static struct virtio_driver virtio_gpu_driver = {
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
 	.driver.name = KBUILD_MODNAME,
-	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
 	.probe = virtio_gpu_probe,
 	.remove = virtio_gpu_remove,

-- 
2.34.1


