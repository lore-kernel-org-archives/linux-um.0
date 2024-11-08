Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283D6D5E14A
	for <linux-um@archiver.kernel.org>; Fri,  8 Nov 2024 09:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jHGeaIeXbClXGW3OEnaUVDx57xoW1HF6tH5iHko0tNw=; b=44Iz/0PL+f4ApLamGhl6TpNzh1
	ZqmGBYNtuBasbZPM02osKut7vV7c0klFv/M0hYeIOjomBNuaKZbETaOP3D8Gkvplrh7mWuNMuSWRp
	wCYDttQx++m7hx529MWRRikTkuPO3VL7JwHKzXEqvimkzyvXA8EEfLKXmvO/dRzDRJ6HTPn05WpDA
	ybNs0Tnzf5QxKV3xKS1/L/Td5QyQtdTV/xy12938g8U/Fxpu1o60cHiQTZeXR6gjkYEmWKX5AXEnx
	uVtugqjTP8MqyLu9kGRn8/ISA6jiTN8Cft1ZrPY+mnPa5job3NXJ7hid/hn2/ypsAnStU6TeW4Jcy
	CKJGY2xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9L7Z-00000009vmc-11Wa;
	Fri, 08 Nov 2024 09:17:37 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9L7V-00000009vkm-38xx
	for linux-um@lists.infradead.org;
	Fri, 08 Nov 2024 09:17:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jHGeaIeXbClXGW3OEnaUVDx57xoW1HF6tH5iHko0tNw=;
	t=1731057452; x=1732267052; b=kHqTCtnIQjt9TZyU5tEH41nB7StrPrWIWB1HA+H9cHMH4pU
	HavO7Ez309i7fFgm6e/sImPHVSHR7B0ISEG3pwyHuei4lrOi6zmXRlc6+TqJLe8JopBSVOPXMYS4U
	6KNbt0iw5XOzI8U4FMtaLX/rt7GkbQX995cj6Isky2n6ZU6gEJycDpT6+oejeSasAW0kSR/85m1g+
	sz6MKg6OAWX/L4P8kUE5iB2iYzCnQZWHsKMsdb/x0CLUTYrkGT3F40dMX1jfXHwG+sEDDKHgQP/k9
	qo3a3ZuPJB3dGHhGXeaEh1paOXEaQUS9w6lH39d6ANZCAxv9sQMhBfkCCSBe5vmw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t9L7N-0000000HBo9-39zq;
	Fri, 08 Nov 2024 10:17:25 +0100
Message-ID: <065b0d76aeea7d3543d3eab302167af039e8f913.camel@sipsolutions.net>
Subject: Re: [PATCH] hostfs: Fix the NULL vs IS_ERR() bug for
 __filemap_get_folio()
From: Johannes Berg <johannes@sipsolutions.net>
To: Peng Zhang <zhangpeng362@huawei.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, willy@infradead.org, 
	josef@toxicpanda.com, brauner@kernel.org, zhangxiaoxu5@huawei.com, 
	wanghai38@huawei.com
Date: Fri, 08 Nov 2024 10:17:24 +0100
In-Reply-To: <20241104123440.1347175-1-zhangpeng362@huawei.com>
References: <20241104123440.1347175-1-zhangpeng362@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_011733_808515_B189B8BA 
X-CRM114-Status: UNSURE (   7.86  )
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

On Mon, 2024-11-04 at 20:34 +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
>=20
> The __filemap_get_folio() function returns error pointers.
> It never returns NULL. So use IS_ERR() to check it.
>=20
> Fixes: 1da86618bdce ("fs: Convert aops->write_begin to take a folio")
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>

Not sure it's critical, but for um I wasn't planning to send a pull
request for 6.12-rc (and I suspect Richard also wasn't, as there are no
other fixes). Also, the original commit went through another tree.

Christian what do you think? Do you want to pick it up? Or should we
pick it up via um, but then likely only for 6.13?

If you could pick it up:
Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes


