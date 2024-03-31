Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB68CD1288
	for <linux-um@archiver.kernel.org>; Sun, 31 Mar 2024 08:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PUGaKwdvwMokLlZR31UQgBcIJ2q0krEU+yZMO7QbwcI=; b=1SHvJtj0J4TFEAgDdd2TyeOC00
	6tYK/ukzLDovbyeTPy7SmeoU/XU/nmnTxJ2pt7z+xQPoNPsNWMovffpT3qRnBDh67Jtsxs97KIY4L
	dMXL4W2NQlFP+Rj4q9ccxhTwnlk7G3H4FlAaW4ZTgMAj2pUAMp6Q1c6pBgYTAAw5+NcylIZhQBNTS
	9XnGgLPnxItT27pmtZPWQPqa8e4bE4dQb9Of1jReDCID4tFhcJDnF1Sk26I1gx0XZNa4n74j2n9eM
	b8QlJrtSXUdD3zTKFVzMeKCDWr5Kd0UbqB3WsApRdwkwY2r4xt8CRgsObbC8GZ7Wcqv/pnSiuHD4y
	F+vIBEvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqq3-000000054KB-371q;
	Sun, 31 Mar 2024 08:46:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqpo-000000054CD-45Ou
	for linux-um@bombadil.infradead.org;
	Sun, 31 Mar 2024 08:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=PUGaKwdvwMokLlZR31UQgBcIJ2q0krEU+yZMO7QbwcI=; b=cXUkZFbNR0Qkph4efQbv0Fs4qv
	6WDAvI4B0Q3W9BPIIQb0qsrcaAKiZ5zrYTPbLopbuwjS5sE5exo3NqQJxHE0XOkIadpcO7KZlMaao
	VySNZW9vISpGIjmX3o+EpmXmuSvSRjteL8PtVY89i0iSe8pJJS3kc0KIng60AxaocHdqSJyYlmpwV
	uWRq1PjHgNJTpEEdfKaPLtuQCkrK6ggBcLp3S8ntNb5mYIdWTR9EEAT2B7ZU4lWl4Gbz+xSaMCu4X
	T0h7xeHG9QaEpv6BpIGgw3m1fSvGbrMU6S3a5ESNxO+vs8HBr6iVL5jku8P9IZfRtp6VHvI5wwMxq
	9Cs1BhBw==;
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqqpc-00000002SOB-0KV1
	for linux-um@lists.infradead.org;
	Sun, 31 Mar 2024 08:46:27 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-341c7c8adf3so2221858f8f.0
        for <linux-um@lists.infradead.org>; Sun, 31 Mar 2024 01:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874782; x=1712479582; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUGaKwdvwMokLlZR31UQgBcIJ2q0krEU+yZMO7QbwcI=;
        b=u5jjrgOy7pOpcnA5PnyXQDwg90siVZXp1UFC73LQBtgzSF2uy5RMK+lvW6XFbh0ZOu
         6RCVJh7HBN9yWHXS+dPLIrEmT9gvNTvKwWHUHbrm8OFDhK5/cBTsM5ScpwDiNV20PoNx
         QLhlbyxVY6bcTie0yJouL1jbDetewD1pZYnD4MM+tqjMkrgCxxv4MRJ9liV1XOIlucy+
         FhY1vRlJwuUb5HX+6rjR9pXLHgFeaEhfI3Cu5TFoo6JWXq/ME3adJWx3d2bxuO2kyMdw
         HJDTI0vl0PGX3rT3P+WelG1C/Xn0QXeAesFCrlbpcC7P+K1c0wCADDDR7Jkv4b1xohfu
         5goA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874782; x=1712479582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUGaKwdvwMokLlZR31UQgBcIJ2q0krEU+yZMO7QbwcI=;
        b=PK6PTRnDiCh8G11gONMtyhN7+QDKQPvJiGputx3jwEVbpm5LVvGjo5JpPCXRKKxhNf
         Dj9mX2o79eDxwZU+zKhwrfA7uSJawV2g+SKuihwlLay7g6HGCZ2PSAK/dVWp01K8szqg
         MnFoJwlRVkVqAmC3tYHZTm4/hv7hrJaaPgZoYF4iSl9LDHnw1buuLzmSkp+HmnHHmgie
         8DzxaD2F8le4FhiDJtBmsnnFJf7oMU6xbegmw0iaw+4A4rjSk+vbdbZOsxiSN3WOIRiN
         OToeL97uaC30gPhgdTepeVZvuWkJMl6W148c90RK+9k3Pqv72m5petiUuXNPGp932l/p
         oikQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpYrmNHVub+QS7eY1TVUq46QwFAzZ3JOraFPJRQhbmqRnBuyi1gn2ETddBz/8TtlIPA+3BuXf0KB5DgJnT/kM9VfrCkYYfsdVPqzRI
X-Gm-Message-State: AOJu0YwLlXLf88giT0DOY8CwXhkgAccipTUAuGD6M4ZCCeb9PVQSzRtB
	7qDshwaT7toN8/s4g8swQPYCEgK7q+cyalzHi91kUYXJiD61vzGxfu6s7uAHydA=
X-Google-Smtp-Source: AGHT+IF7MARc7H4ZqzG7wJkQ89qaWtgYzIyVWgX/basw0DoDqcekmy5aXwgVIVD/A5uDZbyMRmIPWA==
X-Received: by 2002:adf:f88f:0:b0:341:d2f9:494c with SMTP id u15-20020adff88f000000b00341d2f9494cmr3575737wrp.55.1711874782419;
        Sun, 31 Mar 2024 01:46:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:46:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:12 +0200
Subject: [PATCH v2 25/25] sound: virtio: drop owner assignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-25-98f04bfaf46a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=719;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ZZgxTq79++b7HHq30K3VBjFNBWdk1QKSfVGAvnwx7/U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJm5t8lRjxPTys8b+WU0OKgg1LgcvzKJ4xNt
 n3OV06BuwyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiZgAKCRDBN2bmhouD
 13W/D/oDYwucjXt0Tt8Y0Uy9LmGcrAbjofc6FyMbOg5ZcMm5e3+WVCaJvH1GzuMW7eKutG1NKq4
 SG+22VBevobbwXkTrzQkvyrydccLRDbeWLWm+HJad5tojpoFvW83SYI4iPlD0b266lNVIdzpKjz
 hcUgfDLubJvg2WN81urFjglAG74SusSyGpct+7+xypg9xUvAMj+j+vblD6MiYvdlR7YTT07NpVb
 CnsXjptZ5D0mdqdAp/yyZAVgxH8IatToMVp+zeRzRlVPHc8mepyeo/z9irAjfvJMoh/GGv0t6Gr
 6lHVgN1q09NOsaKCBvZgBc1M3JNDSEvRjO4LMT7dAINa97EQdIp9+8ZpNqqX0RQXYDulXZIS5+F
 Fi4LuIifmxFvnLlK3XGafTiE+izB6Av3JwLIwcg0Q9VTwxzmWeoDKL9c1o0P/bZ5TzBsp8cO5Az
 EQrw4GwFCAMD7jfVzip/IzS25Sgb5lVDNqj2sWyi5R9/l0bzGoRd8h0nMUo0h60LV8+UQNG4Qn2
 Z5ijAWCJJVA4mNoA3tp1IfoltFnoxAy+WhGYLKaLo80DfbVnlQAHuwY8P4oIqsfEalA2ZTmhTBx
 qz3zO+FBApnCfqIytRnVYYYjPxsP+kbjFVJOBhR1fGzSU1/is2cPkZduK341zXENT6nHwkNDVK4
 VB34pc8fk3aFIrA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240331_094625_604521_00D2CF48 
X-CRM114-Status: GOOD (  12.72  )
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
 sound/virtio/virtio_card.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 2da20c625247..7805daea0102 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -438,7 +438,6 @@ static unsigned int features[] = {
 
 static struct virtio_driver virtsnd_driver = {
 	.driver.name = KBUILD_MODNAME,
-	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),

-- 
2.34.1


