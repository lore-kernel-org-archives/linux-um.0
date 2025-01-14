Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE20C0218C
	for <linux-um@archiver.kernel.org>; Tue, 14 Jan 2025 11:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=; b=wUtj6z2n3rthdRo25gV0aK9/dM
	MDiQrc0nX0oadsig5Q8ciwq9//FwvKzi2HtCZBgXzMDtDCMt32DQgnKiKnHHy6LdBYM0xWJsNjknh
	+Gt9yDVz/Z2KNUwyFpNkf50KHGiAb488/zihvZXcwc/3cmVY/s5KCxL7bEtA9CCVXEiW7oaWxxudz
	JALYM43dgBqc5tjVjCEMqgo+b1uz1A7C2XuwKU3stykhOwFEXsNiwlKOCOum4Q0MHtFjIb1p1yK0e
	GyEUPnzCvv5aZFUeiHvkFbbpZVWRoCqIY01SFBTjnaHL86ADAyVzv4z0fdx8tZ97Aul6UMV3hrevU
	9hWg1WuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf9d-00000008GO9-3VtM;
	Tue, 14 Jan 2025 11:32:17 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf8k-00000008G8m-3uVv
	for linux-um@lists.infradead.org;
	Tue, 14 Jan 2025 11:31:24 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2164b662090so90305325ad.1
        for <linux-um@lists.infradead.org>; Tue, 14 Jan 2025 03:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854282; x=1737459082; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=;
        b=frJ89O6NYKbhonYWqIMGmaC0Y+M7DLJnAOGzj++Ns5CfpqTpuV3VDcm/kxAegJUilK
         BBCDIMn4KNsOLup6Co2s3KoZYWbnaFROfXJ1OoASEjnQzgAHFYtNzQayYgSLCAxjrEbT
         q3DEskc16ntwdF2Pgbp5Vjf8x+rj9lqiMIM69xmZTS438TlvBP/UCGBLXmIgV+Y1CGMw
         sQ4rdgN5tNJuztfEpZNUQNjWVDjW13v8YuLkf98wNqDqxMXuJb2EcZ8XxcONo3m7jyhR
         /oUxWKDRcfdzIIBNhWACMWs3wj+SDO9GmmaiMV10QimboCnDb/cwy7o9oIue1YMpYy0x
         VXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854282; x=1737459082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=;
        b=Mh8nLuFCD5kB8SsKLSm/MyudD2eq/RRwnDNx3vPL4+bQab0ETensPl4MHWXRc1vuOH
         cBOLbyIyvW/gmAWkQy+bq3nKYJnx0j20ALtoGwQ2PRAdmBnqnziIBUDDIv3toBQFNuvv
         PIpZJ6qa9Sgy5ov19TFpNDwBzVoC+9V9ZCl6IMo4y+EpbeUuDEBjzcJc6KFnVENfqZOY
         Xhxwy5JuMaNbkTFXFcNEMc7yw3cI1rUjXaSMANZXsSFql8/y3m14pth+F4Yg1VYKiqfs
         w+izk+RcL5tJuyf/UR2RX3kWuSyGubJRsn+IFFx87wwLf9Zf0Ql2cy/9+raZ51l6oeAk
         xu2g==
X-Gm-Message-State: AOJu0YxXq14lajz+FRbAdmmOW+TV1/17qbefeCRfukRfMvG5k1n96tQn
	J9jQUYbemRHEw8sVMDKjFNHbpSq1udL2ezJ1S77XDuTipDjbMBFl
X-Gm-Gg: ASbGncuVdxDzauSlncLSpy1evGF9eNf0LcU+7QMMvaZjLsNZlShIAMys/fsiV0B0fq3
	Ee8mVF8H60676TRVYijP16owoXyV9UtQEc5hcSkKYPfs/v8Rf1vFDY+EhBcGq8jmXJnDZOfc51l
	6XBKx4BmibRUcZb5vxQZXgDYF4wZ//mz8xN/LwGPvPnx5z1gFpxKX3gUBSFoZ08qxgrgVbXmi4z
	qHCONsMyJKm884FkOewptpNvL/jIjXWNoT4Pa3vbYD7zrSlnQTIASjOTvjIglZ3neFC07nwys/2
	qm8NZwdkX1T57yFh5kIB1ox4Uqun
X-Google-Smtp-Source: AGHT+IF4sghfuSypEhDYsCQzj9O1GU7BjIJN3KpUR01jKk9T6J1Uqt/9o4hA4UJxWGMNmJwJT4rnmg==
X-Received: by 2002:a17:903:1251:b0:215:9894:5670 with SMTP id d9443c01a7336-21a83f591cemr352831755ad.16.1736854281900;
        Tue, 14 Jan 2025 03:31:21 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12a757sm66288755ad.58.2025.01.14.03.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:31:21 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id E9CE5E1AB62; Tue, 14 Jan 2025 20:31:18 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v6 11/13] um: change machine name for uname output
Date: Tue, 14 Jan 2025 20:30:49 +0900
Message-ID: <5637f0542e7424de062b27fa49c1a925a90075d8.1736853926.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736853925.git.thehajime@gmail.com>
References: <cover.1736853925.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_033122_968423_C2A4FA42 
X-CRM114-Status: GOOD (  10.48  )
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


