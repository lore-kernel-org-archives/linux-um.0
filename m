Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DE3C636CC
	for <linux-um@archiver.kernel.org>; Sat, 11 Feb 2023 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=U3NYdAFpqOU7afIc5eLWI+EQqdy0D4RbbD2bapdODA8=; b=qKceS5YHjn5K+BHnbVbT+WxGZX
	A/EWRK4cAcFGWbSkDOyhbtTbZlbuc8YIieuxD53h6HWSSsTddICtIKZ7mQ61BMe1YFzgIErZPDkJR
	eDA/nuHmkcy2cCDPpGeL2hTYHpKoVHYIbPmXCRENbgU2zrNt2lqfrgXyy03QePSDnAb0smhZd/yDS
	kdVlcjLQhH+AVDbIPCkbFkEO2/FGrZXP2+I78IwIPVfSULNYYvh0RZNsmcZZ9yeT2BmG07f3pi9NF
	uNu/B8t0PyZWOAS2wW30qtcJIk1oo0RrDkp1OjUhTrnOzawmzDnMYsgUEu5woM161s6JdfSWnJvoE
	kExlC+IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQlx8-0096qR-5L; Sat, 11 Feb 2023 09:13:50 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQlx0-0096nH-3I
	for linux-um@lists.infradead.org; Sat, 11 Feb 2023 09:13:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B8EB3642ECB8;
	Sat, 11 Feb 2023 10:13:30 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id E8ICStuihCQB; Sat, 11 Feb 2023 10:13:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5C09F6323048;
	Sat, 11 Feb 2023 10:13:30 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id H6gocNVHahkq; Sat, 11 Feb 2023 10:13:30 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2F5A1642ECD2;
	Sat, 11 Feb 2023 10:13:30 +0100 (CET)
Date: Sat, 11 Feb 2023 10:13:30 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Bjorn Helgaas <helgaas@kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	helpdesk <helpdesk@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>
Message-ID: <1361318892.117105.1676106810037.JavaMail.zimbra@nod.at>
In-Reply-To: <20230210230200.gmf27ywrookqoy5k@meerkat.local>
References: <20221012191142.GA3109265@bhelgaas> <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com> <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com> <20221013182912.k4deh5v47rjbpnnl@meerkat.local> <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com> <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com> <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com> <20230210230200.gmf27ywrookqoy5k@meerkat.local>
Subject: Re: Add linux-um archives to lore.kernel.org?
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Add linux-um archives to lore.kernel.org?
Thread-Index: fVhge8UCM5b9e/zoQvNhFNGfGsbyQQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230211_011342_538194_C94B1D94 
X-CRM114-Status: UNSURE (   2.40  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIktvbnN0YW50aW4gUnlhYml0
c2V2IiA8a29uc3RhbnRpbkBsaW51eGZvdW5kYXRpb24ub3JnPgo+IEJldHRlciBsYXRlIHRoYW4g
bmV2ZXIgLS0gdGhpcyBpcyBub3cgZG9uZS4KPiAKPiBTb3JyeSBhYm91dCB0aGUgd2FpdC4KCk5v
IG5lZWQgdG8gd29ycnksIHRoYW5rcyBhIGxvdCEgOi0pCgpUaGFua3MsCi8vcmljaGFyZAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFp
bGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
