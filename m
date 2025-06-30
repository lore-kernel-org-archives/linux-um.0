Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F245C7EE39
	for <linux-um@archiver.kernel.org>; Mon, 30 Jun 2025 07:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cv5jFCV6649v8T92JDjCzLnbRUBb+ZSyb2iskcXEgiI=; b=l2biG+GhymJGbhUjyw9fgQUF7V
	ZpxuhK2aKPMNX+9pgFMUx8HcLt7d/x4ZkQjjEFnatVco3DJYQEMBVQHJ/WR0Tk5Klcd85/MQ+KmUR
	8/UAL2vzpV/YffeUZqh4fbejE4A6OATqtwSrfheDxJXbrm21uuvAPgF3SDmjtdr0eZSt6OGdEdYbn
	AtrETABtzTIWstFRARXUrf7JXt5NBi0S9c2SlCNWDAXIdVDdSJPFYZMRyVrf2FrVfr3BlKLrR6n3n
	ZXPG8P0kb3GBCj6/lcSWjwQYI7kq6+C0GXXj3RIeFR80EkWyjBct/44DM+tziIr/OQxtmgUF94i1P
	OfdaF2Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW8aj-00000001P4N-3Lkb;
	Mon, 30 Jun 2025 07:06:13 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW8Xd-00000001OpO-2Rm8
	for linux-um@lists.infradead.org;
	Mon, 30 Jun 2025 07:03:02 +0000
Date: Mon, 30 Jun 2025 09:02:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751266980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv5jFCV6649v8T92JDjCzLnbRUBb+ZSyb2iskcXEgiI=;
	b=3+2dPfQ7tbpVGAI70PTpFpOcOtCR0ab0jP8TunCiqfKZKQm8ZSC58eqc/DLg3gVaZMFHzd
	nYJumLVbddzsAScfyENayXXLaVk21dmRf7RqYaTPWHVGAYrgpbK3Npf6OSESTxFwfBrlwu
	mgPPnf4Xf+syf0RmBS/wlh7eRAuqW9mKqjffuznPUFwpAqIbaMs8cQ1bgdztFKKNFPl1oT
	qsNQD1t6TI14jLkNRO1ZKNyH0K+h1v93HEbmDp4k28ef9qDXn7dfcSsmRXXGM8r2UrIDPs
	X2dwULQvs71mVE79ogv4fIYhij9leR3e/Rahc5gDexT1sgT4IA5hgj4MlqVcdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751266980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv5jFCV6649v8T92JDjCzLnbRUBb+ZSyb2iskcXEgiI=;
	b=PdPHjBFFCrcV0zbXN1MAY/71Yvygnof3oUdoz5iVHFpZVxgwj4QiBnOe5CJRxLJpis6qtL
	RWScS2G5qsNHZ5CA==
From: Nam Cao <namcao@linutronix.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] um: virt-pci: Switch to
 msi_create_parent_irq_domain()
Message-ID: <20250630070249.oVVkmFZg@linutronix.de>
References: <cover.1751266049.git.namcao@linutronix.de>
 <5f0bd8e877e7bfdfb1a7e99d6b126caf6a7eea48.1751266049.git.namcao@linutronix.de>
 <e64a4c40b0234fc265a74cb60633117dc6911518.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e64a4c40b0234fc265a74cb60633117dc6911518.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_000301_764055_CCAE4D37 
X-CRM114-Status: UNSURE (   9.10  )
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

On Mon, Jun 30, 2025 at 08:55:54AM +0200, Johannes Berg wrote:
> On Mon, 2025-06-30 at 08:51 +0200, Nam Cao wrote:
> > Move away from the legacy MSI domain setup, switch to use
> > msi_create_parent_irq_domain().
> > 
> 
> Do you want this to go through the UML tree, or is it a dependency
> somewhere else? In the latter case, I suppose you can add

Please take it into the UML tree.

> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Tested-by: Johannes Berg <johannes@sipsolutions.net>

Thanks!
Nam

