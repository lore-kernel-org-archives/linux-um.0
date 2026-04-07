Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BD1FF512E
	for <linux-um@archiver.kernel.org>; Tue,  7 Apr 2026 16:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sJ5G5YsT63UOR7NcEKlBVWmXyVQYPvuzuZuNY8ANmrQ=; b=cUSLll3fJkaHLMsFm6YwWgSwvM
	0KpoDicp0zLr11Ql+pizOSlu1YzoMMpKWzJuX0KAwsjf3Cm93wodfup6IjtoFOsBMGjVBqBokZ63a
	oQm6kYLWapa47SrLcZZc+lbRM7HE66HqnCaNHbrBiqnIqHMl6TsrqGn5xMs9ksut1aH2W1Q4Baev4
	MzwQ9WQ82qHoLIrmGCWwmOMoS9J4talpNU+gHEH59VxwLdxjQnaeMlvdV6MJEANY3wCDRiM2nQVG4
	jb5lKfEvWJIxpdpB7lAW+R+W/5cbtk8wymPyTBWIiaUKMOCy6QW4qodXcGNqkGmW8eAOKzmDgW3yO
	sIaP9ceA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA9kL-00000006p7Y-2VNS;
	Tue, 07 Apr 2026 16:57:49 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA9kJ-00000006p7A-0ZiD
	for linux-um@lists.infradead.org;
	Tue, 07 Apr 2026 16:57:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sJ5G5YsT63UOR7NcEKlBVWmXyVQYPvuzuZuNY8ANmrQ=;
	t=1775581067; x=1776790667; b=Ls3nL4yydkHJ34SNefQfPcfQOHgyQ8CVvTuYWP7OrDj6Lzm
	qyq5CDy7vIJv767+vQHQWdxqbcznek7YOMGodJWbnyo4+xtw0ul73O2jeA0PTj/5ZFuYMtZiKWP6Q
	kV5ZQH37iyDwyqWedK+vPrMIidjDHCRcB0eQ7IXGDu3Za3CczfVmTBNuvFkDsZDAnVuNxu3ttRBoq
	R+5maEM200UKR6NuQugTALhzX5xZrOtzPtEE20f9SKRmmAt20U0S9s4krjtis6Gr8UWe/DOMlb6CE
	b44kv+DWZbbsF98rycrA+SgucNJSC2eee36lUxZtpn5gLlauSUcNduRvRB05oCtA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wA9kE-0000000D6j6-34ml;
	Tue, 07 Apr 2026 18:57:42 +0200
Message-ID: <1e15d25c23b444eae1dcfc01432e7ec1e19e25a0.camel@sipsolutions.net>
Subject: Re: [PATCH] um: drivers: use libc strrchr() in cow_user.o
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Bommarito <michael.bommarito@gmail.com>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 07 Apr 2026 18:57:41 +0200
In-Reply-To: <20260407164435.726012-2-michael.bommarito@gmail.com> (sfid-20260407_184531_208780_F1065C70)
References: <20260407164435.726012-1-michael.bommarito@gmail.com>
	 <20260407164435.726012-2-michael.bommarito@gmail.com>
	 (sfid-20260407_184531_208780_F1065C70)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_095747_198852_78029DAB 
X-CRM114-Status: UNSURE (   6.64  )
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

On Tue, 2026-04-07 at 12:44 -0400, Michael Bommarito wrote:
> That framing is kept
> here: the global strrchr remap is still needed for kernel-side
> objects, but cow_user.o is host-side and should use libc strrchr
> directly.

Not sure. glibc has an unfortunate tendency to use a huge amount of
stack space for just about anything (though I admit that's unlikely for
strrchr) - we should probably just explicitly call kernel_strrchr() in
the file instead.

johannes

