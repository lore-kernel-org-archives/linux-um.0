Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6CDC636D6
	for <linux-um@archiver.kernel.org>; Sat, 18 Feb 2023 01:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CIihHJ9u50Wu57hmuryjcV/tG2L/1iB0mk/8iap2ixU=; b=kTlhMN7F1o6aXs
	ydDC+6zPV6oYkCDSMaORN1mjhAJjQftwvYIHyZE9Ns1oFiKujGVqcwAvuyL7UUyz5VKnbRHxC+/ke
	EX7erNPTeDE3KOjgS0mrmlvecz4nLxyjLXI7V9oXj0Ecanfq7YSGYOEfDVwUOffvrwVSQteOSoqJj
	g3fn4ZMNKPsreV7vTCzxd45hsWDrIhI67/VuBqsXvaBE1M+Pr8R008rrLOvFNUFZlPhLYw9SBF4GO
	tp8Tiy7UYESLP0vMMxNWvmya8LBqraLQB2EQkdPUML2FrgcORSJWdiWffCiGohqWn+5zJsnSJWQ4u
	CkQufoR7hZebScdoGa8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pTBmr-00G7ZD-GI; Sat, 18 Feb 2023 01:13:13 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pTBmo-00G7XV-R6
	for linux-um@lists.infradead.org; Sat, 18 Feb 2023 01:13:12 +0000
Received: by mail-qt1-x831.google.com with SMTP id f22so2238742qtb.8
        for <linux-um@lists.infradead.org>; Fri, 17 Feb 2023 17:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dm9Zb3YfJUlOc5PhgLLXoOZzDF1VUioxKTXdg6kCPS8=;
        b=VX0dxnS3bxQ8apKWjmSnM/Y6dyWI+rGYDi5wAoVU2mJhsewVL3DIyBTVrCxSYBgQfI
         r4wVzef4cr02shYJCptswyE5fupUFcz2egk2B8U1SnICC2PAYt5uajMdiQmfdR18LNq0
         adI1HQQZbJ8v+9Q+LoVg5AiPl4ZaHU4JGZo/uvTmDM+pMR1gkZh8/jC+tgeNUoe+OOGC
         jKFb2JdtSxKU1yHqtJkQk7l4ITxgy8qMG7v31PwJAbsipavfA6zjmYYHnS8bsrBZ1ass
         l/HigO1JHOQy1U65SAEcDdlnoE7G0AmW7OnlT1uXTZKKQKgVPV1N3X3BNZedanFdwGbM
         CT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dm9Zb3YfJUlOc5PhgLLXoOZzDF1VUioxKTXdg6kCPS8=;
        b=UUQ2XIFkj4eGtrWhbJjyuETYVj/BGk34Don3FN+iRnPNHSz0B/clUAao65EuRNVtPQ
         Pa+6xH/HAR5CXlh6H233EXZyY1SIWe4Td5FAfCPsXV1ptlFf3refpR2JSqOIH4Z32amV
         M92Rta8HlTxYxW53Tagi/t6gr7ns2HaumLJRnchxnl1RhZmfiWmm3t7uc+UdEDE+NEU5
         576fgzkGZuD/QHm42Q6PYEWHJl7IwdV6cY30NJ4ecd19ysCKnAWdzHqTz/DenrdWrMS9
         kN73KMAz5kI1VpwbIX2mvH7R7SRSm/p+jBxnwT+u6ciNVZZaVysbH9cXdsQbezof1NJc
         JhcA==
X-Gm-Message-State: AO0yUKUwbcoDqoObN2uyHbAVde/UzH3vFLQacWZ2p/IxhP0tRIgKza3U
	A7cDC87tcMhdhoo+SeSZZxkf1A==
X-Google-Smtp-Source: AK7set/1upC9hp7XAoWby4OPDeqwKKo0xpIttNos16E1kCy9BoGydPVWMxUes09blyIpoaDpBpbzig==
X-Received: by 2002:ac8:5952:0:b0:3b9:bd8d:bb22 with SMTP id 18-20020ac85952000000b003b9bd8dbb22mr12636719qtz.14.1676682789178;
        Fri, 17 Feb 2023 17:13:09 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a024d00b006f9ddaaf01esm4268119qkn.102.2023.02.17.17.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 17:13:08 -0800 (PST)
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
Subject: [PATCH v2 2/2] scripts/gdb: Support getting current task struct in UML
Date: Fri, 17 Feb 2023 19:11:54 -0600
Message-ID: <683d10e752cd4852ac62ef3cc3e9a6972a017bdf.1676532759.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676532759.git.development@efficientek.com>
References: <cover.1676532759.git.development@efficientek.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_171310_937206_8329FC08 
X-CRM114-Status: GOOD (  12.15  )
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
Message-ID: <20230218011154.0ct2MVFQVFvujjMF2dXhHMlNzXOCKpe0o3Ooinrk88I@z>

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
