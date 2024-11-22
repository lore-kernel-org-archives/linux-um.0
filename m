Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA11AE65D3F
	for <linux-um@archiver.kernel.org>; Fri, 22 Nov 2024 09:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KqKwG87BOhNBp9dKTgOo7Io++iQzzo3AhB7LBoi2ljU=; b=sz1Ql3oDv9MR8isFUk/ek5ARZG
	bRC9hTJVuAx57Gn5G4VV4nqOzR1uZQIVbbtuR44W3GeuPonsesUt5PlOJCLXRAnp0YEMWNy1X3w3t
	+EMI5qLFBndSzuEdj4rZziUthHbrdUAosp059KQeEh5tDuLL5oSxVfZsxStFhU+q2H27eP8G1hXzg
	/f+07Y3iJD3eRpZS13M7WfrIXkoYTNvyVHYi9LuxJOzwdAZu2fXkrfsrXh9ZcG1hZa3JKQiHmFOz/
	OYnh1AjXAaxYT3ORmq0uhm+6mZccRS2rwLAISa6GO5p0FHdmfGM+YPMj3Jbyhsq5D9q7nk1A4Hfi6
	5n62usAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEQLx-000000029Z2-0R12;
	Fri, 22 Nov 2024 09:53:29 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEQLu-000000029Xt-2wOL
	for linux-um@lists.infradead.org;
	Fri, 22 Nov 2024 09:53:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KqKwG87BOhNBp9dKTgOo7Io++iQzzo3AhB7LBoi2ljU=;
	t=1732269204; x=1733478804; b=NAzjrDFkq3BGhAGeUJ2c1z1aikHfYRR3RQTfv6pPW2ltPEJ
	Ve7IPLKUPUsgAF06stZgfAuJath+9iRBTFmngQq/TAyielq4hczkoXK2IUV+5568r5gH3VIf7sbpr
	pW3jkGXCaWT7u+RD4W/wLpU16G4hTLjUAbhAwyC0195U3X1lD2SJkMH/yjhKexXrc3ro4gvsj/Og0
	io2ZmATw2oheSqH9meU3lCIa+v62HynmPMeLQeN08Bpsb9AeTlpYyns0Nk2a8BYl5td3c/8iuK8Wg
	PaVL9S9zLKE1EmjwoGpmAkQ4/ZgKij0yBcvaObn551JPqQoqaFZGmq3Q4t3aZagA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tEQLn-0000000BWH4-1sf6;
	Fri, 22 Nov 2024 10:53:19 +0100
Message-ID: <0930a0fa8e28ecaf92727229e6633278399409e7.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 00/13] nommu UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Hajime Tazaki
	 <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com,  vbabka@suse.cz, linux-mm@kvack.org, Jann Horn
 <jannh@google.com>, Christoph Hellwig <hch@lst.de>, Damien Le Moal
 <Damien.LeMoal@wdc.com>
Date: Fri, 22 Nov 2024 10:53:18 +0100
In-Reply-To: <77ab71c7-3608-4636-a618-3044c2316a92@lucifer.local>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <cover.1731290567.git.thehajime@gmail.com>
	 <77ab71c7-3608-4636-a618-3044c2316a92@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_015326_811978_CDD88C9A 
X-CRM114-Status: GOOD (  11.41  )
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

On Fri, 2024-11-22 at 09:33 +0000, Lorenzo Stoakes wrote:
>=20
> In general, while I appreciate your work and don't mean to be negative, w=
e
> in mm consistently have problems with nommu as it is a rarely-tested
> more-or-less hack used for very few very old architectures and a constant
> source of problems and maintenance overhead for us.
>=20
> It also complicates mm code and time taken to develop new features.
>=20
> So ideally we'd avoid doing anything that requires us maintain it going
> forward unless the benefits really overwhelmingly outweigh the drawbacks.

:)

There aren't really any benefits to ARCH=3Dum in *itself*, IMHO.

> There have been various murmourings about moving towards elimination of
> nommu, obviously this would entirely prevent that.

No objection from me, but e.g. RISC-V added nommu somewhat recently?
(+Christoph, Damien)

So we could argue the other way around and say that while we have other
architectures with nommu (like RISC-V), having ARCH=3Dum could simplify
testing by e.g. allowing a kunit configuration in ARCH=3Dum which is
simpler (and probably faster) to run for most people than simulating a
foreign architecture.

Anyway, I think that's where I am with my partial (and very limited)
ARCH=3Dum maintainer role. I don't really care for having the feature in
UML itself, but if it's useful for testing nommu architectures for
someone else, it doesn't seem too problematic to support. And testing
such things is also a big part of the argument Hajime was making,
afaict.

johannes

