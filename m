Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A01CC531F9
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 03:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cA78QBzHmkLvAUUdVIUp/VZli9DJsAoJPO8K/XCSt+o=; b=FnD3a3vpHf5K0b6t6OS33XQE3M
	5OS12gjc5IH4JmLTtJOv4OM/ur/M78OfQ7QWCNUvvr9EOGdukorl+lu/Jx5FFgOe5gnKWPQj2zSBB
	L6UWqBms3pxgmGStlcWYYOtRsBXB3Wz+4P6JWR6o/xBaGy7Efe4czwBroi5DdcIkwM3lvuRMcCCHj
	ZbPM0HcT6Dk/G/ExGT+QNZNPlNKm0ZYt4S84pJrViNb6XzSFWbaAiLspfAqo3XdHtP28hvMsVke3C
	mbMRBrBVUwKURRrtO1Q9ZVQCBQbOz+0A0oRcjs/cC7wlvdexpNAtM2CAlF9IOATJ9iqVJH0w5U9CI
	ZViFtLqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woYgt-00000004Kzq-3Xas;
	Tue, 28 Jul 2026 03:41:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woYgr-00000004Kyv-2Oof
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 03:41:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8775768AFE; Tue, 28 Jul 2026 05:41:05 +0200 (CEST)
Date: Tue, 28 Jul 2026 05:41:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 7/8] lib/raid/xor: x86: Remove redundant
 X86_FEATURE_OSXSAVE check
Message-ID: <20260728034105.GC18902@lst.de>
References: <20260728021603.79870-1-ebiggers@kernel.org> <20260728021603.79870-8-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728021603.79870-8-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_204113_761655_2A39B405 
X-CRM114-Status: UNSURE (   7.72  )
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

The prefix here should be just xor: to stick with the existing commits.


