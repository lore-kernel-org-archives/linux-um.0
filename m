Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324C9C3ABAF
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 04:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=; b=bd1tK859bdFoJD5hbGn48JKK44
	nyMug9ytWExbUivPq5+FSA955bLHjpyLLTS8OLQJOJp1gri5hJ8HD7plo7mUUO0kBQ2d+r+YMOCgv
	E1Hj/fQnqwtgA6OUJTCnDDqcerkIEjtnZxScNyLnJJsj873/MZf/kYHb/T1ERsZBFjSqHU7syxQe/
	KljH+ox/pVROv3DLCrfSqB+sJiE4qvaBSsDkiQVXLGRxC6HXJ/1eXd9lU649CtmW16HmtWVC+MYRn
	HMUU667dAj+PARByWRFmFWLXWRrsJLPm7sKjPeBC+kxDsvATbCOzULoO+/p+ktJdgxLMfPa9D2uQI
	klNBpmvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z4C-0000000BfiO-3UKd;
	Wed, 30 Apr 2025 04:29:04 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z3D-0000000BfUL-2UA1
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 04:28:04 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2255003f4c6so76263155ad.0
        for <linux-um@lists.infradead.org>; Tue, 29 Apr 2025 21:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745987283; x=1746592083; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=;
        b=G3XO04C7Jj8OH2yU5AK/zVv38XCsp+Oq7zMXNpmBoGSJ+LPKAHqL9sb9k9ctq+gmSF
         bE8efSL/ovbno7Cr9AHRq/JVWux4H8YTMLWjnEpwtWsbgZhyPXNP/jUNvq81SafIJBpg
         VGr5aZh7UpbqiT/pPB1XSmaHR/Nzc7UCsFTw8rQ7QBmCQInpVpMtY2+6OpBoEVFQSAbm
         L9PgZ2fxCmS7okBKc3Cayc1Bppo936YgJte2nrienED0aOeusouKmw25Rpsxr+hilm2B
         DMX60+WL224PTZ5DTltbmp4Sv0cuT8dyArL6LbSks9DTuC/2F8HjCxZxUxbwECYkzxyJ
         Zf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745987283; x=1746592083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/ZhA8POgOa1pDP88Eiedzl7Qg41tN4Rus19EAaNMog=;
        b=SRcsvmt975zhWizkDi+8opFGRyq6sN6TyARegG74urfFLXmYk2uyPB+AIEUbB203CR
         qHAiLaF4nM6+NCcUQAC8AxN/AnPfznCzXoHeV1wTRP0JaV3DIm77toV69+GQrGvv5DkB
         PeO0miOLPlSlcSy5Nr9yG7mRoygFM+4V7dcRDrzKfDhUFOtpZNr8xv022liLogTJF5mr
         uBxn0aVAhnCf3pguU/bzRiiC0KTjikO08QtTVIn64/BYkWcsDhpJKZvdN6DgqwNmrxwt
         bypIDHCqIl01C8mB6JDQwMHKTRSZ/ETl3QPFOn5P9r8KM5nc4XWJt4G2p2/4vixsDnca
         9Qnw==
X-Gm-Message-State: AOJu0Yz4UA/xXCxsP9pmdIzMYijh+HeBMc1JzNH/VoIWSlZ1cXAa5EYq
	KSLeaaDd3MPbW0G2EY4q30IZSRElBP5i8IJJ9bVErla5mJCVnx+V
X-Gm-Gg: ASbGncsfv7zSqvNM10Av/Gr8LMSd4vYigSiNKAND3+E9WgQy1ze/SJQJL7Pb8w+TXCV
	NoD01OycHLNX/9eIqDWeXalIcR3LaJ1N/4Gdd01NgRu/C27Iv/E9IgsX3o5GaLVchWHPY0Yo0HX
	n9XP3kfjzUsG+XkujTcqiStCsmqFqBwIP7cvI1Sv6RPW++/tdOQToTNxDNAA7VJCXsbA4mzx9mV
	xkNwGZagNIvDjwvoGiIGUkAnPToQlvcsX6T8A8P9yEdSaepS8BqC+wswQJ7caohS29gG3pDstbx
	LJfKYOqdyne5lD/iCySQ8gNoSsVDaGE/2fPKI7NgEsMb0SecmFwpQ+h2dAJyd4lYtln8uQ5E/c+
	N9djVOgRqREAtqnTK+9tjhA==
X-Google-Smtp-Source: AGHT+IHLnJV1jRxDa8YUV/nZ0brQ2Gx6YopooEOeWXq2tdOwSnZ7t3052ntTYHbm7mId/W8e0+yiSA==
X-Received: by 2002:a17:902:d58b:b0:224:26fd:82e5 with SMTP id d9443c01a7336-22df35caa68mr29021325ad.48.1745987282966;
        Tue, 29 Apr 2025 21:28:02 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db51062casm111526675ad.208.2025.04.29.21.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 21:28:02 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 33EA2E94826; Wed, 30 Apr 2025 13:28:00 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/12] um: change machine name for uname output
Date: Wed, 30 Apr 2025 13:27:16 +0900
Message-ID: <64d60cf0ac06f49a4ff7f79df4c60e364d11464f.1745980082.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745980082.git.thehajime@gmail.com>
References: <cover.1745980082.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_212803_629204_3DA40CD7 
X-CRM114-Status: GOOD (  10.56  )
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


