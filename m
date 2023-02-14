Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BF4C61DA4
	for <linux-um@archiver.kernel.org>; Tue, 14 Feb 2023 21:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JLkd/wYVvWCSiVVWmQRebNiGYJXFyE5KgPe8W9zf0u8=; b=bLaPbs/AwQOWTngd6CZ5I2oXco
	6v6BbH5NfV5P4eGgLQEP1FJfxHaRy5xjEeXZ433D1rS0X3UBfB54a0Eicn9ImOUbXk9TOUog1b7UY
	RNtzNHmPrhiA3gHFBmpvEzHZSpJcVbbmGCY5yv/YZ3HkjGRLGp3KhwKX5q7mg9ciMIrvFkMqSQRAo
	KH3tbRObhruAdBoH7NVnBU99uaTNMLnSSUAXERGu7UEzOQcrX3s+jjjskKSKisMcBY1y/2XVea2lN
	FzZOrXi2/cE6m95Cvo+kNjDsUIZV3pHT0tK4d+2AxsX1gL0F/F7Vo0uzj5Ueho4MkrxszsSbwcX1C
	90+tLLqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS3IU-003i7P-DP; Tue, 14 Feb 2023 21:57:10 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS3IR-003i56-3D
	for linux-um@lists.infradead.org; Tue, 14 Feb 2023 21:57:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 764A5642ECBD;
	Tue, 14 Feb 2023 22:57:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id VcxgEhGSPP59; Tue, 14 Feb 2023 22:57:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1EF7962EFE88;
	Tue, 14 Feb 2023 22:57:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id I4iHAHl_jRWG; Tue, 14 Feb 2023 22:57:02 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id EEE32642ECBD;
	Tue, 14 Feb 2023 22:57:01 +0100 (CET)
Date: Tue, 14 Feb 2023 22:57:01 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at>
In-Reply-To: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
References: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
Subject: Re: [PATCH V1] um: Fix compilation warnings
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix compilation warnings
Thread-Index: IBnuok78cQpRA6uq18kqCafccar16w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_135707_305237_B7F1B2F2 
X-CRM114-Status: UNSURE (   2.02  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIlNyaW5pdmFzYXJhbyBQYXRo
aXBhdGkiIDxxdWljX2Nfc3BhdGhpQHF1aWNpbmMuY29tPgo+IHN0YXRpYyB2b2lkIHNpZ19oYW5k
bGVyX2NvbW1vbihpbnQgc2lnLCBzdHJ1Y3Qgc2lnaW5mbyAqc2ksIG1jb250ZXh0X3QgKm1jKQo+
IHsKPiAtCXN0cnVjdCB1bWxfcHRfcmVncyByOwo+ICsJc3RydWN0IHVtbF9wdF9yZWdzICpyOwo+
IAlpbnQgc2F2ZV9lcnJubyA9IGVycm5vOwo+IAo+IC0Jci5pc191c2VyID0gMDsKPiArCXIgPSBt
YWxsb2Moc2l6ZW9mKHN0cnVjdCB1bWxfcHRfcmVncykpOwoKSSBmZWFyIHRoaXMgaXMgbm90IGNv
cnJlY3Qgc2luY2UgbWFsbG9jKCkgaXMgbm90IGFzeW5jLXNpZ25hbCBzYWZlLgoKVGhhbmtzLAov
L3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
