Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176A1C636CC
	for <linux-um@archiver.kernel.org>; Thu, 16 Feb 2023 07:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Pp5um/P7yLyzTuOmpu85bf3Yzr34boECVBGWOlh3bok=; b=pIznyjNIPhnY6A
	MxwIc2j5xGjDMPAoi4L3881q0LAnPsstn74xraHunwbxdmZpKqPfrXnjcBXj94EXBe1NHdTyRbab4
	ZLVAA3JL/Fo7S7C9YmM75KOq5GuovLW3fBVLlFdhZWlcnnXkGUBRXvPlWAjTHIOsw6lLLo9903JB6
	FGKzqmQoM+yrNadBnPdifJ5rAIUJPTZR1GHkeygDTpmTDxIJi5kb1sjZj+nkVaYzrH5rcZ7TbDxiF
	PQmul2TPLkQTV/CTkWkbpkB//oGmyb536/lT+p7aAiyh9fXC6fTRZHWSv1OOTbEOVvjaEBbfTo6qp
	aHNCEpWqt+x39BVWNKuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSYq2-008pfo-Qw; Thu, 16 Feb 2023 07:37:54 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSYq0-008peG-8C
	for linux-um@lists.infradead.org; Thu, 16 Feb 2023 07:37:53 +0000
Received: by mail-qt1-x835.google.com with SMTP id b21so1247602qtr.13
        for <linux-um@lists.infradead.org>; Wed, 15 Feb 2023 23:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wr2zCQ1Tc928nsK2G1LdnDMg6afLnDzp3aXmHYm4R0Y=;
        b=gEKl/qM/1SD2UkPChky40EdnNrjivH4/3UDnl+UnefpDUxiYidXqvN1yEu8PLtsjiI
         gjjc1pcztJyFLFI5XSctXCs3Kj/K3WowfXi0fOg+tsfFNs/uCBlgTi/cnOBLIwWQe65i
         hzPxwHMu6wo9Ig+Trn4NRLucm91QZVAWQ5XEPZXvRk6eFF4CPIyx/nsldNJ6O6sVZoVM
         eqw3/IP0zbXJjbeasvmRyD7SnIcVO5qWS0mSL0KCqJAdft0S4HcKZD0pKHRalUnvgPu5
         IertYirTm7qFudlz74I48fjN11402L6yUNWWzpyveQt2wViJc4NKCRN88tgCjc5yQeHd
         cpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wr2zCQ1Tc928nsK2G1LdnDMg6afLnDzp3aXmHYm4R0Y=;
        b=5+3lJ01e1Hl/QfTkjgesT1TZDGZhGe+cvN6dv/Un6WO7dccKu+YaJaN7R1P7kVXKP/
         XuqnZVfLsVQI3Xjq9fX8LzSF8p1SJ8eMY+AucOU4f88/nixMzq840cjQs4rTllAjuOe6
         fn3PVTuByM6JF505G/LK+KO6PQD9ZVi++HTSYau9aWKkWj6efXWktTC0YG3I4fUofn08
         Ztslj0Y6Ny3TILiQHG+DQt0yKXTNxbge+KYYE1O3YMOUgubMxX+N8ZjbOFwY5JvIsBdg
         R95BQ8yaL5dNgvsK6ZtchkSFKjmJodenkOgyzIeU6CeK4S99NjKt77yuObD+CfIWUVtn
         ejQA==
X-Gm-Message-State: AO0yUKXynqGDuyFuvUQrOWcO2TFzoBeqyjkprFSsiQ4QsBahyXzN0cOy
	F3EPl75A4Ea3+BvvEaWULrN1Bg==
X-Google-Smtp-Source: AK7set9uhUD6XDybWP+zOIjNuNr31bNVh3ZAIl9Dd6n5rpbLlAXdZKW6VX0ykTn9W4RV/GQMGxXMDQ==
X-Received: by 2002:a05:622a:14d2:b0:3b8:58d0:b4d5 with SMTP id u18-20020a05622a14d200b003b858d0b4d5mr7478177qtx.0.1676533069638;
        Wed, 15 Feb 2023 23:37:49 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id m1-20020ac85b01000000b003b9b4028d63sm756718qtw.80.2023.02.15.23.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 23:37:48 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: Glenn Washburn <development@efficientek.com>,
	linux-um <linux-um@lists.infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Date: Thu, 16 Feb 2023 01:37:17 -0600
Message-Id: <cover.1676532759.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_233752_512422_9A64AF6C 
X-CRM114-Status: GOOD (  11.32  )
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

Added suggestions from Jan.

Glenn

Glenn Washburn (2):
  scripts/gdb: Correct indentation in get_current_task
  scripts/gdb: Support getting current task struct in UML

 scripts/gdb/linux/cpus.py | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

Range-diff against v1:
1:  f33ebe524590 ! 1:  c5a916e094d9 scripts/gdb: Correct indentation in get_current_task
    @@ Commit message
     
         There is an extra space in a couple blocks in get_current_task.
         Though python does not care, let's make the spacing consistent.
    +    Also, format better an if expression, removing unneeded parenthesis.
     
      ## scripts/gdb/linux/cpus.py ##
     @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
    @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
     -             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
     -                                "while running in userspace(EL0)")
     +        current_task_addr = gdb.parse_and_eval("$SP_EL0")
    -+        if((current_task_addr >> 63) != 0):
    ++        if (current_task_addr >> 63) != 0:
     +            current_task = current_task_addr.cast(task_ptr_type)
     +            return current_task.dereference()
     +        else:
2:  8c3db2291f58 ! 2:  683d10e752cd scripts/gdb: Support getting current task struct in UML
    @@ Commit message
         A running x86 UML kernel reports with architecture "i386:x86-64" as
         it is a sub-architecture. However, a difference with bare-metal x86
         kernels is in how it manages tasks and the current task struct. To
    -    identify that the inferior is a UML kernel and not bare-metal, the
    -    symbol "uml_kmalloc" is checked for. If it exists, then do the UML
    -    specific way of getting the current task struct.
    +    identify that the inferior is a UML kernel and not bare-metal, check
    +    for the existence of the UML specific symbol "cpu_tasks" which
    +    contains the current task struct.
     
      ## scripts/gdb/linux/cpus.py ##
     @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
    @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
          if utils.is_target_arch("x86"):
     -        var_ptr = gdb.parse_and_eval("&current_task")
     -        return per_cpu(var_ptr, cpu).dereference()
    -+        if gdb.lookup_global_symbol("uml_kmalloc"):
    ++        if gdb.lookup_global_symbol("cpu_tasks"):
    ++            # This is a UML kernel, which stores the current task
    ++            # differently than other x86 sub architectures
     +            var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
     +            return var_ptr.dereference()
     +        else:
    @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
     +            return per_cpu(var_ptr, cpu).dereference()
          elif utils.is_target_arch("aarch64"):
              current_task_addr = gdb.parse_and_eval("$SP_EL0")
    -         if((current_task_addr >> 63) != 0):
    +         if (current_task_addr >> 63) != 0:
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
