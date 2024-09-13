Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D335FA3741
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SX4zdsozc2X+QR5od44zthTHEvyPbLhpoxxc0Sx6RW8=; b=FqZHtCYRZyS7FbOwK9Uf7Yz6+g
	WMrb7FhMEKW3iRQIGDT9u9tAC2N6GDrhQ0gTr8eHFHBIaQmoll9KAWsU8dQBi8p9mXtm2sXRafhax
	r/54Tv1/ZJzlzYr12uV3QjWDBBGQSJLxLcvWR9gBeSMNwapxkBpPhgfQhXIXX0PYX2VnBDFmOcwEG
	IxrJQYpEd2fPYSSLHCxKo69bisIn7myRCY7peZ/FCNOvIFMkSN1I8JnS3Gdc71tfWpIhQqOt5s4+y
	KcDRcdirkfz/AmXaU2nBZQrIQHEECCTJQJfhTJ5Py/XOwvCKtmCNmFBwhaV+Fp63NOy6yWmrhPW2E
	JD41bg1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp3ub-0000000Fg26-29bG;
	Fri, 13 Sep 2024 10:52:25 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp3tG-0000000FfuB-2Cun
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 10:51:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SX4zdsozc2X+QR5od44zthTHEvyPbLhpoxxc0Sx6RW8=;
	t=1726224662; x=1727434262; b=jxFZoHw8YpXLG3w7d/IHHDJRcD4EhuV3L8PqMBUJJUJgG+I
	Kz2SMPqCA10D9siZ//lKOrhFL9TEF6VNkLmEY0HnflTzgNk9ucVSSz/PAYdtsTaan/shV+QtKbaWA
	nQWuJerW05jkrVT++ztgAyOt/eZGNYVGL7MLEKz/45ODECEwotDxTmARE3/oAotRQqJL5L2Z+l5wV
	tsVCmYRr1qOA1D3DpLEiGOoza2LvCU5R41tnZ8DQPHGZ2wTHPEcmCiR0KQCX8T/udFPoew0le+4a+
	1TROsL4EsUC0OLUSTQitQqpNBq8BSUj9Bo2aaoFqWwTAOj32TIPeqnWt+5frczoA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp3tE-0000000G80N-0Msa;
	Fri, 13 Sep 2024 12:51:00 +0200
Message-ID: <0675ab7f16dc0b8f02e4c162f2e42fb66046feed.camel@sipsolutions.net>
Subject: Re: [PATCH] um: add RCU syscall hack for time-travel
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: linux-um@lists.infradead.org
Date: Fri, 13 Sep 2024 12:50:57 +0200
In-Reply-To: <CAFLxGvxPM9x9ay7+7Sv4wwPFKM9keZGfy9C2=5Cbk-_BUf88gQ@mail.gmail.com>
References: <20240830153825.1466691-1-benjamin@sipsolutions.net>
	 <CAFLxGvxPM9x9ay7+7Sv4wwPFKM9keZGfy9C2=5Cbk-_BUf88gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_035102_582833_D86E150C 
X-CRM114-Status: GOOD (  16.95  )
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

Hi,

On Thu, 2024-09-12 at 21:02 +0200, Richard Weinberger wrote:
> On Fri, Aug 30, 2024 at 5:38=E2=80=AFPM Benjamin Berg
> <benjamin@sipsolutions.net> wrote:
> >=20
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > In time-travel mode userspace can do a lot of work without any time
> > passing. Unfortunately, this can result in OOM situations as the
> > RCU
> > core code will never be run.
> >=20
> > Work around that by kicking the RCU using rcu_sched_clock_irq. So
> > behave to the RCU code as if a clock tick happened every syscall.
> >=20
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > [SNIP]
>=20
> While I acknowledge that time-travel itself is a beautiful hack, I'd
> like to keep the hacks
> to keep it working minimal.
> So, the problem here is that RCU callbacks never run and just pile up?

Yes. A simple example of this is doing a "find /". This will allocate a
lot of inode information which is only free'ed at a later point.

> I wonder why such a situation does not happen in a nohz_full setup on
> regular systems.

Had to search for a bit. But, I think the boot CPU will still have a
tick even on a NOHZ_FULL setup. see the nohz_full=3D boot parameter.

It does look like the RCU code might try to force scheduling (tiny RCU)
or wake up a worker (tree RCU) in these situations. But neither of
these attempts is going to fix the situation as there will be no call
to rcu_sched_clock_irq with time-travel.

Benjamin

