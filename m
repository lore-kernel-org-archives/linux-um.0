Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D417CD1288
	for <linux-um@archiver.kernel.org>; Sun, 31 Mar 2024 08:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CAdnlTchQh8FlREm+ioloxT9FS6Bj5xt9o2Hrx59/ek=; b=wdx/mni+5Ih189f0O1onsv+iuo
	oI/I04aZQbzmUQSv75ePWI51MGI8/4YZZ32A7fMf6C/LH0tK8GZMIrVlw+/MBDhTJOkSe8Xb54igl
	P7H1T2okXk6VKbTcbOf/m4Gi2M+rVvq0aKlqRiQ5LmX+95UH6RgrJZNKqw4hZF6N1ls29gJChPQ1j
	8nrxuqPHLgFJuPPtVRrVC4Xxz9sXQIaqFjzEnidNOygR4egROgMU4lZ3c2OLT8IC2b8YoG4MuHSv8
	fwSUMWbFcmhlEOrfJBBdO2bEOGT5BwOsQs5wyYlYnSokqFpSUxopmJtwTTjDhgC+jd58YjF3KQYNf
	m3tc9D9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqpi-000000054A6-3oLc;
	Sun, 31 Mar 2024 08:46:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqpM-000000053uB-3cQ3
	for linux-um@bombadil.infradead.org;
	Sun, 31 Mar 2024 08:46:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=CAdnlTchQh8FlREm+ioloxT9FS6Bj5xt9o2Hrx59/ek=; b=M+EOezn/hCGnvmUXow4SBF8aqm
	fySODB0H0Li0T7cL35PWnryalV1rHBwat/HHDdZ5Pdt76+eivck6VBs+JTILsn3J45J01dpM/m+2l
	hT47+wYfZ1hrouJq3nK7F1Ifl+TRT0aoBqVqDCTnT8aoEi2msoXQFSkkYn0XiGhNJMHW5PNyqhD53
	Kkvy3e/rsGgbwcE3dXNRwhdemLYO78+e0Uoom0Ii6JQ4WeHv/6uYKTbKN78LXpLHWapin+E0wOeuz
	xiWMrIUxBEudLJGn2BGz2vguv9R94QIQnWlxr5W0O22mkWISbKuvpv7EA2w3Y4vMhBHbP0QZIvmnU
	SEnJa7iw==;
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqpG-00000002SN8-025X
	for linux-um@lists.infradead.org;
	Sun, 31 Mar 2024 08:46:07 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-341cf28e013so2263365f8f.3
        for <linux-um@lists.infradead.org>; Sun, 31 Mar 2024 01:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874760; x=1712479560; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAdnlTchQh8FlREm+ioloxT9FS6Bj5xt9o2Hrx59/ek=;
        b=wwqtXJ8Oa5yf+WI1GPvW2//OZdz6/DrK+NwKQXMOzGDOez1vqSsuhDfWoLGLcy4TtK
         iohbpbzHFRs1+d7okDrTVVFXSG32fie8+oXWmMyx5FEF8OVQtmyER9UTwTMGzD/BXa0j
         z/c9qZtjvKxNeBJVf5AUiuHD1M60OdrXBkEJOFbkTReBdoaPVZBp/OUjCcNawNQWjFW6
         JGFIVEBOXqONWCrW8hFASQ74ogzJa39u6ou/cYdd00OhAfaLkAK3OZQaOJOS82gzvgPG
         NORvM56Yt5qiJ0cY1eNT9eMnbuW77jzvlUX9rf7e1z/kW/5RRQS4RJhV6nFYLMFXWBOL
         YG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874760; x=1712479560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAdnlTchQh8FlREm+ioloxT9FS6Bj5xt9o2Hrx59/ek=;
        b=nv8EV1HBvdAcjWzmv5t1IvuPbxN7uXYtzzXztEndzPHTFCXkAvfzfWuud6EHDPg3TC
         oWP+8PQkwLc7ZbPKLiXu8S242Eyf0h+JLJs8YjdRTwYQo6u3koTq5MW9MTIVpZRiirrj
         3c0vNbMeS9dNg8W0mKWXNjQ7eIPtoCf9DKkHzVBlhwtpzovYOFlAgDfmM8H0EnNVJhQV
         fLA5RePN9a9bsjJOmXe9PhFwYGNLm2c1nKKMskWl/bdW9I3dTdLHi8tWHHChogoU+9LD
         JQueyFJNOW19Lcq8gdhgrzoIU5Q+UQrTfv4au7cJ262M4sg++1DqvwD++CdfpDHU1yJQ
         c4hA==
X-Forwarded-Encrypted: i=1; AJvYcCUHk3WfburKHN+hRPvE1tCg6yG1S8ztYIIt0mcA2b77ZR2nobbe20HMPs0pXKYQDrcX1ft8NILYEu0PMREGVES3Mbi9aORfFZjmAr4u
X-Gm-Message-State: AOJu0Yyyxsa8ySxnDJwWQF3oT8xc3pD+r1/4Zi2N9g+mNdgw0nLsyEuH
	2quanWff5wljx8CfqgHVbDKaTT1CD4F+5A/jMVvxLbq9oF5Pocon9VGRo+yX6tk=
X-Google-Smtp-Source: AGHT+IGz2LpPwhQY80sjD7cN8u8zFvxhFrt83Qh2uspjyZZar+MqP10mw3FpKFF2x5Oa/ktMacEZzQ==
X-Received: by 2002:adf:efcf:0:b0:342:2ea8:18fa with SMTP id i15-20020adfefcf000000b003422ea818famr4808562wrp.15.1711874759984;
        Sun, 31 Mar 2024 01:45:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:45:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:07 +0200
Subject: [PATCH v2 20/25] wifi: mac80211_hwsim: drop owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-20-98f04bfaf46a@linaro.org>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
In-Reply-To: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, 
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Richard Weinberger <richard@nod.at>, 
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
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>, 
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
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJhWw5LbpvzVhFws+zmYGQbgqyzkihUAHIKP
 oZSMQPlSqWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiYQAKCRDBN2bmhouD
 139YEACIQuJ27qQd8eW1dGY27mv+DorF909fjdUQk9218e/PqSQf78sWt8Dwka7RhDehlGI5/jY
 KavPWJS8WmZupYTGwpWwO29uzaCgHZ2UkfSQaCt6QC21Sm2ZSIe5YSORBj73pm4F3aV1pqEG7Zf
 uEKF5SdJn8BL3Sq/8djgih8czEuNasmRrepanUNhtq4BZRUfa9b3d2hIu8czIoxIJ06K8gRv37w
 AsYE4wIp4r8/fbIlRYOdzERJeEbZy971KJWlKSO5MKy6kQgvEcu+ONjd1iR+Fdgfc8CKD9+R7qi
 j0rF0tfjdBKJZQxSDK4OGG7rYqAMfQW1dkb3Wwbs5BfrUc5FsD7sSNfdW4wSQNMO49JRC48Waai
 qcy5cn2TASJYAsl+9siLBtqYDCg8A+zkmblcAz+f8Tg0ZC7adlCFQKf3ab0eBEnC5H1P6JPY3k/
 P+KB2oUo3GGvXUKm0bsUYt4+bB28pkoKTNLzltigIgQGLvc6nx67bmM242YaJrj73rp9q+nHvKI
 69piU8bV2WDZcuDckA55wir1b4ShB3Fxjfw6pOqJxbJCSjvj0a5IvzYr2s2rFI+rEXi3dULTh3W
 8TMJIXX6xAyGSgH1txSm+cdudXTNKT96YWGp98mSXYwNEyRh2EUTl37ZRn/If53EnPmAxYVEX+Z
 M38gpeSfQm/346A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240331_094604_471127_5548F490 
X-CRM114-Status: GOOD (  12.11  )
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


