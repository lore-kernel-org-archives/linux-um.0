Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F99D12D77
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 06:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=coSQp1/Gwn4CiglYWsw06eTGbQvY9qYl2cHooFvAJNc=; b=cZvUj91OLPCT3Enuk/fdL1nekp
	odXMIWSBWHKLNEfDGkOMbEiaHNvdm/pnHeGdNW9BAmK0vwqIQsYg4k+Y3vHx0eyoiLHVbeiINbZHw
	B1BFl349Ca2ZenyRbWHBtaWkD4YUCr3Azksyrpp5WJkhKTC9bww8+1XXWXUxLDjnqw2pTc9IyAz02
	1tYfMWT7bEkMO+oA7x2MoWVcm7KsYgWdfS882Z5Bo9aZFYQS7yTwalmgWLbnOgUyKNs5Xa+Bv4XLF
	+hbcNxKU1RuR4r3HJxFOdvTQclrKwvFlPIk4VDGnVm+ShzqsOLN0BUbA+RFwxuOA5R2BvJIHWVunL
	hxWYixiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANut-0000000GULQ-0oWv;
	Mon, 11 Nov 2024 06:28:51 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANuq-0000000GUKr-2y07
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 06:28:50 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-20cbcd71012so48250145ad.3
        for <linux-um@lists.infradead.org>; Sun, 10 Nov 2024 22:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306528; x=1731911328; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coSQp1/Gwn4CiglYWsw06eTGbQvY9qYl2cHooFvAJNc=;
        b=anfpWmOIjiiZVoB3nq17c0lvxZ7YIywzXBH1l/zmMKt3kD0cCQYCnoQzKDyyrKz6eL
         6JPkIgc5vwVMQNJhNoTp+y0k4LTrEuNomSlvuEZdHHmuMZT+RehPg2M6EIDpGB5xdGG6
         th5Rry8QGVMgMV8rBq9aAyVl4oaye4YhIzrZGSC2tfCwN2GqqBQPWtIHRWqjw21rplzy
         B+f58sd7rpvadnDuP41cgalijQAZcWVG6phruqVDwC3fH4gTtLHKobowmDJU3BfU84yZ
         AimJfjRP3beTLqQASYXjYBQ8oo00yrGV/j9xYf2Eh3v8TaFogyAtgmN/sMT4uAJXkrwF
         s6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306528; x=1731911328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coSQp1/Gwn4CiglYWsw06eTGbQvY9qYl2cHooFvAJNc=;
        b=uvVEWE+NBPhHxC7a1i2YcI7g+MwbFRRFkgJnWXVlJkdNGDQJgl778F8GsvaOdXqRWF
         9dr5qGbqegz63L56OhxQU66pkJ7jrfCgpEoisEh1g7iQ/QNklnBmAPsZpwUG0lLgT8D/
         h/rAkRDhnyL2W69zhER6LwFQhtpbQ7L9BfzjJ+jTf+XvT0sczs77MwdXchDvXbt4caqx
         kVyqbrYt5i6Qz0ltlmZvbEpUKd/svQIxd9b0U5bPDYrYUO+Ghk1WuRzCm/qA0bYSYFFD
         XRmE6PLg6zSeezerO6+lfprDX381yXW68NTWKWINeL5sCofOuQX/OCfFUKROhGO0b6q6
         yfNw==
X-Gm-Message-State: AOJu0Yxt79BDOvfN9xzjB0SGNN9zafkp2r7mSzzfaPzxgSz4B8APXL3j
	UwHkQgupoDdqdRT1hu6vzA8iUzk8uyF9xGpudaAI9yDuXopfGoM5
X-Google-Smtp-Source: AGHT+IEfYK6/Xq2Z6VB7yF7YwLvt5svDLDSTtZo7R0WcR9bNAjDIvANCHL6N55S+z/ihwnlKf2Mw1g==
X-Received: by 2002:a17:903:244c:b0:20e:57c8:6abd with SMTP id d9443c01a7336-211835c090dmr174859265ad.52.1731306527695;
        Sun, 10 Nov 2024 22:28:47 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e59df0sm69010355ad.189.2024.11.10.22.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:28:47 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id C7E4DDBA928; Mon, 11 Nov 2024 15:28:45 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [RFC PATCH v2 11/13] um: change machine name for uname output
Date: Mon, 11 Nov 2024 15:27:11 +0900
Message-ID: <13ed8d91dee15907fc71c66f259d884db3def4cc.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_222848_767587_CFD188F6 
X-CRM114-Status: GOOD (  10.20  )
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
index 1d36a613aad8..e0cfa3a9eae4 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -151,6 +151,12 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
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


