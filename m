Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431E5F433D6
	for <linux-um@archiver.kernel.org>; Fri, 17 Apr 2026 08:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j69y3YHf1m8uiBrjLiPvVvG1wgbSPneNKUioMdmUMCI=; b=UV9wWC9aExho/xrsJYUMiWzBYj
	TYtM0Ey161+bvp6p1rBpjQICK1huVGWPbS04psKW7pX0nC9bndoVE1r8gKIl4gHCWm8LbsIgtjxVz
	YzvggQ3QFUaVYEQVP7KFzfj6Oyp/++4mTEo1R6O1uBTXatUDBZL7tZqbwHjPiGyntBtr+yrxwmOR/
	xdhUAN82XEwvroOyG9hgyBhgZIndDjkdi9YQTU2oOvO/WLJnn30BKSrqAduNIwIplzsbHskpqWrk9
	MDY5lWHDOb+rMrXVB6lnPedu0P/kc0msbfzgLPjLGyTX7ZCKp7dc4y4/1WQx2cobkwurigNxnuirI
	qXZ+mV8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDeEa-00000003ePG-47Y1;
	Fri, 17 Apr 2026 08:07:28 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDeEY-00000003eNv-0ueX
	for linux-um@lists.infradead.org;
	Fri, 17 Apr 2026 08:07:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j69y3YHf1m8uiBrjLiPvVvG1wgbSPneNKUioMdmUMCI=;
	t=1776413246; x=1777622846; b=eugHcOSdPVuRWRPgg6DjACMSwnzlDNGH+o5UywCqsQbiXmg
	/GPG0rM8uB6rMpmwRfNLb+rWdrAAAblZ/tkqmsblHBQYZcJOPJzNmGjdERPBo1dqbNOHYwQFnZwgf
	TeJkE6ZwHWIqmQ8lhmduKEB23e+KEp2HZIIZDtSVF+ysKevI3ppjRrBYxQCcJ+IxBtaMRIK0LMHpm
	+L5WqRnkN9o+RomDUx8JTcZaQsF5z7QloOPX6FpM6AcKs60hqOLpzlOXsMRbojaf+xep/MZwgCNgZ
	4Wern+EupbX78fiEtjOUWK94nLSB1tECjY4UBpNMPfCNqpDPba7rCudU1CMJBF4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wDeET-00000008N4j-2xxT;
	Fri, 17 Apr 2026 10:07:22 +0200
Message-ID: <453f5e190ee7bc03c5e9c6326982559e40bed0ab.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: reject interface specifications with too
 many arguments
From: Johannes Berg <johannes@sipsolutions.net>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Richard Weinberger
 <richard@nod.at>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 17 Apr 2026 10:07:20 +0200
In-Reply-To: <20260417073704.1817-1-pengpeng@iscas.ac.cn>
References: <20260417073704.1817-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_010726_256832_E9A61BBA 
X-CRM114-Status: UNSURE (   3.91  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 2026-04-17 at 15:37 +0800, Pengpeng Hou wrote:
>=20
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

There should be no blank line here.

johannes

