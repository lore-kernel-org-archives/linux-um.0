Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A1FC64ED6
	for <linux-um@archiver.kernel.org>; Tue, 28 Feb 2023 09:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CMlJEvVEAxQg9tNNNhHx304KDkKVTlb7Ah6N27XZ/2g=; b=bqf/0erN0WJtHi
	xs2fhAcBBbJguAACPRdQNBZNNznR26XDFsf+B+AzmIMy4XYWNsyScrAEAlqbIS8ApAj0dGfmTH3g7
	lZzxwGMrYFQPBVzHIv/XWv+kbtDXNnWPNpEErIvtBmxw70KGWMTWNiqBxQFMtnzVFddpidjxuZWsJ
	nSadM0WeeB6rA8Q+cf/bxgzRRLkscuAqEuMp1URtwN2z7YTUsxXAK0K94RSRDAi9qqfrG2RYufJBt
	2FHDzcjw9nRgR5fJZMyMZZOvw3x2Zm/+h9u7EU8dOx5s3ZUhnxbBEJOK43ZkEoweD9HphVjxwsUSZ
	5jer4icz+P3o0EW8ChMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWvrv-00CS09-Kz; Tue, 28 Feb 2023 09:01:55 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWvrt-00CRya-CB
	for linux-um@lists.infradead.org; Tue, 28 Feb 2023 09:01:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id C022BB80E04;
	Tue, 28 Feb 2023 09:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82CAC4339B;
	Tue, 28 Feb 2023 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677574907;
	bh=bYcDCDy77qFJcdCxv4HOiJO5FetPsxCzJKaqdkfD8j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pt2Zt+Lv4h5IymxrX/ToVlgN6LIsYMTmcx8lO0Tt18G/d8pYqJVeGtPp2qefHc1IY
	 vYJ2vlodzc/wdhnmbjqa1ax4Y73ycGcBsjmxIRCJuX8nqBlUzr2ELndC7WDPaxdvUO
	 EXgWLqSQgkPjpnNLJ3CAnpANLy/CeHf2vjnqm3n/1ApKTrZf8KL7nhWt+8vm/X1Vaf
	 WABiIRyL7sdURTNCUDaZPsZuRU/X0f1PV0m0RM3GTB1JS0VfHhzP3bcvHMX8oE8Hku
	 58Y/+Ijlcv765tN68hvXb9LXwLFeGklM0vYca9HAQ//XlekhzQ/OgSV0PYpuJfcWza
	 wauwY0INQsutg==
Date: Tue, 28 Feb 2023 10:01:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Glenn Washburn <development@efficientek.com>
Cc: linux-um <linux-um@lists.infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
	Seth Forshee <sforshee@kernel.org>
Subject: Re: Which branch should this patch be based against?
Message-ID: <20230228090142.y4dcxxzdkycbyobj@wittgenstein>
References: <20230128014159.1741728-1-development@efficientek.com>
 <20230227103336.6bd56246@crass-HP-ZBook-15-G2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230227103336.6bd56246@crass-HP-ZBook-15-G2>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_010153_597782_1BFA022D 
X-CRM114-Status: GOOD (  12.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, Feb 27, 2023 at 10:33:36AM -0600, Glenn Washburn wrote:
> Hi,
> 
> On Fri, 27 Jan 2023 19:41:59 -0600
> Glenn Washburn <development@efficientek.com> wrote:
> 
> > Let hostfs handle idmapped mounts. This allows to have the same hostfs
> > mount appear in multiple locations with different id mappings.
> 
> This patch is based off of linux-next in the Richard's UML repo[1].
> However, I've noticed that this patch needs some modifications to be
> applied against the tip[2]. So I'm wondering which branch in what repo
> is best to base patches from?

Hey Glenn,

Linus merged my pull request that introduces a dedicated new type for
idmapped mounts into the vfs: struct mnt_idmap. So any branch you base
this on should contain that work. Let me know if you need help with the
conversion.

Christian

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
