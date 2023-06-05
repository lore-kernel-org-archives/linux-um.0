Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F82C77B73
	for <linux-um@archiver.kernel.org>; Mon,  5 Jun 2023 20:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oBkKcCm1eXyOszIYYN3xm6UFGa1H+WbB+o+XhDs4l74=; b=PmnW0eO2861t5XC7v9XVkMdOGQ
	TBcZxKOfDKA/ffNNCo8RodJb7PZuQWBrQ6JSb4li0Mj4vxGYd1Kq+w4DrJcxehusHNCrfKiW2TXJd
	bq75NOrwuu8BM2Ib7uxiYFc+B4/m9EElabOacT75h1+4Rs6eqmt6zyYMmpsg4syHi9fabxMaeB+P/
	Ig2e1Nec4kIEzIxAismHJZZsDDurm7HHwY804K7NIweOBPw6ZL3HV5NY+U5pB9lZxnT0/5knZRI6R
	ffeUPsASZuSKtvlnuMlJv3f4lgYQ1TxPdOo8LiYxT22i3vYYxCkuDtsK8bDNEuTd26iRQr16gdTHF
	U9GoNrfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6GUO-00GeYk-22;
	Mon, 05 Jun 2023 20:07:40 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6GUL-00GeXI-1i
	for linux-um@lists.infradead.org;
	Mon, 05 Jun 2023 20:07:39 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 10B7363CC10C;
	Mon,  5 Jun 2023 22:07:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id X6roPuzR374K; Mon,  5 Jun 2023 22:07:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BF45E6081100;
	Mon,  5 Jun 2023 22:07:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xJjb7zySq9_X; Mon,  5 Jun 2023 22:07:30 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9FE3863CC10C;
	Mon,  5 Jun 2023 22:07:30 +0200 (CEST)
Date: Mon, 5 Jun 2023 22:07:30 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
	kernel test robot <lkp@intel.com>, 
	Maxim Krasnyansky <maxk@qti.qualcomm.com>, 
	oe-kbuild-all <oe-kbuild-all@lists.linux.dev>, 
	linux-hardening <linux-hardening@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>
Message-ID: <458187791.3685910.1685995650602.JavaMail.zimbra@nod.at>
In-Reply-To: <CADmuW3WXDg-5SFXkMDE6BmvSwLNHmXpTzBonaOL8eErc4+d3qQ@mail.gmail.com>
References: <20230530164004.986750-1-azeemshaikh38@gmail.com> <202305311135.zGMT1gYR-lkp@intel.com> <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org> <103925562.158061.1685514200368.JavaMail.zimbra@nod.at> <CAMuHMdU70uRxnMNb8KCJe8M3BRPPxowRXtj+POcrh+KLkfQyAA@mail.gmail.com> <CADmuW3WXDg-5SFXkMDE6BmvSwLNHmXpTzBonaOL8eErc4+d3qQ@mail.gmail.com>
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Replace all non-returning strlcpy with strscpy
Thread-Index: F0kvDMRUOo3WCvHaQMtuD24L4U1LkA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_130737_746512_BE60793C 
X-CRM114-Status: UNSURE (   1.57  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkF6ZWVtIFNoYWlraCIgPGF6
ZWVtc2hhaWtoMzhAZ21haWwuY29tPgo+IFBsYW5uaW5nIHRvIHNlbmQgb3V0IHYyIHdpdGggdGhl
IGZpeHVwIGZyb20gUmljaGFyZCBhcHBsaWVkLiBMZXQgbWUKPiBrbm93IGlmIHRoYXQncyBvay4K
CkZpbmUgYnkgbWUuIDotKQoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11
bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtdW0K
