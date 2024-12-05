Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D865DE7716C
	for <linux-um@archiver.kernel.org>; Thu,  5 Dec 2024 13:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jhFmWK3LH6xau3P8SzFKQRupZ+qh/sKRdQvaeA8Q+kQ=; b=33po64caar3UGGAy88uVgA6V8y
	TV8cGZcAaU1v0js9vFWLZ2eQJidK6uQ14pawmOnuEz6g0qGJ7la3keFuNOWToT3db6t0PZ5FOK9XS
	sarJF6YsWMNuBJsTB+0fN7lq9psvmmnrEUoB4dnN+B5Y8S5oj9sJQEx5IyEZht2zTpItLn5F+JR4E
	+kIybxwCgiCKpP3zJWs7tDhOEi8bW82kR7dIe5nBc3JFIo6p/ZY+UtVZnmKDwdgj61yUfNBXprKsU
	JXei4MN4QQ3koY2P8qcUjJtPJoU/U5emdlszdYwbp+JzCDqh6f3mgkg4XTllQL3MQ0gfVQfOB560M
	qfzVI9xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCDD-0000000GDt5-2izD;
	Thu, 05 Dec 2024 13:48:11 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCDB-0000000GDsD-21BP
	for linux-um@lists.infradead.org;
	Thu, 05 Dec 2024 13:48:10 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-7fd21e4aa2eso106336a12.2
        for <linux-um@lists.infradead.org>; Thu, 05 Dec 2024 05:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733406488; x=1734011288; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhFmWK3LH6xau3P8SzFKQRupZ+qh/sKRdQvaeA8Q+kQ=;
        b=XVr6/YHx1f13lR5BqHf104ImAMx7z5LIlyBmC8Bf7HQXf8pzFdg4obJicW8e/aSESi
         KtpbDpVuqu1V1ynWMX74Q6AuEt+pCgcCcD6tVlAAyjuIFZwwgWqsbOAA64D1IMQh2Tvc
         BppxWYCLmt7S7/CtDa0Q8LBP6vZVm4pKR9pOVD3T8Woh3skRPJdxIsx0p0wW8A81iCUw
         qL8cyk5hE/Y0cL19/Zk9pnycprqOCbYwq3L2T1EfAdjkBil7oBH8HFZRg+Wwq8d+RQ2M
         2X/1501ZX5pLOLiMxifze7oTfavUXK6SxjgD6mIrbFGlHHmfgZTnLbdfSPSV57wp/hrl
         XFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733406488; x=1734011288;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhFmWK3LH6xau3P8SzFKQRupZ+qh/sKRdQvaeA8Q+kQ=;
        b=jVnvGJttqUJwGTShuf5ZzaPNdENFpUPyQY6D6Bct2oYS/xZDznnSAgP7+Tp/xYolX4
         G0JK0GCYJQQFajnxgaR1oHa1Yei9D3Jprt/3eiuBAfAUatlwd+KbKt2tl+rxCxEbzjpf
         /icWBv/2mPDIW8V3DF7RIsuPnUmlSyWccEwfOABCkzQSCLdkaLkov8fh41JqpyAI7/6V
         +k/9lPONiaVqL2utCu3qh3G1LTz8aPn7l/ac+nFnXXa1dwqOAA4OOFpnssADZ1ssJ7yW
         QkdJY9qiPWotDc6CxUxS0Z9qtYUuEuOB+j+2L3xbfVUwH3QmSx0SDF7JvCvmB3aE1s3T
         yM7g==
X-Gm-Message-State: AOJu0YzT+/Pc1S93jU+aekTRJZVOmXralDFirzCZh7mm08ODc902MEGo
	LSM1JvaZAOYAOsK1IcsfAWkZCor2eO4VWTS6/1895LBkx2C68mxP
X-Gm-Gg: ASbGncvuqJnnMVk7cKKW5HEwRVZ5lq1uGfP4/gKC6ptnC4syphQ8PF5Zfddmjv4GFLo
	sozkbbDX6bbk4pxX/nVdd/hS1EIQXVb9VWzEC7pSF+y2LnQaJUrXdpHIkQpXqELIdTIdZe3leFO
	I/i1EzXI83PPmUFQdGhVDVLhYW1wGgZvhzyRxj08eeEh8g1917+aFayDYy3VYr0/321qZtkXxKZ
	LRw6S05XU6z7377osIeoFaFioZigWe9nljDuw0SBv6q3DnyPlT5pgd7TczXGPo/uqFpbclUYa6F
	Hmm79R9BVb5TgJ2wdXDlSRJPJfT52o/6LNmD
X-Google-Smtp-Source: AGHT+IEi36KxTazXE8CDBrDQm/q7fEI/7pb/Q2g/hlXNy8BofChEJ8VugW5X6Z9eFr6mxgqr6wB6sg==
X-Received: by 2002:a05:6a21:3943:b0:1e0:cc01:43e4 with SMTP id adf61e73a8af0-1e1653c8321mr14831227637.27.1733406488420;
        Thu, 05 Dec 2024 05:48:08 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a904fcsm1275989b3a.122.2024.12.05.05.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:48:07 -0800 (PST)
Date: Thu, 05 Dec 2024 22:48:04 +0900
Message-ID: <m24j3iw8a3.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH v3 05/13] x86/um: nommu: syscall translation by zpoline
In-Reply-To: <e0babc622127a88880460ecc129b907ab6d00940.camel@sipsolutions.net>
References: <cover.1733199769.git.thehajime@gmail.com>
	<02330ee6c6676cc2f6501ec78f3a1f448ba1d3d6.1733199769.git.thehajime@gmail.com>
	<e0babc622127a88880460ecc129b907ab6d00940.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_054809_517920_640947A6 
X-CRM114-Status: GOOD (  10.63  )
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


On Thu, 05 Dec 2024 01:37:42 +0900,
Johannes Berg wrote:
> 
> On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
> > This commit adds a mechanism to hook syscalls for unmodified userspace
> > programs used under UML in !MMU mode. The mechanism, called zpoline,
> > 
> 
> I think you should just leave this out of the first version entirely.

okay, agree.

-- Hajime

