Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F4DC531F9
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 07:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BTs8H3gaDNEmul2zkhkb2/pPAZYONtaf97d2xbj4GC4=; b=gNs+wr9WuSW7tWZzp2zeK40Sz4
	V7YdlZ3VO2kE4FqJgIKkTIlR4U3VXYj/GtQ3GdV+/Iv3XbdrmoiGCalED6ChU/o7pKykpgId4pRCB
	uo9FBuvwe+6nzK5rDd6nI/gqIHGPYm18te5ZrMzavC/euUVe0fUbc72ahnioCnFymNZbTKHQQ8QSg
	tKYQC5QqEykzIowGlyHJOIuxWvl0PdM/St05zLDQb1CdWFUbH0eik6HhzfnL5hkGi0gbTBAGwy3t7
	KDge1kuvMZxLUe1RsK3v1WXdcN/h7c5UEVNPCtduPj3wDy/O2ISo6/TMTU8rnYSwTJmZGXh6wFuvD
	4NbBeL+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnAAg-0000000Fg0q-2Vns;
	Fri, 24 Jul 2026 07:18:14 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnAAe-0000000Fg0R-28Rf
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 07:18:13 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2ceed7018c8so935235ad.1
        for <linux-um@lists.infradead.org>; Fri, 24 Jul 2026 00:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784877492; x=1785482292; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BTs8H3gaDNEmul2zkhkb2/pPAZYONtaf97d2xbj4GC4=;
        b=PF+9H9E3DJ3sgzQeA5OOjgosFF3c1G/cjfbpmJbFiGLy9jGviNdmOpcejrHKnKhVs6
         hhh/A6H4OgfsoInBxRntpCFdgiZlv+Pa7pUl9YipamLMgpArQkgXoPklll477QABwfIt
         onhGVqgpR7aZhwjRGMWKP/K2CmBsOSGNHGOAy8QHyapBcO+++UyYN3oiUsA508BTkQ6/
         d9V9EF/ulAgH3noTc+EW/G7c3+UAKJI3UDxSqH6WyhYfyVy/QydrACM5d4mDwkD1Idbv
         Tt3rL7Tq/gKn7bMLjd2p5BZlvNTo5h647HWrE1lq10rgqAVXYQd/vtdNHlcJq83vp+fA
         M3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784877492; x=1785482292;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BTs8H3gaDNEmul2zkhkb2/pPAZYONtaf97d2xbj4GC4=;
        b=biYv+J81drbS5leKW/u7bHLljalmM7C9bKvjqRUAVIrBh/L1fE6ZJ29/ZhYhdc6Itb
         pQLLA6363b8lcUZMq7MHmOVVrliRKWBJQjr/2WO6ohnGw+pSS5W57XJ1fJZyBQlaxDcG
         9krP72GmRQHh2wcQzsbOpvM0WK9tycZrcVnyYv/2W6Q1yshRunMnutgAefABuU4q0qUq
         5qD1r7vnYk/9RDhYxKp4rEruJycg27U4rlvxFYdnhs0nsEe+1VpZEhLmtXQqxgXfCKrJ
         6JjRitP7vjUuJQHqbrmznQr//mKMQawsvdgJosas76Gtsc+Vb7O7FQ3CPFtRHy9KzxW+
         LKGw==
X-Gm-Message-State: AOJu0YzF+izCC2bQrSn2h9bSHLYbQgZb2TZNjCO0XtSvoeGkb8vaOA06
	NqvA55d5zWQ4cmWxSl36d2hgquKIMGVC+6YI309BJRJMrcaqhp/M/r/0Td3yKg==
X-Gm-Gg: AR+sD11Z5jduD//DsXFVVJPOkJq6CT0Wyj4ygZxkq2X7A4HJkMhkNChW4+KY7JaZrSO
	p/jys0FQhEZ6Dm3TT6dEW/00mB4vQRv+I3O13rHhHZea9fsYyLoDblnLYwtqXw10lVM405j6qu0
	xGAKREPZj4eSeqB7bt12JUpWFLn/int5XWZ3V/7o7SGCpLq/AXY2c7eYXe7ta7mzG1UV+o5UYRf
	UqTHbHyjPEIjMc9FPFe05WizZsQXNDx3CNrcJmvhC/85ZcvYFYURxmoTvBWkOVdFyA2bwNt8GL6
	sW4/dEqE14Lv1thqHVpRVrOpyfKgQ3z5rL3Ag6UOWqS2JicfoJ47PRi6cNtumr/kwEz5O3k8TLS
	l6dtU2ga62kroVptnz+242CyUUzSfY8OPmIuCiedHHuuwEia45iyHvOmNnVlX6Q7laUWvJQnSCb
	lpbJb11GXldAhPtMevzKQHDdli/jPqTflTixXWbHEVwBDuHf1Z3dAh+pZ3jNUGLyE3lP1a6GKHQ
	nbQ1yhDpPe5xhIN1uI5
X-Received: by 2002:a17:903:3bc7:b0:2cc:f4d4:29a7 with SMTP id d9443c01a7336-2cfa6c567cbmr75502865ad.24.1784877491571;
        Fri, 24 Jul 2026 00:18:11 -0700 (PDT)
Received: from jupiter.local.gmail.com (179.62.31.150.dy.iij4u.or.jp. [150.31.62.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf96ac33eesm40808215ad.72.2026.07.24.00.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:18:10 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:18:08 +0900
Message-ID: <m1a4rg97pr.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	liam@infradead.org,
	ljs@kernel.org,
	ricarkol@google.com
Subject: Re: [PATCH v2 04/10] um: change machine name for uname output
In-Reply-To: <m1bjbw97sb.wl-thehajime@gmail.com>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
	<20260723113633.bcaf234695c5.I226381aaaf6dd46c559b0e694b29370d0102ce3f@changeid>
	<m1ecgs9908.wl-thehajime@gmail.com>
	<c5c1a16d1be4658e2f797b21fdfe5f4dc3d9a168.camel@sipsolutions.net>
	<m1bjbw97sb.wl-thehajime@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_001812_554610_62A0A80D 
X-CRM114-Status: UNSURE (   9.44  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 24 Jul 2026 16:16:36 +0900,
Hajime Tazaki wrote:

> > Sure, we can drop it. Or arrange so only nommu is different? Or even
> > call it SUBARCH-nommu?
> 
> systemd detects UML via systemd-detect-virt, not `uname -m`:
> 
> https://github.com/obbardc/systemd/blob/master/src/basic/virt.c#L298

sorry, I was looking at a fork repository. below should be the latest
one.

https://github.com/systemd/systemd/blob/main/src/basic/virt.c#L414

-- Hajime

