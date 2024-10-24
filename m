Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBF6CE8E6C
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dmOB63QcFjTRGwjcPaN3DenRs4280+ze4qBPAV3lWyM=; b=LNbXm06dOJL2klIvMTXbPNA8Rq
	nd3kL0ZE5wqu4DUxNDMB7Naj3/J+qtyORqmLNkt+FxKXjHSXrqoFyxqo83B141PnkmYBE5oGvcJwc
	+22FBeBuXd4GaH4xNjOYhb6rqQmZxAjrCMPeLT7zPv1ynI9SlQw07WUc0gyJUizndSo2ZSzYeagCE
	VNJsa4UD6x1LaHaEiJKm0S10qte3K8pWnQNLDvbuzc/VJTSt6wq9BaJKEEntLJ9jhBvsEOus9JG9F
	KHI7BtvcFtDuUrEHMSwpZc5/Eh5xkjbRn+5lGirxlgTz7ORKSiNXU35EBUOoBLJGYDRxBi88GRLAD
	NI9glciw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wi1-00000000J8c-2RJR;
	Thu, 24 Oct 2024 12:12:57 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wfj-00000000IfP-0BlW
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:10:36 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-71ec12160f6so563922b3a.3
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771834; x=1730376634; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmOB63QcFjTRGwjcPaN3DenRs4280+ze4qBPAV3lWyM=;
        b=dJb3Fu4Vtb3OHZN8YV3C1xSwqqxLlSN9RXwWic1eAR8qVD+RBWHCRcPzvxt5RKhxVK
         1hQ4kNRgixgp62Kx+13J8m3IhZAnZ0YbTnWutn/9oIUXcRAe4QXkMa8fQbgQ+mKi9qWY
         2TE7fjXk+fF/LzJ5+auQmnO+XXSCZEcfUt0BEgppCitkjbCtNwRBmYhZUbsNlpghV8pO
         AuPYLlCoIUSigLfymxcefAKUQsBeSygi77wVme3N4fxqT58anio5qvTOvDsxW2iX6yNl
         j62KQ+GfJCdV+T/XhCNHIRBMcyYJ1/PJ2cNCBL+i/RF2B3DakuUfgLzWQHRhYKeGmaHZ
         Dm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771834; x=1730376634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmOB63QcFjTRGwjcPaN3DenRs4280+ze4qBPAV3lWyM=;
        b=Er8oyEsUE6TOPoSFdU/KsKzIupeECBv08te7s0x9lVsOEj5bE1KxmhjTti9O4Kc5yI
         rToCeqyRHMQTcJwXdfd3SKcmECmubyzx5CLN+CNqDy7+70sDTD6/gYM3LLmO8uIxzxKZ
         jcA0+d2QjjBe3GCmHJ3QLPi5VNgcIr/R5S10M7ACpzPbA7AwbcbsKUPdi0Enf6Vu3YNJ
         FiGJEtuG/9s82uCSWkU0vftvCFqnwenIVk8lQQoErUcVPvorpF80Xeh5gujywd0zabv3
         y9jPzJ44Je7RoyCHRSZFUrmbjFrcFjdt4LIGUjHZr9bs6oAFYSdyUMHc0/r1NTj4CrLl
         srkQ==
X-Gm-Message-State: AOJu0YyGq35EMogvNFJZXYVTk+UZh+USiqQAbg/SF6Gd07kGybctwWqV
	rPcXq3htoS6C3J3R1nKxBjPp6ijveIwN2unfH3vvQtL8QEB8E16F
X-Google-Smtp-Source: AGHT+IEMfT9BV0hUmaMcNRR1SNP5GUjtmUz1o1H5I+2jxV78VrEjdPvY+MmJiLftltoq9lvURKPqbw==
X-Received: by 2002:a05:6a00:a13:b0:71e:573f:5673 with SMTP id d2e1a72fcca58-72045e77ec3mr1897205b3a.15.1729771834329;
        Thu, 24 Oct 2024 05:10:34 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabda3c2sm8504663a12.85.2024.10.24.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:10:33 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id E5A89D5125D; Thu, 24 Oct 2024 21:10:31 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com
Subject: [RFC PATCH 11/13] um: change machine name for uname output
Date: Thu, 24 Oct 2024 21:09:19 +0900
Message-ID: <917e9722e3f8d69aca88372d2a1278b38675f876.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_051035_106085_C219A69C 
X-CRM114-Status: GOOD (  10.37  )
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
index 00b63bac5eff..ea0c263fea14 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -148,6 +148,12 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
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
index 1dca4ffbd572..0c7942ae8616 100644
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


