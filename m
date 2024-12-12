Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571CAE77189
	for <linux-um@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=; b=3PfvocCxa+x0adwS9ofuxjObzB
	JssGEO/FazkPXp1vvabZPZMs0Ys+9B5t5wFcK97YbjabHxqXfQt0r9TjfFNfdiJFNRFn6RInq7xO9
	vt0lIQHpO9DudSAT4v4SSwoeeLT4TlQOdwDJcc9mB4MvyGTgFHcIqrWq3zo6xJAWDwyyQnEprNnEv
	vs0bDhhewAuAjRUBDThB4BCeYuoQlF5zqIo7XPYsg/BNT4+kHU+KU/mpgdIhOUuGB7dwWNI3gTdwt
	vzTH+r1bhMWknmlD4KiMD+8FJCxYIA1agRn5pPgzYURvFvbPaJg3m8UbhodzEIAAZ7/aqKcFASu1x
	qacbaVdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDh-000000001VA-0HLO;
	Thu, 12 Dec 2024 10:14:57 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDR-000000001Mj-3fmx
	for linux-um@lists.infradead.org;
	Thu, 12 Dec 2024 10:14:43 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-725ee27e905so539887b3a.2
        for <linux-um@lists.infradead.org>; Thu, 12 Dec 2024 02:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998481; x=1734603281; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=;
        b=Wtkz/SNv8HthhLq3bBy5gM1GvCZbqpOPAMBgvxBqtZcsYtwMru+Uw6qhhTYHStnESG
         EpArpxi+uFD4i2KNSkry2LxzhXI8BCv81kxLbRcs3CBwJs62kNDHijYb7PwNzeAXoq5h
         7C4c+KSZ+wFSiXhqeonc8MRWnUNu4kJcDaSo01aLnwSCWXSnBB4mSWz+nvE3GI2icioQ
         emH7CWO8ed2mZB3/HMZyOVk0uzyjB0IlunDiM0/Xei4LtubRurYO1IjALtJC++B+sSwP
         8pGnf55UkLmVlOgfSfDliRGWn9f1rFMcOw9CF2DU0SWMx4PEQ12nY93bNWx6zqxs1DBG
         Cx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998481; x=1734603281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=;
        b=R5hq6XFWYXsD5N2ozN2bwrWrAEwMb+O+Ok+DYxDP5dsxc5dJy0V+mCoygdS9w21o6/
         pQDmnONzQSEYJFP4vyqnyZ2TaFHYtzgEw4uhvmSSGpex+rkHw4gHyvcIiMmmG5KWkirZ
         SC5PX2uvwzgDBlthhAciX/+seGjUpDv21liyHe2erb0CpIgvoJv+ufBo/l0or+zD4Pdw
         c/KnMmvJLas5BxfeEeyzswzynCtWQHixWzBuy+nTTGoBIt7jlOLq5TkMSOoisPiaIjtW
         QxjohLIRYCkDH6uykQkjfjqsnMHdAHZddfmce0y1hfzc/UO9e4PiD+OEdUptbu5kdNic
         LyTA==
X-Gm-Message-State: AOJu0Yz72144yf5iZzEVB70sIzubPThIP/4BL5qeGoE+7+bGZcBoOGyB
	iM91k8lNYdQYwmbKTH0HZQGsJpHaLPAgDbIbgdzWnmDMcDv+4eak
X-Gm-Gg: ASbGnctui4tTamoOtqrpHs7Voh8dCQDQe+I/XNfLgQ3q9CdS7brjDyhnmyVjt1GXOcX
	pw2DOPNQWt9n1hba34Jw2JnulM6SyL1C3/LNyp0zWEqYY/HqsqEo4PtkfSo1n+fCOEjSJFInnSh
	doxQMPkhZlMJZBNv9sSuIuV6h/7haSt7nJyeGNwk3L/9+p/iPPPKc/mecaX+4JbHLuPzG3UnUsQ
	dNr+AcWKMYvPrilrI4kJRiDGEWtSNEprcAXMfTc12pDSpfWnGGeA6JEuOpnSLWbzEhRoch2crTl
	aG5u9hQ2d9eIQpOR4UiAzL+z7Zo=
X-Google-Smtp-Source: AGHT+IEYSwyluv8k5ar9h8NWNArouPS/vUwVCyiBE3dnQE7eACRaC2aFOp0/frQ/s9kLDhbMnColDQ==
X-Received: by 2002:a05:6a21:3395:b0:1e1:a885:3e21 with SMTP id adf61e73a8af0-1e1cea7eb8bmr4984672637.7.1733998481291;
        Thu, 12 Dec 2024 02:14:41 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d3dd4cbasm9257195b3a.142.2024.12.12.02.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:14:40 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 5C027DDEED2; Thu, 12 Dec 2024 19:14:39 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v5 11/13] um: change machine name for uname output
Date: Thu, 12 Dec 2024 19:12:18 +0900
Message-ID: <d0071be6e3c694b765ce23df90de0114ed8111ba.1733998168.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733998168.git.thehajime@gmail.com>
References: <cover.1733998168.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_021441_927618_A08258F3 
X-CRM114-Status: UNSURE (   9.74  )
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


