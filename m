Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260CEC624D3
	for <linux-um@archiver.kernel.org>; Tue,  1 Sep 2026 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ROFHdh5YcxFRur32+u++7A9cnHI72YhPCUV519Syh7k=; b=P3TXv3/zdCP7YdPfQUxyacUzkW
	HBCDBzWAe3L2584CPvOsA228gZ4VzLPQzkiYEYoj6zeTItyQ51zkyXIOHQriJCxZfVP7TP6rYG1Tp
	B1kxsreskcKHLncpLGu3Knknn/DLegYnPkSFQpBZ0asgQ/OhoelDqoJEp2CoGugg8Ki+8mTpLQs6R
	BnSyPcBS+hLXzc3KaJ4Ae+5R+oQk0ZZMjvCORq+c8etWHYCMto/5GwrugBm8kamZdVIPSHQfGlDdQ
	DD/bUxNqLgqjrUG8YsJX6ysd0RD7m/JW/MHEF1uzsXmJo2ultg+1IIclOm1kba6gIhnCjAlgiOQ0M
	AgmjU3KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1PUK-0000000CL1z-3B4C;
	Tue, 01 Sep 2026 14:29:24 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1PUH-0000000CL1C-2KW6
	for linux-um@lists.infradead.org;
	Tue, 01 Sep 2026 14:29:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ROFHdh5YcxFRur32+u++7A9cnHI72YhPCUV519Syh7k=;
	t=1788272961; x=1789482561; b=xwuD3MM3CQff2LUaxNvLRp8IabJ6Z7K3OAfxSfNlPVdf1mC
	GezLTTEpPt+hqP/lLyNg24/Oytz4MFYMRWtHI/7YkvbMP1GNEsvDLvfdd/m/5HFncyiM3FM0/R57s
	Z5Yjww3DXhNQBlBP22ib0CwwZNoVgrPPnr6NBLyCAL/lrX3hFlxqzq/feApl7DsD9WBOwUYNCISHF
	3O8O0LcOxolgj6AGHJeik9b4yUUH4sFwCL6SxrcD0XILJ2b6ASMDjZTqMms9fSZQp5OT2a9yQeWt1
	eyQqtFgSK0xQ2BtTJqqc44lGRlG1VZ8tN19y9jW95VuKQR2JI9LA9K/+a9ahx3NA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x1PTm-000000062mY-3a8R;
	Tue, 01 Sep 2026 16:28:51 +0200
Message-ID: <40e95edb8dafd88fd13c3003c0e76df6a2f124d9.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/2] support kselftest on nommu platform
From: Johannes Berg <johannes@sipsolutions.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Hajime Tazaki
	 <thehajime@gmail.com>
Cc: david@kernel.org, linux-mm@kvack.org, liam@infradead.org, rbm@suse.com, 
	akpm@linux-foundation.org, luto@amacapital.net, brendan.jackman@linux.dev, 
	liuhangbin@gmail.com, corbet@lwn.net, kees@kernel.org, broonie@kernel.org, 
	mhocko@suse.com, rppt@kernel.org, shuah@kernel.org, surenb@google.com, 
	vbabka@kernel.org, wad@chromium.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, 
	geert@linux-m68k.org, daniel@thingy.jp
Date: Tue, 01 Sep 2026 16:28:49 +0200
In-Reply-To: <apAgQJ5p8LEDj1c5@gremlin>
References: <20260825015945.141739-1-thehajime@gmail.com>
	 <f2ac9432-4fea-4007-aab0-ad80597b284c@kernel.org>
	 <ao2Tl9CLL7WjHYun@gremlin>
	 <bb9a3add-4849-4928-8b6a-0afc0c73b112@kernel.org>
	 <ao2l9Ao7BQI6uRKC@gremlin> <m2y0dsuf1d.wl-thehajime@gmail.com>
	 <ao_541nBaa3SJS9F@gremlin> <m2v78wueir.wl-thehajime@gmail.com>
	 <apAgQJ5p8LEDj1c5@gremlin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_072921_589351_AA4F2EDD 
X-CRM114-Status: UNSURE (   7.50  )
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

On Thu, 2026-08-27 at 12:32 +0100, Lorenzo Stoakes (ARM) wrote:
>=20
> Ah ok cool, thanks! Is that headed to 7.3 or more like 7.4?

Seems everyone was on vacation (I just got back) so I believe it missed
7.3 since -rc1 is just out.

I hope to have enough time in this development period to the merge
window to figure out all of these things and get stuff merged - UM
wasn't on my priority list with all the (LLM) security(-ish) stuff going
on in wireless.

johannes

