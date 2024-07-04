Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60ADC30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 09:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4veJ38LZpMoUInhxbmLW4aiRNGM3HDRb02o00JQ+FGw=; b=mNd6Zq4olij5ZYx7hTRB5jl6MZ
	f7R76muMx3vIKdkd053NtG0P0ERer053auWRs8VIvYMcDUMPlVOHPCGmZ24m0+/jBAwL/o81KSXY+
	XwNsuf8RuzO+BCczyZ+7UWNIYwxKHn0k93sWE+OkJlv4tI8LKVlQGF3SqhfYed7ZfkvJttA6kKTl7
	f+WbUiKDbqeA9vWlTrBK/AbhkEEPsolHtculAxlTEeZyhLmc+wrDqsvZ12NxUuOtDZlOnIP5qfZjD
	GSt5O0ho5YqtXvYPeTBPAb0WBBGLWs7zr23ucYKrNitDmDU5eG9gsTrWWkH4r4ZMhjBe01r61QBfG
	EhCsTDxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJAm-0000000CnXP-0zwC;
	Thu, 04 Jul 2024 09:54:40 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJAj-0000000CnX1-3I5B
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 09:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4veJ38LZpMoUInhxbmLW4aiRNGM3HDRb02o00JQ+FGw=;
	t=1720086877; x=1721296477; b=Inw39uMP1EmjMrwIWCiVjZZh3c3bGc16Zd39gbLhLbZp9UI
	4HTSWgAoE1Bzfyky1nwIgW0cJ79jg2SuL1aIQOVk5r1fGMAJ+lKmC0c9AQIGh+ZqcDuZzWL3TNVpU
	RCSIHT+vwxsBoqRdRORSrtQONBZNHvqDcLOBy2Dzlsf0Z8rmEJrRsETduLWhzZ+qtTQl4BF1H0rHS
	kMCx4d6tGDFVejqt0ZuIkf75oilD2Dlu0fPGSgsid2zyQi9XkW3Wkb3wyazaa1Zf/THfaNkY07sSm
	2h4H3Y1+3TC+jG/DVx8YDmBb43BFDINYxkPs+bUhceoCUAiJQ2y/BHbm0mV12KHw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPJAg-0000000CPsC-1QO0;
	Thu, 04 Jul 2024 11:54:35 +0200
Message-ID: <33657816fa30d286a76946b314388ecc3b3ee990.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: Replace locks guarding queue depth with
 atomics
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Thu, 04 Jul 2024 11:54:33 +0200
In-Reply-To: <8b581760-1ac3-4aa0-9257-aac2799e02c0@cambridgegreys.com>
References: <20240704072154.1716301-1-anton.ivanov@cambridgegreys.com>
	 <43f01cf5b1e55730ee06a42136a8814a61a84951.camel@sipsolutions.net>
	 <8b581760-1ac3-4aa0-9257-aac2799e02c0@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_025437_841769_A4618023 
X-CRM114-Status: UNSURE (   9.11  )
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

On Thu, 2024-07-04 at 10:45 +0100, Anton Ivanov wrote:

> > (it probably also never even executes twice unless you actually have SM=
P
> > or preemption?)
>=20
> It does. If half of the vector is at the end of the array which is used t=
o
> imitate a ring buffer and the other half is at the beginning. Quite a com=
mon
> condition actually.

Ah, right, I missed this bit:

                        /* Adjust vector size if wraparound */
                        if (send_len + qi->head > qi->max_depth)
                                send_len =3D qi->max_depth - qi->head;

> There is an extra issue there - stats. I need to double-check the locking=
 when
> they are being fetched.

The memcpy() is an issue, but I think reading them individually should
be OK regardless?

But I suppose you could just take both locks there, hopefully nobody is
accessing them _really_ frequently? At least I think you can take both
locks since now no other path is taking both? But you'd need
spin_lock_bh().


johannes

