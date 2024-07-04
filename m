Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B202C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dfUCPpq8Z7FlyXGWgTHnCEas06aKEHGdYdP5nT9wSEA=; b=k4BMzsvkefWsXDDR18wRoBqhhh
	f/k7ypmyz5EVEqaL5lhkOrb2AsqYwsWh45UEYNcVm6Nv+ubUR+nVOVkj96MzD4cVvos7tGivE2Um5
	WLh3J3xD3LXIyFyeoed/FGy5/ntU8gIFD7khMXtxGrII9gXADacVjx8gucDQcuCK5Z3sGpwHqXAvW
	j9QlhiwNw9wUV4kE4rgJSwuOZUHGccZxWDgieOKr3hufi1MjGzZQIO3A6hV4mx8nbpRwtcQg6v7fN
	J0bgXM+axwBTeufZJLJOeMcooAmdFvKPEVluarirB4LmNsVd6fuT5+wz31ZRz+Gw9uVyrl9AV/ZgK
	FogwFo/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJCc-0000000Co1L-3sRU;
	Thu, 04 Jul 2024 09:56:34 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJCY-0000000Cnz9-3YrT
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 09:56:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dfUCPpq8Z7FlyXGWgTHnCEas06aKEHGdYdP5nT9wSEA=;
	t=1720086990; x=1721296590; b=u3lUFlZ6klnQocamyWUhUrRsAvtXnVFDeWCxK8dXnZ26t7z
	Rq4JxBxiJuZck/bthtEPdhP7CwxV20K2ISe7OJsVZ6ecm6orTBy/MGchreUcb6/5Tjl040AgK88Rz
	gM/yqDyYt6Ri5bUeda63rXK/COKp6UXQh/yWvUrA5Fj5bd726pM66UzP36A3v724wBO/3BZwdByPH
	jf83p+UoSBeJjfD4CJPT6OyagyVjaTGWAyByFBXeE14XM1cwh+XGaIFsAcBjN4/NnUwygBTy9XEHn
	C82jf9KfRvCh4p8iaSE+x2DYF0FkEDAmUinO19SJqcOQouXoWmjGqkecpmPf70mQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPJCV-0000000CQ9u-48RF;
	Thu, 04 Jul 2024 11:56:28 +0200
Message-ID: <3cb4adf8a25fd9d110ff805e6713268eb429e0ee.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: Replace locks guarding queue depth with
 atomics
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Thu, 04 Jul 2024 11:56:27 +0200
In-Reply-To: <78132ecdf0eecd3b78c16499989c1a36ef7c8603.camel@sipsolutions.net>
References: <20240704072154.1716301-1-anton.ivanov@cambridgegreys.com>
	 <43f01cf5b1e55730ee06a42136a8814a61a84951.camel@sipsolutions.net>
	 <8b581760-1ac3-4aa0-9257-aac2799e02c0@cambridgegreys.com>
	 <d9367dcf-5383-4dc4-ac84-fae5e104eccc@cambridgegreys.com>
	 <78132ecdf0eecd3b78c16499989c1a36ef7c8603.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_025630_918751_219784FA 
X-CRM114-Status: GOOD (  10.17  )
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

On Thu, 2024-07-04 at 11:55 +0200, Johannes Berg wrote:
> On Thu, 2024-07-04 at 10:52 +0100, Anton Ivanov wrote:
> > >=20
> > > There is an extra issue there - stats. I need to double-check the loc=
king when
> > > they are being fetched.
> >=20
> > Same story - these need atomics. Otherwise we can potentially get the s=
ame ABBA
> > lock issue when they are being fetched.
> >=20
>=20
> Email overlap ...
>=20
> I don't think so? If no other path now uses _both_ locks, the stats path
> can, it'll just be "AB" never "BA".

Or just split into tx and rx stats, and use the correct lock separately?

johannes

