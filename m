Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776A6C4453C
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 14:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/aXBmBSUNfUqnSU+qGwU6mWywoGYv0nZXcN1RwypNkw=; b=lqdx6Wrfbh60NtOkGXVR4238Um
	PiknQl+g4csNk+fh8n4Naj5wVWhrasiXoi5B9Sq2Fltx2aU8QaINHVDYonsNxbCDG6E1xhdxQqM9K
	fRxQhIRvpLUka9OEwn24XGDURTBCp+mDh5DzPtCF79XYEFRALraW12o9Z0Q9q+JihKdRGT1nPHT1t
	gklSRX/V0Sumsz/eZBAowAAOLzsf3afFI6Ho1SqWcQFv8BI86pNOotQT8BPfFhMpCK/sQtkNFl4CY
	ob0SvJrhPSSrUDcXEEB+VarwViShUENEfCEnxAT2ecMTbtxEU3qES6SR4WwsFGiflDZFZYGDSr+/H
	ocW84IiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmXX6-0000000Bz3D-0bwu;
	Wed, 22 Jul 2026 14:02:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmXX3-0000000Bz1j-2Yvz
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 14:02:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/aXBmBSUNfUqnSU+qGwU6mWywoGYv0nZXcN1RwypNkw=;
	t=1784728965; x=1785938565; b=irQiNHmJiwLxHisZD2HfO7mSL+A23xi1OOwG8T2QwBC8GGQ
	zbRmjOLNkyIxR/8Pj4Id9RH8KMBSFg23ch97xL9h1b9n9mmZSKwHx3cLcxjvJN+ln7ojuIMCbybXG
	h9o2DhxEG9R7I+Py88DO99BD7gVYKcUq8atwVeO6rFsQ80YkJHvZX4ZbKcrsnZ6L6jpKFd1wHlPui
	S9kU/sBajgGuKb35NBib/DIWW2scbwwZELabsjWv6qKYZ1mKqmIkKoNR9mFUuWZDnbG9hZwRskfIn
	3yxr6GXB+hSbKAZkIjYudJlTcVWWaOd0p8Uyaq+dQw5Q1IP9wosOVM/EnrdeDeVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmXWz-00000004nZP-02Zt;
	Wed, 22 Jul 2026 16:02:41 +0200
Message-ID: <8b710b01b8117d41281595265da43ab0add10214.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Allow multiple symbol definitions for GCOV builds
From: Johannes Berg <johannes@sipsolutions.net>
To: Alex Hung <alex.hung@amd.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: Bhawanpreet.Lakha@amd.com
Date: Wed, 22 Jul 2026 16:02:40 +0200
In-Reply-To: <75f2f98c-78df-46df-9961-6ddf2870d044@amd.com>
References: <20260708224006.3405038-1-alex.hung@amd.com>
	 <743d1be771381c86c7f264810d88876976cc508f.camel@sipsolutions.net>
	 <75f2f98c-78df-46df-9961-6ddf2870d044@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_070245_646725_3435924A 
X-CRM114-Status: UNSURE (   7.78  )
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

Hi,

On Tue, 2026-07-21 at 16:23 -0600, Alex Hung wrote:
> >=20
> > I cannot see how that would possibly result in correct behaviour (beyon=
d
> > being able to link)??

> Good point. --allow-multiple-definition silences the linker error, but=
=20
> picking kernel or libgcov's mangle_path() will break the other at runtime=
.
>=20
> I saw your previous patch=20
> (https://lkml.iu.edu/hypermail/linux/kernel/2103.1/06604.html) to rename=
=20
> mangle_path() to seq_mangle_path(). How about reviving it to avoid name=
=20
> conflicts instead?

Honestly, I completely forgot about that. Looks like I ran into the
typical "nobody wants to merge it" problem ...

johannes

