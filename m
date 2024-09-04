Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9080CD4849
	for <linux-um@archiver.kernel.org>; Wed,  4 Sep 2024 12:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BOz/B5LRw5R/fHNDhdZrc5T8VI40jqVVI4mlTebzL7w=; b=rw+wyKlul4FHxR1VlFPWouUHBK
	/qbioG0R+lrvkgiCESQPD4TCdIWhTP5PvC3H0f2Xz0CLOO9xtZ9iJsGgetW9heNSDxZg1RE1T9adl
	WypfRba64WctVezzk/rrSpNll/zrsuY3AlguDcl0HGylmUDo89SAmRoJNwp3QLfPIdqTvByxbcD9O
	PxQNUMcKA31OJ2wTzjRkRzIvKxxmn8LdgX+YH0kU9vcWvk0RbLThhph+WisYtU61N5c9ECGq49Vih
	TsXNkM+tlzYs3Ovtsoisip+MNo7/WQd100nEJZjVqtVaig12gx4eOKrMew1gOivkZiLelOtjpsTrS
	qLcyfUdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slp8t-00000004Mk7-15jl;
	Wed, 04 Sep 2024 12:29:47 +0000
Received: from smtpbg150.qq.com ([18.132.163.193])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slp8j-00000004Mih-1cPf
	for linux-um@lists.infradead.org;
	Wed, 04 Sep 2024 12:29:39 +0000
X-QQ-mid: bizesmtp91t1725452913tk5jw6rs
X-QQ-Originating-IP: SaysuuqQVKOz++TcBwpN6cWTk6uo5XmvwZdgQeuDIY8=
Received: from localhost.localdomain ( [203.119.160.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Sep 2024 20:28:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 956775205899086131
From: Zigit Zo <zig@iorw.io>
To: stappers@stappers.nl
Cc: anton.ivanov@cambridgegreys.com,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	mingo@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	ojeda@kernel.org,
	richard@nod.at,
	rust-for-linux@vger.kernel.org,
	tglx@linutronix.de,
	x86@kernel.org,
	zig@iorw.io
Subject: Re: [PATCH 1/2] rust: arch/um: use 'static' relocation model for uml modules
Date: Wed,  4 Sep 2024 20:28:10 +0800
Message-ID: <477D5EA32B25AA05+ZthOusZtXttQOf3B@evil>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ZtgopAHp+I2+xCIz@gpm.stappers.nl>
References: <20240903130606.292935-1-zig@iorw.io> <FD7D773099A0C7EC+20240903130606.292935-2-zig@iorw.io> <ZtgopAHp+I2+xCIz@gpm.stappers.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:iorw.io:qybglogicsvrgz:qybglogicsvrgz8a-1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_052937_926541_3B1F807B 
X-CRM114-Status: GOOD (  12.15  )
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

On Wed, Sep 04, 2024 at 11:30:12AM +0200, Geert Stappers wrote:
> I failed to match the actual change with the commit message.  Consider
> that ignorance on my side.

FYI, I'm using the master branch of the upstream, but yes it's in the
'rust-next' or other branches as well, so maybe not a big deal IMO.

Of what 'https://rust-for-linux.com/branches' says, maybe I'll use the
'rust-next' branch for the next time, thanks for pointing out!

> I see a problem in just renaming a variable, might be my problem.  Thing
> is that removal of 'KBUILD_RUSTFLAG += ' feels wrong, hence this posting.

I think this is fine, the 'KBUILD_RUSTFLAG' controls the 'PIE' flag for
both the kernel itself and the loadable modules. And yes, that's the only
way I can make the 'PIE' flag out of the modules while keeping the UML
kernel itself works, and the 'scripts/Makefile.lib' I tought has placed
those flags correctly.

What about adding a 'static' flag to the 'arch/um/Makefile' explicitly,

---
KBUILD_RUSTFLAGS_KERNEL += -Crelocation-model=pie
KBUILD_RUSTFLAGS_MODULE += -Crelocation-model=static
---

but that's just a redundant of the already defined 'KBUILD_RUSTFLAGS'.
Have no more ideas what can this flag goes wrong :(

