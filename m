Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6D0C4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NXFrGy6lvMd4saqUxCLmbht8P3KniktSlOiB2KyJQNE=; b=lemVT+4ninONJL
	U2iS+hQt9ll3bUd8udWV+9kLXUy99k1XuwFs8aOnh6jZai3JSgLCabGPnrgA52OmoS41Qxr+sjND9
	f3LpMTwdC2eEnEV/3iUlFj7JLs/pvDiumgGb9sCfwPMYElHQiT+MtHBBRX4Kmy79c8ucNwMksil9z
	boS5A78Po56fV/ZZvFrxdgXEjxDDapfUMAsgR3RA7H5fVRkQKBCwXiAM9CEb5yS5/tmgomYRJj5Ly
	phaCoSYXRsx5voRzRYyhS7WVXRdLMyr+W1Luyn0s4WC6YZRihf9GOdnQCW7TsiCLWdiu+JTTjq+wd
	KSTgZ4XUCEbe1rDDWG0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PPL-008Mb6-2j;
	Fri, 10 Nov 2023 11:10:39 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PPJ-008Mam-1w
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 11:10:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8o0RjTSjCoivtffGSU28Gs/VRFnT62Zo7U58H8MqFoo=;
	t=1699614637; x=1700824237; b=Bt+IC0gH5ujvBh+kL6nQcyceLk4QbEKWU3+hPSL/p5jMqMn
	Yg5lrdNw527d3yKAt1gFwz6W6CENLtppFVJBiWqfFfBiMRVPUv8yKAqAUOo6ZdEcZUeAp6H9qPL6Y
	jhga9vmw5xN3G0zlidFWE/PkxLIbdsR61p/OXeNKuszc8beDeP9DiEr4LOVhZS+o0QMfgaTZMvOrv
	M0osVdZ23Ey3dua9SWz/Fg86hNPeJeSqpapoa926ZODgFowA162/uqtwUbaajCiZgsdrXD9Y92bm9
	8IzQuRq+ew1zwR+UfeCng3H2Tc7ucuwT+FhIxd4Vd3kklL3rka4dLY28GeKBDNtg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1r1PPH-00000002xf2-2Itz;
	Fri, 10 Nov 2023 12:10:35 +0100
Message-ID: <b94879fbac02117df724d0ef8fa4d3b3b400b8aa.camel@sipsolutions.net>
Subject: Re: [PATCH] um: hostfs: catch EINTR and partial read/write
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, 
	linux-um@lists.infradead.org
Date: Fri, 10 Nov 2023 12:10:34 +0100
In-Reply-To: <458e033f-1769-fc04-c491-e9a69058c7da@kot-begemot.co.uk>
References: <20231110094425.1810667-1-benjamin@sipsolutions.net>
	 <f0c614a6-cf3a-b6e1-6f40-ad6d59460fcf@kot-begemot.co.uk>
	 <458e033f-1769-fc04-c491-e9a69058c7da@kot-begemot.co.uk>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_031037_642390_BD796D7A 
X-CRM114-Status: UNSURE (   9.00  )
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

Hi,

On Fri, 2023-11-10 at 10:56 +0000, Anton Ivanov wrote:
> On 10/11/2023 10:42, Anton Ivanov wrote:
> > [SNIP]
> > 
> > If we are going to use this definition of CATCH_EINTR throughout we
> > might as well remove the partial read/write code in UBD and other
> > places.
> 
> Actually - some of it. In some places it will still be needed (trying
> to get my head around where this will work and where not).

Do you mean that we could just use the os_* helpers here and define
them to catch EINTR and also deal with partial read()/write()?

Benjamin

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
