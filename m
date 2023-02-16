Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2736C636D7
	for <linux-um@archiver.kernel.org>; Thu, 16 Feb 2023 07:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9X5mUcjg8+EqVl1LZ3wiIcGDm6IjpNg13z/jzNwOlnQ=; b=jwrxbSdwIuwqfe
	uvOxUC+dtDlQU0APyhjIqCSMzSWDHy8unQ0lvRDhP+qi4yzcb7aZHs/Emc5O+g82g88Eo7jOBgCy+
	ScISo0StT+0RZhxyqDkKF4NMkCULh9HpA2+rojHRXRCnvfYTfFmrpBYbtIaj8OkwF6Lw/LZLRP5Jw
	tNKQ6QxzZHYTos+Hmrum/QvdXZldxPzzHG1OkD8apmUsJOJYfDNOdJwMpE0BTvdxiLtGmz3RdJz66
	f4eSYnpzb8wSWTjcY5pqz3DNwqQ1diB9BBRdjMq7rWf5QDXbp4Tpj7x7XG4qF9pY0a8HWtG84KgBn
	ql5VPWVIQPEu5NRh9AHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSYq6-008pgv-7q; Thu, 16 Feb 2023 07:37:58 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSYq3-008pfg-5F
	for linux-um@lists.infradead.org; Thu, 16 Feb 2023 07:37:56 +0000
Received: by mail-qt1-x829.google.com with SMTP id v17so1299722qto.3
        for <linux-um@lists.infradead.org>; Wed, 15 Feb 2023 23:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fbr6RfPuo0Q7uxzg3+WfaYkNZTVCpurDl/nkrPS1wcA=;
        b=lV2NAp4OyqjRcO+umGjs8mFNnwdEWCjMTJrK3w3acJtVsUtQizif3syWERG8dkw6Dl
         aMyW8Y+74sGboMDotOaOW0VIfMtYNkprstQlu4mG3IqB9tk0nxUjGCovmrOmmPYQpZyX
         yM9uqny6ujwPTuTJVrkqqmOC8uLkwPdJmJ1yBcdhKKp+7bVK7xMS380LsfBNszmH+oW+
         GrI7ISHrDUhHHOo42809QHAJue28gbM1HSE3yq0DtEmEFM52gR2aXAot84o92kzJzDCl
         cPbpWY7EC0w0woWcRKDkVhOD8o0dw/zC/0oW8g+AAEYGkb83eSSJ5VGYS3doVB/sbwyw
         xlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fbr6RfPuo0Q7uxzg3+WfaYkNZTVCpurDl/nkrPS1wcA=;
        b=csxokidpQBhqtFYLIJQ+MxTMo16OmywlTDnuDh5rVP+7f3s331jiPFz2Np/g5VWv8T
         bDNVSAXKy9ZF5Z2uG4FluLpVt+Lmns0Nh/9b5hD+zaErgEaQzFfdnBtgq94Qakvbi23T
         p1XpZD64ss0gb2AGMczVR701KX+tJ1zjaisTALaoPfHFs+Mf1yXNlRtj3fh2TkR6czrc
         qnt8FksikJlm+OTZbXI2m2b0YgqiAgoqQ1ZUnWkc1zCOjmm5zwc6oxwbhZZa6BKsBwcu
         rF5marsWRV8s6Z27pEWlEcpgNyla9OTWnqS8BWl/qCnX/OSXVA1QzBjf3dU/E49blZKr
         lKPg==
X-Gm-Message-State: AO0yUKVYv0yP/yy0a4dvj3vb4hRvozJ/jKgPrHO/FHqEKftQwlYJRk7/
	HBzJhktEHIc7L9OSeuc2nLylaQ==
X-Google-Smtp-Source: AK7set9N2O9PLChNC59GsxVCN4yqLA0VEk0bs9Bi+DlgvCj6EzA/61L1ffkO7rzLTr/ofPGkgLbzYw==
X-Received: by 2002:ac8:5c44:0:b0:3b6:8b52:1359 with SMTP id j4-20020ac85c44000000b003b68b521359mr1456100qtj.0.1676533073693;
        Wed, 15 Feb 2023 23:37:53 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id m1-20020ac85b01000000b003b9b4028d63sm756718qtw.80.2023.02.15.23.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 23:37:52 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: Glenn Washburn <development@efficientek.com>,
	linux-um <linux-um@lists.infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: [PATCH v2 2/2] scripts/gdb: Support getting current task struct in UML
Date: Thu, 16 Feb 2023 01:37:19 -0600
Message-Id: <683d10e752cd4852ac62ef3cc3e9a6972a017bdf.1676532759.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676532759.git.development@efficientek.com>
References: <cover.1676532759.git.development@efficientek.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_233755_223150_A4BC94D7 
X-CRM114-Status: GOOD (  11.86  )
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
identify that the inferior is a UML kernel and not bare-metal, check
for the existence of the UML specific symbol "cpu_tasks" which
contains the current task struct.

Signed-off-by: Glenn Washburn <development@efficientek.com>
---
 scripts/gdb/linux/cpus.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 3e02a1866751..4b4ce6464dee 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -163,8 +163,14 @@ def get_current_task(cpu):
     task_ptr_type = task_type.get_type().pointer()
 
     if utils.is_target_arch("x86"):
-        var_ptr = gdb.parse_and_eval("&current_task")
-        return per_cpu(var_ptr, cpu).dereference()
+        if gdb.lookup_global_symbol("cpu_tasks"):
+            # This is a UML kernel, which stores the current task
+            # differently than other x86 sub architectures
+            var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
+            return var_ptr.dereference()
+        else:
+            var_ptr = gdb.parse_and_eval("&current_task")
+            return per_cpu(var_ptr, cpu).dereference()
     elif utils.is_target_arch("aarch64"):
         current_task_addr = gdb.parse_and_eval("$SP_EL0")
         if (current_task_addr >> 63) != 0:
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
