Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17900CCFA13
	for <linux-um@archiver.kernel.org>; Mon, 10 Nov 2025 09:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LtzNxvFuujSl2ZQUousbc8JpVz3Ej2RbTQDavZlkAtM=; b=eQ66EstatSQJPbzMa1LAQ7kTlz
	HAnif/sw5X5JlmNX0sbRPVrqiEQwBYfg95mgh9hS225dB/aFIDGtVLDgUI25zCmYwG4gn0qhzCgCn
	tN5t0XH8yni/jTUVkkNe4ATZGhX2Q+I+0AJf8aZ6fXGiIDG3zAw3BUepydDeR7eO1NL4bZ8z9FuCc
	ZdsUQh+thsywe6JIi6jORwgRdJi/7u+eNRtNACxRnNeMu6n5s0JxanxDLcE+19r6vo3a30YadeaXJ
	19wE3HNuZChGMuhj7h3nZFwD67pftUwwpHXiRC/8Vr00koDcFvc3/HCvYMCNGHcOFnk2+DU1VqEwt
	wP41PgGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vINyl-000000054Ga-2srg;
	Mon, 10 Nov 2025 09:14:27 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vINyk-000000054Fz-0GDE;
	Mon, 10 Nov 2025 09:14:26 +0000
Date: Mon, 10 Nov 2025 01:14:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 00/13] nommu UML
Message-ID: <aRGs8lPjH22NqMZc@infradead.org>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
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

On Sat, Nov 08, 2025 at 05:05:35PM +0900, Hajime Tazaki wrote:
> This patchset is another spin of nommu mode addition to UML.  It would
> be nice to hear about your opinions on that.

I've not seen any explanation of the use case and/or benefits anywhere
in this cover letter or the patches.  Without that it's usually pretty
hard to get maintainers and reviewers excited.


