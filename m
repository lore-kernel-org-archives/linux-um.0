Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2027FCA0FFF
	for <linux-um@archiver.kernel.org>; Wed, 27 Aug 2025 20:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bmGI/NEfAfgDB/a+dal7o7pLk2x1XlSfdfQurPmEfKc=; b=hgoV9fJfM7i1ZqR4rrywuga+72
	jnbOamj41BF2bG56KGZr1ZJbNgMRhECTAgOEdSrXKpnnnDwd8FiZLuRHHGvhQemNOg58XFi4j7Anl
	Q8iCV8fzujbBswl4gk1wBJKRGMDLovmA4X3uXMYZcjs18NE3YIVSkKcLZ0763bJE87UxylZ3ub2PO
	VHxOcRutjasxQUW6/pS2Hfoe03867CMuYI5LDO2L4Lj7lqoY5BhRorIO5cb5l/PwHOsoQ3WBi0cRQ
	b/abriBFYQBOtaabEeRo0EyfVhpCMmbwARAGUp4AzjpZfJ3r7joYBj8pLwNB6qUo5SsDhrReGr+V9
	0h7QEFhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urMh5-0000000GkCM-3Uy3;
	Wed, 27 Aug 2025 20:24:31 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urLyO-0000000GdXs-2gyA
	for linux-um@lists.infradead.org;
	Wed, 27 Aug 2025 19:38:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bmGI/NEfAfgDB/a+dal7o7pLk2x1XlSfdfQurPmEfKc=;
	t=1756323500; x=1757533100; b=Vj8IC4GohMaSkqILQu8BGWXkdAMPv0ZJA0mdtxF/5zghln8
	YbMaJzp+cK+PbYEA1XwNQFIOyqO4dt4TpF+/F/DOUpLj4UUxyiU92imETBYAI++xiV4Hr+WkfQLQu
	JZ5MEaPTOV9XQ/BolhM7L2xe8NJSG36AQGPKwVrMWZ5qZumFg5wmf0B9VufN3pBK8nQL7EA85Gxb/
	weT1hUbkjhfx/HfOYloIeAwHCfbqilD4hVb67ms3M2fBF0kk7/1LqAed6kEiau9ztif6vuxOu+AjA
	QG72cIuD+h36ceVzcaDgDIYFA67ah2GSUvGuM7htDv6ZCuFMROdrzPnHR0zueI4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1urLyM-000000060vA-04ur;
	Wed, 27 Aug 2025 21:38:18 +0200
Message-ID: <155ce30d5fad5a444f72b681eb096418384542b3.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Support SPARSE_IRQ
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Norris <briannorris@chromium.org>, Richard Weinberger
 <richard@nod.at>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, David Gow
	 <davidgow@google.com>, Sinan Nalkaya <sardok@gmail.com>
Date: Wed, 27 Aug 2025 21:38:17 +0200
In-Reply-To: <20250825212031.111027-1-briannorris@chromium.org>
References: <20250825212031.111027-1-briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_123820_692643_32DEFE15 
X-CRM114-Status: UNSURE (   7.00  )
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

On Mon, 2025-08-25 at 14:19 -0700, Brian Norris wrote:
>=20
> +#ifdef CONFIG_SPARSE_IRQ
> +int __init arch_probe_nr_irqs(void)
>=20

Is there much point in the ifdef if it's anyway always going to be
enabled due to the 'select'?

johannes

