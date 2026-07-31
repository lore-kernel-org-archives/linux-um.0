Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8571C55167
	for <linux-um@archiver.kernel.org>; Fri, 31 Jul 2026 02:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d9qrK/f/+MLuISmePFKu73yneVXZg9cnhjUQC4CDVKM=; b=iZ7SoqVWYNPxzP5OEPfQXilrz5
	rBJSH9+1dr6wYK9YxxrhGhVpa58PrdK8J3Zs3F42CFq/QA+bEnNJmdCPCx9XdCVEGjmDc3lfraaXw
	UWuNnRlbIT0kCF5iAQMPczAtPju3U+pWnSar9+IMja0I3ZPnBtq2hgH6112wCOksoGg8UNfKh7ulZ
	sTrsLtcaR8uKoLnBazIow3ux8N/41qeyk60hHJ6xTGi+2QCdpu4gFpMgfXSp+VoeBMTc+lXD/c3Cq
	wTY8A/MEW0yoj+ATaakyHcQ2GtMRGi1p0pHo+feySTDkG5tBE27vxdWDViNrv0+H9AMy4A4D4tjIy
	bZhvaa7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdAD-0000000Bdj0-0F60;
	Fri, 31 Jul 2026 02:39:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdAA-0000000Bdi6-0xf8
	for linux-um@lists.infradead.org;
	Fri, 31 Jul 2026 02:39:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A557243724;
	Fri, 31 Jul 2026 02:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60BD1F00A3A;
	Fri, 31 Jul 2026 02:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465593;
	bh=d9qrK/f/+MLuISmePFKu73yneVXZg9cnhjUQC4CDVKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZhcuieoZtziFBG/PnK4+5MctAvtwzlDYnO/wLtsfWgxcA2y+zd6vHwtBwSP4vnNhW
	 SMetTTWseWh3EJbYlmxf+mOkQjfTj2/4RWUrUiFm1lokpfdLxk+32RYfGhCJl03j2T
	 roZGUptz/aUUhSxBC+NbWa1L3f6kEdmerAGS1GWxL5WEHZEoAgyvrA1hWLT3Tb/L3B
	 tVBEU5NgbELWYd6BUSRcAL3qL1HxQTHeODoI7lROGpExFAs78T9F4vTdgBpfgDW2YW
	 PmCZg5oR/dRCfUVTgkmQJmg6/970z5rDeR3PXstZSxxJyTARces5mCDK/xJQ8Kv1UX
	 W4OFmMbVZd/tg==
From: Sasha Levin <sashal@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable 6.12 0/9] Kunit backports for older systems
Date: Thu, 30 Jul 2026 22:39:45 -0400
Message-ID: <20260730203700.stable-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026073005-release-puzzling-8f07@gregkh>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com> <2026073005-release-puzzling-8f07@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Thu, Jul 30, 2026 at 02:38:42PM +0200, Greg KH wrote:
>Many of these are not in newer stable kernel versions.  So can you send
>patches for 6.12 and all newer branches (i.e. 6.18.y and 7.1.y) for the
>missing patches for them, and then resend this 6.12.y series and we will
>be glad to queue this up then.

The gap is smaller than it looks: 7.1.y already carries all nine
commits, and 6.18.y was missing only two of them, "kunit: tool: skip
stty when stdin is not a tty" and "kunit: tool: Terminate kernel under
test on SIGINT". Both cherry-pick to 6.18.y with no adaptation, so I
picked them up there first rather than making Florian respin.

With that done, queued the series for 6.12, thanks.

-- 
Thanks,
Sasha

