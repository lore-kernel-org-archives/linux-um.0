Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726DECE7A86
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 20:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0ZhX3n3kuBgsWg8GycU1dCdezXWYFXdq7Vm20wtKuk4=; b=1ypt7JDIiPYE6N/AwaSIAuuJ/p
	M2FxqlDZUJSHRNfOccTmjGjVPiMhqRNzOhRU13YgQD43H/oquWeUZ7GXq7uXy/obK01ulaSZFFR96
	IKygosnrmfjM/IwJ+LtrIrCrGgxP++qEgmDBqkYJ9i445UdZpJZDiEdcPwbWot+a/Z8mPHRr3dlUg
	ZJ2OpgL6lsMb0ojMdEt7vfCmQpccIjuHV1qQM++v5gFMVuMUNTDEmW0k7lkpOJ/wXLtwVN3TVeeSe
	DlFX2THg5siyopKD9uR0Lyuydqadk8c/UeU6eS/dRoTjlk/EdjeGVcHb7J6ZPX3colZDTBnfgZgtS
	0rwIvUww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjmxP-009njl-2Y;
	Fri, 22 Sep 2023 20:40:59 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjmxN-009njA-02
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 20:40:58 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 04375622F589;
	Fri, 22 Sep 2023 22:40:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id m3pXjycH0zXI; Fri, 22 Sep 2023 22:40:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6B48B6234897;
	Fri, 22 Sep 2023 22:40:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tTXAdpgtqh51; Fri, 22 Sep 2023 22:40:50 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4456D622F589;
	Fri, 22 Sep 2023 22:40:50 +0200 (CEST)
Date: Fri, 22 Sep 2023 22:40:50 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um <linux-um@lists.infradead.org>
Message-ID: <1597650408.70670.1695415250057.JavaMail.zimbra@nod.at>
In-Reply-To: <389fbd9de31ccdaad52674b7de06312e57f2cd54.camel@sipsolutions.net>
References: <20230922105609.545573-1-anton.ivanov@cambridgegreys.com> <389fbd9de31ccdaad52674b7de06312e57f2cd54.camel@sipsolutions.net>
Subject: Re: [PATCH v6] um: Enable preemption in UML
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Enable preemption in UML
Thread-Index: J5R4Ql8jifnEUqKqTTrw7Yvuoy5OIw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_134057_218201_34ED4EF2 
X-CRM114-Status: UNSURE (   6.01  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkpvaGFubmVzIEJlcmciIDxq
b2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pgo+PiAtCW1tYXBfcmVhZF9sb2NrKG1tKTsKPj4gKwkv
KiBXZSB1c2UgYSBSQ1UgbG9jayBpbnN0ZWFkIG9mIGEgbW0gbG9jaywgYmVjYXVzZQo+PiArCSAq
IHRoaXMgY2FuIGJlIGludm9rZWQgb3V0IG9mIGNyaXRpY2FsL2F0b21pYyBzZWN0aW9ucwo+PiAr
CSAqIGFuZCB0aGF0IGRvZXMgbm90IGFncmVlIHdpdGggdGhlIHNsZWVwYWJsZSBzZW1hbnRpY3MK
Pj4gKwkgKiBvZiB0aGUgc3RhbmRhcmQgc2VtYXBob3JlIGJhc2VkIG1tIGxvY2suCj4+ICsJICov
Cj4+ICsJcmN1X3JlYWRfbG9jaygpOwo+IAo+IFllYWggSSBndWVzcyAuLi4gU2VlbXMgbGlrZSBh
IHZlcnkgbWVjaGFuaWNhbCBkZXNjcmlwdGlvbiBvZiB3aGF0J3MKPiBnb2luZyBvbiwgcmF0aGVy
IHRoYW4gYSBkZXNjcmlwdGlvbiBvZiB3aHkgdGhpcyBpcyBjb3JyZWN0ICh3aGljaAo+IGFzc3Vt
ZXMgbm8gcHJlZW1wdCBhbmQgbm8gU01QKT8KCklzIHRoZSBWTUEgbGlzdCBhY3R1YWxseSBSQ1Ug
YXdhcmU/Ck9uIFVNTCB3ZSBtaWdodCBnZXQgYXdheSB3aXRoIHRoYXQsIGJ1dCBJIGFncmVlIHdp
dGggSm9oYW5uZXMsIHRoaXMgbmVlZHMgYSBtb3JlCmRldGFpbGVkIGV4cGxhbmF0aW9uLgoKVGhh
bmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
