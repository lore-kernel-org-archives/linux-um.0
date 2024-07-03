Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F763C2BD09
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 10:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6VVaJjUHolqbPfOosQJDJvLSCQCfRIiDsfa2LqOaVG0=; b=M9v+Vdaa0J3T3dSj56LTcxu8Qz
	L9T+hmzKWeqCBfvnzXG+3DUU0+SbQ9NmdKAisvtSKtx9hCqaCcRdX/BwDm6MLDg9DqnwD5RJpx0k1
	JnvBOWFEF8+JH+y/Z+HL78Dfn7LWpfkLtsZakazMRuxYQVjGkrmQT45SZFVJa/Xyz0Qvu+QlgQz/o
	MxQxLbzSFt3XVuVHkabtVySciK+nvksKlosPpTlyh+pzjor114DuAr4VgWg8wU33evdMWLCnqq6Po
	vje5xBPkN9c6cRuGc/wCJ0OnBG6MKww6LGvvpjwqvwPjS8pPifyI+ElK7JYy7YFgEK/ACR8/sB8V7
	sICvqEdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOwwM-00000009go9-2u3D;
	Wed, 03 Jul 2024 10:10:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOwwK-00000009gnH-0eYo
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 10:10:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6VVaJjUHolqbPfOosQJDJvLSCQCfRIiDsfa2LqOaVG0=;
	t=1720001415; x=1721211015; b=FdlgBMf4ViW0EW7wp7h+x9PyztLsziVE+9dGOoSVMKUrttr
	uHPlAi2X4L2w2tCdW037kW9yMaOIK/2FujW8NbTrejRAzPqX9rkr19RykcqOGk+GxpU50fwFnC0yz
	I7/HbkucawDDP3VvSboL5yd2pddS12Zj9+h2phZ/zK7PWWSxJ/tl5fcUJQOO9A0MwlniQVcuNUw+M
	6rvBRcJWufdRSlhwnXqsiAtR0w9SKUJmMIreM37obwbkQaFSO2XQH8CP3xAx4LmBGE4whvQMu8R2l
	UPz0ZBfxG2ORtvKNZCGQiWE5bu6rXbHVLsEmCJxYMWv5ycAXZLZzDamVbvOYw+/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOwwG-00000008Zy4-32uU;
	Wed, 03 Jul 2024 12:10:12 +0200
Message-ID: <efda3d88c20ff9044cdb7e84066d307adcfbeb11.camel@sipsolutions.net>
Subject: Re: [PATCH v3 10/12] um: remove force_flush_all from fork_handler
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Date: Wed, 03 Jul 2024 12:10:11 +0200
In-Reply-To: <f78b8fc811194acb87c091b9064fb7446894f5cf.camel@sipsolutions.net>
References: <20240524213718.1757703-1-benjamin@sipsolutions.net>
	 <20240524213718.1757703-11-benjamin@sipsolutions.net>
	 <2784bb3e9de2ad88a48d8fa70b01c46e1b2399fc.camel@sipsolutions.net>
	 <f78b8fc811194acb87c091b9064fb7446894f5cf.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_031016_214791_C278B052 
X-CRM114-Status: GOOD (  14.26  )
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

On Wed, 2024-07-03 at 12:08 +0200, Benjamin Berg wrote:
> On Wed, 2024-07-03 at 11:45 +0200, Johannes Berg wrote:
> > On Fri, 2024-05-24 at 23:37 +0200, benjamin@sipsolutions.net=C2=A0wrote=
:
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > >=20
> > > There should be no need for this.
> >=20
> > "should" ;-)
>=20
> Hmm, I would have expected the previous patch is what breaks it.

Ouch, you're right, I replied to the wrong patch - bisected to the
previous one indeed.

> > This breaks things if glibc enables rseq. That might even be already
> > broken in the sense that it might corrupt memory that's put at the same
> > place the rseq was installed? But it at least it appears to still work
> > without this patch...
>=20
> Then it would make sense to me as the previous force_flush_all would
> have only unmapped up to TASK_SIZE. While this now uses STUB_START
> which clears more memory as TASK_SIZE has some alignment.

Right.

johannes

