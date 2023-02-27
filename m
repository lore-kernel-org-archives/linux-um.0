Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F982C64ED8
	for <linux-um@archiver.kernel.org>; Mon, 27 Feb 2023 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:To:From:Date:Cc:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4MkO8xqTRGobwFGbOc+ZCfDyqCTdA62AG0TPU8DbPDU=; b=h9kx3ThJ4Tz9hs
	Q8xb9VryZS2Jodfz1W2rib+LGP0V69T5gjLk6JShbgSCzpmzvifMxNCXt0W38IE9pI86yj9Pul/oO
	fxW/KbNfr0Ob4ufCHUhkTR6uEBasMk8Lt1vXkzC2Mm4R9oxBRCaHlB1SzdplxWpMPglOPz8Z6jqS0
	8fGNhsJO2cAKvPieTYR8i8aPGzo2qoaqnEigP9lr3KDLVSJSQeXNB7VqDm3Bvzd9gyrThsYL8wjtn
	3hkCSwx7WBL0jwCLlTeNmSn8yQMlDpYACmRqZ/xQgitB7k3amjLNb52cMvHj2PxKWnQujbnDPPUns
	nktnWGhBtHlfDzAYJkZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWgRk-00ANMV-C1; Mon, 27 Feb 2023 16:33:52 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWgRe-00ANLo-Dg
	for linux-um@lists.infradead.org; Mon, 27 Feb 2023 16:33:50 +0000
Received: by mail-qt1-x82d.google.com with SMTP id cf14so7257604qtb.10
        for <linux-um@lists.infradead.org>; Mon, 27 Feb 2023 08:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO1BewIO9wF4vZTeiZCN+H0iQuU8XwUu3hs7G0qd8OU=;
        b=UjNi0yhKEx5ozGAzQSai93xMxVZa06WXaopHLa4Zds8ihzsZNBLQeO50G9F0ymQvXv
         Dy0Z/Fyh7f1+bmUYoy7LAoSa9xhDza2N+m13mhNskPA02ljAx/ekfkbTxOBtJxnchncr
         xsao1pNLHKVMgvzy4e+61WxgIq3MbZTyReAoddo5ce5vBk0sIEGQQpUthZ9HhSYltVP0
         qp6o/qsDPiqFumC3asfCAWvyD9ag/Tg3T98QxASkgjSEAYx4ddzbMSPTc+W4X+harf4v
         Jk5eH4R9SA04RwWZpmX24SDU22+m+hdkyxtPqN24N2mlvX3/1MHyn2AEGwQZYJvFxzuI
         udBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nO1BewIO9wF4vZTeiZCN+H0iQuU8XwUu3hs7G0qd8OU=;
        b=rclpImbWeXK4oSix81e3gyFE32/E9mw8IN71pCdgsUstqBI+OybA+kBuHZWW43lJqT
         0MzTlcxBnc/oCaWrTIxaGnh2V01GxpNd6iptW4J+H1jqTCRFaYgHTnKcfjUMx0xd4Yj9
         NSh40eB8mJYj/bIZxh5q8qOJ958l+5NoiSubfxGFyore/YfDB+HRXDIOCZkZ9DqUp0eM
         amMi+RFtSZfJe0CFo2Y5uOx5ZlcFmhuCV3pB/AJNqj5hkUcK6CeRm4wBLoMnHIL9Xyxl
         6Py6OW3kaslke7Akn1bobuXCjB3FOUxC37D+7uB4EHEhnWCDobzYXBQPWaIisGnthByM
         7jGw==
X-Gm-Message-State: AO0yUKXnUlOkUPUpoYzYn9wsj7qSDsF36F6amHITZFObdUuKvswLgzs5
	AzdxBFqoUghYulwRTSeeVW/MSXRn3tIL3WNv
X-Google-Smtp-Source: AK7set+2pUjk04bGEo2OjWIuEbF+QDshHHqqxp6hJanwXug3UGWzy0GBjDVvjOHyWsHD9nh6IF3Skg==
X-Received: by 2002:a05:622a:15d2:b0:3b8:2c34:b9f2 with SMTP id d18-20020a05622a15d200b003b82c34b9f2mr46060174qty.63.1677515624028;
        Mon, 27 Feb 2023 08:33:44 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8764e000000b003b86b962030sm4869981qtr.72.2023.02.27.08.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:33:43 -0800 (PST)
Date: Mon, 27 Feb 2023 10:33:36 -0600
From: Glenn Washburn <development@efficientek.com>
To: linux-um <linux-um@lists.infradead.org>, Richard Weinberger
 <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov
 <anton.ivanov@kot-begemot.co.uk>
Subject: Which branch should this patch be based against?
Message-ID: <20230227103336.6bd56246@crass-HP-ZBook-15-G2>
In-Reply-To: <20230128014159.1741728-1-development@efficientek.com>
References: <20230128014159.1741728-1-development@efficientek.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_083346_680283_BD7177D5 
X-CRM114-Status: UNSURE (   8.56  )
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
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, 27 Jan 2023 19:41:59 -0600
Glenn Washburn <development@efficientek.com> wrote:

> Let hostfs handle idmapped mounts. This allows to have the same hostfs
> mount appear in multiple locations with different id mappings.

This patch is based off of linux-next in the Richard's UML repo[1].
However, I've noticed that this patch needs some modifications to be
applied against the tip[2]. So I'm wondering which branch in what repo
is best to base patches from?

Glenn

[1] git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
[2] git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
