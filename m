Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B95BC77B73
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 06:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TbfRAM36QMubAxn+hvBUX0siTmpKjOY7mH4E872o8xg=; b=j+/Txa3aq/hsL6
	8MKeIrliRqwB2jR4YeeU7z300S7nFE2YqPirFIcI2/ANpe0A/+YmCtVeZV0fPl54MQD4ylwd83Yp+
	fH6vFtA/OK3luxxqAD+S7auvBbwVEn7GNQs6aEjYpnmSgtc7eZKG8djULxzsjuo47EOshUpVDQaMb
	gfMB8e01Lqqzn08AbWXIlzfARjInPePyu8HhHP8UAKKs1LgX43ltkVgGMQ/fbGOSVkHY7g6FxUN4R
	eEaTZRX3PAbAZpFNFO5HTIJVGVTAziwcayFSD5c2HxhwuOOO5T+cis8+JmmtdDS1tKHrd+kR0NRWA
	AaxULo88sVI87tUbXl6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4FAI-00GGdF-2T;
	Wed, 31 May 2023 06:18:34 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4FAE-00GGbK-22
	for linux-um@lists.infradead.org;
	Wed, 31 May 2023 06:18:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OMeS+07AgIwC67dUdNYRuvFtsnzkhUi03Dd3OAGMjZo=;
	t=1685513908; x=1686723508; b=NjMUsQ5CgUrC/dW1KYYQdj+ODQZYwI+Kzm/ES+UvgSdu1LD
	KqxhI2aw8PoUK8W2RqekSHuiL6OW9q20BrmQPk/bIk9qgXHg0/fnNFgHS5dAEltumG/ukjDMLwZeG
	AL+Nf327+URAqg3UmHQkzqLtjr5oKXJnCSiFDbbbldtggCPAQkAA7hXAfxk4wtlLcMr5FhH3zDXkY
	R7QByhvU5mjlhZVYuPk5RLLH/tRueZQ7gzbARaFy8KDJWUiT6GYPt0sLolODqbQ8t31QOs6YFFAKo
	x7MMx2KuKhoBUhIGZI3rBSk/+2IMxKTZxlKtXj8kt3OhXCg5UDh43FICYYp8omhA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1q4F9q-009CER-0i;
	Wed, 31 May 2023 08:18:06 +0200
Message-ID: <8033fb8f9677cf9aae411e97eb554d251ca03011.camel@sipsolutions.net>
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>, Azeem
	Shaikh <azeemshaikh38@gmail.com>, Maxim Krasnyansky <maxk@qti.qualcomm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Wed, 31 May 2023 08:18:00 +0200
In-Reply-To: <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org>
References: <20230530164004.986750-1-azeemshaikh38@gmail.com>
	 <202305311135.zGMT1gYR-lkp@intel.com>
	 <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_231831_305488_5342A02E 
X-CRM114-Status: UNSURE (   7.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



> -		strlcpy(ifr.ifr_name, pri->dev_name,
> sizeof(ifr.ifr_name));
> +		strscpy(ifr.ifr_name, pri->dev_name,
> sizeof(ifr.ifr_name));
> 

> >   arch/um/os-Linux/drivers/tuntap_user.c: In function 'tuntap_open':
> > > > arch/um/os-Linux/drivers/tuntap_user.c:149:17: error: implicit declaration of function 'strscpy'; did you mean 'strncpy'? [-Werror=implicit-function-declaration]
> >     149 |                 strscpy(ifr.ifr_name, pri->dev_name, sizeof(ifr.ifr_name));
> >         |                 ^~~~~~~
> >         |                 strncpy
> >   cc1: some warnings being treated as errors
> 
> Ah, yeah, this is another "not actually in the kernel" cases. Let's ignore this strlcpy for now.
> 

Well, strlcpy() isn't part of libc either, so all this would need is to
add it to user.h just like strlcpy() is now?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
