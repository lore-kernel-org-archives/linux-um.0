Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C89EC28B28
	for <linux-um@archiver.kernel.org>; Tue, 18 Mar 2025 13:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1uasjolQQ8z5mKLKz2+E/iOnWOi6UmTmGJSNdNo2eCI=; b=hcNhfbPlSsIYLkkNN7AVrQbQtq
	ABXePZUyCsXh3OYSZVzFN4oT/ET8HXJ5VL2fzViDNMQWm/a44grwL3XBEc7I51BUCJ0U6+fSIeWBB
	7QshgFaTjU+ak20KSf46KFqZoou7gO0Lrp/RX3AMEIOCBp0bA89n8g3NRwpoA/H0Kfq8WSKXMthyB
	Ml9diarTl1jgPDqqrVVOscBqACBeUVLzoHwTRUaybmVGi3qqRapNFkrwwtn2yfKivSgt/MABUJBwr
	HucbzSDG2zMrwpvgmagPHxR92KPFx1+DW10UwpbLDiaCoutRByqa4EE3PqM5kKcIMST4/NZp8Rfqv
	9qpwhkxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuWnr-00000005zi4-3n4q;
	Tue, 18 Mar 2025 13:16:19 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuWno-00000005zhP-1nxs
	for linux-um@lists.infradead.org;
	Tue, 18 Mar 2025 13:16:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1uasjolQQ8z5mKLKz2+E/iOnWOi6UmTmGJSNdNo2eCI=;
	t=1742303776; x=1743513376; b=mIikd6eQLJ2VJx5TfbYIaiCXjtfgQZE7JklsEOHQ0eUpeVI
	d1Y66vubd2iEsakv9RRsB0nPaabniNFXyMIU82BLbUmBPC0ANc6kSRf+W9Ew2SkTIz3hHhT5xQJgV
	V0yTd0EyRqp7DPnfgGRnE+4C92Q26JmKDrIwFbMZXaIEss9PdeeQXxEGxotRhTMOjaas5Kay8DAka
	7tX+YPEZ99lJEINyROAcDm7e9HqRPQcqDHCbbtDuEfiw2MvzqSFWl19x/GdgksEPs4yLUrpKPD8nN
	fnjENCP4kSmtpNpAiYIxEkoZT1kpqYY1t2Dycpn7Jw3722I6v93KKWYu5YcDzsNw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tuWnl-0000000FIWi-2IoX;
	Tue, 18 Mar 2025 14:16:13 +0100
Message-ID: <bacc4abaaec8c254e33974d63482575e8e9448aa.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/4] um: Add pthread-based helper support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
Date: Tue, 18 Mar 2025 14:16:12 +0100
In-Reply-To: <306312a14326a482cba476733a4adde1799b7ccf.camel@sipsolutions.net>
References: <20250306150747.2926434-1-tiwei.btw@antgroup.com>
		 <20250306150747.2926434-2-tiwei.btw@antgroup.com>
	 <306312a14326a482cba476733a4adde1799b7ccf.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_061616_465586_C4F1C3F3 
X-CRM114-Status: UNSURE (   9.33  )
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

On Tue, 2025-03-18 at 14:06 +0100, Johannes Berg wrote:
> On Thu, 2025-03-06 at 23:07 +0800, Tiwei Bie wrote:
> > Introduce a new set of utility functions that can be used to create
> > pthread-based helpers. Helper threads created in this way will ensure
> > thread safety for errno while sharing the same memory space.
>=20
> Using pthreads seemed odd, but Benjamin argues that it's the only way to
> get libc to really sort it all out, unless we never use libc syscall
> functions, which is probably kind of unreasonable? Or maybe we could?

It's a long list of symbols that are needed:
https://p.sipsolutions.net/2f0c8e0de1e69147.txt

johannes

