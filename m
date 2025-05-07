Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7203C369DC
	for <linux-um@archiver.kernel.org>; Wed,  7 May 2025 07:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C0GKFC8KldnbZQE+xBqEHBh0rPqBW1RKl0FzVBfySkA=; b=uEPdE/nuVtwX/rCWh5ssIiYqP1
	bTSLhz/Sao/KIOFChjrgb4rtwzXz/599H5MvGRBYKxcSK3cueFeQGNgVqYXQ06iUM/u2Pv5ENSghS
	xZ579afeFkScGNpJDpV7Xv6k+DblRuJZe+gYOMcygf4a//aQqffxHTv/BdkjZvmrPewiNrmuvV838
	0RkmAo7TgZifuSLUuJYNm1rZwVB3y9244t00RhAxeoTZY4wI2I+HPS6P0BK3GrM4zPXt/JjeBHGV9
	ODOFPfW8Yqr7eJzTzJLOrAVGgZ78calVhRoAKXKI/0k6kgB+Lcva+Cl7SmEbnAw+1luHoH4wPcZBe
	ZHB2X59w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZ51-0000000EV7C-3FAn;
	Wed, 07 May 2025 07:20:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCYxj-0000000ETN2-0aYR
	for linux-um@lists.infradead.org;
	Wed, 07 May 2025 07:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746601981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C0GKFC8KldnbZQE+xBqEHBh0rPqBW1RKl0FzVBfySkA=;
	b=R4a4Xac0IcSQfMOAqU8XCF19cMZ/kRaUUa8WHPqi7RcMZgxXL2eU+QTZ8K/SsSgQJnIi6H
	fdqPi5nOW3MbgW9OVIGOh2DGnrAotc1XlaURxkjLZpvCD9ytlYGG0J5oMVSwbCU1KEz1O1
	SxAhtTlkQQWcj67JAt/9FDHjgk75mmU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-gPuVdrffP1uNmsqbdzrMaQ-1; Wed, 07 May 2025 03:10:14 -0400
X-MC-Unique: gPuVdrffP1uNmsqbdzrMaQ-1
X-Mimecast-MFC-AGG-ID: gPuVdrffP1uNmsqbdzrMaQ_1746601813
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-441c122fa56so16003355e9.2
        for <linux-um@lists.infradead.org>; Wed, 07 May 2025 00:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746601813; x=1747206613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0GKFC8KldnbZQE+xBqEHBh0rPqBW1RKl0FzVBfySkA=;
        b=ntZLCs0URGfKCKaLSw0BgDYRrmEHNm7i+LwVsjknbLtsrHJBl3Z2I3U00mcyRfjpot
         UC6kDi3wP9EN64jQRnHLVtI2YseCddSJIi6yfiCxQ5f94347iqf/beFlwpAPyWsMl4es
         CEWvU1MzGZPUi+yVessjA9trQQ5A1VK7kps3g/fnJ0RnOUsG/HEJMIp9hjUvisfaCyNz
         5ZfaJK7fpd9sJuElvNc+teCNjSgSfy4IIIDl2qgGjL+1eXU21tKzyZmCqWcnQwiGKVHI
         FEvP89plnLJMtNNig6Nsah23SH22bXrHH6hDg/lF6esyZ358nJxI/3EIOKjcZY6Y4oi0
         6/wA==
X-Forwarded-Encrypted: i=1; AJvYcCWjiuxfgs+/l4EiluZv2j7ysWIfAjJJGfWkL1vlpJuuaBR/ZwP0p/GuNcjwaESi8eAfz6dyBupckQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2xM7lK3PWGkGwxKngWduJKSU9pdprIdSGlA1UCpTWlsSyJrdZ
	T3UZFyY9K+NmTe7Pv4zxN374HRhuIbWdUh8ZJuKiqfEx1M6nVZjSVtPRX4ukmKCQGQA7Hf98uyE
	9ZhtyNNHbEWnGOpeZHF51C/sLU1xVkmClriY0pI0mbPiUeyw7MsXTstJyu50xIA==
X-Gm-Gg: ASbGncuPLBYiTPAXU9g37t9HA1cjwfmO+8AEezvWHQWkG+p5g3qgl3rVW0ANEktE0zw
	kcnlREhURmCc8RRURvVcQTI3rrxoUxXeyyQg5b+4m+/RZj2UOL+WKciJkse2VZnvAwnk0K1ALf0
	6j+7mwxVehaMbV2jUH2bUyn4yeDgzj+JB8VjILlUSfYPK3GfidRaBh35NFnH6+Q2+jy3lezHM+A
	M1s1vOx5IKfIWN6d3P2PzUVzJO6eqiCIg2JwgqZyZuylOdAAWOdx/z9Wg4e1TlUHXfgrFQug6Ej
	VhvY814iV0xq49YLqI5aV+pjWjuhUaOst29A+CiJEx6SObYgQpE488oxgQ==
X-Received: by 2002:a05:600c:3115:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-441d44dffc6mr13755965e9.29.1746601812769;
        Wed, 07 May 2025 00:10:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9fskhTRs+MwvCppLYelBRlCfT20TAw6J9cuN0tMrz3HMBb7GdWxRU+1hCm6NmREYeaXZ5kA==
X-Received: by 2002:a05:600c:3115:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-441d44dffc6mr13755735e9.29.1746601812359;
        Wed, 07 May 2025 00:10:12 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0d3csm15667725f8f.3.2025.05.07.00.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:10:11 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Tiwei Bie <tiwei.btw@antgroup.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: remove obsolete file entry in TUN/TAP DRIVER
Date: Wed,  7 May 2025 09:10:04 +0200
Message-ID: <20250507071004.35120-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iLr3SaveE-ww7hmFc6hUwBPZJUECA8zxZZDcbwnqW2I_1746601813
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_001303_241180_181C775D 
X-CRM114-Status: GOOD (  10.41  )
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

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 65eaac591b75 ("um: Remove obsolete legacy network transports")
removes the directory arch/um/os-Linux/drivers/, but misses to remove the
file entry in TUN/TAP DRIVER referring to that directory.

Remove this obsolete file entry. While at it, put the section name in
capital letters.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c166503cc6b..34a55e3ff863 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24981,13 +24981,12 @@ L:	linux-parisc@vger.kernel.org
 S:	Orphan
 F:	drivers/net/ethernet/dec/tulip/
 
-TUN/TAP driver
+TUN/TAP DRIVER
 M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
 M:	Jason Wang <jasowang@redhat.com>
 S:	Maintained
 W:	http://vtun.sourceforge.net/tun
 F:	Documentation/networking/tuntap.rst
-F:	arch/um/os-Linux/drivers/
 F:	drivers/net/tap.c
 F:	drivers/net/tun*
 
-- 
2.49.0


