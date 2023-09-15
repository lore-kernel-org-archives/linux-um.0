Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E41EEE6425
	for <linux-um@archiver.kernel.org>; Fri, 15 Sep 2023 07:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=FDzK2LHCyfxquzF/yBpvphiCMGUsq3LLcH8Iw5aiUyU=; b=hhu
	XfAP5WQZVYna4jEtkHJkPxE8Iw2jvqSW27sUqpKMTynfD8lLLmx6rqAys9VXk/gRaNNs8Z1lCaEFz
	lmsNS/fZB6LMPYa960GoKQabP1go2/hM4AdOIj+ql34V/i9zh/1R5xW5MzmO2NVSAFYLrZmjaljGo
	cZMktgTNcfJoHyziZoLT72d/UwBAsRjJq5T+vGbb3sH25g9N9rJb4zO0CZk/NjFndnYL3dkgL6qY6
	GpjGtt157ITUlD+1NVUdNrY9IWQnx+f55Wl2oypPQcyYq6/vw7e4jnYhkNBvHBi/zVGvLrYbMui9M
	Jey1jeo8j6xLS5SeLEfRo+pNXOdEMAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qh3En-00A2QD-2a;
	Fri, 15 Sep 2023 07:27:37 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qh3El-00A2Ny-0u
	for linux-um@lists.infradead.org;
	Fri, 15 Sep 2023 07:27:36 +0000
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-502934c88b7so3091183e87.2
        for <linux-um@lists.infradead.org>; Fri, 15 Sep 2023 00:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694762851; x=1695367651; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hj8LH0Y9E2ZuzdUJoWNKqFf0G0O45zmHb5RAqQyGTgg=;
        b=Ag+HyY4V0aGJWq6xeVnur/DqVDUOlRC1PQ22GAKSPCE5Ven6Gj6SOJ8IticaLCykFa
         ccdq+BC6v1OehtAUVdV5UnRbl20cdQL2sWSvZYClzgeJ5aKZLbqqP2tBRzHtkMKqBIPX
         4k2S1/rnxamAP2YxGuOj/nF/dQxr/SdWEoMtkey+GjMd8HfZ5ieUNpfNldf7cQ1yZu7t
         XaatHMYXRZUNfsrfSuhEF81iyyfBScpO/J0pztvIJiLSD6HpPljcIRo8wyvVGApvJ0KF
         EqiFBPe4aZwkEATDn+15GL8vi9tXlqOFGVUdQciQww2XxAP8pLIMrqIcY4PPCoK5E2XH
         W4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762851; x=1695367651;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hj8LH0Y9E2ZuzdUJoWNKqFf0G0O45zmHb5RAqQyGTgg=;
        b=DhCH/KmU0+NjfdSBbFgpqEwgJrQWA21YhE8Az4SFk+HcJnPmeu+iBvKx+0s+v9aQWZ
         MURPJvlEg5wohtNNRtJJHvw3dsNZwFermXPhLbP+dl7mR7uGJKa/a6Tgc9f/cpEbXWFH
         C08tPbzKTKIz+CMEYpMLkjdz6VQveNDmGSqFsx9immdnwJzthrfBGDo4lOuXCM12Ca5M
         C0m9ruvMPrpUiHLQl/fFpPQ+Zs9AcGpaNYZXarg1PrHKgUtMJTpAaenKDcSSs3Hsmdri
         Hy1fmnSy8JaVXwE/l7V0U6Qa/yq/PGqc3vSkkL4tKbF07xq0FnsYr3Pgt6C0O1A089bH
         Rqvw==
X-Gm-Message-State: AOJu0YzuKhqO5ez8GNx9QtyrPyn7r+RX29+vIPMn/tMwn9gd5ujN13de
	h6dtjC+3NihebWqxoOJxGw9d6KQFpBarQaC2Vuwh1842dBc=
X-Google-Smtp-Source: AGHT+IHY2ImvHXl5qmqcsguidOkF8Hakr17ezHMtdEKkV1CoC04xkmW6VR5vih8GdACcdGlGPQ5NdBuFxg3gZvKRxUk=
X-Received: by 2002:ac2:5049:0:b0:4fb:820a:f87f with SMTP id
 a9-20020ac25049000000b004fb820af87fmr650212lfm.10.1694762850625; Fri, 15 Sep
 2023 00:27:30 -0700 (PDT)
MIME-Version: 1.0
From: Vimal Agrawal <avimalin@gmail.com>
Date: Fri, 15 Sep 2023 12:57:19 +0530
Message-ID: <CALkUMdTX89qpGKfTRHOpMgHhiLrMEEnWed9hhV5S5FeWj_k=tw@mail.gmail.com>
Subject: printk_caller_id() crashing with UML/GCOV
To: linux-um@lists.infradead.org, oberpar@linux.ibm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230915_002735_318194_2F4A5965 
X-CRM114-Status: UNSURE (   7.78  )
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

I got following GCOV configs enabled

CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y

and was trying to run UML (kernel version 6.1.44) and ended up in a
crash in printk_caller_id().

I tried to debug and it seems current_thread_info is returning NULL
and that is because it is not yet set up. It hit much before mm_init
or any thread_info could be created.

this print is actually coming from __gcov_init

void __gcov_init(struct gcov_info *info)

{

        static unsigned int gcov_version;


        mutex_lock(&gcov_lock);

        if (gcov_version == 0) {

                gcov_version = gcov_info_version(info);

                /*

                 * Printing gcc's version magic may prove useful for debugging

                 * incompatibility reports.

                 */

                 // Need to uncomment post fixing NC-124446

                 pr_info("version magic: 0x%x\n", gcov_version);
<<<<<<< this pr_info causing crash



$ gdb ./linux
(gdb) run mem=512M rootfstype=hostfs rw init=/bin/bash

Starting program:
/home/vimal.agrawal/Morane/git-openwrt/basesystem/NEMO/linux-kernel/linux
mem=512M rootfstype=hostfs rw init=/bin/bash

[Thread debugging using libthread_db enabled]

Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".


Program received signal SIGSEGV, Segmentation fault.

0x00000000600f2de3 in printk_caller_id () at kernel/printk/printk.c:2033

2033 return in_task() ? task_pid_nr(current) :

(gdb) bt

#0  0x00000000600f2de3 in printk_caller_id () at kernel/printk/printk.c:2033

#1  vprintk_store (facility=0, level=<optimized out>, dev_info=0x0,

    fmt=0x6097ed2a "\001\066version magic: 0x%x\n",
args=0x7fffffffe188) at kernel/printk/printk.c:2143

#2  0x0000000000000000 in ?? ()

I am not sure if any of my .config is causing this. I don't think we
can use pr_info so early. I do see that this pr_info in __gcov_init
was added long back in 2019.

Thanks,
Vimal

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
