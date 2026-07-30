Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536A8C55165
	for <linux-um@archiver.kernel.org>; Thu, 30 Jul 2026 12:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G9dBsbHFtnsoPzu1y2fk+jp8KXfdGqzJ6CGDLwjFSLc=; b=qr6wxZPmL+sth9iTZs6Sj3LuY6
	olLBR1YFDNVp6hhe0vmtzvFWMe4iQoaj4LycbooQg64sEB1YDLsaWQZunMkMnTBaFIsGFc3tM0AVt
	oHe9cvOOuEcR3it3UyY4kpk5WD+zeyjf2Fv1lYrLYSdUbni0kwTF1Rbq19Y6EjeDkNUur7X1BahQs
	H3d3lGopCSWBA6aWDmlAQxz7m1bcW1ZhBjRe5xHGE+roVEPpK62GcO+2kwwS8TBEF9ZbimaoVlC9l
	Tq5QEK2iAC1XDSGFw7spJ4eNmn9+zprB7iTbsYFCSVoj3OVtjmmvshRLN5oe3hogtqVDWg86x/Cmu
	BTa1tRTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpQ2M-0000000AULQ-40CC;
	Thu, 30 Jul 2026 12:38:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpQ2L-0000000AUL9-1v8H
	for linux-um@lists.infradead.org;
	Thu, 30 Jul 2026 12:38:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CA4634038D;
	Thu, 30 Jul 2026 12:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F08F1F000E9;
	Thu, 30 Jul 2026 12:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785415136;
	bh=G9dBsbHFtnsoPzu1y2fk+jp8KXfdGqzJ6CGDLwjFSLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=szfeQsL0GjeRmU7x5/3KTNo6HFlRs/BtXNMvrSP65YMLUuEc962xADY1zoWj067tu
	 jfNFsES8WDbUV6dFd8TlW0/QuBOlDrZVzHzs6yJL+HkOmB+cI752BZWL00J8TXYJqp
	 pPtL0COPn6RiXhRkq3RmgiHODZLszf107/LU1d40=
Date: Thu, 30 Jul 2026 14:38:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH stable 6.12 0/9] Kunit backports for older systems
Message-ID: <2026073005-release-puzzling-8f07@gregkh>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
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

On Fri, Jul 24, 2026 at 02:41:10PM -0700, Florian Fainelli wrote:
> This patch series addresses an issue we encountered on older Ubuntu
> 20.04.6 LTS servers whereby running Kunit would not return to a prompt
> and it would not be possible to Ctrl-C the running session either.
> 
> Benjamin Berg (2):
>   um: Set parent death signal for winch thread/process
>   um: Set parent death signal for userspace process
> 
> David Gow (1):
>   kunit: tool: Terminate kernel under test on SIGINT
> 
> Shuvam Pandey (1):
>   kunit: tool: skip stty when stdin is not a tty
> 
> Tiwei Bie (5):
>   um: Add os_set_pdeathsig helper function
>   um: Use os_set_pdeathsig helper in winch thread/process
>   um: Set parent-death signal for ubd io thread/process
>   um: Set parent-death signal for write_sigio thread/process
>   um: Preserve errno within signal handler
> 
>  arch/um/drivers/chan_user.c            |  2 ++
>  arch/um/drivers/ubd_kern.c             |  1 +
>  arch/um/include/shared/os.h            |  2 ++
>  arch/um/os-Linux/process.c             |  6 ++++
>  arch/um/os-Linux/sigio.c               |  1 +
>  arch/um/os-Linux/signal.c              |  3 ++
>  arch/um/os-Linux/skas/process.c        |  3 ++
>  tools/testing/kunit/kunit_kernel.py    | 39 +++++++++++++++++-------
>  tools/testing/kunit/kunit_tool_test.py | 42 ++++++++++++++++++++++++++
>  9 files changed, 88 insertions(+), 11 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

Many of these are not in newer stable kernel versions.  So can you send
patches for 6.12 and all newer branches (i.e. 6.18.y and 7.1.y) for the
missing patches for them, and then resend this 6.12.y series and we will
be glad to queue this up then.

thanks,

greg k-h

