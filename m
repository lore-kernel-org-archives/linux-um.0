Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED88C77B6E
	for <linux-um@archiver.kernel.org>; Fri, 14 Apr 2023 10:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=LDJJ9JT1UAk7HaLdjeVC5c/CvGfMwRfNRzb6y2oBO84=; b=EgXfpgRX3jQEZhvPtkaGpaHbro
	vUOEUcvTp0JiDMgiNJBfqjgPEZBzzZjdOfbFioZaw8tMTy9m6EAcZ6bmhcrFQKqXhwlALp1R1r9Ur
	JJwqKIMY6myBMC+G4WJA4ZX1+qMQCGe6EdaaZ8KT2asOQy1qxue+xk9HiiBdFyH82FDkN9pROWmCU
	BDLwlLGoZVMWQIPwKPDdlq7K6T2uPEtqIQTGinfpE2XnSSp+vzeCrSttuKPyuCIjSlidy4EUmvXyo
	noY2s0zY2zAax7cis01+Dsd0jcbLDlRxhGCXCX4XSUapm5NtlWJpL7qlmIr44ac3skHB7i6/Zc5I4
	l5Ewx9UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnH5D-009GL7-10;
	Fri, 14 Apr 2023 10:55:11 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnH5A-009GJK-2K
	for linux-um@bombadil.infradead.org;
	Fri, 14 Apr 2023 10:55:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Mj95K7G8l2u5vzdmkL7VnEjif+3gh4r7fc84RHGAivM=; b=hRl+F1mXu/SkNRYUB10Nb64KUM
	/zVevKMiDc/2gXNUHTd6RbNoqOA/IZIBNMEB7nzrdZIlUKS6H1Kte7X2JwOAt0qXvgxs7egKjF1nE
	5IqSHfcFqeA/n7BL9R1Y43iKEawSalnoq6oaMvEjpo3s/GRRF+J747tlzsibhcm9e0fkadfIEPifZ
	6nf6aBCkw9GdSz/Pel+TonBZ3PQsGfJlvJKuBr/CN7kQA7mNzynE4vWYcspLo+BnuV1fI5+XZv+z8
	TgV/QbEnXw/fRkxK2xvR14U8ZirjUZugOsWbUzH/TcGsjRrI1Np2LcWCdt9S9aGWz2Lmi0W5gLdbl
	bXiB1ueA==;
Received: from lithops.sigma-star.at ([195.201.40.130])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnH55-00FYJ6-0X
	for linux-um@lists.infradead.org;
	Fri, 14 Apr 2023 10:55:05 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 670BB64551D5;
	Fri, 14 Apr 2023 12:54:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Wse-VarY_KMF; Fri, 14 Apr 2023 12:54:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1537A64551D8;
	Fri, 14 Apr 2023 12:54:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DAQ_qH2wKl7x; Fri, 14 Apr 2023 12:54:52 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E87BD64551D5;
	Fri, 14 Apr 2023 12:54:51 +0200 (CEST)
Date: Fri, 14 Apr 2023 12:54:51 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Marko =?utf-8?Q?Petrovi=C4=87?= <petrovicmarko2006@gmail.com>
Cc: linux-um <linux-um@lists.infradead.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Message-ID: <1668890621.62421.1681469691730.JavaMail.zimbra@nod.at>
In-Reply-To: <20230414023357.63722-1-petrovicmarko2006@gmail.com>
References: <20230413223024.11513-3-petrovicmarko2006@gmail.com> <20230414023357.63722-1-petrovicmarko2006@gmail.com>
Subject: Re: [PATCH v2 2/2] hostfs: store permissions in extended attributes
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: hostfs: store permissions in extended attributes
Thread-Index: /mpeai398z2BFo7WTf1qXP1o1jEG9g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230414_115503_992955_FF3A42D6 
X-CRM114-Status: UNSURE (   4.63  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIk1hcmtvIFBldHJvdmnEhyIg
PHBldHJvdmljbWFya28yMDA2QGdtYWlsLmNvbT4KPiArc3RhdGljIGludCB1bWxfY2hvd24oY29u
c3QgY2hhciAqcGF0aG5hbWUsIHVuc2lnbmVkIGludCBvd25lciwgdW5zaWduZWQgaW50Cj4gZ3Jv
dXApCgpJcyB0aGVyZSBhIHNwZWNpZmljIHJlYXNvbiB3aHkgeW91IGFyZSBub3QgdXNpbmcgdWlk
X3QgYW5kIGdpZF90PwoKPiArewo+ICsJaW50IHN0YXR1czsKPiArCj4gKwlpZiAodXNlX3hhdHRy
KSB7Cj4gKwkJaWYgKG93bmVyICE9IC0xKSB7CgpEb2Vzbid0IC0xIGNsYXNoIHdpdGggdGhlIHVp
ZCBzcGFjZT8KU2FtZSBmb3IgZ2lkLgoKPiArCQkJc3RhdHVzID0gc2V0eGF0dHIocGF0aG5hbWUs
ICJ1c2VyLnVtbHVpZCIsICZvd25lciwKPiArCQkJCQkJCXNpemVvZih1bnNpZ25lZCBpbnQpLCAw
KTsKCgpJJ2QgcHJlZmVyIHN0b3JpbmcgdGhlIHZhbHVlcyBwbGF0Zm9ybSBpbmRlcGVuZGVudC4g
ZS5nLiBpbiBfX2xlMzIuIApKdXN0IHRvIGJlIGZ1dHVyZSBwcm92ZS4KClRoYW5rcywKLy9yaWNo
YXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
