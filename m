Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A51CA101F
	for <linux-um@archiver.kernel.org>; Wed, 10 Sep 2025 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gEhz83X1fEdIoqgS02uWNCmDVXrCuar+j0FyE53NpqA=; b=X1NdNJsVAMST55YebpSTW53NOy
	vVg7pyXwLkhflCHk0ShBTOf9GeCvkDVkgjRWT0HEmEnBA9wakkADELUQdyhxEGQQbREJFEGNY1XDl
	R12ugg2f7OnYPmFmS4b1ld3s6Ii9BFhJIG+yb/hTtKnm9ORRUIGsuviC3AqO4lCfzXqPVyFMVdd3X
	DXhf3YlCTs785wOvHXvLobT7pbrEex2AFOmR4hYK29xUjqhoS5uDE3ICD5ZwvraWYVAikVLFm0L7F
	EPKEeGz/LgMj3DjIhvqAvBSx/97YorRmXCjBiBklO9fDls753e710X/NO0cSOnjW0LUyBUMobilTF
	Q72GuyWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwJgV-0000000E1u2-4Br7;
	Wed, 10 Sep 2025 12:12:24 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwJgT-0000000E1qp-2V8n
	for linux-um@lists.infradead.org;
	Wed, 10 Sep 2025 12:12:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gEhz83X1fEdIoqgS02uWNCmDVXrCuar+j0FyE53NpqA=;
	t=1757506341; x=1758715941; b=d6Z1jc5x1qnABH1XKpydQE0shuwYjnHDJPe9esxp/l9gCj3
	0UA7rCHuhGUyQFDmmwf7BiNupH4ggTk7fpKDmmWr+ftmGoo79P1OeIbXGRq/i1CjcIphiKEtcWqiC
	NAlyQA3zrOgL9E7eYzIM2+4HOLzonXmrLOinQU45UoVVlGzZuNp1s3WwUUN2kl0g+ZlC3jOAuGoYG
	BLY63MUA50fhZ2siZ99KeINEzVzV1bUuBC8WbbPN3n8mhBflLfVP+dQQyKuRDGliqTeOUfkEYMW2V
	FwkPSFNqwzx/oy06cBp6pB+QkOXKhYOcSXZE52vVCQfmQbiU7drN2+HkRFwICa5Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwJgP-0000000CoT2-1aUq;
	Wed, 10 Sep 2025 14:12:17 +0200
Message-ID: <ecb230a3384e22acf4fa6c03466c7db7092ad9f5.camel@sipsolutions.net>
Subject: Re: [PATCH v2 09/10] asm-generic: percpu: Add assembly guard
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com, 
	linux-arch@vger.kernel.org
Date: Wed, 10 Sep 2025 14:12:16 +0200
In-Reply-To: <20250810055136.897712-10-tiwei.bie@linux.dev> (sfid-20250810_075308_080221_8093A5E9)
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
	 <20250810055136.897712-10-tiwei.bie@linux.dev>
	 (sfid-20250810_075308_080221_8093A5E9)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_051221_635881_FBBCF940 
X-CRM114-Status: UNSURE (   9.80  )
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

On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
>=20
> Currently, asm/percpu.h is directly or indirectly included by
> some assembly files on x86. Some of them (e.g., checksum_32.S)
> are also used on um. But x86 and um provide different versions
> of asm/percpu.h -- um uses asm-generic/percpu.h directly.
>=20
> When SMP is enabled, asm-generic/percpu.h will introduce C code
> that cannot be assembled. Since asm-generic/percpu.h currently
> is not designed for use in assembly, and these assembly files
> do not actually need asm/percpu.h on um, let's add the assembly
> guard in asm-generic/percpu.h to fix this issue.
>=20
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org

Can we get an ACK from someone for this? :) Or a reject and we need to
find other ways of doing things?

johannes

