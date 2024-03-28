Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1751C54E67
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 13:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eKrrFlQsP3g3t8tu3t235omjg4cJpaXC8DlorBooGfs=; b=okTWces8awF7lMvhF0r9CICUi6
	J07/pcDmSjze/9P3Vbgxzon/zsmMlSzVs3U5Jc+Zs11Dr00MmkpElfywZ2H2WqSibRHg9i58rNxfp
	NYqrwi30fpGRibdZL6qwyLPGNldjqupiM8qh/akIBjZLOysMomps/7CcwB5/tB42OMUr/FPU7lbHX
	B3GUePt06n38kd0yTbHSccjTzzg8XrGA0B3qWdbYTnAkCroki0yI/MVRdI9uXvG+qkYYICG+tNPhU
	Z+6H4au4ZcLjPJ1NCQVlRVstTDQosiG7NdO8Uf6GW4+78M9B0KnQ6DZ7ZAjGe5YMvNBKtdK5qpk6R
	PjPu1Y6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rppn3-0000000E6bT-3xl5;
	Thu, 28 Mar 2024 13:27:33 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rppn1-0000000E6au-2kSs
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 13:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eKrrFlQsP3g3t8tu3t235omjg4cJpaXC8DlorBooGfs=;
	t=1711632451; x=1712842051; b=ttQhN20d9YWa4xsVhFOnhYjsjk/kFJdWEnjeL5QTG7P1828
	VoPTaEleYvVJ2BcOna3uZMUQNxs7v1ijwUoikQ7OfDXNWAEvpM/R1ussb1O8jMJHko42ngEHBtJW4
	GWF1NJRp9f1b+E3WapaqDs5Ste30nKzkDiXwJUbMAhMlUDOYZlCGT2dURWcV7yaMUphc/17IIbedp
	KbEwnUiPu7zbKLScit7w1bfRmHF00UQELSMlyEJMxfWVUKRZ6eYPrwgHmPkN3EDUhxP0YVHRSbXXp
	nRljRmjo8thNF3RRnrNMWGGk/1kK7RC2ZSJHGW0rvq7pmOBZpMEj6x88JGu1WrbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rppmz-00000001055-1bc9;
	Thu, 28 Mar 2024 14:27:29 +0100
Message-ID: <28036aa40978e288326ce2456834e4d02e83b373.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Remove obsolete pcap driver
From: Johannes Berg <johannes@sipsolutions.net>
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Thu, 28 Mar 2024 14:27:27 +0100
In-Reply-To: <20240328132424.376456-1-anton.ivanov@cambridgegreys.com>
References: <20240328132424.376456-1-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_062731_712969_0A0B5A45 
X-CRM114-Status: UNSURE (   6.06  )
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

On Thu, 2024-03-28 at 13:24 +0000, anton.ivanov@cambridgegreys.com
wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>=20
> Remove the pcap driver in UML. It is obsolete. It does not build on
> recent systems due to changes in libpcap and its dependencies.
>=20
> The vector driver's raw transport in UML provides identical
> functionality.

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

