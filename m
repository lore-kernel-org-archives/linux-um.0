Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78879CAC5B5
	for <linux-um@archiver.kernel.org>; Mon, 29 Sep 2025 08:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5RLyKFm4jgkZLyCw57ehihBsj/peM8c/q1zO/wcZ87g=; b=VSms0lDkUNFtFv7XiEcx5yNiR3
	Bw7zUfBT2HD5yh/IetPnlcnqHYNUbSWEnxgPnvQ6HnJfpshcEmWsUvxh0OJey3VQ6x+4b8DQf/eOg
	GAsSc1NlHGc8Pvi2dnro3lPDTPtyobEh+UQCqkBgHGxNqmVH492cEyHmtNQPgyPcD7eKzOb5gNQ1n
	TCCZ0203QjzJ/uQJ6FqHLEPeVimFQ9HUFJXLZa+QyGbZG2tLdlfA+ZriCsaC3yaSdxVnoQ+yd8Zul
	ER7cFd+NLvZU2+epDxdzmwDsyk4fN7Ywk75PpXR9nBQj35s/D+i+AZm9EQvbCGL7Upj0yn1NLqQZD
	CNde34MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v39gQ-00000001qev-2kDI;
	Mon, 29 Sep 2025 08:56:34 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v39gO-00000001qe5-1y6t;
	Mon, 29 Sep 2025 08:56:32 +0000
Date: Mon, 29 Sep 2025 01:56:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <aNpJwH1gSZFedysz@infradead.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <aMgZJgU7p57KC0DL@infradead.org>
 <aMhd4REssOE-AlYw@google.com>
 <aNGR0x185VGHxSde@infradead.org>
 <aNGaBiUOb6_n8w8P@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNGaBiUOb6_n8w8P@google.com>
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

On Mon, Sep 22, 2025 at 11:48:38AM -0700, Brian Norris wrote:
> On Mon, Sep 22, 2025 at 11:13:39AM -0700, Christoph Hellwig wrote:
> > Controller drivers are a special case I guess, but I'd rather still
> > not open it up to any random driver.
> 
> I don't really see why this particular thing should develop restrictions
> beyond "can it work in modules?", but if you have an idea for how to do
> that reasonably, my ears are open.

PCI Controller seem pretty special in that they provide infrastructure.


