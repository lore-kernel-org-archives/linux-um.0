Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B174CC05027
	for <linux-um@archiver.kernel.org>; Tue, 14 Feb 2023 23:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yxkxjRKZPR+3zx8OjRiC4jxPhAXGhSfl+fghWn6xOv0=; b=B0AuxFwZxtzxtL
	wPoFIqv3/AqcAcoDmtbowp9/UXuaBglLUQ+3ksnjkqgfEuRFg2qjrze1Il3kmItxY9Tv64R5Ayp5t
	IF0P2OlIAPJwfP3QmHETLQ//cAzXD+BsyQCYNJv4/DjZz7jU3W4Ulnf2gv3/LpvXEF0xz93KnlpDl
	Y/D6Ddg0lzOeKIyl32DrWp+PsAqiHAoN5FXA+itZMpcoUwgipDjafQX8o2wBLaYGHVeht3zPQlkcJ
	3U1p7OrjYl2vQqYEByRLexhFi2UwFw3saTRgpSpWzTkHU3HbsPhEKZO35Os3tf+0vXO/DM8bOosQ1
	MpUKS45Pjo4kknGilOzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS4rc-003vIx-2u; Tue, 14 Feb 2023 23:37:32 +0000
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS4rZ-003vHO-Qk
	for linux-um@lists.infradead.org; Tue, 14 Feb 2023 23:37:31 +0000
Received: by mail-qv1-xf2a.google.com with SMTP id o42so9411191qvo.13
        for <linux-um@lists.infradead.org>; Tue, 14 Feb 2023 15:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PExgdktPFDnbwiC2ZhAAKO+c3GHZZ7T8KuLCa5+nyeo=;
        b=dABLLz3UJUAfyAA2Fu6yj0FHcI5KQy/Vq+NPZJ/jD03WMG3j4HiuqTuyg+9ZlOXE2e
         PoXag+VERBF7+DuNNWYcCWpCAme+cg0pnoAIPfQstpZU9j2mOFnbOcSyTRh7wvhO84+7
         KPQLZusQavLBXsBI2sH+QfG/cm+x3+h5CfXi1i+FhoWeksjEAD+q6Ri1WqTNNEFnrcER
         GinGTVdNCNZ7Qqdb3EaiSvEsnZZGO2BVSzlPZYDIAuRzszbqkCE390ZPC3dVjNSjQpFJ
         XBIjRqXyuPln2L/9TR7IGcTVmBJDNMkCwse8/vNsUW6XCTFpozJPjVsvIQOqNodNvSQL
         xxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PExgdktPFDnbwiC2ZhAAKO+c3GHZZ7T8KuLCa5+nyeo=;
        b=yVtX6eY1JDOuadeggYxEeXSc1PvLL04T5G2hemjGrJxNGkKNKkSaaOo3mlBV51wCAS
         xy/4F0OqHNkTSy0+Cp3fjBYicangAvl2VW4FEoii9CvjCxuRpjrVqsIY2Ub5pdTe8jwP
         txD+YJhKD/xT8ME/B/gnyzR0XEn28w1ca+zcrR+IPy4l28YmRiDNPje255MjMCpzbYVC
         0D9V1G+Uq4onUaaZDu8E6vVNdHvRGEBAIksDpUaPWv4zbQFLXUlPYn1sPCXDp61+Nvn9
         GPBYJbA5zv5Zw589TcNtO78pfhAOtfL00AtaYCWXvK8eKaMBP9RwXPiUbPGA2/c0XHLl
         vynQ==
X-Gm-Message-State: AO0yUKVNxcogQW467VIBBHf/xHjw8hg1Q7aqksF8Y55xbeZg1wbTNrwO
	1bUxy6pjfyH7tfVJBKup72an4w==
X-Google-Smtp-Source: AK7set+BJQ0eq2BsihN0upchp47DbKCwAmDbfzwH8BBZq6OsT9aaXBS/hNVuOyB0pV8EDFEs19Vupw==
X-Received: by 2002:a05:6214:b63:b0:56e:bb46:fc79 with SMTP id ey3-20020a0562140b6300b0056ebb46fc79mr679637qvb.35.1676417847560;
        Tue, 14 Feb 2023 15:37:27 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id d7-20020a05622a15c700b003b7e8c04d2esm12310262qty.64.2023.02.14.15.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:37:26 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: Glenn Washburn <development@efficientek.com>,
	linux-um <linux-um@lists.infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: [PATCH 1/2] scripts/gdb: Correct indentation in get_current_task
Date: Tue, 14 Feb 2023 17:35:39 -0600
Message-Id: <f33ebe524590314238b48fe620c9af717b1db096.1676416728.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676416728.git.development@efficientek.com>
References: <cover.1676416728.git.development@efficientek.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_153729_891806_00514673 
X-CRM114-Status: UNSURE (   9.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

There is an extra space in a couple blocks in get_current_task.
Though python does not care, let's make the spacing consistent.

Signed-off-by: Glenn Washburn <development@efficientek.com>
---
 scripts/gdb/linux/cpus.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 15fc4626d236..289f0bf4d2a1 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -163,16 +163,16 @@ def get_current_task(cpu):
     task_ptr_type = task_type.get_type().pointer()
 
     if utils.is_target_arch("x86"):
-         var_ptr = gdb.parse_and_eval("&current_task")
-         return per_cpu(var_ptr, cpu).dereference()
+        var_ptr = gdb.parse_and_eval("&current_task")
+        return per_cpu(var_ptr, cpu).dereference()
     elif utils.is_target_arch("aarch64"):
-         current_task_addr = gdb.parse_and_eval("$SP_EL0")
-         if((current_task_addr >> 63) != 0):
-             current_task = current_task_addr.cast(task_ptr_type)
-             return current_task.dereference()
-         else:
-             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
-                                "while running in userspace(EL0)")
+        current_task_addr = gdb.parse_and_eval("$SP_EL0")
+        if((current_task_addr >> 63) != 0):
+            current_task = current_task_addr.cast(task_ptr_type)
+            return current_task.dereference()
+        else:
+            raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
+                               "while running in userspace(EL0)")
     else:
         raise gdb.GdbError("Sorry, obtaining the current task is not yet "
                            "supported with this arch")
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
