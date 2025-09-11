Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC6ACA1016
	for <linux-um@archiver.kernel.org>; Thu, 11 Sep 2025 04:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yPYJyXQcMkLEdId7BxO4MJ7oFM0qGRofBwW4YEW5VjQ=; b=FZOsSJERdDZqvS6JR6uUhhV9Jh
	/5dEOHZJloUdtJDr/gMsbYQFE7ZJZWtFcfr7fKHfts36Y+zFZ0kB4HwawnjmOOaqYz9zrNZ8YeFEx
	fm0u6hsaEXNpUbEoInTxvWuX/xFkb5MYNkmDSZy/A0gLKNIvs6NaU4NsvVjM1a1JSqgNjvLEXbcT/
	jFNc84aYNHYfs9v28cHkn+eJECcSOH0ltwOsovINnUP06fskInfUpaH+vBMbGvYxGHzr6wajA36mO
	9iHYnwCE0z+S80pvYf8KvxtNJ97CRcotJJW+Gzf0sZ9cX//RpOJNflcUm0316No6X3wbABYqYgiHJ
	dB1MMU3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwZ1Y-00000000pTH-3A1X;
	Thu, 11 Sep 2025 04:35:08 +0000
Received: from out-189.mta0.migadu.com ([91.218.175.189])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwZ1V-00000000pRs-2s1l
	for linux-um@lists.infradead.org;
	Thu, 11 Sep 2025 04:35:07 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757565303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPYJyXQcMkLEdId7BxO4MJ7oFM0qGRofBwW4YEW5VjQ=;
	b=K9D0Bo/OgRTbfllmu4hqFXliRcKyLmmK+1mGlzxGgDMWOvtLZnfGWfRXyi3JWN3hk7cFLy
	lbfaB9oOodE6kWymnrpCc15eEb3PPK8QEsM6Vxk5LjH28y2/ltGw+RPnuhD9MtxpO/qL4Q
	B8hWt+ccyAidGkdy/VaPNkEirN9jfZ8=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
Date: Thu, 11 Sep 2025 12:34:34 +0800
Message-Id: <20250911043434.2897892-1-tiwei.bie@linux.dev>
In-Reply-To: <f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
References: <f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_213505_874943_A8D18345 
X-CRM114-Status: UNSURE (   8.63  )
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

On Wed, 10 Sep 2025 14:15:28 +0200, Johannes Berg wrote:
> On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > 
> > Turn signals_enabled, signals_pending and signals_active into
> > thread-local variables. This enables us to control and track
> > signals independently on each CPU thread. This is a preparation
> > for adding SMP support.
> 
> [...]
> 
> > +static __thread int signals_enabled;
> 
> How much glibc infrastructure does __thread rely on? More specifically:
> Some time ago we had a discussion about building UML as a nolibc binary,
> what would that mean for the __thread usage here?

We would need to parse TLS data (PT_TLS) from the ELF file ourselves
and properly set up TLS when creating threads using clone().

Regards,
Tiwei

