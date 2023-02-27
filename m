Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7A6C64ED8
	for <linux-um@archiver.kernel.org>; Mon, 27 Feb 2023 04:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=C0ve7QHR37Vetmx/W0uqoEFwkB1FIdm40zdXlhRP01Y=; b=ntsv6IlOB33qNG
	KzJDEv3hHoDz2h1vBGZ7z0xO9yhvZhtamqFWhiPrJpeZ87wpEQPII5SQKaHP19v4m5eHTIzUH7gbk
	VH7835i0IIOqfE74P+CelpQcA+vMLCT951N4qOcH2Xkrc7e32IjCKJA3kKSTcEjNSwaxaL4Z0IAHF
	0ssC8eOShr1Hn/7U2CAmN1m8TXezZbEbXgkPjYz1D4U5n+IKvcbVgilOyKMDlxWzkjjbdZHee4t7/
	w1iThQS7IOWnaeac58lThTNMdJwylH5aUnRcRTytZlOXKWx6v25blQ3BF7yfE94KTfkSdavQy1FDt
	rP8Hu0x2McO0VARfxgmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWUmk-008Pjt-Rw; Mon, 27 Feb 2023 04:06:47 +0000
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWUmb-008PiT-89
	for linux-um@lists.infradead.org; Mon, 27 Feb 2023 04:06:45 +0000
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-172b0ba97b0so6237790fac.4
        for <linux-um@lists.infradead.org>; Sun, 26 Feb 2023 20:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8NY3l/s5VQm6VcHLyL10UBGGbYoT2GbHYKXZoazGbGQ=;
        b=4qhtQ2kheDnpHE9FFFzqrfE2x+dSjQm8Mbdrez47ES8OGfHOGTo33J6l0+jvwR/CUl
         frX8+8C9eRptVWrhKZ5tQE653DA2JTheX9OBSKUMR05W1tqHIC8Z19/GAWShZ5NQUnsM
         BiePDWIh6PVq3Z8R8LBSRuMdLG2wECYCM/jHmVJ3+KOJzUKCRl4J3w83PaPbUGOReGJt
         VhpRZTW6WzjSOSWgBW+u2YaSH//VHlZ5c9s4zKdWK+kKz5R9L/hEb/AOBARqjNMeiK5m
         VD7lTSP4ToMdP3GEiROVI6JMYF5NmRNx7ympf8peALnBoJ+jSGoYK4VBIRFa378kvEwU
         t62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NY3l/s5VQm6VcHLyL10UBGGbYoT2GbHYKXZoazGbGQ=;
        b=oXE1RC8s7a08BMBDYNjrPXz0aUXsSeDYuwpIrZdXdsH4R1E25+j4z1Ny5a9enaxh+3
         jCfQ9togkjhiS/9u8dW4/LrR/ajomA+TsGeEl4SBE9DWxQ8oAGmb9n5itvBeOiOS4wXP
         bbw5l6yivftjjWkxtwMhw5CyKukI3Dws/CUI5LfeT5daJjAYKoZvjdg1Xc31zxfUjEoQ
         Qt9gt31mAyRgCfN8TJcFdT8B6dxLSS+AlKVgSO0RkvIBujs4vseppDF7oh7iaV8glVtk
         2SIov47hKwRnpoTOShHcMHUqhYh3bRkhu99yQo4w8QkD2ER/yIBvK1rhYQC+2VdmOsJ0
         qoIA==
X-Gm-Message-State: AO0yUKUthFWlSTJNFVgKD0DWH/+ISyiaQc1TQHf7tY6G/vqNJ3Z4QJSz
	jV2IbbogwHVuVV0mSiOGG6bqhg==
X-Google-Smtp-Source: AK7set9I9pJi9niHzngrb+YDyd1WgNevIXHBtFNjsLnj4BakBocFpMg3ebWR16yLK5HVOgaU5sAjig==
X-Received: by 2002:a05:6871:68d:b0:163:535d:4a86 with SMTP id l13-20020a056871068d00b00163535d4a86mr18651384oao.22.1677470795611;
        Sun, 26 Feb 2023 20:06:35 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id j19-20020a9d7f13000000b00690dd5e7345sm2219589otq.26.2023.02.26.20.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 20:06:34 -0800 (PST)
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
Subject: [PATCH v3 0/2] GDB: Support getting current task struct in UML
Date: Sun, 26 Feb 2023 22:05:58 -0600
Message-Id: <cover.1677469905.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230226_200643_800766_D900E70B 
X-CRM114-Status: UNSURE (   8.46  )
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

Changes in v3:
  - Rebase onto tip.

Changes in v2:
  - Use cpu_tasks symbols instead of uml_kmalloc when determining if the
    kernel is a UML kernel.
  - Improve formatting.

Glenn

Glenn Washburn (2):
  scripts/gdb: Correct indentation in get_current_task
  scripts/gdb: Support getting current task struct in UML

 scripts/gdb/linux/cpus.py | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

Range-diff against v2:
1:  918bc1299bdb ! 1:  2e117b82240d scripts/gdb: Correct indentation in get_current_task
    @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
          task_ptr_type = task_type.get_type().pointer()
      
          if utils.is_target_arch("x86"):
    --         var_ptr = gdb.parse_and_eval("&current_task")
    +-         var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
     -         return per_cpu(var_ptr, cpu).dereference()
    -+        var_ptr = gdb.parse_and_eval("&current_task")
    ++        var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
     +        return per_cpu(var_ptr, cpu).dereference()
          elif utils.is_target_arch("aarch64"):
     -         current_task_addr = gdb.parse_and_eval("$SP_EL0")
2:  93fc6584ea16 ! 2:  b839d611e290 scripts/gdb: Support getting current task struct in UML
    @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
          task_ptr_type = task_type.get_type().pointer()
      
          if utils.is_target_arch("x86"):
    --        var_ptr = gdb.parse_and_eval("&current_task")
    +-        var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
     -        return per_cpu(var_ptr, cpu).dereference()
     +        if gdb.lookup_global_symbol("cpu_tasks"):
     +            # This is a UML kernel, which stores the current task
    @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
     +            var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
     +            return var_ptr.dereference()
     +        else:
    -+            var_ptr = gdb.parse_and_eval("&current_task")
    ++            var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
     +            return per_cpu(var_ptr, cpu).dereference()
          elif utils.is_target_arch("aarch64"):
              current_task_addr = gdb.parse_and_eval("$SP_EL0")
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
