Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39E9C54E64
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 08:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xyJ35OeYZ8gYDoCSDvqC+bURigKZ0DrKEJIfJCIxPiA=; b=t+NbZUAO0sjlWua/HVn/y8VyvS
	iv5FZhu2wx+ukL11Bc4Mx4B4UTkX5WlV/gR9ha9F2HSSF/2OM/gkLmDYVkqXLZSeml1skBoUnJGIs
	ofx/exw8HZoOPsgd9nlD3KORQRc10UfZSb2S5QoGWnqHUXMD94LUEG5Y56EMDld7kT6pYbkRUtSUl
	f6QPHwxd4rlhqU5OCSxXsTmkJe+Y4Sc1LMbcjzDRbGL7cdPay31npoqGHGG+kA85v8q0Qj9XJCpKW
	GioJcUlTztV5Lt4xUlkxyeLEd3b5qll/ugZZtIgtrVqmDfcQUT2QbRCE2lUuyrXe6upRDS1l9LVbb
	sYF5u96Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpl59-0000000D5Kl-1WK1;
	Thu, 28 Mar 2024 08:25:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpl57-0000000D5KH-2hjR
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 08:25:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xyJ35OeYZ8gYDoCSDvqC+bURigKZ0DrKEJIfJCIxPiA=;
	t=1711614353; x=1712823953; b=vKOostsJpL7kb+WntTWwPGs3/0Y/OWqW18vvaGyfSYKwY64
	auWJQ0UpmDIZAhuw7oaqkJEl0jZHr+B1rjOp3NisNtqVq0lmSI5xwshO3AcRauBkwt+NuY+zF6Ntb
	qzYtsbSztocAjWr/57Ja4/5ZCx0+tou5TJxmZbe4qMAZNUtK/hxGedG4tHsKUsj5On+bR8B3Lgv0K
	NSF8/nody1Vv9NLxDPOrz9vY3sicvTBko5MFLZ/vuupq1wgBDk1tVUq8tIdcbbW7fn3paHyjsHG6x
	RKYVD6S+0/s29ofx7zpvfcYy/UJmLzgjQnIAj1Ho8WqhbVPgLNYYUsuLkvmJYm+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpl51-00000000mV1-3Jg5;
	Thu, 28 Mar 2024 09:25:47 +0100
Message-ID: <1743ad022502d64042fa7db4d847a988bb90cbdc.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Add winch to winch_handlers before registering
 winch IRQ
From: Johannes Berg <johannes@sipsolutions.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Thu, 28 Mar 2024 09:25:46 +0100
In-Reply-To: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com>
References: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_012553_709628_A8FC3F35 
X-CRM114-Status: UNSURE (   8.43  )
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

On Thu, 2024-03-07 at 11:49 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Registering a winch IRQ is racy, an interrupt may occur before the winch =
is
> added to the winch_handlers list.
>=20
> If that happens, register_winch_irq() adds to that list a winch that is
> scheduled to be (or has already been) freed, causing a panic later in
> winch_cleanup().
>=20
> Avoid the race by adding the winch to the winch_handlers list before
> registering the IRQ, and rolling back if um_request_irq() fails.
>=20

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

