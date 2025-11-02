Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC417CCF9E3
	for <linux-um@archiver.kernel.org>; Sun,  2 Nov 2025 09:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9nqBnkNS4GHBgTUiwDcxL24xHY+Q8FfpyTOYW+ItBnc=; b=AG/a9ERZU4dt4MiiGDO69H+qA5
	bV1Euly8vz2qCTMSjndK9eVkjZZ2dhmA4aqExllMnOnpoYwH5goj9JydIabT6KTKzX/YtidpmfPn9
	YG2xwC0vRCIQAn5CxkDGsDL82r/bFgQFZZKptZsr7t8s2Xv12ImgzVj7rnodGe/0zcTG2BJsukHqc
	Z0T4uBOM//wAf/zwcHaEmALTcTjvqXHRSjaFn530d7obM6VojXGsNF6FCSI/AA9MTADokz1garw70
	YTTyrk470BJnkxdTVTxKUdwEreEyJf2i6gkN4aWb9hT/200TbFf6ZZcBm2VDcKJaRSZUbAXgdg7FV
	q4akrs5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUis-00000008Ryt-2dkG;
	Sun, 02 Nov 2025 09:50:06 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUip-00000008Rvd-3TGv
	for linux-um@lists.infradead.org;
	Sun, 02 Nov 2025 09:50:05 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-340c1c05feeso774247a91.1
        for <linux-um@lists.infradead.org>; Sun, 02 Nov 2025 01:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762077003; x=1762681803; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nqBnkNS4GHBgTUiwDcxL24xHY+Q8FfpyTOYW+ItBnc=;
        b=nkV+hWpZIJ0UmThds3tq8rif0XpNB3nqBYd1JGUtXnGcSeGdQQZJBcMrINF/ZR3cwh
         T0JX1Ikxqs1qan6b0tRra5GwmwrDGLXGhpxUCBjDZKdZfyKd+kq7Ebv14gE+nwabkHR0
         SYK4OTkuDg0sSm56Zu5nqwXxJiA+Pw9MX+sXypJKsWA27wpvImA5A4SGbCiZQeREf8s5
         dghsGHEQjT4djuryErqWDpW2fFhD4CcpEeeJ5IVYOU9peG8B0febc/AwZstn5+iwxGAd
         uPQcp17PsQ5aUPjMkyH2MzinxTEntaIPZZRM0yDVHoS/GBPIZGZcd5Y9qPfXAuzCSEAA
         aBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762077003; x=1762681803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nqBnkNS4GHBgTUiwDcxL24xHY+Q8FfpyTOYW+ItBnc=;
        b=slAmhNW3soivDA6O7j/VQBWB0IURUudB2mAA31Y7H0Weu6m9gdrMJ1Y7ko71YABUax
         nLuXSyUqa43ns+C5yFhS7kMyLpg15wI3bKHk1McZxmGmc5LhEp5AaKS7oJetEg3/YHQt
         RNMOWYYCQ/ZruMeVIwf0cp1/Dw6AtEGkoMDzrTFsYSgbSKSwgjyeNqN6Shk/HX8mOAEe
         tNvkkQx1GgNMAf+sVB4VJmLvrZZ6XmZw8ebfZB7vvK/l1eFk8u7BIChrDkd9Vnu2UhTC
         GtnQV3UrINo4+LQ47Oe8yRN+yKsKdsk02MA9kcK97oDsVEuwU7Zl/mdPO2H0TQlg3O/n
         K8DA==
X-Gm-Message-State: AOJu0YwlBhOwF+g59Nt6w6uzGmMff+kSzaoUEjsX9/gKX+w37Gv7l3td
	hWBWbyxnhOjWS7W+GbEUd2c5n89Q6z87C2q9MEkHWeT6yQW6J6r2z2uWZ+yGIg==
X-Gm-Gg: ASbGncu3xF/JGxMYBbH5sH+vLvCKi/LIGxrJl7UaCYyOCswauUhnCze6kyN0oJKz9PG
	R2lkUoVbudRaiwjZIuGBzKKlNAykQDrr72KX9qORfk3Pn4A3+iTQpWuNG2dx54fypyri4O/JULI
	McqFk/wb7kbL0DV++r2In9de0zoDsu24EClufTfLzPwKZRqwaShpoI5mBlIp3mvpUkGj8KTUTUs
	5Jzb6Wtpa1JKB9izmFwd8vTyYvWufbov/dFwv2hNHL/6jiyVw6ZXtPKTItuvpYKBskxQ7vDovE4
	aTV4c2D8SXLlYl97P10t5GA7f5Vn6EOXy4EV94wIsQiBKydw3grE8b6OwkUqeCsGfgA5LQskQio
	fhA3ag06M/eRmIhCMpFHEyBn60e73UxgBSnGzjInhRSe4pbFnqfAsIo3slHC0X9rCxmr2aTUFua
	2PUUeQkFAJUXVmy/+chN76zbbqVSXkHQAdSA3D3cSwcnJ0WA==
X-Google-Smtp-Source: AGHT+IHuXrm2fcu4utkxWrFy+W8BUf2g500DhuJfUTiIskvkxoz07jb3DhqnxeSGx4/0+emeuA/vkQ==
X-Received: by 2002:a17:90b:3e44:b0:341:194:5e7a with SMTP id 98e67ed59e1d1-3410194623fmr1787362a91.29.1762077002893;
        Sun, 02 Nov 2025 01:50:02 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340999f9943sm6854469a91.1.2025.11.02.01.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:50:00 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 971AB1123811; Sun,  2 Nov 2025 18:49:56 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 10/13] um: change machine name for uname output
Date: Sun,  2 Nov 2025 18:49:35 +0900
Message-ID: <e37819e93cf5a593fa1b16444b3c7aa6b7885301.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_015003_905746_5294F0EE 
X-CRM114-Status: GOOD (  10.25  )
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


