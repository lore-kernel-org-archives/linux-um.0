Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94788E74AC3
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 16:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G0li6k695CIddnhioEoYM8cVKSKatuM3QM9V/Gygrjc=; b=L9kaAq6NS32Oiwp2i5JMnAT3Iu
	hiyglc1AyjAUr6vEXHdq/qSGsDTVxk5UO23eNnwJApJN9J8z+fhtkY80lnunt5Q8wVnu1AgNBUU4J
	6+NYPjY2ya+XdbgB9F5TwLLotCxdoikmbWk3mLOa1XGBOKGmRsxzjUasOUY+6nIm730K+vg1dlxvB
	JB6IncxvIAU9MD/kQO+QzhQNFJCoLFuOAGgDoOHAkdRTaD5AqgLWVyybD2myrCWCcqiv6DLhqkqyu
	KPOfQhPPIacr3yzX9haeVcJHK/TujgzzMQ+SEy6WZu/vkPDv82iY4TD8HNIbW6FQINMpMeYmxTIao
	KLwDm3Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIWEg-0000000ABZK-08LI;
	Tue, 03 Dec 2024 16:58:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIVGG-0000000A0vf-2NVD
	for linux-um@bombadil.infradead.org;
	Tue, 03 Dec 2024 15:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=G0li6k695CIddnhioEoYM8cVKSKatuM3QM9V/Gygrjc=; b=OURF9ef/CrJly41mr5LzJD6Xlu
	/mNSg5bvdtggrB2ehHLc160XqMts2wQ2G8wSOO7Kt1PcZ81z2F7KMF372m9fM3AKrMZePuAHLYD5E
	a+Bc8aacgnEFp32DJec4gydqP+tZVWNZgD28pOKiBQfUEHiOWHdccf9aU4lJYiEI08kJLwj2oOzOh
	N3vH/xEvTGSeM4F+0DzIYt+Sawwjq/FpQS9eOOaMe9CZSYuotBYYOmKtXrJ165IXXKLbBhmn28Dm+
	XrmEaTV2wwZxug2sQFQAD/YBeWts230pO4hRlKBhh4e4kZnqjFYVuE7vQuNDBNr0QQPrVJGbKp/vS
	4G2vL3tg==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIVGD-00000002Pn2-2Rcf
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 15:56:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 43FA2A41723;
	Tue,  3 Dec 2024 15:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E70C4CED6;
	Tue,  3 Dec 2024 15:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733241382;
	bh=Cd/CwG2ikloaS7+dru5hZXIx4WqkNv4xB4jCo4aiz9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ABfDabbgcGi7hw2OxCyNSs4XMvYcFn+2ncvY5DMcWXC+dCqKWPgmBxHTHG5BOHaOr
	 l0b6htYKVsxXemLzgtGs/mEtZUO4MEhvkpDlxfGtajaDvjPeasfhOJ+RclXtiodRuu
	 QKLooyQFdD+0zINM0y3iA3v81EddIES+IEx9jfhT1qnokIt2AVC7fTDN12ehl/g9Wi
	 MvWjRcH88i4IGeLkW51TJiw5lNH27zROcsK/EXVXpBy7vqIRvxnWBRS9WrjdXxDPPi
	 581tD96uHA+M2TaGIF1fRsamRuAPdGxzDtdftabU8QOuoMzE5DfdfDIs12sY4nKwCd
	 1HBB1GeS6Xmvw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	linux-um@lists.infradead.org,
	johannes@sipsolutions.net
Subject: Re: [PATCH v5] um: switch to regset API and depend on XSTATE
Date: Tue,  3 Dec 2024 07:56:18 -0800
Message-Id: <20241203155618.1510-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241203150021.981-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_155625_838257_EE2AA40E 
X-CRM114-Status: GOOD (  13.57  )
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

On Tue, 03 Dec 2024 07:01:09 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 03 Dec 2024 09:40:34 +0100 Benjamin Berg <benjamin@sipsolutions.net> wrote:
> 
> > Hi,
> > 
> > that probably means the size detection for the FPU state (i.e.
> > PTRACE_GETREGSET for NT_X86_XSTATE is incorrect on a 32bit host in some
> > way.
> > 
> > Is there anything special about the qemu setup or it is just a default
> > qemu-x86?
> 
> I use default qemu-system-x86_64 on my system.
> 
>     $ qemu-system-x86_64 --version
>     QEMU emulator version 8.2.2 (qemu-8.2.2-1.1.hs+fb.el9)
>     Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
> 
> I forgot saying it is not just x86 but x86_64, sorry.

Oh, and seems my qemu has some downstream changes.  I will try to reproduce the
issue with upstream versions and report the result again.


Thanks,
SJ

[...]

