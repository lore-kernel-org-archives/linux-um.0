Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D80C54E67
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 08:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HqQErbvN+ijNu1Jdkp6E3sCfvGXfGUK+92NtkuPAjjs=; b=TFXT/5ho1GPK3lK36bdr8gWmbj
	y3StYB7fUSReKBYe5qxtV2OEnODIJ6jWlr8qfeZ0BB8RTdKZUDK8rsegNWw4ZOOHRbMr7aWRsrl2/
	CWAkYv3r9bGJjrQrrXpEwn3j4TayX3nPAdZHgv7hs23+fHyUDChdwLCzIt7vTpnLXvZnu3uvvPilh
	XNt/6qUrQWw+hxNsDlePZjUrxC7up3bNLus2g8nPWuuPjcsnHNGPiJ9UTOzazdshBMhQVw5HbRDEG
	mdVmAW3QbSm2GonhDrJaJilbdeMWlduC9qJhKIbxM6dfZDswnPpVjIGltK1PRW7p6UWUkzlds9tQ+
	8znpE0Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpl6Z-0000000D5Yz-2YKZ;
	Thu, 28 Mar 2024 08:27:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpl6V-0000000D5X1-42qB
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 08:27:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HqQErbvN+ijNu1Jdkp6E3sCfvGXfGUK+92NtkuPAjjs=;
	t=1711614439; x=1712824039; b=d7lS37iFGSq322f4oQMueJz/4AcFz0hqSZGm9cn7AIR3my3
	WuP7pfHXGWNYfWG85WukPf0eszuWHlnoVsO22QhrTGqgwVf8NyGUvXI8jvWVD7SosNr1CljQuDVof
	IxrJ/1NkDSgF3ZX7IFrAKNNV7fqu8xsIAmtKjjsAE0Ohh6WyDisxYhJEkxmpSesOGLJhy/m8ezE34
	Izdv3n9VmNo8Js3FkOvfvGAh4nZdAUXXTibgJxKIRrCE1uoGpH9bLFB8EUsVItoDptFUmskju8PBy
	tDNo93dFhZHtoR1eFK1XgAsHNhD0uSwDTrmaC7PmojmDzELUhSVy6aLZXpt5w3Yg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpl6P-00000000mZL-3bbB;
	Thu, 28 Mar 2024 09:27:14 +0100
Message-ID: <6fa3c18b3421d5dfc80c82ce29a49171c1841bf0.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Fix return value in ubd_init()
From: Johannes Berg <johannes@sipsolutions.net>
To: Duoming Zhou <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org
Cc: linux-um@lists.infradead.org, richard@nod.at, 
 anton.ivanov@cambridgegreys.com, axboe@kernel.dk, brauner@kernel.org,
 hare@suse.de,  jinpu.wang@ionos.com
Date: Thu, 28 Mar 2024 09:27:12 +0100
In-Reply-To: <20240306091259.18605-1-duoming@zju.edu.cn>
References: <20240306091259.18605-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_012720_026247_82B331F4 
X-CRM114-Status: UNSURE (   6.46  )
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

On Wed, 2024-03-06 at 17:12 +0800, Duoming Zhou wrote:
> When kmalloc_array() fails to allocate memory, the ubd_init()
> should return -ENOMEM instead of -1. So, fix it.

Not sure this really matters, but the code seems cleaner with it :)

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes


