Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A45C3064D
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 10:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PGN/Z4nHpXQCi6h5qSdSGZE78U7FokNZlM0EE7rRTNo=; b=0fd9VuiyLuT9IkWV4B/ixOGDTr
	YcdW2Cd8mDHLNXx91ZS7DGDQfsjIfkBQYH4bNjJ3BJmgOb4InqzrNNXHWGd+eIPmh4mCkNTQHAGil
	2i9B+mU73I1BTk2vlX5VVN8cYqTpO5XBZKt3vniblsUjI1jzVXbq73a4S6vFz8cZ+GPvZzbey92ko
	IPbUBTzWElw/YKnVPmJ8pevqV5dGH5vXidmzW37VgTx0JXXfs5iUip/2ccSJkEk15cbKOIeRDwCyY
	JB6cGWqi6D7GbwnFKUHDN2ao3bKEjaLE5YfAmuU04xNVP/2Hmwo0WPfwTiPdEuDNp6V1cQjQsvKc4
	J/QxYDxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOagv-00000006LDd-2TU3;
	Tue, 02 Jul 2024 10:24:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOagt-00000006LDE-2yau
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 10:24:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PGN/Z4nHpXQCi6h5qSdSGZE78U7FokNZlM0EE7rRTNo=;
	t=1719915891; x=1721125491; b=wgGLJhKJodk4hRjoV1jI0xG+IZtfYMTWb+iuACgKZhAM8Z5
	OEPjgvvPqUdzCeLWJTMmM9nd/wZfPlxfK3AXcegwUoyg8h4nNlZPaprddzVp2O7VnA5i85tWRFH9M
	dHDTHQ7VJrbfS/H9cSso9jiIV+WfTJSUzHz5Glzr2cKePVt4x1H2Zlr+wlOQhqJ9IUHhA647oiy62
	iWw+cJDnBzv+Qv49JfhRq0EFuRUpPbAquFFifp9eUiKwtfECdktmfHc9bewVKB1YhKmH87NayC5Ta
	gORlNQyoKhZNfhEAuOx7Ma+6SmOZqwHaXPaLxhV8UqwBMVbwDFsV/H56DD5bAqJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOagq-00000005CqG-29iD;
	Tue, 02 Jul 2024 12:24:48 +0200
Message-ID: <a7e7f619bc73fff0f54dccc1129feb3c721cb49d.camel@sipsolutions.net>
Subject: Re: [PATCH v10] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Date: Tue, 02 Jul 2024 12:24:47 +0200
In-Reply-To: <20240702102549.d2fcea450854.I12f5a53d80ec1e425e66ef272b1e95cb523b608e@changeid>
References: <20240702102549.d2fcea450854.I12f5a53d80ec1e425e66ef272b1e95cb523b608e@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_032451_768333_9AFAA54E 
X-CRM114-Status: UNSURE (   6.94  )
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

On Tue, 2024-07-02 at 10:25 +0200, Johannes Berg wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>=20
> Since userspace state is saved in the MM process, kernel using
> FPU still doesn't really need to do anything, so this really
> is as simple as enabling preemption. The irq critical section
> in sigio_handler() needs preempt_disable()/preempt_enable().

For the record, my main interest in this is to unlock debugging for RCU
lists, sleep, etc.

johannes

