Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A6CC6FA8E
	for <linux-um@archiver.kernel.org>; Sun, 26 Feb 2023 06:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/jQFJQQD4tFRYt6b+Ii9dAoNUT2xMYwNAW/hG7UacR4=; b=nKYqvDtUT2iOcW
	nqMNC0RhPIyf1kav/YuwPxgsitXcMyZkHvCJ3q8Uvcv284BNUfN+Ex4CVRw4SN5CGVVRGGk5j6pJi
	Uz0eXJAmOIAtXYbC8KedUc8QJeXSi/N4A/3a+GnzUQdDVrRyYXjNnedlo1kuOFVyQYSx5E3mRQ5cO
	t6oA4Iu01li9Oe6aJlpmvSSeR5cAL2QRl3yxPpJmGr4AIiUh2YozCZtgdgLmWJQLOIpDf/sA9kAG2
	9RDz8l0rdBmp4I+GE2FhVhtJwS9aFrXXz30H55v5Mk/iTIt8VKKyuAuUt4KiRmBABl/zrMWn0umhJ
	ui8Gg2HHn2bQaHI9kJ4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWAot-006vHv-Io; Sun, 26 Feb 2023 06:47:39 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWAoq-006vGk-MG
	for linux-um@lists.infradead.org; Sun, 26 Feb 2023 06:47:38 +0000
Received: by mail-qt1-x82b.google.com with SMTP id ay9so3636283qtb.9
        for <linux-um@lists.infradead.org>; Sat, 25 Feb 2023 22:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qBZFZq3Oq5B/sjhHm5mCKbT3pc099zsCp9+1MZ3rYBU=;
        b=51gUnH1IcQLgB4jswn/INIDwy8MekCPZJGi7Hc7nhRKZFzaKfj+KIOEnexlgnzbFqC
         oDxaQPPXaAMQpr4Utk1O/uOelsusibXzZ28VMwUgARpYCKoxGknIHFo3JDu051GEHCrL
         yJO1hehKIYqI8zddScpccT18ZY8HX0qqqJw7SlEVar/Z0VoDl13MRYKNIjSC3lH6VifY
         5gl4kj0wPGTB5XDc2KVbtZrGtVrcIjleFeHYmd9p8RrhVoiMGe4gNgDKZCBgHc08Rt3W
         sJTzoU4rg+l9GDMGnlsfDT+kJm+gRt96Ft5P4RHNpHqj0ldZFB0mZ7Jk+Y6jbM+aBmI1
         fYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBZFZq3Oq5B/sjhHm5mCKbT3pc099zsCp9+1MZ3rYBU=;
        b=RbXX+8DIBCGBXDULLSQ82ayoiml9ZoSz/5FmEaEvfy/rmxdZnUczYiyi5zwZ9/9k8W
         BG4uOIbDYSpYIN5usTQSMHT4xKpfK87+xNLB1n51LnD/XAG9/b/9WqcYLtLsQoNSxYx+
         MfhOJRemU14Hh5bRLiLJ0zMKYetuKDWNCS/oG5FW4HMUBrShWLn+g8MW0qapyiLMEm+J
         nZRcM+FR5fThH99d6Sy/Y7UhrjwUifK9RdUvVlu0ii8AFBatgBH3G/Py6kUHikJ4tqKJ
         fJ0ag6gFXNTSo7SpaIimWXnLlU7gs56xzRMXkmxSB+wWpHWjY2nWNhALNYJ9Gb1wughn
         9AQw==
X-Gm-Message-State: AO0yUKXU9LyXBlx2Yc+PObQl+nyDPIWwOxEqsZrKeCnY0SRrF5NHRlkk
	0zQfgJxd2HEU0NPb9rZETOV4TA==
X-Google-Smtp-Source: AK7set9ZnqIcTa/5lFOP+RzYXWYgihu0hptVh8t4jfuyqWdqzt53cKDAn3x5W9oZtg7ok7vI44OlNg==
X-Received: by 2002:a05:622a:491:b0:3b9:bb27:e116 with SMTP id p17-20020a05622a049100b003b9bb27e116mr31100037qtx.1.1677394051483;
        Sat, 25 Feb 2023 22:47:31 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id e10-20020ac8130a000000b003b63a734434sm2518639qtj.52.2023.02.25.22.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 22:47:30 -0800 (PST)
Date: Sun, 26 Feb 2023 00:47:19 -0600
From: Glenn Washburn <development@efficientek.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham
 <kbingham@kernel.org>, linux-kernel@vger.kernel.org, linux-um
 <linux-um@lists.infradead.org>, Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov
 <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Message-ID: <20230226004503.1856e58d@crass-HP-ZBook-15-G2>
In-Reply-To: <20230223131402.6d6a662f76348b14574121d3@linux-foundation.org>
References: <cover.1676532759.git.development@efficientek.com>
	<20230223131402.6d6a662f76348b14574121d3@linux-foundation.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230225_224736_965633_2B3C15F6 
X-CRM114-Status: GOOD (  17.65  )
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
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, 23 Feb 2023 13:14:02 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 17 Feb 2023 19:11:52 -0600 Glenn Washburn
> <development@efficientek.com> wrote:
> 
> > Added suggestions from Jan.
> > 
> > Glenn
> > 
> > Glenn Washburn (2):
> >   scripts/gdb: Correct indentation in get_current_task
> >   scripts/gdb: Support getting current task struct in UML
> > 
> 
> For some reason I get a bunch of rejects when applying these on top of
> the latest patchpile.  Please check my end result:

It looks like there was a change from v6.2-rc8 to v6.2 that caused a
conflict.

> 
> def get_current_task(cpu):
>     task_ptr_type = task_type.get_type().pointer()
> 
>     if utils.is_target_arch("x86"):
>         if gdb.lookup_global_symbol("cpu_tasks"):
>             # This is a UML kernel, which stores the current task
>             # differently than other x86 sub architectures
>             var_ptr = gdb.parse_and_eval("(struct task_struct
> *)cpu_tasks[0].task") return var_ptr.dereference()

This is missing the return statement in the second patch.

>         else:
>             var_ptr = gdb.parse_and_eval("&current_task")

It looks like "current_task" has now been changed to
"pcpu_hot.current_task" in v6.2.

Would you like me to resent the series rebased onto v6.2?

Glenn

>             return per_cpu(var_ptr, cpu).dereference()
>     elif utils.is_target_arch("aarch64"):
>         current_task_addr = gdb.parse_and_eval("$SP_EL0")
>         if((current_task_addr >> 63) != 0):
>             current_task = current_task_addr.cast(task_ptr_type)
>             return current_task.dereference()
>         else:
>             raise gdb.GdbError("Sorry, obtaining the current task is
> not allowed " "while running in userspace(EL0)")
>     else:
>         raise gdb.GdbError("Sorry, obtaining the current task is not
> yet " "supported with this arch")
> 
> 
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
