Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE1FCAC592
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NTOWiy5dTMZluijZRXvogpMObctV0ej6Q8JzUqFg6Xc=; b=oaMhsN9MuGVJSyVU9Zzo96vD4p
	GQipxVe1+k7WrJylmGbMsb9mZ5KVhcybHfAtHU+1njk3rnASQ3ZcyKxSCLk7A2XLM2SWqKpcLB79C
	YqF0GieVFzPGUpSwqZRzuL5Rs8vKNIkQ3O+9HK/K5cT6/luovyU7936JOwRAQzO0nY8vVU0nybZub
	C/SJ7Y8O4XElfEDvVaGAsg6HNHXxSx3na764TBnd/H916lxsz7nuAWf++eftyPnlPLl/0KpesEcuc
	GM8LYZB7EMp8/HMwpnVIsDDcNLMa9GOriexslmIEiloQdi/CBvvsJs1pacDspWB2CqP8IZWxhvJf9
	3py25eJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy9ZA-00000004RmM-0XAe;
	Mon, 15 Sep 2025 13:48:24 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy9Z8-00000004RlJ-2vGz;
	Mon, 15 Sep 2025 13:48:22 +0000
Date: Mon, 15 Sep 2025 06:48:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Norris <briannorris@chromium.org>
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
Message-ID: <aMgZJgU7p57KC0DL@infradead.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912230208.967129-1-briannorris@chromium.org>
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

On Fri, Sep 12, 2025 at 03:59:31PM -0700, Brian Norris wrote:
> This series primarily adds support for DECLARE_PCI_FIXUP_*() in modules.
> There are a few drivers that already use this, and so they are
> presumably broken when built as modules.

That's a reall bad idea, because it allows random code to insert quirks
not even bound to the hardware they support.

So no, modules should not allow quirks, but the kernel should probably
be nice enough to fail compilation when someone is attemping that
instead of silently ignoring the quirks.


