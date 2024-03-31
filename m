Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D4ACD1288
	for <linux-um@archiver.kernel.org>; Sun, 31 Mar 2024 08:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JpODOh8SpqDydjsGmjw6Via7WFpVB11YsZ1xvZ5Vpsw=; b=L6kdpRLcec9ktPKEzmQwQ3FCg+
	EkTpM2qZW/z2gfLRPY5LMbY/Z/4UZ2ocVTWpjutpa8tIvSCm7lIOmNAaKi4qTI2GJu+QN9SV5dRcj
	qFFurXioU9b3y8iHod5/WiFy8r9+W5dOjWLRLLbX5gxggv/sODQBBf1YdWiJeyA3b6+vSpfcyFq3Q
	9FhxOQxdOztvrCTsd9Z8cu6/xPGFo8kEIt8SOazrwcDR5o0A/i08ceGzR28FKcXsi4iuvM7Kanjue
	5cDDbxaH0rUFhRBJ7Y1L0/3ZfMOj7unMOiL9mjl+Kvq0pbzRcr+Tk6fvCzqxwYj3A/p1pcq+oHglV
	0ijz4UhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqpH-000000053qi-3Vse;
	Sun, 31 Mar 2024 08:46:04 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqot-000000053Yc-15jZ
	for linux-um@lists.infradead.org;
	Sun, 31 Mar 2024 08:45:41 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3416a975840so2612164f8f.0
        for <linux-um@lists.infradead.org>; Sun, 31 Mar 2024 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874737; x=1712479537; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpODOh8SpqDydjsGmjw6Via7WFpVB11YsZ1xvZ5Vpsw=;
        b=DET9sepmqb918tVaZ7QHGffOFRaUi1t1bvaq3GXz4GzRi5zXHPP5wIfQNjI25VALEE
         9kj1mkY30oo9xfaYXD0f/jJnUOVaS23oYKjivhlBlX2lJR/J+YybyL/cmBbKYZgtTafu
         tAXkRfaJ8gaSFn+XNHwqoIBmE5ECU6sFofdLlc4mtnnZoqvzcxYWBGLaf4Jj3Nb3QZ/Y
         KE+hO0K5j36blQsKOVI5poXs8zBXVFGow6bdktHcs7Hc3dbe0rK4Jcq0eMq587XwhR7X
         D5mGu2uXZcRuPMawbXxm9So3AXcZyGpuT8lkD+AGieaGixMMALt6itNsv1jofgRc+2sx
         y27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874737; x=1712479537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpODOh8SpqDydjsGmjw6Via7WFpVB11YsZ1xvZ5Vpsw=;
        b=guR5ruM0exNdvCSnnyxpl9M2enrgjFqZBfBGcA+IHjTiF5zPSgl3jdNQklBb6HRYC9
         W5UPoTSi/40NNEn6vmyLvZ43T0pxC5m0Nw9ytteHroRKp8Hae7oBi074Zzrv6qZB92dz
         f0IQhueW+BmDoi7XDZj1/b/kM66PeT6EKPISqv1VVNwPg2gE5ctBQgNGG4///8/nCZlK
         NvG25H+NBWIhY8BU1AhxBWUEIOfwmQgUHodXVT+3zXQN12SaGiZzY+qj4D0cIuUAZ+h3
         D/wccxKh3yvRCZUZ54/ukCD/1vBOW0T9C0c9i/UG1hInBuGrkjW/Jdy745mzOGvb5yRZ
         DGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVOhvkLkOTl5Awe8BMOlpM2a7cBqL625EpUUXOhj6L+as2uyMYa8vkv7z8fqVTd7puLFRubTFAeqJ/3uaZygZpJ1Yl/1pU6z4uyt9K
X-Gm-Message-State: AOJu0YybRiGvfqVAItF8gBYOabyUvUGM1kO+llCmoj5qPZSUg2inVN/W
	NdsB5NMKfn2Ket7+/3NHjl/Kg1oBpMb6cjsXIu6Z4623Tp8s+7RxhOy8ZtpWLPk=
X-Google-Smtp-Source: AGHT+IFhMJyghUycTdACT9icbSfKwd5VYS5+lHR7GEHa8HFyFfxUN9leod9pf+Cfrh2o34+h8a1zxA==
X-Received: by 2002:a05:6000:120a:b0:33d:4966:fa8f with SMTP id e10-20020a056000120a00b0033d4966fa8fmr3764747wrx.46.1711874737155;
        Sun, 31 Mar 2024 01:45:37 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:45:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:02 +0200
Subject: [PATCH v2 15/25] misc: nsm: drop owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-15-98f04bfaf46a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=780;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rkTpT83OyeYcLFTcFWPlfq1EO9ueUCyja/WSxZqw7hc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJdqEGjps1UnoPgvmyvw1qk/es9sAOvFP6i7
 rDkSj/3F6mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiXQAKCRDBN2bmhouD
 1zh1D/9K9JiZ97FbRH997WXYeCIcOLie8y2bqS/tD2tujwmKzpHYmuBcAuNOI+xUFCEA8dY9ZXw
 Xxv/alBFKHlBE+G5EjNOODjB6vPUte/sSc53V4DB1/khRKZXwLX2GCksWhBKxe2Bo8hWQ1uWPrx
 zZqhsapmUGDnwRrG4U2DvNOQFc2WP9MoXnHRI9Vn4WXcJ8NjXlmBLoh2SmH/y7Xnn83iAsY4Bd9
 FJtqV6C94yGjdfn3mNcEd1nkXz6GM4cB59sJjLC5LMrCICh6donIiz5rbH2jmwPPMzFCx89FCBo
 QFtEU7uXE190p/t1P+2MImFzqbzp9AXhclMuU+9H6MHRDTBZ6F5AKb2xCpjNUJ9FYvCT+Oc0/l1
 yR7kmKwZOYE/Z6N8tohI7QT0GuBxqh9+yh+qsD9MpuHsNSwE2xLFJ29VpEUUcUMXBNYKADSdJbL
 CF9FasVoxOWKghUj0Si8FZ55UJ92wVI8P4ZTNOUWZ7Rzgyz2txMbsfAslxSkDxEyv+cKDMAYb/X
 lkeTdl48V+76z4vY3NM3ADVZGkCRhNpnE1/Dylblp2mvOMZGCGh5Qbn6aKYIPbaP8ovLWpLt2ey
 zWfa1CVWWaXBOT46qGPDtdbm9Wc+IsLSUv46B0GgwCXox+drd7wsQkIOppqY7gTC0Chte/FjF7J
 4fZvDPp1PJKyCmw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240331_014539_428584_46494D83 
X-CRM114-Status: GOOD (  12.73  )
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
 drivers/misc/nsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/nsm.c b/drivers/misc/nsm.c
index 0eaa3b4484bd..ef7b32742340 100644
--- a/drivers/misc/nsm.c
+++ b/drivers/misc/nsm.c
@@ -494,7 +494,6 @@ static struct virtio_driver virtio_nsm_driver = {
 	.feature_table_legacy      = 0,
 	.feature_table_size_legacy = 0,
 	.driver.name               = KBUILD_MODNAME,
-	.driver.owner              = THIS_MODULE,
 	.id_table                  = id_table,
 	.probe                     = nsm_device_probe,
 	.remove                    = nsm_device_remove,

-- 
2.34.1


