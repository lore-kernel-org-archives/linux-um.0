Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD90FC0218A
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=; b=dQ9clS/A7fe4kg5MVIbFhnBssp
	NVrgrqBPMYtT2ojcMHBeSMmo56m1n5jHe5ezA1m1C854FTut/OSTFAVPZZQVcTTLiwp5YnKvjcfLx
	diQf+eXAIKBW3ISkZ5sDzI2LfrHJpvo0Ni5r8M2JWZFF/UFmMnvA0gTljG9eCrSrDOHhUBAIpy0dC
	J1lvzYaCf3O+8k8vCTOjvXC52NlfUW7HvLTf1emRpPeaJk5f5K8jZsowO6ZUZElJQuvPQIrEgRdce
	c+Yh474caqJXgVAc9AN/XHzhFnHFw7LNN1SDLZNVVcnuyxRoTOiZokh9fI1f9sY//U//Mvg0Orykx
	AB0M+KFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkr4-00000004nUO-1peo;
	Mon, 20 Jan 2025 06:01:46 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkq5-00000004nJ5-1DiC
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:00:46 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2166651f752so96308335ad.3
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 22:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352845; x=1737957645; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=;
        b=I8lBnuEO5QkHwTLCbKjo64nr5baTfuPrAvhjhxoR7Bn6MYd3fbaNkqv3M/HAHR6xwL
         P+hL2tl2yNYKTMospnS7bYRVavB9FjKrYQ5RbrqAz0GbHZx6L7zgiiATHN9O4n1PVUR5
         ZahCyRG6qHfAHMT+XZ/jUt8zz0dZYJeTtXXjcslguZv5UI9DZIC/vUFxZb0iygZVHAnE
         g5RpLNTzVjNPIcStSLwOztPy+TMQWRgLyUyOdpyQCyKxC5dzo49Xhb04/wRNZxRK4Gsd
         EWUeEfjdKlJ7CBpFAlcffctWgIw5UtfbssG7J3n//4SCZkeX5wskzJbDqhYVK32yg5uu
         NKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352845; x=1737957645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=;
        b=IK9XQXkd5bXgLnRGys7mKUNEM/Hwj7xgcc4sRjezQ7JMraF+d/Nz8KonNIPFam93by
         d7qKnVAh83t0IuEyacUXT4/DbnVh/O1jXQuuCYlxSC1CMSuyNyA5O+G0SrCrgUojeqPv
         L7DaYY5MrHD/GqT+peYK1p0ATa+hKm5fPjrN50tSixgfkpPFkvdRF68HORDaJRoEFekA
         CiwnYvHEfbykRsR9X5IrM2ONK2wnlcVT1SEYasBLiKeNuILsnYSG6H4PspBuV60FTl/K
         9AL8kzZjoSzpLJii/gXViS9IY3NG3+/sULqDwpYvUgxVWJO+5clnHqG0zqOoz3xjdsJg
         8NdA==
X-Gm-Message-State: AOJu0YzT04vqhfg8OGnYLp3ZIitdNCMWm+sj2Hky/zE+OItINzvrHFaA
	HA812UtIfexneSlXR5L1GGpHryNmgMmvqglFRfxblE3d+PLchcDDtiCKeg==
X-Gm-Gg: ASbGncvvuKcRIPrDQYmBC3ZyH5tGCzM7pa7TqCP72I9D9rzIWJx0b4NLn4FdGVB6QQB
	Z7ikDsI1CkJx6HAgZKLC2FQy7TL+lJHFUTENZDJb+HXMqeVKvjyUYHQCjN2h5YEaOfHCCtXBer/
	vyUEktDM7Yi4iZhKcFIonmWfMVeJcUTU4gRGk4Ugku5XHcQ6j4oMM1UtiCy43jNcWb46s+jvr2p
	j2hrDivpCUW7wuaRbNtIRmXXPFh4m8zgpUK3qzDBIKNpQ4LT2FQ4d7Kh10X8USap2yArUsGhtyB
	C4xhoAH3AePM9u4O9YuThehKSzUqXe6FvwcPiSO8eA==
X-Google-Smtp-Source: AGHT+IFBVLA/YuSptEMGp7YSmBTjYFJGKEYSdK3bwQXdJAkty93FDbtMi4/4/vDgibUi14BJzyMk5w==
X-Received: by 2002:a05:6a20:8429:b0:1e1:e2d9:7f0a with SMTP id adf61e73a8af0-1eb2156f917mr20819394637.34.1737352844780;
        Sun, 19 Jan 2025 22:00:44 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab8132c5sm6151914b3a.47.2025.01.19.22.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:44 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id AD50AE2753C; Mon, 20 Jan 2025 15:00:41 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v7 11/13] um: change machine name for uname output
Date: Mon, 20 Jan 2025 15:00:13 +0900
Message-ID: <5b2db76c8e787f0d21d6a7b416b7af7eb4bf0f3a.1737348400.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220045_468931_620A373B 
X-CRM114-Status: UNSURE (   9.77  )
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

This commit tries to display MMU/!MMU mode from the output of uname(2)
so that users can distinguish which mode of UML is running right now.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/Makefile        | 6 ++++++
 arch/um/os-Linux/util.c | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index fcf4bb915a31..722a3bd03f24 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -155,6 +155,12 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
 CLEAN_FILES += linux x.i gmon.out
 MRPROPER_FILES += $(HOST_DIR)/include/generated
 
+ifeq ($(CONFIG_MMU),y)
+UTS_MACHINE := "um"
+else
+UTS_MACHINE := "um\(nommu\)"
+endif
+
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 4193e04d7e4a..20421e9f0f77 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -65,7 +65,8 @@ void setup_machinename(char *machine_out)
 	}
 # endif
 #endif
-	strcpy(machine_out, host.machine);
+	strcat(machine_out, "/");
+	strcat(machine_out, host.machine);
 }
 
 void setup_hostinfo(char *buf, int len)
-- 
2.43.0


