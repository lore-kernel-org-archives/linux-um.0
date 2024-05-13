Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4111BC25B10
	for <linux-um@archiver.kernel.org>; Mon, 13 May 2024 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8bkkbkRkMtHeGtx/q1XYfdnXfjo5YYKtbt2tSjRiBYo=; b=R8txSWAKRXv6Z41toI/WXvEYsT
	xBsoP0DWo/lPnNwFM90eF7Brrsh2fH4qD2VoAzfD/ySXEE78G1lIAIejVrmBB3aCZvyDwFehlNvmL
	urmXnRzUzdF5NMBsujNiJlSMJ/ALdgkXFXtkvi6itijexl1pfYYt+lbLkUMxh/cvZvWLkNBa1M6lm
	6iSjPCdt/LIW8aXF2YWCrQxJP7L0/niJ1m83Sw0ak5+hPD9zw+i15vMYJvNozLY7vU0Zlbv6e3XYo
	MGsFKznRVfeeritjEamc1DvClzQa/KYxQ7nodJ+1RAACHGFJInO/L1jk2QjrKtUxaQvXIUBw54vM+
	Q83qJkxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6VB8-0000000CtIX-0418;
	Mon, 13 May 2024 12:53:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6VB5-0000000CtHz-1bCd
	for linux-um@lists.infradead.org;
	Mon, 13 May 2024 12:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8bkkbkRkMtHeGtx/q1XYfdnXfjo5YYKtbt2tSjRiBYo=;
	t=1715604794; x=1716814394; b=ej+Gh6Nil7syMRP/SPSn1G3laT6wshPHZ085f95UJgT60Q4
	AfkwOvLYhBbt3ujp01Ijm0IE9Uc0VOU6H8Csk5BlNcx8T8boDIdgJLXeF5WbZYS5mNFoTJbmQX1cu
	Me/qhPofhPdWJ4198Rdg1cNlyp/xtsNYSHujleVtsiTHLuA6f8t3HdPqPKmJ15CFQDK+j1prC/5E6
	E3YLQ+KoQiSzQsA74I1r1v6+csFFqk0/vUHrujS8C9Da4Wx15tQ/eu8jGoN73r5DO+CEYX7H9Njo7
	bUz9qAuQz/LNS2xsjdUWjtO3XkoLTeW4JHVIsUchkiJE0S6K0VvcGN+EugGLdI9g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s6VAo-00000002HEm-0LUs;
	Mon, 13 May 2024 14:52:58 +0200
Message-ID: <f88384a305b90708db3b30012f9edf09690dc5ee.camel@sipsolutions.net>
Subject: Re: [PATCH] arch/x86/um: Disable UBSAN sanitization
From: Johannes Berg <johannes@sipsolutions.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org,  zohar@linux.ibm.com,
 linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 13 May 2024 14:52:56 +0200
In-Reply-To: <096121b3e74a7971b5e6a3d77ca8889380de1885.camel@huaweicloud.com>
References: <20240513122754.1282833-1-roberto.sassu@huaweicloud.com>
	 <d4f4666bf745e83ea00b466b7a7cfb5132b8c7b9.camel@sipsolutions.net>
	 <096121b3e74a7971b5e6a3d77ca8889380de1885.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240513_055315_442879_DEE3A608 
X-CRM114-Status: GOOD (  11.42  )
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

On Mon, 2024-05-13 at 14:42 +0200, Roberto Sassu wrote:
> On Mon, 2024-05-13 at 14:29 +0200, Johannes Berg wrote:
> > On Mon, 2024-05-13 at 14:27 +0200, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >=20
> > > Disable UBSAN sanitization on UML, since UML does not support it.
> > >=20
> >=20
> > Luckily, that isn't actually true, nor does it actually do this at all.
> > Please fix the commit message.
>=20
> Thanks, I was actually wondering. I based that statement based on
> ARCH_HAS_UBSAN=3Dn.
>=20
> Any other solution would be ok.

Not sure I get it. What you're doing in the patch is perfectly fine and
almost certainly required, but you're definitely not disabling UBSAN on
ARCH=3Dum as you described in the commit message?

johannes

