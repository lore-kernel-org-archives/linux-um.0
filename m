Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B494C531C9
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 06:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uQ/5XuPRwwawWyX4jOYl9csbf6PXRDWDINOuHJKtxaI=; b=May0mr2PeGkYr0akM5qzelCME5
	Wi1G2Fxzr2CvxSk6JNDENCeIAwxdImcPlYUq4cz6itUfe576MMEeEp+IG38f5H7/q2ZjPmlqK5gEy
	ejUrb6RmiAHl6g0SXKgukSzkeV2jdf05oS65w6LiqqNRW5PZ6LmXrENDfOlW5wXvMPW1rJFGvGE2R
	dAOkIWCRrCktl5cSmcDXLOwiIlDsQ9Kt8zPVZQAy8sPMmzUcdKRCLIHkX/aUNbHNLzJ4ecUE9sqmR
	YZx+irjuQc94H+dCBLK1DHExdQUMMQBrzn2hEMQ1VE7qNKJuczd4fqYmEETrcX+yR9n4opx7Nt6tk
	4PErblxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9GT-0000000Fajg-46XW;
	Fri, 24 Jul 2026 06:20:09 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9GR-0000000Faiz-2a7m
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 06:20:08 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso63148b3a.2
        for <linux-um@lists.infradead.org>; Thu, 23 Jul 2026 23:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784874006; x=1785478806; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uQ/5XuPRwwawWyX4jOYl9csbf6PXRDWDINOuHJKtxaI=;
        b=WenrpiRUDFzzSpHa9aRLteZGI6PhwonDHmly/BlBmmEewMHpdnOJZPNjU6AkZH4FV2
         T+/yPEahq+VWEvFfhJyHbnPeZzU+0RpHCmelwwvxzHOA9IsvmKqIfHzy9+VoVcZyiK9M
         2a22fIR8YbeL2m8Q8e3qBcpZvtWEKL51EDPkYW/p7ir0jODjXqZS0In/sH3U1pvYAcRS
         hgHbpdJto8HQNmkQ+0nAEDb+FsWPToT2x4ghnGDU2QP3Av5lpukpRBKwTEhEktoZOuhS
         ERrzIjDCdwEcSZUWZC0e2VA0FtqtzE7xmJR86/E63h3EM84lSkeWN2XnjqyMpybZoTmH
         U48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784874006; x=1785478806;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uQ/5XuPRwwawWyX4jOYl9csbf6PXRDWDINOuHJKtxaI=;
        b=FwxPQ3YgvAcRdP0Wi39U8nYg28E3nSFFlcWcYqiiBGw+mpbkbQjdAqk46LdcnrxqS8
         Wopej/rqTimqbZHw7z9Inoh1UUcqLVgi7/JHeCucpyQxrmwQM6WIf9ArZ4LMt3XL8J/1
         SFxEFvc71apEjmVF/lB0y1EjxA+gZJSBRlgYsvTfP/hmRUPUK+gJjTEcJRcGjoVQVBiX
         xJB/GFvrGNZtxjeRcoKR53ZH6zn72I7KkjvPCqgNKOH7p+IMqmEiiTzglxjmoE45itDq
         zcymCyGrsm0N0xW+YmcJCqTAgxAGOavDxx3D2wR5cAbxY9/r34JfnNpDtcfEGmq3Z9Kt
         gDzw==
X-Gm-Message-State: AOJu0YwqKPFoblinrSQhvilZGuq2E8u4GAClDcfKk08BjrNt0b8N+1Id
	i92lBJBZnslXi29UtHlYJ4K6z74SGPu4jY6hdZGX1KYt2VxA+SOz3dtL3eU1cQ==
X-Gm-Gg: AR+sD10XcWOVywVMqu9bulsT+EVS5czNZQMQH5DiOkRJw2BW5Y/kx0H1N0L8YM3dX3o
	bFDBENCmecCcHOjcIGu09jFro8YPY7kS0ctkfQv/itDLv1qqW9orNI0GQDAicuPiZm3IScY1OhA
	p/EcrA6YJYUczNCpn94NizxTboyXjIsya9HXFmHyNtJlvu6oAFS9txa9QcCTOqU70+r3WDgNNWU
	Y9FMZ2zUzOL0z4SPC7dG8C7O8kbmaj3vY4hFOVkfae7gcgizRsNealNZRJyk8EirtM51Uese4Y1
	z7/UvF/RotXkMzo65Wc6HuPFEXhsP0hT+p1GquaRlsRdifK8+zZZDJ5nrOJ/F1VZFM5PLwGU00n
	LiT5NFC6FJ9Z3s4mnG+FtSjSiYxgiBpd44RWiZ4yDts2Job8emFpL0G1/BFCtfQTdqFpo9VY4G3
	FJ4WKtsxEfDOOEjaRZ+UcGwpzd+H5vbBjg3kmVM8tjGFA7CaJ/fsJYeenK+LwwHcY4RCSATos71
	wSMMExjsGNu9e7W5p/T
X-Received: by 2002:a05:6a21:7002:b0:3c3:954d:278d with SMTP id adf61e73a8af0-3c44afb7068mr7236152637.9.1784874006067;
        Thu, 23 Jul 2026 23:20:06 -0700 (PDT)
Received: from jupiter.local.gmail.com (179.62.31.150.dy.iij4u.or.jp. [150.31.62.179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1c4c3asm3746988a12.31.2026.07.23.23.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 23:20:05 -0700 (PDT)
Date: Fri, 24 Jul 2026 15:20:02 +0900
Message-ID: <m1fr189ael.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	liam@infradead.org,
	ljs@kernel.org,
	ricarkol@google.com,
	johannes.berg@intel.com
Subject: Re: [PATCH v2 10/10] Documentation: um: document nommu UML
In-Reply-To: <20260723113633.19c6669dc151.Ibd7a532eef856a1ea39699a263dfa8a9ded9dc20@changeid>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
	<20260723113633.19c6669dc151.Ibd7a532eef856a1ea39699a263dfa8a9ded9dc20@changeid>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_232007_696524_F12F62F6 
X-CRM114-Status: GOOD (  19.92  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


On Thu, 23 Jul 2026 18:35:51 +0900,
Johannes Berg wrote:

> +When emulating a system with an MMU, UML gives every ``mm_struct`` its own
> +host process with its own host address space, and keeps that address space
> +in sync with the kernel's page tables by issuing ``mmap()``/``munmap()``
> +into it.
> +
> +NOMMU has no per-process address spaces: there is a single "physical" address
> +space that the kernel and every userspace process share.  UML models this with
> +a **userspace runner** - an ordinary uml-userspace stub host process, started
> +exactly like an MMU userspace process, but with the whole of "physical" memory
> +(the physmem file) mapped into it at the kernel's addresses:
> +
> +- The runner ``exec()``'s the stub just like the MMU case.  The only extra step
> +  is that, once it is up, the kernel maps the entire physmem file into it in one
> +  go, at the same addresses the kernel uses.
> +- Because NOMMU never remaps, that single mapping is all a runner ever needs:

I was actually not sure what you mean here: "NOMMU never remaps".
could you care to elaborate ?
the subsequent parts are clear to me.

> +  there is no per-mm host process, no TLB sync and no ``mmap()`` of individual
> +  page-table entries into a child.  Userspace code and data - placed in memory
> +  by the loader - are directly executable and accessible.
> +- The runner processes hold no per-task state: the kernel loads a task's state
> +  on every entry, so there's just one process per CPU.
> +
> +Running a task's userspace therefore only means pointing a runner at that
> +task's code and letting it run until the next syscall or signal
> +
> +Building and running
> +====================
> +
> +Configure and build the ARCH=um kernel normally, but deselect CONFIG_MMU.
> +
> +KUnit tests can be run in NOMMU mode with::
> +
> +   ./tools/testing/kunit/kunit.py run \
> +       --kconfig_add CONFIG_MMU=n --kconfig_add CONFIG_KUNIT_UML_PCI=n
> +
> +Running a normal userspace requires NOMMU-aware binaries.  There is no stock
> +x86_64 NOMMU distribution, but a prebuilt Alpine image with musl-libc and
> +busybox built for NOMMU is available and can be turned into a root image::
> +
> +   cid=$(docker create ghcr.io/thehajime/alpine:3.20.3-um-nommu)
> +   docker export "$cid" > alpine.tar
> +   docker rm "$cid"
> +   mkdir alpine-root && tar xf alpine.tar -C alpine-root
> +   mke2fs -q -F -t ext4 -d alpine-root alpine.ext4 1200M
> +
> +Then boot it::
> +
> +   ./linux ubd0=./alpine.ext4 root=/dev/ubda rw mem=1024m init=/sbin/init

For the alpine packages, I'll contact the distribution once this UML
is upstreamed.  And update this part with more proper information
rather than my personal repository.

-- Hajime

