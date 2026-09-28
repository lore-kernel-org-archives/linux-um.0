Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50619C9832F
	for <linux-um@archiver.kernel.org>; Mon, 28 Sep 2026 07:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f9GuvQ9AZTHwGr6CKXhX5QxhIaXr7oa97M52F15fiUE=; b=fGL1mm/mRxaJjdnA38qZG/dbsf
	dH0YLXQGik5Y2SPl+mWUyTnnp1lLScJEjV4aej6kp+HsIg63ETdrxmXnW3wOSy95iZaTkeZDkIlsp
	xs0DutuVJ9ehEtT3Jv2PxCl0yJ9ewUJpTRktnompQR/jaTCk1Fy5u5RhU1ddhruQ5uRFn7SmcVAwk
	vSaimQEqGIysiCgShlJYzgViu2ftQRnmbhAGtvBYIsnE9fudBgMnjzBL/QENjbWeM1UdX7ClNUdn2
	obev6fy19BFYnb4KJF36dyCbLl5q5wpR/07B5aCxQdvXD2BYSQXisDHjA/v+V/3AVzVQG7ZHRwKoY
	3U6w1pkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB62u-0000000HZj7-2wHc;
	Mon, 28 Sep 2026 07:45:08 +0000
Received: from s3.sipsolutions.net ([168.119.38.16] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB62r-0000000HZiR-1jzZ
	for linux-um@lists.infradead.org;
	Mon, 28 Sep 2026 07:45:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=f9GuvQ9AZTHwGr6CKXhX5QxhIaXr7oa97M52F15fiUE=;
	t=1790581505; x=1791791105; b=IQxcErAkWdYJYIETU7xg360SHgjyQtLvwTJzly4ZHT/aCpR
	OmK7VAlAVYRv7PlKeXC/qZj7zUKtw0uxJ96t9MqVmM1SMWiWqdBuXsMBpd600VhsOhxQXyrpXIzpj
	6bEcxJN3X+itI5Lgj70Xd+KinghjMSx8fHW03BYpDT0EHi/5RW1h4IHwmW8THm3DJs4Eth/z2ubVV
	+v9MYtmPUUzc5lTHr0qMxJN/YULO9r4ysflgLveLrvXDH6x0MWGzoQRawo5e6H7JHopNBFgqZw3Tx
	GOhy8G610unc8rerhz5anpCHsim/JOvPfCGeKOMd8C7naY5zmlgUKp9KiLHWGe4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xB62d-0000000DL9B-0Xwl;
	Mon, 28 Sep 2026 09:44:51 +0200
Message-ID: <04259a99ed91f8a527b255951a6f626310728170.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/3] selftests: run tests on nommu architecture
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org,
 liam@infradead.org, 	rbm@suse.com, akpm@linux-foundation.org,
 luto@amacapital.net, 	brendan.jackman@linux.dev, david@kernel.org,
 liuhangbin@gmail.com, corbet@lwn.net, 	kees@kernel.org, ljs@kernel.org,
 broonie@kernel.org, mhocko@suse.com, 	rppt@kernel.org, shuah@kernel.org,
 surenb@google.com, vbabka@kernel.org, 	wad@chromium.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-um@lists.infradead.org
Cc: geert@linux-m68k.org, daniel@thingy.jp
Date: Mon, 28 Sep 2026 09:44:49 +0200
In-Reply-To: <20260926010819.604346-3-thehajime@gmail.com>
References: <20260926010819.604346-1-thehajime@gmail.com>
	 <20260926010819.604346-3-thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_004505_463056_1DD12004 
X-CRM114-Status: UNSURE (   5.87  )
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

On Sat, 2026-09-26 at 10:08 +0900, Hajime Tazaki wrote:
> Architectures lacks MMU doesn't support fork(2) syscall and only

nit: Architectures lacking MMU don't support the fork(2) syscall ...

Not sure where this should be merged? I guess selftests would make most
sense, but you can't actually test it out before the UML nommu changes,
so that doesn't work too well right now?

johannes

