Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E61CA1016
	for <linux-um@archiver.kernel.org>; Thu, 11 Sep 2025 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MoWNn7DHA78iwugknyQ5tFhWQzWHhiXfaQ0zWgavsSM=; b=Zc2x3UHz/emPKKtQHG2fKqLGCs
	U80G+jLwYxmaEDuDWmw8buFoz7FDPsji4B9/TgTfx4PeJ2sULAsBREvSpXd1hgE+aImooipAnUmE1
	3IbRBkOxPo1Fae8V0XebtNAcQCPDlFh6hm+XdNTEIdTB8kYg42vC3jieshdA8DlEX/hzDewriHkdj
	MuU0wxZ5O/wOtnK3TAy+Q+5VrcSF0DZEAGmt9qx1tBauJyK81TvlcGuIpXTxRc+MjBoaqMVRuAnjP
	9CBkTG/rua2vaJKXwTc1G+Hc0QlO0jHXFVpt8zbw4rU06r8HS5BYEs7pw+04zaiMZ8Jopmp/3VGmr
	4UYXCMWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwdaD-000000027PY-3w8r;
	Thu, 11 Sep 2025 09:27:13 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwdaB-000000027NF-2Hg7
	for linux-um@lists.infradead.org;
	Thu, 11 Sep 2025 09:27:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MoWNn7DHA78iwugknyQ5tFhWQzWHhiXfaQ0zWgavsSM=;
	t=1757582831; x=1758792431; b=Xy6Rcyw7dWs20ojPn5dfyaJhtkL5ZJ8jf1HdYN9ModCtdwS
	q00AXvvpWVKJhIezTD6H9oWNQYhtnNUflNxQbAE8GR3j6uvSkpJQAHXjPiBlXAkqwuJ+k1YWFd7l/
	TwZK0Z5LyzxukiDFv2NJb3Mpaobw5xsL8sFvyzC+JAtqRN1HYipr/xuMCYIp3/q9EZqercTciUJ0z
	E6yEb5EgY837WvVSi386Zq1jY+Qq6MGe9iC1x1nrkhtcCPwyVOEWRyYnVYAwS6mkdA4QCdCQ2gDCO
	IzOTtIMW3iXbSXEErB9iAbtHplA/zeGcmwAeo3AFUD5rx0FI4YAQ9Z8dUyjEfC+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwda5-0000000F0aa-27nQ;
	Thu, 11 Sep 2025 11:27:06 +0200
Message-ID: <78c8e39d9719a26c6e492e895b070794eb8218ea.camel@sipsolutions.net>
Subject: Re: [PATCH v2 05/10] um: Determine sleep based on need_resched()
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 11:27:04 +0200
In-Reply-To: <20250810055136.897712-6-tiwei.bie@linux.dev> (sfid-20250810_075306_773702_0F58F2CF)
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
	 <20250810055136.897712-6-tiwei.bie@linux.dev>
	 (sfid-20250810_075306_773702_0F58F2CF)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_022711_585213_02C240E2 
X-CRM114-Status: UNSURE (   8.40  )
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

On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
>=20
>  void um_idle_sleep(void)
>  {
> -	if (time_travel_mode !=3D TT_MODE_OFF)
> +	if (time_travel_mode !=3D TT_MODE_OFF) {
>  		time_travel_sleep();
> -	else
> +	} else {
> +		raw_local_irq_enable();
>  		os_idle_sleep();
> +		raw_local_irq_disable();
> +	}

This seems wrong, with it, lockdep gets really unhappy, and if I remove
this change it seems to work OK?

I'll note that arch_cpu_idle() for x86 also doesn't change anything with
interrupts.

Was there something else that required this change that I'm missing?

johannes

