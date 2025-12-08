Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB10D3B7DD
	for <linux-um@archiver.kernel.org>; Mon,  8 Dec 2025 07:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XLv0HBTetXxoS4vCKz0X9BrXqB4r7kl7AGbnRmgSzlY=; b=3bIeqIYdUgnvBz/E3QbBJGfIOi
	y6+zrQtbGLzhO79XWhHzfRy8wGtO0pDRnoZcuI3Ck2R8CfJHx+mmJ/lGSmMapu/yhRTdoGfmA+p2+
	NOGUW9KPJBG3Fy8WAFwfX9FTPt3i56igZA+7O0jtBPeB/nhI71hknctNkOjZPd9NLfwpdHapmgKR+
	JaLF1KUa4p5+G+B1mptKXRzypSlVaiCZGWyTLgjTeeBUERuTybpYKAZstD1t85LIYkzTEx0T+x/2A
	CJRgIppzDcChU3fPgpKRkBiIP44JAR5EL3PI3XZfqKXSiZXdK3tsK9BGrN2fiQ5CkBdqxFmQ/jIx5
	il2xuxaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSVmE-0000000Clw2-2qp0;
	Mon, 08 Dec 2025 07:35:22 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSVmC-0000000ClvR-0VLm
	for linux-um@lists.infradead.org;
	Mon, 08 Dec 2025 07:35:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XLv0HBTetXxoS4vCKz0X9BrXqB4r7kl7AGbnRmgSzlY=;
	t=1765179320; x=1766388920; b=ccNuFB70e6hCcJHCdWdUFD0Ve1PuzfNxauIDVEh27A4IxBg
	xHkhFYQUYPPRHVjVobKiidI+fdS/BXhpNgpnBL7obw4e66/UQZ7VTDn08CPr4f4wfeUHvgPCFLWHW
	YzuhTd2fOyNatVtsCYZh3lJA1Zg0t4urGNN/uYC90xL0V3xHKpGktLg9DMKvEwnkeQUKGZA/NmIy3
	KtEDul5MuMMau9SHrA8MQJ5xJYa778qcOxCoceUIzIrsSkmPQV7jZ/le7u/xuTWHBr3h9z5wInaU+
	IEZ7KSy8x2gqrB43sQ9WvOyiXn6NoA4+JmCSnidjoWPLIQPuALM4GiTLnyWV3LLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vSVlz-00000002aqJ-3mY0;
	Mon, 08 Dec 2025 08:35:08 +0100
Message-ID: <24e75f32d3ff9254d10e40aca328d98ae589cc34.camel@sipsolutions.net>
Subject: Re: [PATCH] um: use ARRAY_SIZE to calculate the length of an array
From: Johannes Berg <johannes@sipsolutions.net>
To: Chen Changcheng <chenchangcheng@kylinos.cn>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: benjamin.berg@intel.com, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Date: Mon, 08 Dec 2025 08:35:07 +0100
In-Reply-To: <20251208023723.19789-1-chenchangcheng@kylinos.cn>
References: <20251208023723.19789-1-chenchangcheng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251207_233520_457236_EC28F4D8 
X-CRM114-Status: UNSURE (   6.23  )
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

On Mon, 2025-12-08 at 10:37 +0800, Chen Changcheng wrote:
> cocci warnings: (new ones prefixed by >>)
> > > arch/um/kernel/skas/stub_exe.c:180:23-24: WARNING: Use ARRAY_SIZE
>=20
> Fixes: 406d17c6c370 ("um: Implement kernel side of SECCOMP based process =
handling")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512080556.BbmGuwU4-lkp@i=
ntel.com/

Pro-tip: build your patches *before* submitting them and looking like an
idiot.

johannes

