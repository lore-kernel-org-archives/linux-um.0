Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518ACC2BD09
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 09:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1NlKcZZkLvY++SCCi9vNVYxMlHhrObroSwL2nN7Zacg=; b=pie1fwWyhZhudSpEnZUoz6rXSN
	wl2srvzbxlFtogXgvnmlrISm7AoMuExcMDAS2vo04s+H7ZYY/1NbGldPLXrAixwQtJzj3kYjMf6sJ
	179UhjcU6C5e63JzxNjUPZ61iixuWlHMrsZCd1x2qZ6UIlZxMR5Qiedi82nrhA3NgDC6vM97V7DTq
	MKu7oOWxrkQBS4GUNBGH/ma6dH8IUFAdmBm1RRq6uA8eIb1fQOobfECLpyTq4iveGjD58OI68amkr
	iogZulyk/iWWA0J8Ig7kzkiEIGUD/sVInhM2EIrVqTxlxW/JCvs5q+d0a29vSmEErIQwdWsIkdUEu
	sKFwQ3dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOwYA-00000009bRs-2oAV;
	Wed, 03 Jul 2024 09:45:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOwY8-00000009bRK-0xOg
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 09:45:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1NlKcZZkLvY++SCCi9vNVYxMlHhrObroSwL2nN7Zacg=;
	t=1719999915; x=1721209515; b=L8Ym3G1hWUNrnHiyCcAEAZf2NMMettimdzQu/O7A6CocQK0
	Vgouw+lJxphzuLEsdDuwtIQwmbGLgLLOVVSdeJFw1krOAucTo4P7VCjwsTrR4vSJM1Xzz0Z08FQpB
	jNub22a7ogZDC+XpKD/0AclSpZloN9MuRqBOlqVHtf29kT1YvaCnMZQ547vzaoZA/LPTlJkFewryo
	TfCVDZGmGV0QwytQjnhoE7MGTLtBAlQrb1p0QVKzihlP2r9zwSykK2IBUCSSEFNJKM3+PT1ZuGYPc
	42pvmphzFWIjEyaRGXvF7DeYz+c/OsrggZrxKNxXTL/v6wPzkEp2zeIPBQ3rxgQQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOwY1-00000008VPp-45M0;
	Wed, 03 Jul 2024 11:45:10 +0200
Message-ID: <2784bb3e9de2ad88a48d8fa70b01c46e1b2399fc.camel@sipsolutions.net>
Subject: Re: [PATCH v3 10/12] um: remove force_flush_all from fork_handler
From: Johannes Berg <johannes@sipsolutions.net>
To: benjamin@sipsolutions.net, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Wed, 03 Jul 2024 11:45:09 +0200
In-Reply-To: <20240524213718.1757703-11-benjamin@sipsolutions.net>
References: <20240524213718.1757703-1-benjamin@sipsolutions.net>
	 <20240524213718.1757703-11-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_024516_291220_F3A0690C 
X-CRM114-Status: UNSURE (   7.36  )
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

On Fri, 2024-05-24 at 23:37 +0200, benjamin@sipsolutions.net wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
>=20
> There should be no need for this.

"should" ;-)

This breaks things if glibc enables rseq. That might even be already
broken in the sense that it might corrupt memory that's put at the same
place the rseq was installed? But it at least it appears to still work
without this patch...

As we discussed, it might thus be better to fix up the execve() patch
and do that before this.

johannes

