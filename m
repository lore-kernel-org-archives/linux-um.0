Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57302C25B10
	for <linux-um@archiver.kernel.org>; Mon, 13 May 2024 13:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zoSxVBCVN+gkwt4Gp0eaYQXVfaorf0WQt7DhqdHnm2c=; b=sNySiWXIYigZEz7HGLGvOMjoUu
	eHqYjZwMv2Qy8a2WNefCWqLg8ASfFrqQV4gFZSGyo9ry9Y8WZV0pcu33+DhOJ0nAz4vhVkuwzj5cN
	U8eqClzGXf3euVREHVj5PBS+vqLDlMB48UY4gJG7+miNM6mYIsCFwnoy6/3aEKs0xWEymqe2OCjUT
	M9MITtvEi4hfjehOsi5DkPezl0uHtvrLC6Fwcxo1qk3SzCNpwLdceVJoNoEahCN5Xh8Ipzx9dcAVg
	D3R0lkPzsoV3nH1ZoQP2fmjZtOCB3Ry5Ed9ebtIknOmcCwiTGgzRdizRjFOtwROyrN8dPuiLNFkHQ
	PZzdHtYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6VQB-0000000CwLj-2bMR;
	Mon, 13 May 2024 13:08:51 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6VQ8-0000000CwKK-2Oes
	for linux-um@lists.infradead.org;
	Mon, 13 May 2024 13:08:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zoSxVBCVN+gkwt4Gp0eaYQXVfaorf0WQt7DhqdHnm2c=;
	t=1715605727; x=1716815327; b=bp+aMoNCzaitMHv4lZMcI8ucepi5xpTYrPnCd7224kuwbgB
	Z6rP8QicLhOyUV+HLvzMQqY5Y9myf7y3NzePwIwyaq3WMfCBjetLlGBIZqcM8cKI4Z75FExvqvLUn
	JD9IWijGq4x6G8l4BpJdYKYlGhfCbtVt04HuDO9IlrzfCm+6QCQM9qoKzjxNwE6t43HO98mO0vOKV
	8Acc95r6mZTnm1+snkzl+zJBhOHo5pYt5JYjjP2J+EZKl4brzK+ceggv6M5tKFDTRVaBQPDJCmVqJ
	qydyuUbyoSKvHOZ/BaG6U3nlZzy1+DldxwPxBG9IA/gQtXgDrlSrsVfc41phquJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s6VPs-00000002HwD-0hyI;
	Mon, 13 May 2024 15:08:32 +0200
Message-ID: <d4f9861effd64c155f93cc712d2c7660b1cf2e4a.camel@sipsolutions.net>
Subject: Re: [PATCH] arch/x86/um: Disable UBSAN sanitization
From: Johannes Berg <johannes@sipsolutions.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org,  zohar@linux.ibm.com,
 linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 13 May 2024 15:08:30 +0200
In-Reply-To: <dba181a54e76ba2916ecd4747f76e40e6fbbb757.camel@huaweicloud.com>
References: <20240513122754.1282833-1-roberto.sassu@huaweicloud.com>
	 <d4f4666bf745e83ea00b466b7a7cfb5132b8c7b9.camel@sipsolutions.net>
	 <096121b3e74a7971b5e6a3d77ca8889380de1885.camel@huaweicloud.com>
	 <f88384a305b90708db3b30012f9edf09690dc5ee.camel@sipsolutions.net>
	 <dba181a54e76ba2916ecd4747f76e40e6fbbb757.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240513_060848_615114_662998E7 
X-CRM114-Status: GOOD (  16.33  )
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

On Mon, 2024-05-13 at 14:58 +0200, Roberto Sassu wrote:
> On Mon, 2024-05-13 at 14:52 +0200, Johannes Berg wrote:
> > On Mon, 2024-05-13 at 14:42 +0200, Roberto Sassu wrote:
> > > On Mon, 2024-05-13 at 14:29 +0200, Johannes Berg wrote:
> > > > On Mon, 2024-05-13 at 14:27 +0200, Roberto Sassu wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > >=20
> > > > > Disable UBSAN sanitization on UML, since UML does not support it.
> > > > >=20
> > > >=20
> > > > Luckily, that isn't actually true, nor does it actually do this at =
all.
> > > > Please fix the commit message.
> > >=20
> > > Thanks, I was actually wondering. I based that statement based on
> > > ARCH_HAS_UBSAN=3Dn.
> > >=20
> > > Any other solution would be ok.
> >=20
> > Not sure I get it. What you're doing in the patch is perfectly fine and
> > almost certainly required, but you're definitely not disabling UBSAN on
> > ARCH=3Dum as you described in the commit message?
>=20
> Ok, I guess the right word is instrumentation (got it from commit
> d4be85d068b44). And the reason is that the vDSO is executing in user
> space. Will fix it.

No, UBSAN is fine, but you're only disabling it for the vDSO :) The
commit message doesn't even mention the vDSO though.

johannes

