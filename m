Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CA3E77188
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 05:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bJ1rQvFWAU9SGSKH7s1SbjVP4inlCelUlRtoueYL/0k=; b=mQ6+g5GERsHTdN2pm/2D417bnD
	0wLpcj+j3NxjHFd2fJY8WELseaps2pfMJRil5132hyKuAN0BsGf+cOaS5TKIGBxdQZ16QCDihMYJ2
	f3O/siIkB2lciX1yZO3/n+GeHr/89350QGZW2Lpj+h5U+RwbCvbtb47l0dySjDrruyMDiK3UAZpY/
	QKWkiIlx9BcYxbZ6ZsB8FAVL8BiElGjlZzn8ah1hdQOEmO5gDNMZGkO8jDFLT+7B/MHD+5NPjT5XJ
	USHOnsSc4uL40NyXfGBMNq3V1g8i+X1oyDGcsbNZckKLJGMhyX6RHMsyLiL+bENQfCB+y1l4qLORG
	w7R/gUug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tW7z2-0000000E6az-3Ibz;
	Fri, 10 Jan 2025 05:55:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tW7oJ-0000000E4M7-2BfN
	for linux-um@bombadil.infradead.org;
	Fri, 10 Jan 2025 05:43:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bJ1rQvFWAU9SGSKH7s1SbjVP4inlCelUlRtoueYL/0k=; b=LGWTuyCeUejobeWpkskRg4rfBB
	fw6kBVNGEZ/SD0TuS2SGSzUubXlxvt/sz02roDZ0mXNKL+KphsVl7OoEkgdRRVtKWslQFsTnHUTPB
	KvjGKCBwSy3JuiQimEM79cVpgsx4iCgtpKkR38b0RICnXLDMCsU4Y9BPaZmiJ73ax9p8cM32Dcq+8
	DsWNSf0/BFKP1LH31N2eNFbdNoSt1XrtmXVM9sbqF9k+YmuMu1RNaUYLNCJud4iZS5/NwiQf5L1ZD
	4wEKVDnnSOPMsJFUF5FsUu6O0ynLpYLg+ZusDTsPxqfF5sm7/K/L+4549WwDhEE3YBLAHjE/+hlNr
	twpNeF9w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW7oH-0000000Bt1r-4B2d;
	Fri, 10 Jan 2025 05:43:54 +0000
Date: Fri, 10 Jan 2025 05:43:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] hostfs: Convert to writepages
Message-ID: <Z4CzmTsAjKtUfu6I@casper.infradead.org>
References: <20241220051500.1919389-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220051500.1919389-1-willy@infradead.org>
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

On Fri, Dec 20, 2024 at 05:14:58AM +0000, Matthew Wilcox (Oracle) wrote:
> If we add a migrate_folio operation, we can convert the writepage
> operation to writepages.  The large folio support here is illusory;
> we would need to kmap each page in turn for proper support.  But we do
> remove a few hidden calls to compound_head().

This patch isn't in linux-next yet.  Any comments?

