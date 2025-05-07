Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC2EC369DC
	for <linux-um@archiver.kernel.org>; Wed,  7 May 2025 05:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LEtuTQ95S5zNWQ6ILd3h8AYtfPMOrGBJmza5TNoXkrw=; b=Ce/NWldA1NTjrC8pD3HIbm9f1B
	hnX46znf1F2MMt3S7vl+L1Z8KDciYqHq3cua54RG92PcqUXGzzvrvA5b18tLDuPGX3UIkv/rK5tec
	/RUfU5NhGi7lH4oB2olVImqdugVz8W4KJO5MBFzBVs+b0I69QHdRP+qkC5jqINW3JZQ+9ArF7ERNr
	KEL8yOe9e7wDjk3Oq3AcRjVD45VHMyebQPyHHHj0m0vSDrr0RGwebgaAeKxoiwz4FcLAqffqq0vAL
	ToFvAIp2AW8kWxIbwumaOv0gp6u3s0QmmoTf2+jyZcPV7IGOuAsCehqaNxHZgQJQ7A4f5mjKklUnN
	ERnJiqdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCXZa-0000000EI0T-3DAZ;
	Wed, 07 May 2025 05:44:02 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCXXR-0000000EHoJ-2PyH
	for linux-um@lists.infradead.org;
	Wed, 07 May 2025 05:41:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LEtuTQ95S5zNWQ6ILd3h8AYtfPMOrGBJmza5TNoXkrw=;
	t=1746596507; x=1747806107; b=fZ3GIziWD8QeQp9HQ4HzqgD9IaisLC4TgKOZXtYgezPowvs
	n2G6EdpKM4xnleWtJmR+uZ3Wp6GUj5pjV0+3jTVOUfg5y76SnvMBknJTKczCfDsRd3RgsDCqhsCu7
	Iv0LvYLZ5j3I2dbIN2j4uKWXA8AeGxen7KlQhoqJUc49GgQ3YjdNOxDr082qirf/1i6Si65lFTOQu
	1v38jacMjN/pbPZ7qeT9G2esBrjO2S6DWDz5JHvKzc16qWPXg3V8mURO1FIMz/p5BeDE9SAXaLdcv
	Eun2Q5f+Wv2Bwaa0vPYiFiSbL+RJ7hKBm36IoQPB9+ycepgDj3Ya1/+HonHu5EXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCXXF-00000007LGf-2K7m;
	Wed, 07 May 2025 07:41:38 +0200
Message-ID: <1fff027e24110fe1692ab8bef06da99b31391b00.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Include linux/types.h in asm/fpu/api.h
From: Johannes Berg <johannes@sipsolutions.net>
To: Herbert Xu <herbert@gondor.apana.org.au>, kernel test robot
 <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-crypto@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton
 Ivanov	 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Wed, 07 May 2025 07:41:36 +0200
In-Reply-To: <aBq6X-UYlQG9HUQd@gondor.apana.org.au>
References: <202505070045.vWc04ygs-lkp@intel.com>
	 <aBq6X-UYlQG9HUQd@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_224149_611119_B035E598 
X-CRM114-Status: UNSURE (   6.92  )
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

On Wed, 2025-05-07 at 09:41 +0800, Herbert Xu wrote:
>=20
> I'll add this to the crypto tree if it's OK with the UML maintainers.

Sure, seems trivial enough and nobody is likely to touch that file.

Thanks.

> ---8<---
> Include linux/types.h before using bool.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505070045.vWc04ygs-lkp@i=
ntel.com/
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes



