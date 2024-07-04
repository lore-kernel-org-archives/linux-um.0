Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFECC3271F
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W/xbJmzP40eYEcWPUnYFihOt2h1sAJEMU2WElyiBQdw=; b=ZgEUB1cFq/jZvdddsfKPLm9tkP
	TPJjkRLkXZFqGCKGkHAhQJGTkaxmHHjpboDXTt977QNtCDf1xjDkGuz/MWkqA7bH8uJ0x3dyBjETB
	HOBH3TcenoHyYBy3NUseq24CH1A3wYBCPyDJFSmRXz6BYwppZBaPasjJ7Gqker8CzDIJQpdR0ollT
	Lpo/3tg5XvYoW0nSmcV/KTEOHzZqaFp5B3IeLG6nS7UmYXntE/JV4Kq21emH8H4+h2cz6QEEu2qcS
	da4HjOojH+YDSfxMLkloKwcbzJRcJn5+u5O/7vtCqNpBYamWCSLV4VGAznNkmFWkuUBaMb5ufe03L
	edD2J6Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPPfX-0000000DtVK-0ZQA;
	Thu, 04 Jul 2024 16:50:51 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPPfU-0000000DtUs-3f1o
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 16:50:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=W/xbJmzP40eYEcWPUnYFihOt2h1sAJEMU2WElyiBQdw=;
	t=1720111848; x=1721321448; b=ouF6idi79n6bUkIyc5O+U8Na72qDYrsOuapm5g/f/pKAKZz
	CUDKAtstt3pA+QyVQoTsdePkiw0ChX+1hWLxYQ8kjJQSHYQrx9W+siGK+z/ufCiVRPv8f7+ezDFyx
	TuRPlh25b2urj5V4eUT5/nzNZNxKGwimydgXk+46Z/+JTv7meErZcGuIkSbQELBPZvhc5CPx99vXt
	pMMNeyAaQEdMbm1awaqCtjgCdpH1nd6oMKr6iaBsva9V8D2/e4cgCCLE18IqDB9F13aIfEtEzCeIX
	1EMHfQyEQ3No/UJIdh/28H4uEctez7g+NzaKAzWej9VCQ9MVQT93opDZVI2v7uVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPPfQ-0000000DU5S-3XSz;
	Thu, 04 Jul 2024 18:50:45 +0200
Message-ID: <e218d5c1ed8b353951cd27fd485c3a9d82ac8f7e.camel@sipsolutions.net>
Subject: Re: [PATCH v7 6/7] um: clear all memory in new userspace processes
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Thu, 04 Jul 2024 18:50:44 +0200
In-Reply-To: <20240704162717.1417338-7-benjamin@sipsolutions.net>
References: <20240704162717.1417338-1-benjamin@sipsolutions.net>
	 <20240704162717.1417338-7-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_095048_931586_E1274697 
X-CRM114-Status: UNSURE (   9.44  )
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

On Thu, 2024-07-04 at 18:27 +0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
>=20
> With the change to use execve() we can now safely clear the memory up to
> STUB_START as rseq will not be trying to use memory in that region. Also,
> on 64 bit the previous changes should mean that there is no usable
> memory range above the stub.
>=20
> Make the change and remove the comment as it is not needed anymore.
> ---

Missing sign-off.

johannes

