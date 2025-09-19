Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B6DCAC59A
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z9HQEie4yyR1EvlQG0pJEaoVYImYR1NNOaRDN3iYsdg=; b=U6H9DsIePGVH6mw8uQsfWBSqPw
	5nRQ0PfpznedHEx/kWjuWZ6+lg901VQJOfM0YhFh+BJQCUKFWSOa/LfJqd+/jIe4io2CT8xlWor6c
	curYbJ+NkxBetAjtDur4sOy/RUpvM+KkhQg2ULkt9fAr8Z4vuQE1iuB2u27lx/YCZDxoS3e/rSjGq
	T2naQkTpdXasyemgUSH63hXVZ4ZgR1xJBMpsaAamXP0oc0nAXlyYRMYCbouZUejnAWZsouxC/Sv6q
	2gytIXCZvura5aowGM4OXGGlHCb9qBMgHLyqLqAp9OUZDQ/3PdfiDJb/a869XV+7Q+2HaqwplBd7z
	R7Q1K14A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzdE1-00000003NO1-062d;
	Fri, 19 Sep 2025 15:40:41 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzdE0-00000003NNn-1nR1;
	Fri, 19 Sep 2025 15:40:40 +0000
Date: Fri, 19 Sep 2025 08:40:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
Message-ID: <aM15eChUObXfxLzs@infradead.org>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
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

On Fri, Sep 19, 2025 at 05:34:09PM +0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> This patchset is an attempt to start a nolibc port of UML.

It would be useful to explain why that is desirable.


