Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0710CC3ABBE
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 09:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Rypyay4AhyqMCAVMP7o+y3EI6xc+qzYvwlMDd5Jl4g=; b=hZAgZWsEObjlOaib+bRwuWlRN3
	N8KpJZGayNJfqm+mbMk7AHbRWzHhpk7SpgKUM6ScPwcGa2KrmDqjp6UUg5HrXzSH6/ZIQL8u2MSkx
	M0AreIlz0yOsgYbhri8wbkhdY95z4YTd4KyPrrXY8k0HHXS9A472tb9/YMFnlCjgLM7fvjzNTEJX+
	kqRbAnMIoYn4REv/+DrjazcssVD80nu2AVbgyluC3ZmgD2OOEHMAZoF+nTVnHYnr68riaBhgYCZTr
	VBZ59EPQfgmnQq52CisQkAfZdSrO+UkzEOM80KTmU2NapJBUzQP9MtrgNtZL6P+B9gqLP20HDCFmz
	mLA8zx/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCxUP-00000000FYs-1o9u;
	Thu, 08 May 2025 09:24:25 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCx95-00000000CJX-1Ynk
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 09:02:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8Rypyay4AhyqMCAVMP7o+y3EI6xc+qzYvwlMDd5Jl4g=;
	t=1746694941; x=1747904541; b=db5j4QU1Unter884lEnf9/ruPxiS+GXznWMJr2DlCw5Yza9
	gutc5XMeM306ZN+Xvjawcw91Y3bOAnQ28U+og7WKYHn3Pdolos8lPsAZPqX+VpWAszrZCBSVK/24R
	nbZWHaqTzAmeZKjUKi7kMbYXbSdgTkDN46APlG9/X98LD+BsY6ozsVsjttVKhobh7Mvi2UJ9xe5ze
	FGJr82tpBAzlX6lezvwfHCa7f+UOI1GzmyQLBaetIz8icRkZID9E1wcEIxGPfcXuCDq4FwgO4wloT
	mDHiDZ9nZPdcag6kmjvNOp9Ds83ttAtWCya95PwYwX25+HkE5xIVkMUDDHRCrK9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCx90-00000009zND-059U;
	Thu, 08 May 2025 11:02:18 +0200
Message-ID: <709b486f4cfb93e0feac12300e4f06a34f49fd27.camel@sipsolutions.net>
Subject: Re: [PATCH -v2] accel/habanalabs: Don't build the driver on UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-tip-commits@vger.kernel.org"
	 <linux-tip-commits@vger.kernel.org>, lkp <lkp@intel.com>, "x86@kernel.org"
	 <x86@kernel.org>, linux-um@lists.infradead.org
Date: Thu, 08 May 2025 11:02:17 +0200
In-Reply-To: <aBxyDyVT5QbOlhPq@gmail.com>
References: <202505080003.0t7ewxGp-lkp@intel.com>
	 <174664324585.406.10812098910624084030.tip-bot2@tip-bot2>
	 <007a7132d1396912b1381e96cc4401a10071ed24.camel@sipsolutions.net>
	 <aBxyDyVT5QbOlhPq@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_020223_406354_34DA008B 
X-CRM114-Status: GOOD (  10.02  )
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

On Thu, 2025-05-08 at 10:57 +0200, Ingo Molnar wrote:
> >=20
> > I dunno. I guess we can put rdtsc() into UML on x86 as I suggested abou=
t
> > the file placement, or we can also just fix the Kconfig there.
>=20
> The Kconfig solution looks much simpler to me too :)
>=20
> Patch attached, does this look good to you?

Yeah looks good to me. Common gotcha really.

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

If anyone _really_ needs to have this driver built on UML (say for
simulations/testing, we do build iwlwifi for all the time), then they'd
probably want to replace the rdtsc() anyway with something else there.

johannes

