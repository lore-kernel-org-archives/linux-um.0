Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616DEC64ED6
	for <linux-um@archiver.kernel.org>; Mon, 27 Feb 2023 04:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OzaY2qwooARQJUjXY5f4362P23JMw+u8Nskwj39dIfI=; b=ERslIbNjgjAqQU
	qMccfIgU0573rIzTn1jMen/ipn2EQwb4QDeqPpn0Z0C4UzSSnduVjVZEG1vngPQUQEviTOBEpZRXe
	6MaE89yJBwAObu0MB3LOFfN6Kt9jjUHAO3iyfWbAWrwMr8kR/znyugVI3cyZSboLhQ69pOMe0LnjT
	DKSBC6El/EN9PLln45yHJE5qhtWuM15REX2f9mqMwWu2RA3IGIbLcQvTstGdtU/BKfXsayrI2tOEb
	mPNMon6KXmTzIkjYq/BdPufnGQaN/X7Mk6e3/8T2aAQR+oPi2d9lQex0Zb5D3/n6hKbs91mWQzm0R
	OyDBe5mIK2oIuBeD7XpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWUmm-008Pk7-32; Mon, 27 Feb 2023 04:06:48 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWUmh-008Pis-IX
	for linux-um@lists.infradead.org; Mon, 27 Feb 2023 04:06:45 +0000
Received: by mail-ot1-x336.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso2878698oti.8
        for <linux-um@lists.infradead.org>; Sun, 26 Feb 2023 20:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flnML7b+bSQRGsvQ8NZIpa8v6ijknaB9o2IhQpg86OM=;
        b=HydNKyWBQ6INfb8aCWugSFRRQyXuUfSnrsfrPH0qpTanBmBdOmE1ChbsPcS5RlCnAU
         L7YgU3avoC/d1NOa46vC/Z+gc+YxTaWNe26fm4YZo8BuRs119GWsZVkQnITEc9jwc0kX
         4sVWLWm601f2CzphpW/FitMhVF2j+c/f23fPhsMcXbyEvyIuBJGiDKDo7l7DW6YOq09H
         X5SB4lV3tIB46+TqV1VsXybHxVk1T84M+hsxfnC+YU97M/vKPdhsTHYx/nqM1G7SiU4/
         CMPuvLCgFmIwyxgHgd5J7sXnfAD48nipqDexhVH0QL/7pBPar+sw5XaUQ9wMO6GnjsQF
         bczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flnML7b+bSQRGsvQ8NZIpa8v6ijknaB9o2IhQpg86OM=;
        b=WbgtwjourE/Oc51m/QB/GCxYZpBiiEHV938bJzjdOiG3TgCkxSgT3/lku2dOIncSg3
         Iu13HFptKIVLQSQqKo23l+5VDF3Aos1ge/s0/2iRhiPcnUWJSVdfyRFIfThf6VMPB6Og
         jQW9gY8uOoW053Fp2GGjLQrHrCPDeJvBQU00QN/Ug5XkBQkPdQIvsx1qeJPeMfY6MiFS
         t2TpMT6VMs8lyDbtKyyRRvdVihRfxcHpc5ybii1Ui3ap3/9hZlyabnwZnUjxohIe1Ae4
         QnHHV+5zXzf9JiFggJ3p1LY1M681rss+Y9xSOPIU2J3EwEy4IGnpolIMK77WH22J3fqj
         KzGA==
X-Gm-Message-State: AO0yUKVCO40Cu1UdGNK3bi4jUcdXoTW1gdfX178clYjvCRSrcTiuRQZO
	OPWkDE7uattS8UQMJb+fbP0A7g==
X-Google-Smtp-Source: AK7set9J0nTW4hS4HuqvLTM2KAs1wmypF/nBiEPT9XNeaZovonDhj8PaKB0xQUZm95HarPWlm8HBNg==
X-Received: by 2002:a9d:1cb:0:b0:690:edd1:a86 with SMTP id e69-20020a9d01cb000000b00690edd10a86mr12439347ote.7.1677470802128;
        Sun, 26 Feb 2023 20:06:42 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id j19-20020a9d7f13000000b00690dd5e7345sm2219589otq.26.2023.02.26.20.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 20:06:41 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Glenn Washburn <development@efficientek.com>
Subject: [PATCH v3 2/2] scripts/gdb: Support getting current task struct in UML
Date: Sun, 26 Feb 2023 22:06:00 -0600
Message-Id: <b839d611e2906ccef2725c34d8e353fab35fe75e.1677469905.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1677469905.git.development@efficientek.com>
References: <cover.1677469905.git.development@efficientek.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230226_200643_799219_05C0B354 
X-CRM114-Status: GOOD (  11.92  )
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
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/gdb/linux/cpus.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index e8d2a62ff119..255dc18cb9da 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -163,8 +163,14 @@ def get_current_task(cpu):
     task_ptr_type = task_type.get_type().pointer()
 
     if utils.is_target_arch("x86"):
-        var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
-        return per_cpu(var_ptr, cpu).dereference()
+        if gdb.lookup_global_symbol("cpu_tasks"):
+            # This is a UML kernel, which stores the current task
+            # differently than other x86 sub architectures
+            var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
+            return var_ptr.dereference()
+        else:
+            var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
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
