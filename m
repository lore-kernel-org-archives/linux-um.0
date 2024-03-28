Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302A7C54E67
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 08:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iHrHxou/LQhUWas1UemQMQryecJ9CPAti3mj44c5cFc=; b=C+DfLOW2CYj9Sml6X9FsrEFr5F
	JinvxswRPm/7XoRlQF0UJogK/80Q0kGbWdBZ95urMo5XBwYdGlmZYIpE206EWYdyLQZbBF8CPyug9
	va9kvaNHJHlIn6+DuSRftUfXpBGwKM3SLTmkPolWYzpEDInxGikJmg7qB+nHTrq80Ytd5OwrFzWfr
	2rZL7SjC7lDBU1d/ySo8wesqVEHkwY/ZMOFVVVqaJiTBhLy2iV7lVsxZm0HjtxX9shQ0nB/FzI+t+
	gWt90/g4F+FE49Gx1c0Vt0cHz7MIQ2/4Ei24AvFBcFGO2HWAaf3ihQsj62KLS/fJ3RV22lHjPjsZg
	cSTe6+Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplQt-0000000D91J-1atp;
	Thu, 28 Mar 2024 08:48:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplQq-0000000D8y2-3h1W
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 08:48:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iHrHxou/LQhUWas1UemQMQryecJ9CPAti3mj44c5cFc=;
	t=1711615696; x=1712825296; b=dG1bR3HnJwOcG0Pxm8tAIkhYu2cG27ooSlWefPgsXBy/92m
	X4W02hb0sLwaNZlmQQBT6rR6C1Xw1qYjw1Ttpn/kVsxYPKX51/6F2tIZRUYAnhkTWqBj/UbWmBhsg
	ZNG/YhIAW6GZpBElwK0m6viT6bMWty4WryU1OUsBa5HGPHgaV5KWUe6SaZ0xzUy0Tx5PsRKO5MEg/
	hZyLoWPFU8gL5eMbQI5s45zKLOXaqgRoYA4An+SbHd519mUNguCyjwH4Q4Ph/spDvdz8oiHASlSqT
	raDcgeznBi1tRRGjCYD5rDsdhwtuBYzlGy1WHKh0DQC1uz1zSSshBkwWeSdxO7Ig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rplQd-00000000nRW-3isQ;
	Thu, 28 Mar 2024 09:48:08 +0100
Message-ID: <261b229ae93fbd27f63d887b3217e3bade4e816f.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
From: Johannes Berg <johannes@sipsolutions.net>
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: sfr@canb.auug.org.au, kent.overstreet@linux.dev, sj@kernel.org, 
	richard@nod.at, anton.ivanov@cambridgegreys.com, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux-next@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 28 Mar 2024 09:48:06 +0100
In-Reply-To: <20240326073750.726636-1-surenb@google.com>
References: <20240326073750.726636-1-surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_014820_984987_9BCFCA7B 
X-CRM114-Status: UNSURE (   5.17  )
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

On Tue, 2024-03-26 at 00:37 -0700, Suren Baghdasaryan wrote:
>=20
> -extern void *vmalloc(unsigned long size);
> +extern void *vmalloc_noprof(unsigned long size);
> +#define vmalloc(...)		vmalloc_noprof(__VA_ARGS__)
>=20

I was confused a bit by the define at first, but that's because this is
a user-side header file.

Reviewed-by: Johannes Berg <johannes@sipsolutions.net

johannes

