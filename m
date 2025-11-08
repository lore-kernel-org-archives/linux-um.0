Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BD4CCFA18
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9nqBnkNS4GHBgTUiwDcxL24xHY+Q8FfpyTOYW+ItBnc=; b=H73v8WAOnbdFi7sNdR7LnmcfGe
	OKUEVeQCcLbLAyoVI7u1nlGTCTEYWrMef/SMjswWrOphn3W6cXH9SkN8lPla87mSz8be9sKuI66gD
	KFL8FbictwragnSs2q4USyRSO4KXOwp85fdGC+g+66ESrxYq0bjng5cGj3BfdYUF3hhVfZBdRHzux
	G3yDBE0GH6acagXvkMoxK8905de2EhMMisLV70bLeYtKi1tNNr0CdKT7jL6o4QwXr5TgJvmevVEH0
	a7F5gUEsAjxl2FxOiHo1GBX1yUobA7xCLeV0o4iTEJ3dd4rtVBYpZXUI6iZuiw8c+VL7NmIZV11Wj
	otdNLXlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxp-00000002j60-0Lon;
	Sat, 08 Nov 2025 08:06:25 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxk-00000002j2n-0wot
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:06:21 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-7af603c06easo1411408b3a.0
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589179; x=1763193979; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nqBnkNS4GHBgTUiwDcxL24xHY+Q8FfpyTOYW+ItBnc=;
        b=JDSkvIdx7cb8U55Zhec7nUEGRactMgMjGVycfhXfo5kHXQYcPvHYJICE1+gywAlufC
         3oKLTfKWPlAf38AjAYt/4xHXJ+q/8FJi6sSat3JYZK7oXl+lkbpJBPH+Q4NSzij1mIbA
         K3ANiQGOOYq+K3GJcm+ZwZHMlAWxAtMnpNoFkRENDvqXL8FU87O8RWps7HS+O5P0XgjF
         ix4UmMvxE45hfvIkFsUDmqW5uTZguBOk0l7KIpN0G7SVln7dConZfH6NPKZetwQ+akqG
         gtvqnlQpdAEXLJnIREphTyq3+4OVf3hCMFnu8xb74nlR5FJ0wX4aHpKjDagLJPOQ8phy
         kwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589179; x=1763193979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9nqBnkNS4GHBgTUiwDcxL24xHY+Q8FfpyTOYW+ItBnc=;
        b=FMJpZ+wH6tM2qoMbCo9GJWTAJ3xYSuyMxPS+g9QPDXzm3P7taP1lpWFgZTL7asjCIU
         jCvDKeGqmSHSwZP7gKd6kilPVrj6fi/8hx1fWs/qmy5DhgaHHYDADwFB2B8mgTHSncWP
         cSUuJsUd4IsUvUfxb6lNDt0NqCB9TgtaM9pAGGZRN1GAUZAGeQg/7LGo1Rquoq/7LL1l
         3uNa1M9iyROtdsqhWLzrxAqfRYaE3YLF24w4e2xT4QOeHVBE2sJouBIiZxk1+28YUzi6
         tJ14mJUfzPzSva+EnP401N8uVpkhfdLKrNN8e9txWCGGlrKpE7Z2JvE0MHqZL9ksy2Eu
         SWfA==
X-Gm-Message-State: AOJu0YxFwp/Tb5TQYvMa+I0SLmOv+VfBZs+AE9KutX2hGFZsYrjJtswR
	el9V8523lcHcs6M9Oiy01fQtGzwwq1n/b82R8zcW4Cb4ltbanfkm/vaF
X-Gm-Gg: ASbGncvGDrAwO4rQPv3w2sfoDmesKE+QGxRimnB6fQ0fKbkOWwFv0F2Nv55prXjlshL
	7OHDydhwH1eupr5pGUo3RkorG4vZu9i3CvJF03acohbVc5+ZoQ0RSa+ixm5kOU5J39nPnJ9e4QN
	qZsOej/erG00BfbdcL5iMF9Ctn8JkuX4XXm6k/Ms9viC3eWhi2ExMmPCOFxdBwj8AVZnxruZv9g
	0oPAW1EEAY8cGOJtOasvouK37i5Y+VmcWh5JlHq2NQneu16xTPBkTfcOVbex06jXGov6cIBvSyJ
	reo7AtBXeuqOC65KqasBaAwuPGHXnsIsOf1UvgjPk1r0t9Wo6hLUgb3sABTmxTVvzvSloiLW65D
	kiPRQkmBKpxflezv3uLgqbBTkTtYASG6oaDDwI8Reb9mMslF0mnVG0AhF85qdd+t3GEAAS2kaAr
	C/P/9LzgdeoMcypaOzXLh4UwEhAGa5IOU7VfKPxRy1JKYM4MzVGvpD7vBl
X-Google-Smtp-Source: AGHT+IEeLxoMDyJQgdBR8WYJmHiLhZ7pAXN7oI3a/DfOUHZJDQcbCb7YzFoFxJg3hJbK1bLn0MBfQg==
X-Received: by 2002:a05:6a20:a10a:b0:351:e1bc:e8cc with SMTP id adf61e73a8af0-352b5c009d0mr6591481637.5.1762589179593;
        Sat, 08 Nov 2025 00:06:19 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8c880c5sm7230587a12.6.2025.11.08.00.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:18 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 346A711388D9; Sat,  8 Nov 2025 17:06:17 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 10/13] um: change machine name for uname output
Date: Sat,  8 Nov 2025 17:05:45 +0900
Message-ID: <7cfc1ecdcb8fe15edd92d3b1539994e28f3b6d5a.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000620_275065_4E57C23B 
X-CRM114-Status: GOOD (  10.00  )
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
index e3ad71a0d13c..5fb26f5dfcb6 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -64,7 +64,8 @@ void setup_machinename(char *machine_out)
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


