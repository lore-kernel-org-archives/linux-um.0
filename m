Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5008BC982FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Sep 2026 03:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ixt/Rxi4OM6LS0sSMn+Kn0k0Yx5XJM0PK6LzpYStkGc=; b=QqqmylYnrfLw2J7adsOOYdzztb
	GoIYGgG9oyIt3UqHfPBQpXC4/hXbX/xBTiXzNX0nWpp0Aeanihn4Qk5xanEuUdPPSSk65+mBtmXpH
	TOQ+boSXIInwY4L839PaJwsCUZKPbRVkQ9MwbfvCIx6Tvz5NN8aOHAE2LvV9qx/lf4bcLl6Lq3eW/
	3JU88YJp2FaHrEnkoC7UxzIkxh5Kc63vTqtslNjATkAaXoOeH8No9u9afjQW8LHqG1vmn68VG18+E
	cJbZXNNJ1zB5zNuNbjx2tA6Ri8JKsmgIquTdMHJNIg+v40qQBBmqI7P87wqjEymEgG64xmW03uocV
	pNy9Sblw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8qmy-000000042cN-1YDs;
	Tue, 22 Sep 2026 03:03:24 +0000
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8qmt-000000042bH-02vQ
	for linux-um@lists.infradead.org;
	Tue, 22 Sep 2026 03:03:21 +0000
Received: by mail-yx2-x0f.google.com with SMTP id 00721157ae682-85d4ddd179eso30293467b3.3
        for <linux-um@lists.infradead.org>; Mon, 21 Sep 2026 20:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046196; x=1790650996; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ixt/Rxi4OM6LS0sSMn+Kn0k0Yx5XJM0PK6LzpYStkGc=;
        b=Ka/fLnKaFPexGdQXmWBj2E4BK4V19VGfJLHaNJZThGoAytXeh9N3QrIVbuS9i6ThiG
         3HB0NcldBODx2FtcmPtc6bjHrkta4IbgpOcCLU0mcktO2CVF1InMPx5ayAvBAqsEjxW9
         kxLZOL/XwhbS5EEJzYInZ+20oRLfoAIVWd/rGPAUyqALuSmu+Ut11nuYW8PWMONfmQUz
         5hkZLr/vbNfJMy7pgiQyoca3LqT8A/B3saiLHzX0U7gheDuSxT4O+Hj0JTepr6w9QesI
         eG1WfRmB/hAwYxT9k+59ma70EvFV8fq5pPAU8jJ2OdgL0qUOpMpsFpOHkVeUqCM6bp6l
         Nf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046196; x=1790650996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ixt/Rxi4OM6LS0sSMn+Kn0k0Yx5XJM0PK6LzpYStkGc=;
        b=DQCCK0IE5qcEQwaaQmAhhHduCqIOkksoq0ZUm8WAhZmuuXRkiqrz7FLIh7g5QtzMWE
         9Rop2LKe0s+mWFkXEdXlRbzvOvFRFycGN/DrX537I5qtPWBhm1pAWPA3g6JoUnQA1s6L
         qSLtAT3tNkNk1RHygYp/3ssJmpgk7iCJyKfxQZx0U8jn5eYWSfY/pM2tHXix4Z0i84k6
         vOiYBE79qLyT2S+RyYlAUNJs8GVsgT+0fJ9WQXvwDEV7dCLi6Q2F2UzhWx3t9Av2rey/
         MrJvsGWAhghPyxMBQwRr3tvv7WZ+kZLQYq6vEKXnGuGuK0Ao6V1EAjSZHPBfaZChKSGk
         jjDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzs8DdAS2BixH5ctvZKmLirdcKuiG/lwst0jhwsNnIQqlC7cKK/09j89W23XXG243CI8o3zpc4EA==@lists.infradead.org
X-Gm-Message-State: AFuF++nmwJdeFe7bHDxdEuP97M2BUMSE8W9OxNmO+RnW2r8Yyw8xXu36
	gVshRQZN65kZRCfnAkjh6ck2vCxpxlPn2mgzrXz9fR48eDk7Srz/XViC
X-Gm-Gg: AYBFou3QFqijJK9ZrUfP0J696Y1reeY8AJdSHU6Eq4MwrL27PnTqFLuq2n7cdNYdmql
	eVyBSef/fYaow9orrY1o/QqYLallL/HNEldxyhBpVCayQJb2Hiava6w7hUKqhR+9+alwUkBQig1
	BCTNcEVu6ZcPiUjwTV4Rq9b5ZH4w1n15t1nj7Xt3jjXgl0I7tPKm2T5adOlYs7KyMeS7xEqI8Rk
	exspcGIFslaCaAd+kEE4dcQk8RcwQZ/cuYGmr8UzSuMuf0sEGhz0aR79uYki556/ZnwIujMj4pn
	MC+mDdsBCsfpMh5+I3HAJm3OWLwOsTieFAXYatKF8cwnFrBa/9aXWzp70SJ2IcCDJxFGuCWMM2D
	4vAjnyAgAnXt1BxxE7um4WXFXzWsCtDhVseXjAKvp5Ol+7NIy7u9XQweyAdu7OQCoIy6ttLPi0i
	Hnt9qlXn8IpLVkQiWEoHRCcFvuPa0Wvrfg3cCngcoV8VD2KN3QkR3Xl1huBLNO99HD5nNz2yE+L
	Tc27AY9QMY4scYu7uieyCg0iQ+HLHKsM6mD3hNl7+coW6H3D5Zwi3/NFvjCNJ/KMo5Tm17a
X-Received: by 2002:a05:690e:1181:b0:671:70d2:527b with SMTP id 956f58d0204a3-6717fd6a661mr4352075d50.62.1790046196312;
        Mon, 21 Sep 2026 20:03:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:2875:43a3:e345:710c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a2c1b02abdsm1471447b3.17.2026.09.21.20.03.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 20:03:15 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	mst@redhat.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-um@lists.infradead.org,
	virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6 0/2] net: prevent partial checksums from modifying network headers
Date: Mon, 21 Sep 2026 23:03:08 -0400
Message-ID: <20260922030310.8684-1-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_200319_062696_A923331A 
X-CRM114-Status: UNSURE (   6.85  )
X-CRM114-Notice: Please train this message.
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

A virtio-net header can supply CHECKSUM_PARTIAL metadata whose checksum
start resolves inside a network header. Software checksum completion can
then modify bytes the stack has already parsed.

Patch 1 checks the data-relative L3 origin in the virtio-net conversion
paths. Patch 2 checks the parsed header length before checksum completion
in IPv4 and IPv6 fragmentation paths.

Changes in v6 address Michael S. Tsirkin's review of v5:
- Name the Ethernet-only L3 parser accordingly.
- Derive the AF_PACKET L3 offset and protocol from the actual Ethernet
  frame, including inline VLAN tags on an ETH_P_IP raw socket.
- Use the IPv6 base-header minimum for IPv6 checksum-only packets,
  including IFF_TUN before skb->protocol is set.
- Restore Assisted-by: LLM on both patches. Patch 2's code is unchanged.

Validation: focused x86 allmodconfig and UML defconfig W=1 object builds,
strict checkpatch, and application of the exact mail series to the stated
base. No runtime regression reproducer was run.

Link: https://lore.kernel.org/netdev/20260921025341.44846-1-habte.yibelo@gmail.com/

Paulos Yibelo (2):
  net: validate virtio checksum start after network header
  ip: reject partial checksums covering network headers

 arch/um/drivers/vector_transports.c        | 13 +++-
 drivers/net/tun_vnet.h                     | 52 ++++++++++++-
 drivers/net/virtio_net.c                   | 10 ++-
 include/linux/virtio_net.h                 | 87 ++++++++++++++++++----
 net/bridge/netfilter/nf_conntrack_bridge.c | 21 ++++--
 net/ipv4/ip_output.c                       | 23 ++++--
 net/ipv6/ip6_output.c                      | 12 ++-
 net/ipv6/netfilter.c                       | 12 ++-
 net/packet/af_packet.c                     | 24 +++++-
 9 files changed, 214 insertions(+), 40 deletions(-)


base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
-- 
2.46.0


