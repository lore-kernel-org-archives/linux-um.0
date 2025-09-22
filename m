Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222FFCA100F
	for <linux-um@archiver.kernel.org>; Mon, 22 Sep 2025 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=62BWT+ChZietzG21mZwYd1nPiVzg6h9wIs2Www+JfAc=; b=urJcphdHOaW4ZwTrYov9jHgV0w
	uFkUWOoBjOa++KueQXBRq6DfA2xuhqvQGyHRg4a0quJotSTx/TId1cCP2/AQBXBdRZs7otifmEZ2A
	gcgCqiCUN/KCKTuM4RecIPXMkGEmaK9IUN/3zk5mReA/tnZGrFjYMii4TuKsOtC+OD1evCpqLMNAi
	VPbOwIrL8xvin6U979j9GcNvJd+MoMjpcSPBN4shJ6FrKTqQTzboKjIX8RolArUkDUk6w9154XGuI
	R7/IpkYsGa8cqx9LlGx16D9OdHoIK3BBeC7D59zZ5JJdyQDrw8+3oBLFzGCWWEJAFzPIWjDeej8W+
	EoJvcpeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0laf-0000000BHhd-1CXj;
	Mon, 22 Sep 2025 18:48:45 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0lac-0000000BHgF-0lN4
	for linux-um@lists.infradead.org;
	Mon, 22 Sep 2025 18:48:43 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so4736408b3a.0
        for <linux-um@lists.infradead.org>; Mon, 22 Sep 2025 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758566921; x=1759171721; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62BWT+ChZietzG21mZwYd1nPiVzg6h9wIs2Www+JfAc=;
        b=JWcJTHTsWt8Yvx6hjFdIuCZUysOcXhr2Hu4243UOqK1iprLIubO+8D/bN8/3IRjJcg
         jNlDApl1igN81Jz1oNAIn9eF2ezj98vCuzIDpJvvarnaktgva/ZjE8/yFENUyUG31dTd
         qNfoQlC+AkFgOvWOcY2qA7pGv4B1wU3L+sFjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758566921; x=1759171721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62BWT+ChZietzG21mZwYd1nPiVzg6h9wIs2Www+JfAc=;
        b=lKST2LDHmW2p4OUVu7PtKo+MiCb2bPuuUN7u/a2LeCHsBBeSh0yJWnyMpA2hRDniqb
         uXdPngdMkIHbQ8hmjHRpzcDJJVZKRJ5hoysxQD0FWltg0Z7q6AfBbrHmfZLKw9S/kRKs
         tUKO980ytiiLgMSlbOsLfX20X0VIbw+uMiyL9xhSE8uAzGpp9DLEpcSPSoMw9mJtkOkW
         I9YD+jI5u0IO3CQkVg5F//SUDyJxCzH07JY4vt8M03XZZojKSdtkYKBPl7nWjp78aCn3
         7DovgNRb3fOsj5B2M0KvqNNZUuefRnuxWDtliUk6URVm/lOCzManoKMvlP6Mci/xh9pv
         S69A==
X-Forwarded-Encrypted: i=1; AJvYcCUPorpWu6eDRh7YgqjgSlcDUIBD3bWSvENbpN3nCxdC93K1cdHEh1B0S+JyttlPF0mfjAU9M5okMg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yydg1ulJfPAlgK1KeC9PZbdjuEl1m1Vd2uuhnV18nYPNoqAaJkC
	I+We95tkYMOu8b5nLJmvNnr+otRBT4xl3B+nw3rtx3046CGhLT9UcAeLQgJ00GkoUQ==
X-Gm-Gg: ASbGncvc2mgWBmsY/5ETzL8C8AlsNur82o5eXMfQbBbrvShUnWdt1y1qeii8C9F3NXh
	T7f/TWla8bv0Y0zUXM06m1KOYdHlk1iGhhNRNmFFeSf0PNQW7/3jl2L6ACGC6Tt2hylMB/xDfcK
	k3V84PWxZOy4hu/VRyW/mvwx7D/PrQNqvmXhEzsf56c9aW2HUmJbGt9fx/lDVtEhxfFg0cQWnhs
	R43s30mgiFVQGfo8B5/w58Myxz0jtjCu4MZ/x+kj4xH1xSX8RJmzxSiv4XAeRr2rahrGX2fspj8
	3DCj3cf25dftpouvTDw2UPB/TqhVdwjn15lNomonOqNjv6/SEYZlr0qtDlfP5Gy3SuFzBN9h7J+
	dbFxuT27NarKG15Jy91RC3NF1exCaMKmJF/MgyPNq83jutNoRox8WnZ/lH6OU
X-Google-Smtp-Source: AGHT+IEwQZB9OJP+yIk47lHkNRnpblDU+mAiC3pniWHHE9+nReBcI884SHHQG9F+tJn/QrVZqfu7fA==
X-Received: by 2002:a05:6a00:390b:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-77e4cd35838mr16708833b3a.4.1758566921098;
        Mon, 22 Sep 2025 11:48:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f126:ac9b:b8ac:e280])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77f34d416a9sm4169794b3a.101.2025.09.22.11.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 11:48:40 -0700 (PDT)
Date: Mon, 22 Sep 2025 11:48:38 -0700
From: Brian Norris <briannorris@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in
 modules
Message-ID: <aNGaBiUOb6_n8w8P@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <aMgZJgU7p57KC0DL@infradead.org>
 <aMhd4REssOE-AlYw@google.com>
 <aNGR0x185VGHxSde@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNGR0x185VGHxSde@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_114842_343724_1647C18F 
X-CRM114-Status: GOOD (  13.40  )
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

On Mon, Sep 22, 2025 at 11:13:39AM -0700, Christoph Hellwig wrote:
> Controller drivers are a special case I guess, but I'd rather still
> not open it up to any random driver.

I don't really see why this particular thing should develop restrictions
beyond "can it work in modules?", but if you have an idea for how to do
that reasonably, my ears are open.

> When did we allow modular
> controller drivers anyway?

An approximate count:

$ git grep tristate ./drivers/pci/controller/ | wc -l
39

There's been a steady trickle of module-related changes over the years.
And several modular controller drivers predate the
drivers/pci/controller/ creation in 2018 at commit 6e0832fa432e ("PCI:
Collect all native drivers under drivers/pci/controller/").

> That feels like a somewhat bad idea, too.

Any particular reason behind that feeling? Most other bus frameworks I'm
familiar with support modular drivers.

Brian

