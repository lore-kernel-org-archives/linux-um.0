Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9CCCA5FA2
	for <linux-um@archiver.kernel.org>; Mon, 28 Sep 2026 12:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iya9wujgQEdqUfmH+V2H4et1ziGVCRoqLQ6GAz7eQu0=; b=lfzP+/MhCVZ2W+WWjQrentoiE9
	eKid2Q4kczfFHLMXDfil7S53+AMJMUFJLhFnXjUu0mTKRN/QBqnFY7iUU7WfLMlAHh+2HngcTcLK6
	LnqHVpxXoJaCXvV3kaQutX4eZGrHHa4pK+3cRPHR5Xfo6E9Gr2pbcg82jZiYwdenTStX5N05lBNjM
	CFpAWXPmPMta8nHEpAM1hye80T4rLjkNExszGDeUNMa+g7unRlDgl7wvhLvJWHydQWmy4iiEr8Yt4
	2KKQuO58YCHz7KnQ42zdigVkdmdghZvnGAh7s+1TbzwAnVZNPAx5xAJKJFpjIbwpq5RCMGR23qrjO
	sTeEsacQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBAXY-00000000Z59-2J1t;
	Mon, 28 Sep 2026 12:33:04 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBAXW-00000000Z4Q-2i5f
	for linux-um@lists.infradead.org;
	Mon, 28 Sep 2026 12:33:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Iya9wujgQEdqUfmH+V2H4et1ziGVCRoqLQ6GAz7eQu0=;
	t=1790598782; x=1791808382; b=T1iImATiVj3p3yWe+eQYqKK5dWFD13zvuDi4tjpXDUXrho2
	aTVyHAOANgfXEfLAabmo5oYjl9ssuFnjzk6uhS/iHdWtGBXq5yM8B581kymSUfmQPgMw6HRkJsI++
	Qsu79BUQxX8vEoQUCk3dI66uW7vmOQhPC491+U9QbjuYuZSHHKohqzzwYKojOcWsloF6AfQ4DWMo7
	pS9zj3d8Kt5BpZ07HnpxKnvxcnUilXBGGpGQiLIQ0Xw9r6gGQ/3R9e8Jkl2F0WFH+C8fdq1bo3jsI
	vyXbEmzm6yneF0bJiX285Octq9cSbJ2qvB+EGUNn4HfYkQrhV66YMGqy1kWff6rA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xBAXM-0000000DXzf-0Rx8;
	Mon, 28 Sep 2026 14:32:52 +0200
Message-ID: <8dfc0ec9ed660e373451c96b6fcc352c35a6a004.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/3] selftests: run tests on nommu architecture
From: Johannes Berg <johannes@sipsolutions.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org,
 liam@infradead.org, 	rbm@suse.com, akpm@linux-foundation.org,
 luto@amacapital.net, 	brendan.jackman@linux.dev, david@kernel.org,
 liuhangbin@gmail.com, corbet@lwn.net, 	kees@kernel.org, broonie@kernel.org,
 mhocko@suse.com, rppt@kernel.org, 	shuah@kernel.org, surenb@google.com,
 vbabka@kernel.org, wad@chromium.org, 	linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	linux-um@lists.infradead.org,
 geert@linux-m68k.org, daniel@thingy.jp
Date: Mon, 28 Sep 2026 14:32:50 +0200
In-Reply-To: <arpIi5QBG1_MuZzJ@gremlin>
References: <20260926010819.604346-1-thehajime@gmail.com>
	 <20260926010819.604346-3-thehajime@gmail.com>
	 <04259a99ed91f8a527b255951a6f626310728170.camel@sipsolutions.net>
	 <arpIi5QBG1_MuZzJ@gremlin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_053302_687306_06A215D3 
X-CRM114-Status: GOOD (  11.27  )
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

On Mon, 2026-09-28 at 12:00 +0100, Lorenzo Stoakes (ARM) wrote:
> > Not sure where this should be merged? I guess selftests would make most
> > sense, but you can't actually test it out before the UML nommu changes,
> > so that doesn't work too well right now?
>=20
> I seem to recall Hajime saying he tested this on an actual nommu
> device/virtualised equivalent so nommu UML isn't strictly necessary (thou=
gh very
> nice to have!)

Oh, I don't recall, but I guess that's plausibe.

> I think I saw something fly by that implied it might be coming in 7.4 is =
that
> so? :)

I did end up merging just about everything that was pending for
uml/next, so if we don't forget to send a pull request in the merge
window, or something equally catastrophic happens, yes ;-)

Sorry for the delay. The onslaught of LLMs means priority is elsewhere,
sadly.

johannes

