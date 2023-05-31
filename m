Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAB5C77B7C
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 06:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TsRNXiGuYAjaL3ba0vIbo9qik05fAIsKZbExPe8q7zE=; b=c91jwTOoVs6+9U8Kk6yf9RzgMc
	tsxgm90b5YLKfjig7ek9EUPkvGHFmJGaYoW4ZzGe0i74gzfOrJ4MCo9DbmLcU8gnF+WP3QHh5F1DO
	3kYqezF1c9m+lIH3rSD/ETeWOtBx0hkgv2x1OH8vqHHb4AuykZfSRFItoMGJVJLSlbmc0mVEKZ1Pd
	iosuxn1Sl+CywfT6SRxq5YVDXMrapvopeadP2KWcDoqohLDpk5Q0fN0bTgH32zNIxyYLz4SSmuj86
	jHXdGxRNQWkIdybxY6R00LWWZt5vukiExBWNbYfVD0VPCnerFVSLGIpg+B9ij9XHZYNC6fMDGk3SR
	jH8MQgDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4FF8-00GHBk-24;
	Wed, 31 May 2023 06:23:34 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4FF5-00GHAW-0b
	for linux-um@lists.infradead.org;
	Wed, 31 May 2023 06:23:33 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E454A63CC10C;
	Wed, 31 May 2023 08:23:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id L1MW3AYx1K1h; Wed, 31 May 2023 08:23:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9E3CC616B2CF;
	Wed, 31 May 2023 08:23:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sVKUU-jUg0rd; Wed, 31 May 2023 08:23:20 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7EB866081100;
	Wed, 31 May 2023 08:23:20 +0200 (CEST)
Date: Wed, 31 May 2023 08:23:20 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Kees Cook <kees@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Maxim Krasnyansky <maxk@qti.qualcomm.com>, 
	oe-kbuild-all <oe-kbuild-all@lists.linux.dev>, 
	linux-hardening@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>
Message-ID: <103925562.158061.1685514200368.JavaMail.zimbra@nod.at>
In-Reply-To: <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org>
References: <20230530164004.986750-1-azeemshaikh38@gmail.com> <202305311135.zGMT1gYR-lkp@intel.com> <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org>
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Replace all non-returning strlcpy with strscpy
Thread-Index: /e3HVPBWZ39oPFmlPQoqSK9b5wqRFQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_232331_401588_A1DFEC86 
X-CRM114-Status: UNSURE (   4.61  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+Pj4+IGFyY2gvdW0vb3MtTGludXgvZHJp
dmVycy90dW50YXBfdXNlci5jOjE0OToxNzogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9m
Cj4+Pj4gZnVuY3Rpb24gJ3N0cnNjcHknOyBkaWQgeW91IG1lYW4gJ3N0cm5jcHknPwo+Pj4+IFst
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+PiAgICAgMTQ5IHwgICAgICAg
ICAgICAgICAgIHN0cnNjcHkoaWZyLmlmcl9uYW1lLCBwcmktPmRldl9uYW1lLAo+PiAgICAgc2l6
ZW9mKGlmci5pZnJfbmFtZSkpOwo+PiAgICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn4K
Pj4gICAgICAgICB8ICAgICAgICAgICAgICAgICBzdHJuY3B5Cj4+ICAgY2MxOiBzb21lIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCj4gCj4gQWgsIHllYWgsIHRoaXMgaXMgYW5vdGhl
ciAibm90IGFjdHVhbGx5IGluIHRoZSBrZXJuZWwiIGNhc2VzLiBMZXQncyBpZ25vcmUgdGhpcwo+
IHN0cmxjcHkgZm9yIG5vdy4KCldlbGwsIGFjdHVhbGx5IGl0J3MgYW5vdGhlciBjYXNlIG9mICJu
b3QgZXZlbiBjb21waWxlIHRlc3RlZCIuIDotKAoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcg
bGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
