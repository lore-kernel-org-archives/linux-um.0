Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C24CAC5A8
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 07:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=; b=1gL2xUP56SBtnR8xk5pqQfSEns
	mFtNXTGPqLN0M3Vt5yNcJYxUrH0sRw81QCLj3p65YXwkSeksGxxtu/pxePQpFmPqO/H/4bpZzC4X5
	b1YJ6qcrgJmIKUHNUHvZQKFzy5ouVUL27W/jKvNG1J8tVpqKrffYNFK/8sFYlYgzyR9XXDXo393sb
	CXj4JGU1f9qDit6DBE7+LHLESlYvra/KB2so2LbopQJrAQ5XrtDa+cDp5q/8puYGzfUI/EvHytUbt
	vNsa8tADQj7VmqUVCK/Gimw8uFE10HbKoEXEi2Acbj5LSWOU3oPXAxH2jvHwaWn8wZQ8NF52VlNt9
	dtqyGRSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Et-0000000GZIo-3Rqn;
	Thu, 18 Sep 2025 07:39:35 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Er-0000000GZFf-2aq0
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 07:39:34 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-77d64726e47so238280b3a.3
        for <linux-um@lists.infradead.org>; Thu, 18 Sep 2025 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181173; x=1758785973; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=;
        b=Ge5lemN8P1nDwns2ewnyxlM6e8SJ60f8UnnWOT7gLIY8+kmk8/4wp7/qQFobYLuntE
         gl2a715Hxwk30527+HqGNnTDJDc3tDkSsOqhVrkvPp+hWIHguFSYdOrtOeJmE3hM0lBk
         mRjLC1ETLbKJH1sLrK0DqtIBBXGHii/TWSlV/f+vO+hfXKHRIS5ggaWlonaOjcGReHG+
         2J7rG/6bkRWg+1IPuyKa2bkeaR/QHP5ycTP15RJun6UWO78DvaNQosgzg5NGGG7yLtbh
         oytH1U8mbmGsewuuUXTiCHgKbRf0y54Ui7UrtyaHnWzt7/KYz5DZRIX1HVJ/Apqyf5AR
         f2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181173; x=1758785973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=;
        b=GZl47VKQd1xHwTVaH67h7UgDVaOtTqH3e0m/KdJG4SZLS9yl+Mdx8TLPDdVnd44/yY
         MOVHJhs4e3T7oTJmLBoNtinzohRJLK5n3H9jtmHxZfEnfZsx4ZCKbnTcB0j9T428/iz8
         xPGBdrl8uIReu3h8ggbcoK+gnSxXgbZlSX/baLeh3KdGJST65RXqZF10yDqgvkRTY/V+
         tWoIMEdvFy3JK+Mv+i/8yJO9roWLCjXTPfLITZXoEy9W3o2shb8O/sZk9nsT84C3f9qo
         W3bZloaJbdK6A39GZ7HTGKi3PspTgD3UPVz1FeC8M0qr+Ra3pm/TajLUXexjkCtzobNS
         25cQ==
X-Gm-Message-State: AOJu0Yz9HgeikPz6JpX/Xgo9/R4K/HuDBjzFBGkTDuuOteA5Xdo57bPM
	SpLhSagNhh5415NEmu0qbVE1+E3uBMcMEtLj8S4OQm2kr6DFQmS7ETXN
X-Gm-Gg: ASbGncvGfTl71vyuDdRLMHE8SUJ/eVMtOx7NRVICQCd+GzyB0XighI2VnJVuGvSW0Ip
	pekXkXvu0zoLyj/rWcyuAQm7TeAlsSUiGkfdIs+GqhDS3IU+Uq1b12df9+46J2auPJsic+qubwD
	kltivA422gUTW9A1mxeOsYzGB+hRVPxdM2qZbpk0Ys5/162yDrMJpVgGTdNmRy3OE6lCuFs3E50
	1kmfQez2THHs5ra6g+cnpbfL7BxWbV020HUi7nnM0PizBcYHbx5k1gO8f+7Jp9VlqgCQqY8FWkP
	iT1DhZFVqW0IC2rbqH0VmLrL1b8vYAWKAWl1sU8EdQUr9KE+DRizMrRCf5o5UlJ0xIOF2ufC7Ww
	2w9wCLV3vnc/jd+FjOHqlscdyWrKDS/aR+/TsSWpGN6fjZg6OYFRPJiAn3QmD1a9s2Fun0iZxAz
	FaMiKRX29iKGQ=
X-Google-Smtp-Source: AGHT+IGoXWN5DJ8xIXCgwHsBi/4NPgC0UAZOi82Bbm/JRF9tQ/p87F/MCcBLJSl0bwTlX6e3XqHsuw==
X-Received: by 2002:a05:6a00:188b:b0:771:fbc3:f151 with SMTP id d2e1a72fcca58-77bf8e72b17mr6667074b3a.15.1758181172767;
        Thu, 18 Sep 2025 00:39:32 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb79c23sm1476897b3a.1.2025.09.18.00.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:32 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 328491062110; Thu, 18 Sep 2025 16:39:30 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 11/13] um: change machine name for uname output
Date: Thu, 18 Sep 2025 16:39:06 +0900
Message-ID: <4e20b02e2b44b1db9a6f80e59e6b0c00ab08d5f8.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_003933_662005_024CAA73 
X-CRM114-Status: GOOD (  10.57  )
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
index 5371c9a1b11e..9bc8fc149514 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -153,6 +153,12 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
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


