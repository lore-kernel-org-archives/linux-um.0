Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E293E77173
	for <linux-um@archiver.kernel.org>; Sun,  8 Dec 2024 10:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=; b=NpXiRjIpnBvTDXxfnpUjG74wIA
	88tqYI3lvVBSlGFhbWnPuqrhqKsJzdNhxTcWMMROPKI5xKsO6LI/PjQhSxdtgo0DneoX1QBB/39Bu
	6NrM+aQOI97rRD/9yWBDQNVHGmlTxD0fpZtvThz+s0To4tqgP2/zsSg+8nV2G3Ji4M4kAcNoibi0D
	R/gHGDTph7ZOC/MY71qfBLve1OAtCB8qwJoff3MGTlEuhobpNZsWsDMssgLQNOAOMuEhA84l4Ynra
	yDH0e0Tu8oCMDkukUuVIzxtp6x9jB+VbZqzLERJl56JNaCrZ47bThZ8ov1wHJ7uNtkEH/Dd+Nit7D
	lstHNjwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKz-000000057gx-15pI;
	Sun, 08 Dec 2024 10:16:29 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKx-000000057fq-0Wzv
	for linux-um@lists.infradead.org;
	Sun, 08 Dec 2024 10:16:28 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2161eb94cceso11078995ad.2
        for <linux-um@lists.infradead.org>; Sun, 08 Dec 2024 02:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733652986; x=1734257786; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=;
        b=hNVituGV0nAD3dv1+Js5s1q3v7yB6bRe9/UiBb3fRvFwLTwNtKUs1zpRh9nCRo8Yf1
         4J3Hi8t0HaTeY/rno2B+KOFfLHTtPUdmJXsDCkzOsEsbIKsXqJJzMSeM2XEWJd1ZZGVv
         CugED+h2l3gsxdWci5OWPA/IBH10hPAm7YCZxaklmVBgzK9dUJoC+hBi0o3NsedEVAGB
         ZF0/B1ufz1SU+mwnY1XrGz+SiZUhfO1DKXKrvpo5w7PMkwhOPbIm8DRXPVkMpI2pXdlP
         FO+mDHdTos2Eu33yjodjF6d2iMb7i9x0zoae6l9Q4CXzs5vM81OEcYIwfjzLxkOGaXUl
         UHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733652986; x=1734257786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=;
        b=R6iy4MWPRdajLVKQ3H62C7Zk5ec0Vs/7bmrfmTMJdnl1zGQIoj7HVAYTw3lnLEIWGY
         CDU3HporDS6vn16j50SNStMEqAcIXN5wforrFyBdxb+Emmte4ShoOqn7Y06rhTxOZDRO
         VssgiUjO035+fOmsM/htCaRF6/1FZT23QErZH6/4YVOYQr0itZ2l/364l4b6v5CHy9t8
         NbHEHdXHUQEeg3LUPxGfxhw9zuNlGyzfKUHk8cZ4ChLxsZM2zIMHF4lOF26kW2VcHjFD
         FqcooenlBwiK3nHHW8EDzpPIw3NDxrp4ukUvcGAO7GHr2huyBUonbZituJPnBRxMwcsX
         jlDg==
X-Gm-Message-State: AOJu0YyZBjql/2f6+JqddJKLRMNcBp4LUJc/O+dqcc3ZyXBfkI/H20RW
	bTHP/U+ZZihbo77v1b4ZzcLeW8fLeyTdXRJzI5jbL00lyP6uzvTB
X-Gm-Gg: ASbGnctNapOV8rkoMZ5XynXH8Ekzl8hXM6HMAQNru9bvVi68GsKPs8mHOnI/rRzy5Os
	EtWElw9Vuan/f9HhSIK6NMq/0nybwIXkFcXZB3KitHoqRYOEQbUQNHVVOEYNZ5O3mHhW6UPYZMu
	MhGktRuRdLHT9WmR0tn0WI/8EfV7YN0oi7v4UKCI/YH1Lw1WCGgaa8164NSsze4xpbrNQAhq1+O
	gtZlMHQEXJKviD4NZi9HN2GarjCI+035i0WuDTQlXnCA0m2jNw87HO0Xr92PxddF8hQR6qA6+pB
	AVGssqUfcWm00JGLAYDm
X-Google-Smtp-Source: AGHT+IFp4Pu3aESBiddhIN0fowhTv0XbNAH1SZkXzGqAigzkMmb9j9x7RHdBk8z8vTT5uZCnZPAJ8w==
X-Received: by 2002:a17:902:ea0d:b0:215:8847:435b with SMTP id d9443c01a7336-21614d2ec47mr120669645ad.9.1733652986230;
        Sun, 08 Dec 2024 02:16:26 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9fcdsm54451545ad.146.2024.12.08.02.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 02:16:25 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 9AD60DDB034; Sun,  8 Dec 2024 19:16:23 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v4 11/13] um: change machine name for uname output
Date: Sun,  8 Dec 2024 19:15:38 +0900
Message-ID: <4fc3ff4f68165b0ed2a335e600a18035f69fd126.1733652929.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733652929.git.thehajime@gmail.com>
References: <cover.1733652929.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_021627_163324_C4086529 
X-CRM114-Status: UNSURE (   9.48  )
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


