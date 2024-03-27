Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2651CD11DD
	for <linux-um@archiver.kernel.org>; Wed, 27 Mar 2024 12:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CAdnlTchQh8FlREm+ioloxT9FS6Bj5xt9o2Hrx59/ek=; b=TxywLrIIsKnPhmzHaEV5Bzjgyr
	+udK+8dfRAgJLHqOjWTOodh9994VOfIjBd3vQwwCyaW/jw3PwlL95SXLH0nb0444qNvb/1X/6Vawh
	Re8bMaT6iYT894YplfYvd+JNR98aAviHzg5zOKmOOaAo8jUDoLY/2PDZohV46d9rAg6d0hy2TmSFb
	myORuMzvHLo/cqdUClldaOw2eLIukU5I56EMsS9WbTH9QUzetFHvC0VDg27uCkvbYkAPm1ADsJDjN
	G+2CeMHU0n8zz644P9HsFEsIsjqnS/NfQitE/WtrRJ3BUYXqkHegq9IMWLWkE1oqy5L6EKH7rs+TS
	RXEs7Gjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSfr-00000008yrR-1dkV;
	Wed, 27 Mar 2024 12:46:35 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSfo-00000008yoi-1F9J
	for linux-um@lists.infradead.org;
	Wed, 27 Mar 2024 12:46:34 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a4e0a65f37bso61416466b.0
        for <linux-um@lists.infradead.org>; Wed, 27 Mar 2024 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543591; x=1712148391; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAdnlTchQh8FlREm+ioloxT9FS6Bj5xt9o2Hrx59/ek=;
        b=EuLayFdDMiZ6GBxCmHwjwNBSQkRj56fuFr3cn1E0StxKgT9k41ENBw9vnUUHsmgIeh
         /WGpsvZUpUoXlP1whH9APNcycGqQgJyZw3T41JuELiXaGpmKUDiqQ4HfNkX0yjhCLMd3
         dcLZyaG4fkx5xHMVLNbcVRSEn0qKoCQ7oW3S9YDSs7z8OckdGLdAfD3//wNwazJ1LXh0
         osjfiRymWqSPwyg0emAd2JitONQsaFpLC3TkKxMBlBlyh7tyBnuWgAYtNXQnAOfRlW/W
         VYUcnzJttXwire7JJQ0H82zEwZ5r9lHsZx1j3HbASE8u5eTCP9m1LS3cExO3o78q+tll
         kAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543591; x=1712148391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAdnlTchQh8FlREm+ioloxT9FS6Bj5xt9o2Hrx59/ek=;
        b=DdB4+0kYofiKZLsvYMDjDaLYcGu+r6eG2zbQAibheARau1xjHxxLt+Y+WaR2w4WXUp
         eP8CEUX0jVKEDG4cwkXJUnFcw0lZ4U3uwVslDGejhWePgJkK6Je+3CN3WociOGlPlQe8
         cpXKuIfQ1Vo7pkxWW5KHmBLw8UpvsS4C6M3pmMUFprnxbrrZb2DTtJIgoxN4RvYGm1Us
         d8hcPMoZA0wxv9KY2OrpaXytvPcO7kUUwRcCcRiZgmhvV8/VEbuoCdYuoh3ytnUMtBlA
         QqVvCtaZGpIJgCMDeqAAgk246zJ8fX+wc2fi76+bx+SX1JlCIKx19OT2V1uxQ2oFfPPH
         ivNg==
X-Forwarded-Encrypted: i=1; AJvYcCWt5hy93LpKDleWjpc43MMBOfyn/VphadKxALgXCDY8kHfIOBUMznbSMLJOGmNtvSwRihR8CgqnHGQ4rhNcG3NYnEFcw+7bt4pqCCC6
X-Gm-Message-State: AOJu0YxOe/OqDusGXjuRlwdsH4OT3aF73NXGq4f9nRJIGCza6KQyC1us
	GIKIpTfhhHNHuoOAOSvVDpP3IHtCPx20MfB7wwhGgj/hE3h66LxUeaGzEcZnoRU=
X-Google-Smtp-Source: AGHT+IHVexc2kbCUunNAztPCJwdU2CYnVCIBBNG4v/92F/JNV3MM0F/SD/YxnW9+Oek5jxzlrpSwlg==
X-Received: by 2002:a17:906:411b:b0:a45:94bf:18e6 with SMTP id j27-20020a170906411b00b00a4594bf18e6mr908668ejk.73.1711543590897;
        Wed, 27 Mar 2024 05:46:30 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:46:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:41:10 +0100
Subject: [PATCH 17/22] wireless: mac80211_hwsim: drop owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-17-0feffab77d99@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=807;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NiQjVjMZFYqKExZsObNgm/DCszic+bAl+n8BqmPOZX4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPo9EUYxSk0xH5wVhPIu64wDaxPpeXtcUWD2
 6lVJMlVdRuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT6AAKCRDBN2bmhouD
 18pcD/9PLz7we290JB+0IIbADnjysV/3BADPsYqLnSwRZ4yb6P+wx41774nzlWugyWHJCX/j/Qk
 f+VNbcHKb1Lk8fXjgCCChiCYTBGnw5m0bpt+moBBHgE52CQ1Sw1WVjxr0tM525MyMYRhjhTDkfS
 kYK9PvEwCSBa/xhbwmcPEP6UCxmFXDMSPWB4utZ9Fc3QDnFca25zSRK/P1Xo3dHciiN6rf1IC9I
 jwQsgm8oEV40ThwOHxYN1YewOL/FD/X/mJgSZgJiWLBv1xnab4CS4BB6TAR507GDgMyASK76u0k
 Xx6KkPwpj+sPF+Qjz2EtV9ace5CEDfSQVRNDJNIcfkAvG9L6sEtTiiv7moMhIsgem25GeUPAH5P
 gVKYvaK9WZSveQjPc0rldRRiwmPYY9+q2qmDZPnI1qkd9Sw/aN8dvngQ2Lf0IIiV9LMwDRXfNaW
 06OmPJupRIH4tcBbWGCnbw06+oKJtRRLsaQsVwuWUuzKkkq63vHWnKHgNWziYufFjtfGqteyaxF
 Cyx/H6WNuU8GKMM5SVtD9O2m5Tu77YKhw7llT2eX1nAn0aWiH8ZPBCgVFFpuC0qECvOGYFRNx4N
 n3uKKbezBh5kkdYwgPZ5FoHNa/MFZoeUGMRLBiWFJhEUW8yIKmy9W+cC+jLtG6Vmac2xysrgU/Z
 8y6mEAPjW44Ba+w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_054632_504105_245AD80C 
X-CRM114-Status: GOOD (  11.52  )
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
 drivers/net/wireless/virtual/mac80211_hwsim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index b55fe320633c..ef38b7cc9fdf 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -6662,7 +6662,6 @@ MODULE_DEVICE_TABLE(virtio, id_table);
 
 static struct virtio_driver virtio_hwsim = {
 	.driver.name = KBUILD_MODNAME,
-	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
 	.probe = hwsim_virtio_probe,
 	.remove = hwsim_virtio_remove,

-- 
2.34.1


