Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C4AC6379F
	for <linux-um@archiver.kernel.org>; Sat, 18 Feb 2023 01:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VtpFE2CnrXFrHBv9egBLdJL2QBuSYQgSayoVMbqPJu8=; b=ic+DAmQUN53pHR
	2fs182fN6ni/JxCil6ExAA5jNw/q8BfPATWkCpjR6I4GegUQtrUD7jjw84kXVmVSnVn6auICBLmsr
	v+p7WuBKroI+iL+67kTlMXXE+vOhrbZLZWExxaOE9BoLkVEw+u57txrQ859goo8Qlphn5pfuN6E9c
	LhT2WtRvQMkRsdLxv61nVyxh3l0BT2OqKl2fimngF3mLFrg9sQe9qDDGGf80W3vhc6iFDvWY2DtBY
	pgUP9d0AGdk8ol6l+cHs9IviHMcZXOMCHDlm0cNxycwSFfAPemsJupl1JhIHuE5jDfhaJYmms7/iB
	wx08BX/ytYDRzMcT5HlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pTBmo-00G7Xd-7M; Sat, 18 Feb 2023 01:13:10 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pTBml-00G7WV-IH
	for linux-um@lists.infradead.org; Sat, 18 Feb 2023 01:13:08 +0000
Received: by mail-qt1-x832.google.com with SMTP id l23so2374975qtj.1
        for <linux-um@lists.infradead.org>; Fri, 17 Feb 2023 17:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxWY83X/UsingK6RL95Hy3CzpqO3q6ngg34P0jTRocg=;
        b=WIN99IGsdtMz+H4Hv/qbj5Re2qRTd9H0KYj0LkUK3EChVco0HZL+ADh0IFoaIRIpup
         1p7nrMauLq1lLWTK3pYnVq13gLRoNeqGnpMa6Ii1aNIpNQi2/ipm/sBqKnyIpjcMrQLE
         v1W8NcZUC7WWzWce76eT8bnOm6xzNabSau6112FYd+bpe+JkJjgF8WPfWdv6BJ83Zc43
         tpJPdGmVf0F6gDkkuAYm8yy1xe2Wph6ZJKhY4jHj56SF5kxev2SgZVv91tjLRsEnZMVw
         rKojYiHirtaWrcAv9O+qoSszAOteOVx8j+JhwlANHLmDtLhnuUH7jcswL8d279c6mEOi
         3kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxWY83X/UsingK6RL95Hy3CzpqO3q6ngg34P0jTRocg=;
        b=KJMINkWR9WQEJXeQSm89qaTbhyl8aMvImwk1egbL57NBYSkYkZXx3ppULlewSULvES
         Z6Z9nOoqtg10/YLyWVVkNnzGCHM8Pi8D8Mz8kVarnAfLVOG2aCKI1gLflnnRQHV2Gg0S
         JH8ynaYVxbk0wAUHPJVD9DLjdnpnnN1IOzfVz4eiUJTAPurokNu+RqE8ySoC+CoGdlT7
         tHERC3SH0mqGze+N+JddmR70ACIBYm283JSzw7/IJLFzqCEzyaDmrx9oNDUGiQvUA6/E
         5DI7zE7YC7MwlY4jauVDCOT92DwyH+EwNGfQ60GUDb/W0hOkKubSN8v4O4T02Iv42lEz
         eVpw==
X-Gm-Message-State: AO0yUKWRj/hrGUWMy1hVqK2oS4FIzn/MyRt+/FCdygu/PPvQ2IvHed6R
	BgDadFVNs9WYXOIILrHrDdsYQQ==
X-Google-Smtp-Source: AK7set8hC9JiVA8qJhjEM5Kh6B0VruCtsUFsRT/MMcFZeeDzKDCiXVqSFhl1hOmJ0S7IfX7njGlbzw==
X-Received: by 2002:ac8:7f44:0:b0:3bd:14c:c39b with SMTP id g4-20020ac87f44000000b003bd014cc39bmr6205860qtk.25.1676682786337;
        Fri, 17 Feb 2023 17:13:06 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a024d00b006f9ddaaf01esm4268119qkn.102.2023.02.17.17.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 17:13:05 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Glenn Washburn <development@efficientek.com>,
	linux-um <linux-um@lists.infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: [PATCH v2 1/2] scripts/gdb: Correct indentation in get_current_task
Date: Fri, 17 Feb 2023 19:11:53 -0600
Message-ID: <c5a916e094d9c7acd551030b5dd793203046fea5.1676532759.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676532759.git.development@efficientek.com>
References: <cover.1676532759.git.development@efficientek.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_171307_624699_2DAC1218 
X-CRM114-Status: GOOD (  10.50  )
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
Message-ID: <20230218011153.ORCCs9ixaat3S3-SORyRSjtCnIbPXGJXfQr6cSJWNuQ@z>

There is an extra space in a couple blocks in get_current_task.
Though python does not care, let's make the spacing consistent.
Also, format better an if expression, removing unneeded parenthesis.

Signed-off-by: Glenn Washburn <development@efficientek.com>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/gdb/linux/cpus.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 15fc4626d236..3e02a1866751 100644
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
+        if (current_task_addr >> 63) != 0:
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
