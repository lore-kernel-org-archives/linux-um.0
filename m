Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD11ACD98F2
	for <linux-um@archiver.kernel.org>; Mon, 22 Jun 2026 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EZ7pZRYHyAL9Y6GeFGdymSQ0UmhOlD3YoloBKxZNcFU=; b=mcLZvrf+1HxzhY4LMYYpSJWRKU
	H3ReHREaCV0vuIwcB8GWcJETgGr1iIf+7bzYzlw+RRwktXeJX4NOWM6WSgCUjcIVmM6Mx/yYGP4m6
	y7HPA8jQF2rMAqRliryJTQz9IpK2cY6oUVlFiGd0naeq20e31JxoWzUgMjYJVtmVQA3rxcPySRjxQ
	iFiFV9dK/FvTm5Jx/VUZcn8EXm2j/k0RgYLFVi8kaw8d3y/hCQhDcUU8hoyUWv6Vpx1OwBJF8o45Q
	ZYYsQxFWlY2yC06wp3wWyzksAp7tsX6j+MV1L9PTvPv/HNOfCA/P9Grubnf2i6W3Pmdk7/adYS0Pe
	gMR2uVqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbe4E-00000004yjb-1wIw;
	Mon, 22 Jun 2026 12:47:58 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbe4C-00000004yjE-0Ur3
	for linux-um@lists.infradead.org;
	Mon, 22 Jun 2026 12:47:57 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-9157f7c1c0eso416737685a.1
        for <linux-um@lists.infradead.org>; Mon, 22 Jun 2026 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782132475; x=1782737275; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EZ7pZRYHyAL9Y6GeFGdymSQ0UmhOlD3YoloBKxZNcFU=;
        b=WkaVncGmb7xCMol0y5ExIzZvMQREYGz2OS3xcaqCAY8esVEnQKnwm12oqLzLIM3QGm
         DPPTIbJEOPJmSaOuD8bJQ9SIk1K3z99s7eFxonWMTXw/QkQofRIEM4014IV17dgrO4+i
         2m3dRpRD1oYT/fpQMqjrgCWaddo9rwFYNM63RE88OHRuAqMxoF7rCATMzSJjoHtJfLd0
         T868BLac9/WFJ64Ge4Axrr6OaNEOdqDTLblLTYeQmKScNPlzUkd/o/l2cR16dl26aQEP
         B7RfG6z183qBEpWWzaBEbQhngVGQw3GYNQiMoyZ4ffd65n47ChUZpdtmOvcR2PCmWBjJ
         yCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782132475; x=1782737275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZ7pZRYHyAL9Y6GeFGdymSQ0UmhOlD3YoloBKxZNcFU=;
        b=e7/csJMyGP31ZI8u3yotR54czpYTyt76U7HzAqg1WCferQ7SA3Jq6iNR62bWE37ctN
         zp+n4fo7GWdzOhZHi8Px3sweMf8xldZzp9UCYgTdFgIIWv9ZHcXtaJPapmfA60iJcMwy
         TdqouZvNxiuLZWTN2OuOMzZHa+K8xxaoT+1HUqVIjzEN9sJN3NcW/B7NuNiS4HOESRof
         JluSSc+Bfg3FW4NsjmIAQ77/PR7Q47qnePzWtV1twsFzPXkdR76PmHK+4bmnUKf2WQUL
         z5n9ek7t8CGoZxWG1uypFXdSmbOHJN6Dm3QvlcDY5Mnj+WNv0agTc9PhxwUrPhTHs2s8
         Zi/g==
X-Forwarded-Encrypted: i=1; AFNElJ/p2uf4VXQRe66iEgBbCdTyXNnBDs9oNMWofsj8NvtQh1Q22XzDwq2nrtUsfJGMTuh3QX/tadKZPg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyUqBTkSz9wBZENA0DBOfYr4ozZ6jRCp/lcwG3QNVfDtmVHjo94
	oOAX7xri7LRYazEj0pnsan5lYU9VxxJQgHV4cx9+rPYo6B2QvNgpZQcQ
X-Gm-Gg: AfdE7cmoan0FEa3WwetoTIeBXnhCvq9dt3MJT68IvBJEfd19SLy+XCrmi61+Jkv/W+k
	7EIi12u77i9Qp3r4hz11zMP9mbSWSdzrfssBhVdWuITwFwpB4eJziwfK4fsQ9z8NWTwwLNQ/e2V
	JGNyGfcCyphwP2L0tPR5bx3O+KMqlNpNBRi90/HIuidu+Jj9RNa7BQxZM8C5rZAT0O+ugWQ/aov
	W6u8nx/C1kgf8YkENZn4awJyfGcp74TT6WoWRKUKRAtW8rOL4paGRpzZKUW+vFJZSNBaUbw4tTG
	UfgO8TfyCOfBwh1PicojYHL+mT9kkrkAErNjcq8ZbuktaJKeNZJ0hZTUEx/m1I+RGzYpzb2ORcy
	dbV3c0XscdR8DWxdXXVjuf5keuLVHG8G0kngtxGaB5H4iMdhNbvDP+H7/Px68yIWJnkFv99n65V
	XWv583ZbpDwvKv40QNNIjD1FBIrzk9PZXTqN/Il3DwY27a1GxPPmJAbE7DbJbiAN/SdrS8FodQ7
	K5F2ZzjBLpnN98waJK58BvajLim0T5d//uVKzj114M=
X-Received: by 2002:a05:620a:2945:b0:915:b852:4354 with SMTP id af79cd13be357-9208f15a21dmr2300093785a.9.1782132474635;
        Mon, 22 Jun 2026 05:47:54 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921d7f5127fsm972531885a.17.2026.06.22.05.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:47:54 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: virtio_uml: fix heap overflow in vhost_user_get_config()
Date: Mon, 22 Jun 2026 08:47:50 -0400
Message-ID: <20260622124750.1694957-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_054756_171226_D29AA1F5 
X-CRM114-Status: GOOD (  12.61  )
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

vhost_user_get_config() sizes its reply buffer from header + payload:

	size_t payload_size = sizeof(msg->payload.config) + cfg_size;
	size_t msg_size = sizeof(msg->header) + payload_size;
	...
	msg = kzalloc(msg_size, GFP_KERNEL);

but then receives the response with msg_size as the payload cap:

	rc = vhost_user_recv_resp(vu_dev, msg, msg_size);

vhost_user_recv() reads the header, then full_read()s header.size bytes
into &msg->payload after checking only "size > max_payload_size". The
payload area is msg_size - sizeof(msg->header) == payload_size bytes, so
passing msg_size as the cap lets a peer set header.size up to msg_size
and write sizeof(struct vhost_user_msg_header) (12) bytes past the end
of the kzalloc(msg_size) buffer -- a slab out-of-bounds write of
peer-controlled content.

Pass payload_size, which is the size the payload area was allocated for.

A malicious or compromised vhost-user backend triggers this during
device probe (vu_get -> vhost_user_get_config) with no guest action,
which matters in the confidential-computing model where the guest does
not trust the device backend.

Fixes: 5d38f324993f ("um: drivers: Add virtio vhost-user driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Reproduced on a UML KASAN build (ARCH=um, CONFIG_KASAN=y) off this base.
A stub vhost-user backend that answers GET_CONFIG with header.size set to
the full msg_size makes vhost_user_recv() full_read() 12 bytes past the
kzalloc'd reply buffer; KASAN reports a slab-out-of-bounds write in
vhost_user_get_config(). With this patch the oversized reply is rejected
(-EPROTO) and KASAN is clean. Benign control: a correctly-sized GET_CONFIG
reply succeeds on both stock and patched. Before/after logs available on
request.

 arch/um/drivers/virtio_uml.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 7425a8548141a..38e960bec9e65 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -568,7 +568,7 @@ static void vhost_user_get_config(struct virtio_uml_device *vu_dev,
 		goto free;
 	}
 
-	rc = vhost_user_recv_resp(vu_dev, msg, msg_size);
+	rc = vhost_user_recv_resp(vu_dev, msg, payload_size);
 	if (rc) {
 		vu_err(vu_dev,
 		       "receiving VHOST_USER_GET_CONFIG response failed: %d\n",

base-commit: ef0c9f75a19532d7675384708fc8621e10850104
-- 
2.53.0


