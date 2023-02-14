Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11969C61DA4
	for <linux-um@archiver.kernel.org>; Tue, 14 Feb 2023 23:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vxps8x9SvzyEMju603iZ8PlUS6jIPfmpnDPMzXdI504=; b=tYiG64hBFYJX9p
	Rp6u1oRXmsdktjiRUyU/RZfdEpYUVdLlKsQ1w2iRiSWZGbShhrpn3nj4Wy9E1Mey/WjdmQmcSMpXT
	4VHuo8EagEfiFR7qwoSPhPy/kZ4hc0ncZJIxf4C9QOSF3M3ZvbRcH/d0/XANE145HdLWvIGJAUE8y
	3v66bwtOEIcTRg/N95pH6KEv4T45I3a7jU/W3v9a2uqbeHldqyrmn0s5zPQ2KRd9W8+AxODEr4BEk
	6abrYTv51sV3zGTendtrHZQta7Q7KniCm9/fhCgCIOTzxDaA8ePTgiL8lCWEdf2hl9/ncaR5H4Qlj
	4bkJ0SyBIW6WUsLa9lcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS4rj-003vMX-FY; Tue, 14 Feb 2023 23:37:39 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS4rg-003vKv-T3
	for linux-um@lists.infradead.org; Tue, 14 Feb 2023 23:37:38 +0000
Received: by mail-qt1-x835.google.com with SMTP id ch10so19010575qtb.11
        for <linux-um@lists.infradead.org>; Tue, 14 Feb 2023 15:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKzDlfrozyyNKmplOOldXNknWP8g5vf1yCTgxiwvDXc=;
        b=EDV22Jf5F+lsc8lEeB+jwU3RqahR19ik4p9FeJLUKcQuBrjP1TBo+eutajs0dhnoIU
         eaSimbgZ31+XYvd/oETTATX5DLeYhrJSd9tKCeSktr5NM9nHYCr1nfUjkHlf6T/a0CIU
         s076fFLIlHpvh9eH6YIEfgbo4v3om0yr8srCCiHMGu5Crzbf3JU//9nsSRpUB9JnC8uu
         LHHATJSZYWaGLwpEusV7d4yD2GBPPnKanp5Hyrr7UfV7vmaSujTLldsGz9IdsXf7GW6O
         lyIezE7pBUxR5eKxs80MHglsXRAuDpY4d+8SN5EVfQaJ8S/q/xLsGNHWaScmIZsoTRs/
         hlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKzDlfrozyyNKmplOOldXNknWP8g5vf1yCTgxiwvDXc=;
        b=MjmSEt0BEZTKBnysMOm5J0zXpk8t+XIN0aJq/dkm7oD06Z7lXylsVrPoA4vzA/2oCZ
         gKrqNE/RSVY/Ucc3msYf2dzaNCueDk+2hhbYAdYEWIVOSxxRN9mDCJbkgjTxVn99/jUu
         WQjdYOGn549hNGfRRX2lU+iacC/r/ckQsI9A23sBC0m1kxvyjzJRPG5tTchSFvKhhj0n
         iGrWsBP4cJOl38C/SqbFOI/99HacuLCO/L51bTPdV9CdvsN62zvbCn4wZRuhCJpaw2XH
         JqR1vVAqL2JoWoDRQuGVlCbruwf2cwB0LStSw/gO/k99ydM+qXqaiibSvqS5QGUOH0dh
         MRoA==
X-Gm-Message-State: AO0yUKXsEeCItIOQKEGNNSCiLw3Qug9PVzvpKwr5H4Te33coC9Yg/a/V
	oP20hVzjNljFHWysriIALcxmbQ==
X-Google-Smtp-Source: AK7set8C1ys/1LHOl0+CHehOfbRVMTuBbG88DAiJ1MfCGeAQ2Snc8UIWv/hIhnaJ1+B7VBalbvZ4cw==
X-Received: by 2002:ac8:5cd0:0:b0:3b6:2c20:478c with SMTP id s16-20020ac85cd0000000b003b62c20478cmr298226qta.1.1676417855935;
        Tue, 14 Feb 2023 15:37:35 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id d7-20020a05622a15c700b003b7e8c04d2esm12310262qty.64.2023.02.14.15.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:37:35 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: Glenn Washburn <development@efficientek.com>,
	linux-um <linux-um@lists.infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: [PATCH 2/2] scripts/gdb: Support getting current task struct in UML
Date: Tue, 14 Feb 2023 17:35:40 -0600
Message-Id: <8c3db2291f583200a9036e83134ba363db492222.1676416728.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676416728.git.development@efficientek.com>
References: <cover.1676416728.git.development@efficientek.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_153736_958210_FEA7A9E7 
X-CRM114-Status: GOOD (  12.02  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

A running x86 UML kernel reports with architecture "i386:x86-64" as
it is a sub-architecture. However, a difference with bare-metal x86
kernels is in how it manages tasks and the current task struct. To
identify that the inferior is a UML kernel and not bare-metal, the
symbol "uml_kmalloc" is checked for. If it exists, then do the UML
specific way of getting the current task struct.

Signed-off-by: Glenn Washburn <development@efficientek.com>
---
 scripts/gdb/linux/cpus.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 289f0bf4d2a1..90908653f6c7 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -163,8 +163,12 @@ def get_current_task(cpu):
     task_ptr_type = task_type.get_type().pointer()
 
     if utils.is_target_arch("x86"):
-        var_ptr = gdb.parse_and_eval("&current_task")
-        return per_cpu(var_ptr, cpu).dereference()
+        if gdb.lookup_global_symbol("uml_kmalloc"):
+            var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
+            return var_ptr.dereference()
+        else:
+            var_ptr = gdb.parse_and_eval("&current_task")
+            return per_cpu(var_ptr, cpu).dereference()
     elif utils.is_target_arch("aarch64"):
         current_task_addr = gdb.parse_and_eval("$SP_EL0")
         if((current_task_addr >> 63) != 0):
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
