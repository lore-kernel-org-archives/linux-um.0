Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9375AE6C5F7
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=coSQp1/Gwn4CiglYWsw06eTGbQvY9qYl2cHooFvAJNc=; b=yMfDHZ6b+N4FmT7sy4EJQd2795
	IiyzuMiIwvOA9PZZljpR3b/Sz//4/rv6VgYSWO+uu+9lcC/o5V4USqbskVSrPtHtlTS1ohS+oohbL
	rXz2wfC6enwQqsClOp0mbHvmRFekQtqJyxEzyqAr3A2oj0J0QCBN56E8dlOpUrJUJ0cEn9BdQ/Thv
	Egf01sPafwi5cGJgiwCHUBz426lStREM0JqChDIUhLBzD/CZkgs9cBNUmvK/+eS8ad9W0PLDbX+X2
	REzX6LI2fY9n+k8vNPOceMtvyTZkPBOs4ffXszEybbRdV7Kb0QFEZFAaVlPoZSxDY/Tfwo7ym1cS4
	X2vBuTGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKSA-00000008DWc-1VEA;
	Tue, 03 Dec 2024 04:24:02 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKS8-00000008DVK-1Q0I
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:24:01 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-21578cfad81so17406575ad.3
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199840; x=1733804640; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coSQp1/Gwn4CiglYWsw06eTGbQvY9qYl2cHooFvAJNc=;
        b=BQUkYoaybsFvPOrhjYgPGTHjvCxsqHlPiHj3quBkS3XoXNc0rcVqpXR4iKO/nfOKNa
         mzWScxp1zHo5FBUJo90lzBsKoKPnqz/OpuPcxFsLhL+R4+YJ1/dmQ1F0c4dCgri0C3Pw
         xZKqiSpFp97/CxKXpdjTuCwm0ZlBDeO2zrU1lRImQGtokaaDuALDH+TwxSQ1K4ESONB9
         Svb77J3aJdKQarN+OInKHlCehTeZIqJ70pcAtaOUlxTMjibhpD0cKFDRqcBPeGFGppyu
         K/u/oI8X0PDYikxeDxPGJIh1t6DYODEZkbuAqRTl0dZWsZd+VNIMC3Tj2Whv7vCflpK2
         qYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199840; x=1733804640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coSQp1/Gwn4CiglYWsw06eTGbQvY9qYl2cHooFvAJNc=;
        b=EjBR6yB/im9Zv0ksNiZYpNiTKqR/7n+R3vqb9ZsWqpB2enV6ClKpKlZEF33jRjiqVn
         rj0DjzvjplYp995Ogt38rvoIwBue5nUvznLa2GWnL0lcT3clnzGYfj2/nDAWUYwT+iNs
         exE7f0f+ab8P/WZWflyZy3shWC4Tl2oM441P+yHrPeFotSzFCZGau8XBeCmLZ3GQAsc6
         ZRRwaT9TU29ZrdbmQD2Xz7rTZNmDLjpuC46ZHV48p7etBYP5/DP7jjgSa8S/EhHvJFR+
         43cOjRvkwqaeOoLPJIPPDwi8PBNUoGvJ9KdUQAnlS3tix+ERZnFcc3MsMs7WEccIxE3W
         36dA==
X-Gm-Message-State: AOJu0YzzIN2b7PvGKOtb4jAHod3NXJLEVjhsHPaPqtl6qD2YY3qmx/dM
	5UC10eMCrNzwmEDE0KevipOGh6AknYR0gAAy3dO2W6ZyvHo5Uf0A
X-Gm-Gg: ASbGncvQiqUNq2fZIlbQKc/4w3sHqLJwhDC7yNl4LNXqLK/QJq2iMleJXdYgsbomCjF
	9imWR8Op9kZWmHqxwD9Tn+oDrGH3yyN1riLkRPKJPsJkrXdBcdFUsTdxot0W9WEmjzxk6niqu11
	aLu/1hu2GicAn65FbQ9iOR0jPi0O7eWVhnisRGfnCk11E6Py1+aRI52WDH5iG/YUBDlXYMTfyYW
	V9aIBQAV1/HKjnUE+YfHEC1z6qB0r67VTuE97qLRCUq4grH6NNvpDx6d8z0yVAfIMw/tAkj32OO
	2ZbdXnH0N7XOiUrX2n9S
X-Google-Smtp-Source: AGHT+IF6RxUa0Stf6zjRfxDnhlS2Mj/qYlviRNVZl2n1MU/SnbwZwMl5CLEQisCjQqixH+howKWgjQ==
X-Received: by 2002:a17:902:d2c1:b0:215:96bc:b670 with SMTP id d9443c01a7336-215bd1cd9a9mr12149435ad.18.1733199839669;
        Mon, 02 Dec 2024 20:23:59 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f56d5sm85356125ad.56.2024.12.02.20.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:59 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id BEA3BDD3A0D; Tue,  3 Dec 2024 13:23:57 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v3 11/13] um: change machine name for uname output
Date: Tue,  3 Dec 2024 13:23:10 +0900
Message-ID: <7d15f1a804ae18b9622e3fb4828e1c33ac89ffc2.1733199770.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202400_373605_8E1807A2 
X-CRM114-Status: GOOD (  10.54  )
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


