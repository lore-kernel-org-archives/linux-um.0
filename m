Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895B3C67871
	for <linux-um@archiver.kernel.org>; Fri, 13 Jan 2023 04:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZxEtBL8b/s3uecx5VNaexCy7Rekgdng3D+4gAyinNcA=; b=ICkENNcxTQxdFH
	sjuxOAv8IhxXuGae3E//YiHkCJJXXFOnFih+j7Wzce+yZ5+o3QvmktWl4QwicDlKqWiww7vu1OrZC
	LaBhoMoQLaPzdGtsE+vJ7ZJQL5K8I1f+1QqcrmI8g5E6lo6bVrmbOGUbVk2PhmAivxL6aLxX46iW9
	UEAdBYSw52JEyp5B3mlV8ou+FGu0NCuLlVrHyDTeXdcFskl4sc4Vs25ZYz0PH+eNJ6+dhi285M3Qj
	9i+he0wTR1rbIOQ1YO75E1D/J7ZJeR733f17o7pyQ6rvfhd3Gyj9J9YizRDoiuL+y7Spob2eFypUo
	/j2b1i/mc5WkVLCaqQjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGC0J-000RNQ-K6; Fri, 13 Jan 2023 04:49:23 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGC0E-000RLK-W7
	for linux-um@lists.infradead.org; Fri, 13 Jan 2023 04:49:20 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id qb7so14149681qvb.5
        for <linux-um@lists.infradead.org>; Thu, 12 Jan 2023 20:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPMupWzHNPM6tliJ7ayw5rMWVqQwAd6pjpU1pINArHw=;
        b=YXjyet8MNQ2JQUCfrp7UKKGt5gpB8ooxSYCa0QNBfVZRIUTYTtCo4xXl6bVxWeOaRj
         LLiFzXEKLEK7vVVUgDlNKqDg+kOnR25Z4nmLzou+JYtMwDMLmqmpuEEUDKCqESW5wuYe
         5i6dKzGCSeFXv7uMaNH57yqz2+m5RwsyCUdXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPMupWzHNPM6tliJ7ayw5rMWVqQwAd6pjpU1pINArHw=;
        b=7PDJ3xpi3XlWMyIiC2dL3NlZKFgPdByCy74+dTvkW43mtsphbZLib6JDA9Dv2Va79s
         ttimxh4E/PZwzL9CHOGF7wcgpChePhN5RdLEEAbelKItK6I6Dd+E+dBAvXD7DQr5duB4
         lYyYBZfKFr/yRtwsHtfbndUWupFkH4bhUQThqNsmhqD2ynssgtongHEM8erGxZSBFt4m
         I/gvpqT+rVnU+9jbocBsDrAmdHpoMpAFq9OG0GmlPiSfs2VGGfp/2BoNcKD0VlPrZCSf
         Jmkw7RdcuAfzQVrifG2YjlQhJnzJVELIA0/67mLGNJjuB1KbKCsazzYbgTN5V1xDXx0R
         3hng==
X-Gm-Message-State: AFqh2krcD7kPydxOgAVZgCd3N+iBBv8GqStILAEhCi5n3ORKqd/Bs+m2
	ttfcQ2NE17qa+YDgSEXBhYSfvw==
X-Google-Smtp-Source: AMrXdXuM910sA8krtlGCRk7bXLXQVDHtbL3ipS+GLem6e3saTcMoMX+cK05cfi29sMNpAMMw8rAQ4A==
X-Received: by 2002:ad4:51ce:0:b0:532:2112:69fc with SMTP id p14-20020ad451ce000000b00532211269fcmr29637646qvq.0.1673585356939;
        Thu, 12 Jan 2023 20:49:16 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm12099472qki.73.2023.01.12.20.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:49:16 -0800 (PST)
From: Peter Foley <pefoley2@pefoley.com>
Date: Thu, 12 Jan 2023 23:49:10 -0500
Subject: [PATCH 4/4] um: Use CFLAGS_vmlinux
MIME-Version: 1.0
Message-Id: <20230112-um-v1-4-6bec9e97ad13@pefoley.com>
References: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
In-Reply-To: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
To: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673585354; l=1469;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=Vga2hFswscRKGQdpjgKxlTRwGsFMXJP0qX9HRn8ewW0=;
 b=0LeNmvxk7JUmCA7g5p1WH5uLkngDkEtMpHqFTr3iIMnkJ3t8F/K1s88I2n29F1YUYOP5mVtHiTv6
 DCHga229B6V+hXzhodm0o4DHuW143R7+9NcGBTQj8+35ZTkVzrJZ
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_204919_071560_2A3F2D96 
X-CRM114-Status: UNSURE (   8.47  )
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

link-vmlinux.sh doesn't use LDFLAGS_vmlinux when linking the kernel for
UML. Move the LDFLAGS_EXESTACK options into CFLAGS_vmlinux so they're
actually respected.

e.g.
/usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: warning: .tmp_vmlinux.kallsyms3.o: missing .note.GNU-stack section implies executable stack
/usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions
---
 arch/um/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index f1d4d67157be..93dfb23bd263 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -139,11 +139,10 @@ ifeq ($(CONFIG_LD_IS_BFD),y)
 LDFLAGS_EXECSTACK += $(call ld-option,--no-warn-rwx-segments)
 endif
 
-LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS),-Wl,$(opt))
+LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS) $(LDFLAGS_EXECSTACK),-Wl,$(opt))
 
 # Used by link-vmlinux.sh which has special support for um link
 export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
-export LDFLAGS_vmlinux := $(LDFLAGS_EXECSTACK)
 
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.

-- 
2.39.0

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
