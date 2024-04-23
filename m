Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2405CC4345F
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wdLaAi/HXNFJUa/Vn86wUdeVGT8NCDKEn69CFwiXFwM=; b=cPd0dOhHRDBrBO7U9SalgSM0fM
	/XcRF9w/yMiO9C2AWOT7uWDWm9fw5Tbz0IMU2YXDCzd6CfVk4Bnmbbuxgd0Hnh48Zc5OgYyrAGu5g
	YMxgIPtbyFnjqKBrP6nLK9y1GAHB4QHTz9R5ekxkYIxN3M1FB0PW1fggdslmmRKXmtbOmr05ORJvO
	1HC/RLuecyRldAgK9G+gf+IDEjdOc/SgpGNsw166MLdbRidhZgkENJnMMTGopMrg/1WUBflNaFuVX
	xe2gzk5xr4JgLp87FVILpnKo/xaaAvCLICdJmgFtZFzYkQ5+WHGj8tuFE9fzOwixdlJDjwQuTXX/7
	LLyziDQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzELi-0000000H6SP-2pWA;
	Tue, 23 Apr 2024 11:30:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzELf-0000000H6Rh-1Mvx
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 11:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wdLaAi/HXNFJUa/Vn86wUdeVGT8NCDKEn69CFwiXFwM=;
	t=1713871806; x=1715081406; b=SCbupO+L5fckSlj4QT9k7p+4mlfE5JxScTr+OEWP2kR/ZRT
	dxof3FgsQZGbcF75XrfypZn8qutnyjtCPPtTDHkuo71KTux3qPyIs2C43dYHre0PKa9WNgpKmbOQ7
	giV34gLCo3IoOVUiwdHfOO6NVTEkpSqCYgwJUbD7CEFyz8fW4o50ltyvZV+KaSFgV6ydyDD0K+ybl
	cD+G2JHAw+iJQGm1FI5xKSMfB9VcUiwX7kmjBf/9n9wP/Pteyb4dCWp8ouhln7v5Gl+Xz5+xzUqq6
	bCSaNIHLw71BK18cH4fELJC9rv1v9Pcfm1VpLMFoFhb6rnyrwq8O4iMbm5l18JaA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzELb-000000025yu-2KUq;
	Tue, 23 Apr 2024 13:30:03 +0200
Message-ID: <f175a7b540ffd6764aa68ae021c19920aa6d4f5a.camel@sipsolutions.net>
Subject: Re: [PATCH 3/7] um: Fix the -Wmissing-prototypes warning for
 get_thread_reg
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Apr 2024 13:30:01 +0200
In-Reply-To: <20240423112457.2409319-4-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
	 <20240423112457.2409319-4-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_043007_456623_3D175B1F 
X-CRM114-Status: UNSURE (   3.90  )
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

On Tue, 2024-04-23 at 19:24 +0800, Tiwei Bie wrote:
>=20
> +extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
>=20

Like, in general :)

johannes

