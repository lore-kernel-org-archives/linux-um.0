Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CD8C2BD09
	for <linux-um@archiver.kernel.org>; Mon,  1 Jul 2024 19:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1+AkheY1qO/EdNutLDSeGwioQmleVh65EjV3xnXW8Gs=; b=jRJK4m7vaDMospzo8TVP+wZtmU
	Mf3lS2H0WvkkAfHFkABzzXwAH8lW4WwSDTkwL+hh/FjZBTR0Dtga+uyiIBWgCQe7BYWrsh/P7CDbk
	SRdso8Ami27M43xzqIS2ObebVz6M4JR+RGRo3JDDYDvy72ZbHPbQx8hXlp0xGnBzcmI6OmEWGxvWw
	gj0ITwgcCViGm0Vxx4I+h/MSM7olYBN8PV5nkmu0RKOkVT/E3FsNGdu203+BP71weOHcQLnOpDM+d
	c6lzlu5fSs9If3paVkZeWZhUueuvbjkfu4ikW4CoUP4FP8ZhtKxULoxOIHB8OD5wipXvOg9+d42XO
	EU+mGE0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOMP5-00000004aIF-054t;
	Mon, 01 Jul 2024 19:09:31 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOMP1-00000004aHa-45Pg
	for linux-um@lists.infradead.org;
	Mon, 01 Jul 2024 19:09:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1+AkheY1qO/EdNutLDSeGwioQmleVh65EjV3xnXW8Gs=;
	t=1719860967; x=1721070567; b=NRPPFNXwyba4llj1kkra5LL17AnCWMN2B9vqqxgLx+XoMpg
	XspQNSUIzuZeKXq86VRXSq85QyNV+zCQuz0Dv1Ae3kcDut4iYprUvsyBOcVwg0b8lbQUjZM3sZqJh
	ZwoHpvb8CNXfTZwyvsjJ6eidJuaxeA77rMkmRu7XcmJiMIA3K6jBjs32y/7Pxg/BTEYktI2JmSdjo
	0SoGLAO9LaaCMo/dCI5yVZAFxgW2m+CirfS5wik28+Eb1E/qNmWEWVZtfE36AmPuB73xPGjO5jOgt
	zsNGkjgIsmwMwVoxGKgNosYfxtyUliOsrQSVu0gUp6G/ApVnyHcCbKXlzvNARcEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOMOy-0000000368o-36xo;
	Mon, 01 Jul 2024 21:09:24 +0200
Message-ID: <f66a4586fdf321bf8778698d49b2629bdc0bb8c2.camel@sipsolutions.net>
Subject: Re: [PATCH v9] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Mon, 01 Jul 2024 21:09:24 +0200
In-Reply-To: <733d5ed2-d085-4422-9d46-4c14426f56c4@cambridgegreys.com>
References: <20240403062754.124752-1-anton.ivanov@cambridgegreys.com>
	 <6969757a8347ad5171a651fb668a28613b08176d.camel@sipsolutions.net>
	 <4137d6ba7d380fed13f8edc1147211b4511e8bfb.camel@sipsolutions.net>
	 <c6056c4a2d1cb549ae2c0b010de912e8ff38ec8f.camel@sipsolutions.net>
	 <733d5ed2-d085-4422-9d46-4c14426f56c4@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_120928_033716_495050F3 
X-CRM114-Status: UNSURE (   6.77  )
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

On Mon, 2024-07-01 at 19:55 +0100, Anton Ivanov wrote:
> >=20
> As Benjamin pointed out we no longer need this, so we can junk this=20
> patch at this point. If there will be any need to save/restore FPU in=20
> kernel context, I will revisit it.

I think we still want/need the parts with the preempt_disable/enable,
and Kconfig though?

johannes


