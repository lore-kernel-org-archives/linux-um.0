Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895E5C678D4
	for <linux-um@archiver.kernel.org>; Fri, 13 Jan 2023 04:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:MIME-Version:Message-Id:Date:
	Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2w42laE2pwgD6eDdoeb7nj3DHoS29m30s92iKSqL/mQ=; b=Va2jRM2NfiUc+p
	BlLf5v6Mf2xg7aWWh/5NdEG0g7di6v5AnJn1yOIgEtmMF6mU2JoKMuzbkvDGF7CoGgpMXBVY+fuQB
	ab3+9Ixyzzi2fGUdQ6MOL6kWlTHxaF3o+ERPGy68bJYZJ1Z5hr6uV4FqxanKtg5k/tYmkQqWjf0E5
	ep6cnMByF/3fq8KbKJ9tsyxNRH4oZcpVT45OoghJZMW8liN/RNKvIZ1RQSBWwzPnOHxlJF4ID0SFt
	n/ZxmlW0Z1anTtwexxSlGT4g5XX77ViLup4fbysJqXJ4ibvn7GUi0b4UVwZ/92Bk4tNHHdcUUwSOg
	pJNinvDgKbW4JIh69hIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGC0H-000RMw-VW; Fri, 13 Jan 2023 04:49:21 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGC0E-000RLB-2x
	for linux-um@lists.infradead.org; Fri, 13 Jan 2023 04:49:19 +0000
Received: by mail-qv1-xf33.google.com with SMTP id d13so14128816qvj.8
        for <linux-um@lists.infradead.org>; Thu, 12 Jan 2023 20:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BGX3VGymQGp8GLR/8ell86Z6rupR3s1Pq8aI6kKwcEE=;
        b=uF3qGo1TN8n3B6fNlpBQMxkO9ioZdY68UVSs4+j877qiAZxgtnB70ARzy7dGpI+oCU
         ijDatCGMwHrL/cjxYRwdhH6xZPdy80v2jzTFWxcFJe8cpWMDgM6GRwrpNl/1jvLn2jWF
         /I/SSsO6yvxA3iftmgituaoFiU28YHNsUa/ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGX3VGymQGp8GLR/8ell86Z6rupR3s1Pq8aI6kKwcEE=;
        b=k5EKKbvPRqQ/COyk3W2FAhg28KMmDmYXEiaTGjazR08T1WZFtSZGEO6ye+9M/gRd8W
         IW0CdR87F1M5ExiU88BKjI5Q5sWuKWacgVrApnMApKCwQ7NIlWFFWVmGBk7+vDumUwTf
         4BPLOy/4DSCW0KXCboDeV1pp+0shdsv+wjAHSQBfJtsc9slwnmRn55knFt9J7THK/NBB
         cqrS4yvfRA6stkEg0UHlncdGWI3k9Ji0FCAqI+Bd2aEgrIbxCKbe0+GkkFCuH54hiGt5
         lhmkRfS3BOjFqb45d3EY5Q2X6dqY4SQ+xnKk+ZOVX5XOfH2IH3FqkVD0Uo+HDN1p2t/X
         EKkw==
X-Gm-Message-State: AFqh2krIlv39gBwrH5kbtIJEvAaB8Whtibhftju2xuXOzsZfeyGWuqPT
	iuNBIS2d4MEAuwkAHPPSeju9cQ==
X-Google-Smtp-Source: AMrXdXsu3oBNYKR2YZHqs31dWkamf6/T9JzfFf4OZZjRB0LIKRdSLgYuAO24BqnHnm+JSVh/NtxbUw==
X-Received: by 2002:a0c:c586:0:b0:532:236d:3340 with SMTP id a6-20020a0cc586000000b00532236d3340mr33594903qvj.51.1673585354708;
        Thu, 12 Jan 2023 20:49:14 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm12099472qki.73.2023.01.12.20.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:49:14 -0800 (PST)
From: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 0/4] um: Various build fixes for allyesconfig
Date: Thu, 12 Jan 2023 23:49:07 -0500
Message-Id: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMPiwGMC/x2MQQqAIBBFrxKzTlCDFl0lWmhNOQstZioC6e5pf
 /f4j5dBkAkFhiYD401Ceypg2gbm4NKGipbCYLXttDFWXVF1q+698XUaiuidoPLs0hyqGp2cyPU4
 GFd6/vo4ve8HRX1ux20AAAA=
To: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673585354; l=1042;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=Pj+bhJnt9Vzw44uU8oe3PGVTrfvQfgKSmUU7jQWh2Ko=;
 b=t26ey9F18MEelti8Q2CNfi4eauyJ6tavJeEqsXXNQwwbkNKoBktxXTaXD73uyFNvmuTQVg4iFjez
 ysAQ54D6AkRDZJSsJcQxL7FANZ9UPfB1bHGpr4ZieQP2d7YiAeya
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_204918_200708_CBDE9877 
X-CRM114-Status: UNSURE (   9.00  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Fix some build failures I ran across when trying to build an allyesconfig
kernel for ARCH=um.

To: Richard Weinberger <richard@nod.at>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Peter Foley <pefoley2@pefoley.com>

---
Peter Foley (4):
      um: Make the definition of cpu_data more compatible
      um: Avoid pcap multiple definition errors
      um: Prevent building modules incompatible with MODVERSIONS
      um: Use CFLAGS_vmlinux

 arch/um/Makefile                        | 3 +--
 arch/um/drivers/Kconfig                 | 2 ++
 arch/um/drivers/pcap_kern.c             | 4 ++--
 arch/um/include/asm/processor-generic.h | 2 +-
 arch/um/kernel/um_arch.c                | 2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)
---
base-commit: d9fc1511728c15df49ff18e49a494d00f78b7cd4
change-id: 20230112-um-3f06b1bbbbb0

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
