Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E4AC636D4
	for <linux-um@archiver.kernel.org>; Wed, 15 Feb 2023 15:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6DRrcvpOGYrZQpsiLHgywoR/MdwY/OGbsB+9R96xl2A=; b=LsTMqMp4XiEaSD
	6o0rGjzVyj91hKf42MrIp4oZkbQWbbW7EXU43+w8yxI+XY0h1/oZIN/r3HaZePcR3J7/Ou0TWRD+V
	dMd3Nzz++K4I2HwDRP5lwRjsIjE+R2Yx+jhiWHWWvVfE0fE0K6pHuYJ8BCV01gro5c65opTedvNB1
	eQYrqD9LMvr3EqKddelrbY7fwSjrhd7vM0dynzNHsd7yPE0w6JjogtGQdV6+73AgcK9qw7b8HoftO
	3CqOzcF4ODUtPXVu929z/L3UOMcphD4Z2HF/H4sIJgS1q7wGwxARt1BZkoDKO3O9Mw170nfEGr1R5
	t5gW1uJIdFVfQs7zpXWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSK8D-006RC7-SM; Wed, 15 Feb 2023 15:55:41 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSK8A-006RAf-K2
	for linux-um@lists.infradead.org; Wed, 15 Feb 2023 15:55:40 +0000
Received: by mail-qt1-x82c.google.com with SMTP id cr22so22208211qtb.10
        for <linux-um@lists.infradead.org>; Wed, 15 Feb 2023 07:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nYslZGZUg399C+KZgkHqQqJBtb+8z43BvN9LYWAff/Q=;
        b=iH3mLQONqZ7SxNF0vISxcnrWlr5Oze5tEv+BHci33PfPBQ760OtFCR8XoBTrwCPyVP
         JO4MOVZTX2itjBlyHkHZqAkqK+c/mYijg6imPLQdo1htQ28VLUPss4iau6KTeVgnsBPX
         pmM6+312S04F91vHuVXDyBxmJHtffer9fp/PPrfwKeII2w1gniq6+p8vo1TcEUSFHfjf
         kHEvtMQ68OSoblePFYm2/A2OXPlU/+UKtDi+kNLgt+itdSmnv8brmlh45a/Hl0t0+QPY
         z/4VCtB39pHN8CgofDwfq4Z09i70WQuqrzTVI7LMO1nKLCfenYLfFF9p1aBXh99XDodP
         tzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYslZGZUg399C+KZgkHqQqJBtb+8z43BvN9LYWAff/Q=;
        b=EAjnRW0Ya1IVbtPJZ126BPS0SOToSyGcWXC4maQDRd4KPyiqk+oyUXtZ5kWUnH3ke6
         ifeIWydAqDRy6JzZc1u2lpNIw7DsxQPvWo82/mBhB/QpMmwVCO1qV9KiewaNPTLMcZRj
         PITJlVGqCepSBMu4Zyh8GzAFqytXLgQnvms8/+vKmiPyF6CoHMShMaFRfVAG5zuld/SX
         sJFfDc/4TecD682DoklZ8bZ16mzGUR9b93har+PPwp+Tinm6oVP3uMDuqRdZUbOmyeL1
         /35P9o/mLXEWXJbx6SAJPIl2SdWwCQqWjdh4D55bXd5/HarXKY7diJkjPPB4rFzRnks9
         pvsg==
X-Gm-Message-State: AO0yUKUgqxilB3i+BUSr/vV+wkVrdlQcfESOkoHE1dY8dra8k8U8hXAJ
	uJqlofccxgdmLxQ8ffkaPcInjc3IpCew9ugJ
X-Google-Smtp-Source: AK7set/kL40j7sSQhNggM3AQljO0VvFFvwPUUP6/x2QtRgh29HzoPN1GEpvCm2UuDhkX03Dku6Z3cw==
X-Received: by 2002:a05:622a:285:b0:3b9:a641:aa66 with SMTP id z5-20020a05622a028500b003b9a641aa66mr4189836qtw.15.1676476537013;
        Wed, 15 Feb 2023 07:55:37 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id c5-20020ac85a85000000b003b84b92052asm13765889qtc.57.2023.02.15.07.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:55:36 -0800 (PST)
Date: Wed, 15 Feb 2023 09:55:29 -0600
From: Glenn Washburn <development@efficientek.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>, linux-um
 <linux-um@lists.infradead.org>, Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov
 <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [PATCH 2/2] scripts/gdb: Support getting current task struct in
 UML
Message-ID: <20230215095529.169f7b0e@crass-HP-ZBook-15-G2>
In-Reply-To: <31d49cc7-b6a8-8942-016a-9a2793e601c7@siemens.com>
References: <cover.1676416728.git.development@efficientek.com>
	<8c3db2291f583200a9036e83134ba363db492222.1676416728.git.development@efficientek.com>
	<31d49cc7-b6a8-8942-016a-9a2793e601c7@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_075538_910273_221FC90E 
X-CRM114-Status: GOOD (  22.85  )
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

On Wed, 15 Feb 2023 08:45:20 +0100
Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 15.02.23 00:35, Glenn Washburn wrote:
> > A running x86 UML kernel reports with architecture "i386:x86-64" as
> > it is a sub-architecture. However, a difference with bare-metal x86
> > kernels is in how it manages tasks and the current task struct. To
> > identify that the inferior is a UML kernel and not bare-metal, the
> > symbol "uml_kmalloc" is checked for. If it exists, then do the UML
> > specific way of getting the current task struct.
> > 
> > Signed-off-by: Glenn Washburn <development@efficientek.com>
> > ---
> >  scripts/gdb/linux/cpus.py | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> > index 289f0bf4d2a1..90908653f6c7 100644
> > --- a/scripts/gdb/linux/cpus.py
> > +++ b/scripts/gdb/linux/cpus.py
> > @@ -163,8 +163,12 @@ def get_current_task(cpu):
> >      task_ptr_type = task_type.get_type().pointer()
> >  
> >      if utils.is_target_arch("x86"):
> > -        var_ptr = gdb.parse_and_eval("&current_task")
> > -        return per_cpu(var_ptr, cpu).dereference()
> > +        if gdb.lookup_global_symbol("uml_kmalloc"):
> > +            var_ptr = gdb.parse_and_eval("(struct task_struct
> > *)cpu_tasks[0].task")
> 
> Can't we use an UML indicator that is related to the topic? Why not
> cpu_tasks itself?

Yes, I like that idea, and makes a lot of sense seeing as then we're
sure cpu_tasks exists right before using it. The one thing that I like
about using a symbol with a "uml_" prefix is that it makes it obvious
that this branch is for UML kernels. I ultimately decided against a
comment because using uml_kmalloc seemed self-documenting. Do you think
a comment is warranted if I make the suggested change?

Glenn

> > +            return var_ptr.dereference()
> > +        else:
> > +            var_ptr = gdb.parse_and_eval("&current_task")
> > +            return per_cpu(var_ptr, cpu).dereference()
> >      elif utils.is_target_arch("aarch64"):
> >          current_task_addr = gdb.parse_and_eval("$SP_EL0")
> >          if((current_task_addr >> 63) != 0):
> 
> Jan
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
