Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B2AC636D6
	for <linux-um@archiver.kernel.org>; Sat, 18 Feb 2023 01:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Pp5um/P7yLyzTuOmpu85bf3Yzr34boECVBGWOlh3bok=; b=CMxlIWbdQtkSdc
	kRBNRLDzHmBhOmYsuUz70DzJvYj5J595nOSmg+smyj2QbpHAg457/gJiFsU4x2Ck8CzQunxmeX2p2
	UuRnCVW1XXDlJuBz3pIO4Mdo+VMkVqlxKVltmAA6g7NB4g55Mve8pwhAZkTb5KMuzclb8gaEOMy7Q
	6T5sFx3SRLjGyS7Iw5POAHyofuzdICNJ6HwK+09QJ5pB1ZRB2KH7E8xYVH1lbZTEvBL892yU50FzT
	xu9MyLoYCl8XQX7ySnk4HWAcUzaZcTARL7ITJsYkb9MnRLyki6k4qVWB5baFqsvDZIIFKwy+NlHZ9
	R794lxlf55E8F9ykeUDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pTBml-00G7Wh-O9; Sat, 18 Feb 2023 01:13:07 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pTBmi-00G7Vk-Vp
	for linux-um@lists.infradead.org; Sat, 18 Feb 2023 01:13:06 +0000
Received: by mail-qt1-x82b.google.com with SMTP id m11so2332453qtp.7
        for <linux-um@lists.infradead.org>; Fri, 17 Feb 2023 17:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wr2zCQ1Tc928nsK2G1LdnDMg6afLnDzp3aXmHYm4R0Y=;
        b=3LZZJ8PIaPV1i8wlos2B1/poAFMGi8fZ5Nof9/vczbtCLkM78UqClyya28OBzzaKR7
         z6IpNmM6nhEJwHO4tWqMkZO9VOZVisZDUg6G2R0fcC9TkXazH2qgLTDhoF6sv0JDM78u
         P1IcNb7mqTdQ38p2BTPXMtG8U41IFXxbAQzUS6YEFYE0pvvKqv+ZgqipbauUoSs3lzQ2
         mZ5drufEBeosri5ekoMf04z7BUkyVKIa8oRmP0mUajiyPQtNEaRbfkonpqU3+blb8FyB
         sZek0wP/j/23QFy3v8YA3MePixw01UdK+9L3koCFM4afKjiF7ELGfqJxUrdbUxh/grrs
         GOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wr2zCQ1Tc928nsK2G1LdnDMg6afLnDzp3aXmHYm4R0Y=;
        b=1uN4qOV/HlcSzWcmqYVQrV/t/NEpBVCK7LrAIfxKq4uoZOupDVm7dhAOvdTiDXEMD/
         G5QVXqAuf0eRtyUJikl2xnVUcLhch1s6LplgMO0ummv7jZkLvxInS384uy3HXUIuo1uE
         s+ugN5qd3Wt32cr9dCCoaS81kF2m06S+4SPdoYN5Q3VjkmPS05avmtTEo5emfTwD8kdy
         5DNRY7lo9lDj6GAVXUbH4tujozi5I5NfNOwmXA7aSyDdIUEThMfVXRcrIXauPPCWr2ki
         eSpYY2PXzqReufVv8hIe/SfQtq47pWXNIU4T0U77R8mASKIBh54cVGtPZ34gvzqzecd2
         Jrrw==
X-Gm-Message-State: AO0yUKU5IkkMO6RYRVxFqWd6K+SIHd3RZKvKBxmTCJakUiDk6pdsrrnt
	RV7QmUCGE9KG/jdfZWMty4z0MQ==
X-Google-Smtp-Source: AK7set9mecnmhN9lQs+1mh2KjpWEkvGt+HvEwPAWLjRIdx2QXia4RXM4X8Haemgi+/3jWKRyYbSkRg==
X-Received: by 2002:ac8:5a41:0:b0:3b9:b450:61f6 with SMTP id o1-20020ac85a41000000b003b9b45061f6mr5934166qta.62.1676682783430;
        Fri, 17 Feb 2023 17:13:03 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a024d00b006f9ddaaf01esm4268119qkn.102.2023.02.17.17.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 17:13:02 -0800 (PST)
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
Subject: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Date: Fri, 17 Feb 2023 19:11:52 -0600
Message-ID: <cover.1676532759.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230217_171305_271336_9D21466D 
X-CRM114-Status: GOOD (  11.72  )
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
Message-ID: <20230218011152.WEF5PeMDNoVdyEsniCYyPim9uLro8tpaus3z69hqCSk@z>

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
