Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E52ECA5FC5
	for <linux-um@archiver.kernel.org>; Thu,  1 Oct 2026 01:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:
	References:In-reply-to:Subject:Cc:To:From:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v6sl/0R+rB68lGY0FGguwPrnWxhGA/6NlVevSXWfXMc=; b=qA9MAZNj7IU/Fr
	j+rruDy57KtY9jdn2Rr7LHAaPIkOiMONZ6ZPITnUmcNqbAVVJ2+fYLLbcG95yx0OL5L6epcSA6Atd
	TGyHCAW6DLkIMpTRrDqTygMn0pcYFvwCIjeTFp0zCXl1ngtMBHuqtxbrJZSxV5cG++UManUne5tAA
	h+zgPMsSNWj0emN8CcRpbFmbNimA8Jwkm5r3Jh1sJJvH7KLhKUgH+55OVK7ydlkmKRNx0c6dpNjIk
	NMV96XLr/AT1lQ5e+6viEIKnfbOwdklZxktbnYyUzY3iXf3jVjytqQuFk+GoGm18HgGdb8X6UhKRh
	8Mac3ixuYLNiyRzeX6EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC5eo-00000007Zja-2G4r;
	Thu, 01 Oct 2026 01:32:22 +0000
Received: from flow-a1-smtp.messagingengine.com ([103.168.172.136])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC5ek-00000007ZjB-3TuR
	for linux-um@lists.infradead.org;
	Thu, 01 Oct 2026 01:32:20 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id B6867138013B;
	Wed, 30 Sep 2026 21:32:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 30 Sep 2026 21:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1790818335; x=1790825535; bh=v6sl/0R+rB68lGY0FGguwPrnWxhGA/6NlVe
	vSXWfXMc=; b=dU+0WpT9ayrHlXGiw2fE7NtD4nUKlPkDDP3/RGUUox8ZXvJoUQo
	oINwTLuzSo0Zg9v+dfBIplaHyARav2Mu8lCTqCAOo96G8RZvfBJi0GOymeRhi/dI
	f7XplgGDzIDMI1NiNvfl0Zh7g8pAGXhSyOM2ZuxW5gpn9bMfnBKntlbG0GmOil2a
	B91sBRg0ZDavly5kGWDikF89yurM2VpKV4qhOtg+jwnmZhRe5eEarAe582USAxvq
	3TpRvW/dssTdCeqkSWOs6STZvipHkq3bwiSYuWKRV8gjPh+rQa+uxuUeDyyZW7OI
	yaHU7NrMF786oNViHGBZb+A/zmB/ZU28Rkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790818335; x=
	1790825535; bh=v6sl/0R+rB68lGY0FGguwPrnWxhGA/6NlVevSXWfXMc=; b=n
	ykSWi/sGd5gvCHPUtRxJkK9qcoysaAZwvGnmOCwOtaQRRj1psP/USs+V1s3CCE8U
	bGXX2E4xnMQU2eypDh/nQ4BVxOh/jB80ebnekbDY1oAa3240VyEwbSN+2nHiBQg7
	kQTEDfjMQuCTtO/5lEEZqtGJvdfezRH80tHfoLaAYyvbV1vxa0wXlsMv0CSzAF1W
	IzJYOjwhvjlayK2Cce3kxXooukECSCZ8CEO+QC2UTlLIWfL00oyTSCyqiKtquJWR
	WNVkaXGTVvKYZyu/rAoJrUdPgNYilg28OA2T/F7ZfmMU+EBPOcfIPiXJIyMb+g3q
	Wd07JiigVXT8DStdGxSBA==
X-ME-Sender: <xms:Hbi9amRCw_kioWSBEhgnA4y0lG82UU2w07EeZKMs03XSK3bOCXF6nA>
    <xme:Hbi9aus6-sF1IYxOKWGWnSJ7esBELFJJ4RjqP7pbXWzuyw9SfNidEdevmUe2qrpPT
    6dBXtg9wpG_1KbOWHqWu7HcbCJn4x4SjDV-rfvmQFhNcSZy2pY>
X-ME-Received: <xmr:Hbi9asCM5t-3GQu68lUW4pPb12EVK7ZfxE5JiCn0jxXqtLlyltpHLJofGBy1_PCWUyE0cOmDB2n7mv8cveU-5a6ZpaCEunk>
X-ME-Proxy-Cause: dmFkZTG3KGb7tHgt4XbEdgaBbvRJJoXDWpMAFSGKnPa+FGRadeoOBQt63/9dFXh0uDdMHQ
    4iJ2cIgUNrLNuACkoRhTc5qxpMylSF3jV7QyvProt74YjF+kiQqUTZdmWNsWacBqmWB84K
    veH6OTbRcmsBVg1Wf2i8FMyZzc1eVaa+pkZCjnSlhdl4PlH1TysaXJbsGByCtBTH+n50BB
    bcLzTEbkv5u2szZE2cmghDoJokPu68Cm+X2VRhSm6wIj0B+fmNAmOyZWU4zuUgOTHOSYnY
    8OFG6vhsXQdCgKC6M6ZLdbcYz18tGTjcRhbAFMqiExh5vytioSAFh0IWdadZHBY/Q+YJsA
    ln/MlFLYMsinjIw+1kmsqp3DVjRD4Hn+KNat7h1gnG7JekPoGkqrnYyrqPZvn6fiBKUpEn
    0MDVBje7PRDGze3i9HFtvY9bUZlsY71046ZeN38zQq5h9E7XluoSZIuDT7WpQG37GNp+rF
    E1CpBcw0zc0B9qZwbqQWwlUygDW1onMVM0VOnhrcnxwCQ59RFCVQsv7t2U3/QMSCzEuWaX
    d8tEmDr4x0aozLp1DyF/IIcp6jGB2ETbZsjzbcpG3jEdtniaAruC9emGU9rvRatKlLHGfb
    RQr8YBl253XGkX0sH1oOBGWWEx8zXBUrG+J7MHy/si5zIydG76lUiyz2+k1w
X-ME-Proxy: <xmx:Hbi9ag0SmFUKJA6pqZNzQM73oSQuOS6JxCjWZ0qnhOnwy_oETfCYIA>
    <xmx:Hbi9auS6xhgyi0kKzqyjeQGXMDAuEAIZaJqH5HhIKYcDW6E6NgAWjg>
    <xmx:Hbi9avuA45NcxPmR8CruuVNHR7uHKgcEa3khA2ZaZ-H-_VBIq3pJvg>
    <xmx:Hbi9au6JtIyHmLZ0gH6zRoBQAOTZdhLvdp4YIL2YSwaLGMgSKC6big>
    <xmx:H7i9aqETvhFQVYysvlbm8o1zdHJwYsBkfqktEGeP4RoZ9q8OaxtXJYbM>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 21:32:05 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>,
 "Amir Goldstein" <amir73il@gmail.com>, "Kees Cook" <kees@kernel.org>,
 "Joel Granados" <joel.granados@kernel.org>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Breno Leitao" <leitao@debian.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Jan Harkes" <jaharkes@cs.cmu.edu>, "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Hyunchul Lee" <hyc.lee@gmail.com>,
 "Carlos Maiolino" <cem@kernel.org>, "Christian Brauner" <brauner@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-um@lists.infradead.org, codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
 linux-mm@kvack.org, ntfs@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/7] configfs: remove d_add() calls before configfs_attach_group()
In-reply-to: <20260929050739.GB3909609@ZenIV>
References: <20260929034158.1455429-1-neilb@ownmail.net>
  <20260929034158.1455429-5-neilb@ownmail.net>
  <20260929050739.GB3909609@ZenIV>
Date: Thu, 01 Oct 2026 11:32:02 +1000
Message-id: <179081832202.37859.12981680448323688912@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_183219_166221_E607360A 
X-CRM114-Status: GOOD (  13.27  )
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
Reply-To: NeilBrown <neil@brown.name>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, 29 Sep 2026, Al Viro wrote:
> On Tue, Sep 29, 2026 at 01:36:04PM +1000, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > These d_add() calls cannot be necessary.  The inode given is NULL so all
> > they do is attach the dentry to the hash table.
> > 
> > If configfs_attach_group() fails, then d_drop() is called so the dentry
> > will be detached.
> > If configfs_attach_group() succeeds, then
> >  configfs_attach_group -> configfs_attach_item ->configfs_create_dir
> > must have succeeded, so d_instantiate() will have been called and the
> > dentry hashed there.
> 
> Neither in mainline, nor in -next...

I guess you are refering to d_instantiate() not being called here in
mainline or -next, because it has been replaced with
d_make_persistent()??  Sorry - old commit message.

> 
> d_add() _is_ wrong there, but this is not the right solution.  What
> we really ought to do is build the subtree first, then either dissolve
> it (without any pathname resolution having ever seen it) or move it
> in place once we are sure that everything worked.
> 

I'll just drop this patch for now.  I only want it as part of
deprecating d_add(), and that can wait.

Thanks,
NeilBrown

