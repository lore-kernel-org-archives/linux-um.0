Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA364E7716D
	for <linux-um@archiver.kernel.org>; Thu,  5 Dec 2024 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=stPP7YaX8NczBe94EUNJGGQYrsTGF2tS1ZZnY2i0wbc=; b=lIkF0m37k4jvCIVhIz/sWhIjm0
	lsnF1IAPeoDaJCCyG3g6N8pzfhNAb/yCMp1EB0dsZEVPVVst4EtpUNIUcUinkfq8DUalNKX3Lntgi
	ru9b1yx2eawuNaRP7swl9HYk9e86ifIbXjlChKBEWkU/3mQ3W5aFEw0DKBQ/liNbivDn6rQ0TZsRK
	CyP+dIjErtvMgm/GQ5aX09II5OV0km5yerSapMAMP8ODUzcc8wAuKy4U7P8t8/czAAULZssefjXDi
	+rKISmv77TfizJKk/w+44Euzib+rRRd5MwQdTc7U31BQgtvNU20YkjiDAmfDj5upq6ZWfAtN3uozD
	cEm0w3aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCAL-0000000GCy1-2IYp;
	Thu, 05 Dec 2024 13:45:13 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJC6e-0000000GCG7-1WVA
	for linux-um@lists.infradead.org;
	Thu, 05 Dec 2024 13:41:25 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-724e1742d0dso856299b3a.0
        for <linux-um@lists.infradead.org>; Thu, 05 Dec 2024 05:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733406083; x=1734010883; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stPP7YaX8NczBe94EUNJGGQYrsTGF2tS1ZZnY2i0wbc=;
        b=XWdM/Mm7yIU6/5sE3JHwFmUR82RoMqgkmupwxIz6gabLL2lFTR/0kX8rfI/4ezq1Mv
         /1S8tYbLm5RcRj9EhfNnVNCYPdCxzZ7lNbqsoIIpwow6ZxAYooTEktktMZdNmlCWQsTZ
         oTzuocLd2HpZX/i7aHZbtjA4phIC8kB1W3y0QRT6z24tBug/XufIYG2NyQkcv3guF2Cb
         jy66hs1LtumOusalrt7UEunNP3Tg+NirCjNhgJwdDHtxoOGPvVPd8bHc85WoqO1IepJ6
         gzBYX+Ya5JTa7RkE3M2fUodQaTyqMFOYZHgdo/W2wrGYvSiMrkVHQImkBsWGGXWWnhWw
         /5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733406083; x=1734010883;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stPP7YaX8NczBe94EUNJGGQYrsTGF2tS1ZZnY2i0wbc=;
        b=ahjHmNVQ+NxSIi9w+j9xq4r2zHzI84knPdk11YvcBr3JnGsDgJMBP1nMXoRX5O0vax
         ERbbm5aBoFXJXoHYSiIByimlFYL0UuLk0AovClt50ofqugdJZdwHtyh0xjohjoW9Z2/H
         PG9BEiTtRbxvqPGwxQRULzmqNSo3J8ltr3iAVYm77pholTRuOoSp8yzWS5e/7t25pp7q
         phtfRPAGjBs18exj7Dy7BnPAoscgSL3Ub1J7trvo9XCemT+fumbNe/s0MNqWV66bsgcS
         A0JpJ6zzQQQEDU2VCV3RjrUUrWUq1m92FSBnCxcWoqHsIM2msy+6EQU/xrlFtHy7Tncu
         N3Og==
X-Gm-Message-State: AOJu0Yz/iw6VPuG8U6w+VP39se35iDUGAQEsuZRg9kjvb/Zkhd+h1zCy
	jS/si2USWK9XUhCKFTaEjlUaJZ7/cKYA/KuqyQBhs40aDCF34+Sp
X-Gm-Gg: ASbGncv/7yXDAyA2cxHNV0+gaJlfK4XOQGPKOqxs/R3SnA5A/zoUBPZXIHR2EzhkJUD
	WQpDNWXzDEEpFuRDgygxJ8tMI0XWonPbQA842YhbzpkWVZzZOI2kCZJq/rWjCXea5GHIPj/FFjj
	0eD91utdsGW9VWv0U2zDqwj3cgaDSIP5EDjrzLXFMtXAdsfVEQIJtdpCfjuKUJnaelr5cOw7X/0
	fHOVwOykjjCKhX0FoSLPBNZ1zVNBDQYnq7RLAZ9kmw6lnk/5rro7PTH4rLA8rxmBhw98ZCdxY2u
	3N2hQSxA0XIX7bKNTs7QIkNU9jVMlXATNQj6
X-Google-Smtp-Source: AGHT+IHqy2fB0PSEtlgLnY5uV9xawlm78HfsnB+wjTo6kKRSaGcYU2YxGWLqYyJoarSz/w0en8Z3NQ==
X-Received: by 2002:a05:6a00:218b:b0:720:75c2:7a92 with SMTP id d2e1a72fcca58-7257fb740b0mr12587584b3a.15.1733406083228;
        Thu, 05 Dec 2024 05:41:23 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a17e8bsm1229477b3a.88.2024.12.05.05.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:41:22 -0800 (PST)
Date: Thu, 05 Dec 2024 22:41:18 +0900
Message-ID: <m28qsuw8ld.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	ebiederm@xmission.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <5b5b50909f7c23f09500d7ecc8b57b46c33ab7b0.camel@sipsolutions.net>
References: <cover.1733199769.git.thehajime@gmail.com>
	<215895272109f7b0a4a00625e86b57f39fa13af8.1733199769.git.thehajime@gmail.com>
	<5b5b50909f7c23f09500d7ecc8b57b46c33ab7b0.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_054124_397240_AD42500B 
X-CRM114-Status: UNSURE (   9.08  )
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


On Thu, 05 Dec 2024 01:20:51 +0900,
Johannes Berg wrote:
> 
> On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
> > 
> >  arch/um/include/asm/Kbuild           |  1 +
> > 
> >  arch/x86/um/asm/module.h             | 24 ------------------------
> > 
> 
> These changes could be a separate cleanup?

agree.  will do it.

-- Hajime


