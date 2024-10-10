Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F34ACF11DF
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 12:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UKA4yj87rDTn/Jo5uQ/BpYdUCPvsGLfut4O39aD7i44=; b=xtrNQNKT83lFo4/VcZmVZMAD2T
	Au5ZS9I/1bcCHXlAWQrOcieOe6bc1fxJfbyB8P2SOBKCntvWHVZ2/VDmMwAcSpkTtB4j2DR/rY++q
	j9zdpqP5o55rKTjgtfRcEkA0w1zVTr89X9K+TSbdyUMXOYYy+NVeBrQcITp3jBmsWGl0UD74+Gvf7
	XAhTIMINlnVd1TaRLft79n4hIMvKSsSRy9QUJIWRzLRXZ9PzFlqMoCILgOQ93PPAomQf9OdYpYzNH
	2rNr2WXJQbE9cJ5lA18rs3n9Z09Al179IkCwSkDbzNkumyCwWoYY7MV8LyidL8GJeA0KzN+/jbp31
	oBsRnLHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sys81-0000000Cgok-3VZ2;
	Thu, 10 Oct 2024 12:18:49 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syrfd-0000000Cbsd-2V0S
	for linux-um@lists.infradead.org;
	Thu, 10 Oct 2024 11:49:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UKA4yj87rDTn/Jo5uQ/BpYdUCPvsGLfut4O39aD7i44=;
	t=1728560967; x=1729770567; b=ySYVXmE/X41szX0mApj1qvBlFmnnXgko8biW9V34Pve9H5P
	/+4N8PzvGZ5KPD6sgwcURKgvHEvy4mvgnbel2R6yYZ7aQ85ACuFpxPMegq+VTKTrwCaGcsGDa2SaN
	q3tt8J9H1f+aZsw6YfY82QThT4vRWq8LwxGhMREy9nh58UvSTICuibYs6A750fhwCVLdvt+1io1D2
	cp34WxKAznuUu61UUBzE3us4UF5+7Q1eTlLHMAlK0SJSdK74flyfx5Tt0cYSG8pXJbq7fVlFA7L9r
	N4u1dwc3eovar0JrrjyhxYuJrvDPIH8gWQfGVubdFB2yZVVKpFMWNoEAdXjf2zRQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syrfW-000000063wL-2Kwt;
	Thu, 10 Oct 2024 13:49:23 +0200
Message-ID: <e84ac18d5a5b8d817e3039b7c445f6c4c4fdc32f.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 3/9] um: Add UML_SECCOMP configuration option
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Thu, 10 Oct 2024 13:49:21 +0200
In-Reply-To: <20240925203232.565086-4-benjamin@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
	 <20240925203232.565086-4-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_044929_707539_F77CA049 
X-CRM114-Status: GOOD (  11.54  )
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

On Wed, 2024-09-25 at 22:32 +0200, Benjamin Berg wrote:
> Add the UML_SECCOMP configuration options. The next commits will add the
> support itself in smaller chunks.
>=20
> Only x86_64 will be supported for now.
>=20
> Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  arch/um/Kconfig | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 48db1c99bd46..4698e4c8ef29 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -240,6 +240,26 @@ config KASAN_SHADOW_OFFSET
>  	  set to a large value. On low-memory systems, try 0x7fff8000, as it fi=
ts
>  	  into the immediate of most instructions, improving performance.
> =20
> +config UML_SECCOMP
> +	bool "SECCOMP based userspace"
> +	default n
>=20

n is the default so you don't need "default n" :)

johannes

