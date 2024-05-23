Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2A1C25B75
	for <linux-um@archiver.kernel.org>; Thu, 23 May 2024 10:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=blpZAozQ3ITK7SHWW4E6qfsTgxzl67pxZ/Pvq/s7bP4=; b=pXfSvdGYs/h+jZDKOCZnhLbBgu
	5FOUMiddkIpH11xuPtztExC74yqEG+FSoD5IGIHyOhMN6Z0opMZckIYBN+bVhAwHZC7kIKJKdysNk
	oNFaZtz5DVrWXyoqwe0fsJh+x/jSJJ27/YeSdXeYabSaIUvwlfxUHuiO26NarXAqBOotc13w/toPj
	FTIbo5GHhK2wl8rhziBwsnzEqe5YWE7gntzMRux12s5n4MPoGY+XXR3vhS6t/Gqbt70qMPEl7YWkY
	l/JOsKL22tVc+jEEBzV7BPl1pYaqFaWfNWNi6rZOH8Ew5zTfAlGaL6jLc13gvdlufeYiMwW9TjECX
	UNw4MqSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA5us-00000005vGL-0bzs;
	Thu, 23 May 2024 10:43:22 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA5un-00000005vBx-1Iri
	for linux-um@lists.infradead.org;
	Thu, 23 May 2024 10:43:19 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-42017f8de7aso52234405e9.1
        for <linux-um@lists.infradead.org>; Thu, 23 May 2024 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716460992; x=1717065792; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=blpZAozQ3ITK7SHWW4E6qfsTgxzl67pxZ/Pvq/s7bP4=;
        b=mB3SJUY75mNnBdl/uAfJW3nfrbe6Tdr7Pkyy8QVH6AKQOeAK75tiSE7607Qcpd6OQL
         mBPKGzXs6ugZIMlfSJcsm6BqPENHKtdXrF3ElKz0ddGZL32tXYFWKYvlDZ36YJe5d3R8
         CO1FHmZDVfOCAjuUCmtM3NNp908CNW1p1WVFY1MggTvbENHXcKFAs1E5Y+4eySorHGZW
         LkLV5as/Hfa+K2ScZllN6TtePK2Imcb+uCLP2vOpccEpcSKpS9hJTs9p089hUK9x92Cy
         Jq3iaYIFA/Eiy8sfgn5FuOTznyOlcPPKv9HumGTfbY8eQ92Fm7RmiQOAJ0BSTBxrle3d
         RAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716460992; x=1717065792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blpZAozQ3ITK7SHWW4E6qfsTgxzl67pxZ/Pvq/s7bP4=;
        b=K2llAk8OpxkfwbBqu/8skvbZMCSt3siC42CjzU1qaVPKH80fCUCCSgru8GlRsVow36
         R/JYqkOOaJio/vXnr68o/3McmZ2UskZfZBkwQ3XPdOwCs05IzDOVA3e43Toky+w8D0a7
         3zA5/xenZOsY78An7NZNcZKD5mc2UpIOf1vZ+HU9Dc7Go5OQehGIjB/uXGjuuS8s80Yq
         S7tKf/0ASZc8hLcPQ0QIhbnNX6hljhVfcaNVWMPRPHIQ0oLXGB4OzNw/PDP97ebMBeHI
         GzUuOhDzPFdVSztpJI5tXDb5yv7SUrlVL76nYTIjdKQDFzmX2OncRO7EH3rUJ4YvzmQ8
         1LKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjiTecpsGplY8ktIiwovqowWxtPEURmXlWt++fLHrfib2XL6KB/s7DEyiLTRrdxezG3OxowwHnZiB7sixgTzV/15F3D+uztCVDqsTA
X-Gm-Message-State: AOJu0Yzu18hjzTlYCbI9FK2QRn0nF+SigejtWMEP00019YD9gT7u2KRX
	UX/3bjdhkTcmQvMYyZRm3OV9YBw0+hI61h/TNjXlueXhilt225ey+9SY4Bj6zXw=
X-Google-Smtp-Source: AGHT+IEqmfLIqt+uK/afgKxha+DGnAVwMJxlTN1e6e0x6vAfoT8OIivGDrhmD2js1LqTqRKN+1LR6A==
X-Received: by 2002:a05:600c:1f90:b0:419:f241:633c with SMTP id 5b1f17b1804b1-420fd2d79cbmr41007515e9.4.1716460991618;
        Thu, 23 May 2024 03:43:11 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fad58dsm21528105e9.39.2024.05.23.03.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:43:11 -0700 (PDT)
Date: Thu, 23 May 2024 13:43:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: oe-kbuild@lists.linux.dev, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] hostfs: convert hostfs to use the new mount api
Message-ID: <df349a89-e638-41de-858b-04341d89774e@moroto.mountain>
References: <d845ba1a-2b10-4d83-a687-56406ce657c9@suswa.mountain>
 <74576c52-5eca-4961-ada4-a9ec99fb16cf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74576c52-5eca-4961-ada4-a9ec99fb16cf@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_034317_415627_22133767 
X-CRM114-Status: GOOD (  12.71  )
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

On Fri, May 17, 2024 at 07:21:09PM +0800, Hongbo Li wrote:
> Thanks for your attention, I have solved the warnings in the following patch
> (the similar title: hostfs: convert hostfs to use the new mount API):
> 
> https://lore.kernel.org/all/20240515025536.3667017-1-lihongbo22@huawei.com/
> 
> or
> 
> https://patchwork.ozlabs.org/project/linux-um/patch/20240515025536.3667017-1-lihongbo22@huawei.com/
> 
> It was strange that the kernel test robot did not send the results on the
> new patch.

With uninitialized variable warnings, quite often Smatch is not the only
or first checker to report the bug so I normally search lore to see if
it has already been fixed.  In this case there were no bug reports from
Nathan Chancelor and the second version of the patch wasn't marked as a
v2 and there was no note explaining it like:

---
v2: fixed uninitialized variable warning

So it wasn't immediately clear that it had been fixed already.
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


