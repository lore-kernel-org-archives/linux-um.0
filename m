Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA5BC6FD20
	for <linux-um@archiver.kernel.org>; Tue, 21 Mar 2023 20:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:References:
	In-Reply-To:MIME-Version:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vNX9u5n2c/2x07TH8cKR7RI3+WuF/IbkiaBBw3huR7U=; b=vM0Ys41HC2GPqZ
	NT4K49K2ZisL52cQaa+3XXwSxq8tLCLEeWuI7ufnu+v4LcwelaEB9kvumhNcLSG2aSwkAjgqP20SQ
	f52rX0P8noQ45rmNkQlXoXa5RtO0s6EOIZBFoqpvFInMS0xwI9kLn7CcJIpaoUFrBzFZSCBI8Upq2
	X+OrpQrVXFyzmHy6uOrfP8tBhi1C5sUbNIUxMQEwrudHSxMhlEydNQtB96M6czGpdh89QerysVJF8
	RSrdHVr9sl4xmah728LyeGjJQtn254WWsL8RLjHLU1tXSmT4iWDT708D2HulgLjibWpUEhqXE1BcF
	SnjYs9FNrlxPOY9Q0xjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pej2T-00DlC0-2c;
	Tue, 21 Mar 2023 20:57:01 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pej2Q-00DlBQ-2g
	for linux-um@lists.infradead.org;
	Tue, 21 Mar 2023 20:57:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BCBE0B819C2;
	Tue, 21 Mar 2023 20:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F1DC433EF;
	Tue, 21 Mar 2023 20:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679432215;
	bh=qgNHCadAkebh8+XwXNyHvRzBICpIGss89/yZYgR7dic=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=nzP6F7edJAjZYbEwQbVQWLCYc3HyMeXECVqqzGdpbVHOVXMSIX9PYlwTWai4WhkAr
	 XvCuEhBF/PbBTetnSx9AAQ1gUj426mcEGb+aTek9q7g4ORAZxQ0mJTUrLO+PO686Lp
	 IhED1ev9cMw7wFHQUbTb/WL+BydQhJE4Un6AIVMNEQG3i0+XKeH0jHKW4kLuORi7Wc
	 SFsQG2xeopUpkboBNDdQt3Y03W2MTPI7c04JibwbUrU+PSlAwH6yhuXqeyubp3jSz8
	 G+54EW3RIxX2W7H5CPzzyAKwP4gKdKyAYYcAqvWGH/sNUds8xu7Z4dJBMayhaqRfqw
	 aAszR0TbIeBsA==
Message-ID: <ffd2d079db17d6756a72ae711d6fdafb.sboyd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABVgOSk9gqRe_5yQZweBA2Qg2aGx8rUJtOHywGeT4x7TEyBH0A@mail.gmail.com>
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-3-sboyd@kernel.org> <CABVgOSkomwwgKZ9N0_0YMDL--QaZiTV7ONgSRABU2Ph1Z0CG-g@mail.gmail.com> <a97c9bb3a5addfb34af8ccabaa513026.sboyd@kernel.org> <CABVgOSkJ4mw_DtFzn5EwcsuYixWY_j13YotxEYqWhO+ZCL1KPg@mail.gmail.com> <d64a086ddcb7c5ca5abecab0ca654259.sboyd@kernel.org> <CABVgOSk9gqRe_5yQZweBA2Qg2aGx8rUJtOHywGeT4x7TEyBH0A@mail.gmail.com>
Subject: Re: [PATCH 2/8] of: Enable DTB loading on UML for KUnit tests
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
To: David Gow <davidgow@google.com>
Date: Tue, 21 Mar 2023 13:56:53 -0700
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_135659_045172_FEC0C2CA 
X-CRM114-Status: GOOD (  10.34  )
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

Quoting David Gow (2023-03-10 22:42:24)
> Hmm... I'd've thought that shouldn't be a problem: kunit.py should
> ignore most messages during a test, unless it can't find a valid
> result line. What does the raw KTAP output look like? (You can get it
> from kunit.py by passing the --raw_output option).
> 

I rebased and retried on v6.3-rc1 and it isn't a problem. Maybe there
was some problem on v6.2?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
