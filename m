Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290AFC369D9
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 11:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H9TVpNIUqRJqkHSoRR2HwqA45ZTtVXapiUPjmIrPXOs=; b=fUYy2yaFJdQqVhrdkA8ZiEVHc8
	2iueIvzI7xCO+GNvrbb9azEvp52h9f+qGgRmYwpVk9JBCLdxoZfxAQwskA3Z6RlnYzb47vw7F0kCm
	63fkPrcUnn6YbX5ZzqqaVPGFznWb+xzgiJVBAooQMnPHZoHryHZL6iJw6CxGqYyimbM7iZ4+dXbwv
	CKsrkSTs3Ik6bEugW/O2X4pLtf6sQciKZ7mTlAVgegcoVt4PgCRVRBzeg8P1oxzPjPy2sb41pMonv
	nMkffq9j5COX+f25kE0hyKjT6lMc9GCzZI8sAIARAv0UCRbDATLBYG3cy9xka6KrxDMcQ7qhB696+
	PhoesdYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA60P-0000000Cjqb-1yLV;
	Wed, 30 Apr 2025 11:53:37 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA46c-0000000CRHw-2wdd
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 09:51:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=H9TVpNIUqRJqkHSoRR2HwqA45ZTtVXapiUPjmIrPXOs=;
	t=1746006712; x=1747216312; b=G0AeCbin24Oc/2gCqekD1CXRcPihGlfHKN/ky6GiZzawInS
	uyRrWqALDLdcDV5CN2kWXgTrFR2YjKscIsvXLmyLmzLhoWIELnQFfwO2cKGi1Zzy0mGtrUoRvoZEB
	LaHlwAW8OuYq1CCU1nue4jC4ytS+bhBoPwZZg9qfjMrg2EzVb9886Vm6wGPomyW0TwEpyM+RUJvtO
	3kBW2s9vYNBtdcM7dpZ9wJICazczxn9JQJ8L3vV4G3bx2J6qa0sPbFdPD942vqvvMsJPyx85PqanI
	YTxW/WJq0rhqkHKczZuZvdvkyIT54zypUtSmG78ZdXe+7o+oUhqswNqq8wO7rMBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uA46V-0000000Dars-3CIj;
	Wed, 30 Apr 2025 11:51:47 +0200
Message-ID: <0837b343960cc6392df4a04b974a2ebca4b60b9f.camel@sipsolutions.net>
Subject: Re: [PATCH v7 00/13] nommu UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Hajime Tazaki
	 <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	richard@nod.at, anton.ivanov@cambridgegreys.com,
 linux-mm@kvack.org, 	linux-kernel@vger.kernel.org
Date: Wed, 30 Apr 2025 11:51:47 +0200
In-Reply-To: <7271fdc2-5f3f-459d-ad64-b0275265fe2a@lucifer.local>
References: <cover.1737348399.git.thehajime@gmail.com>
	 <f4242067-0113-432e-b8d1-d26ff5e4a355@lucifer.local>
	 <m21pte6z73.wl-thehajime@gmail.com>
	 <7271fdc2-5f3f-459d-ad64-b0275265fe2a@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_025154_737717_5B910595 
X-CRM114-Status: UNSURE (   9.12  )
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

On Tue, 2025-04-29 at 14:23 +0100, Lorenzo Stoakes wrote:
> Thanks, appreciate the response. I would say send a v8 that's rebased to
> make life easier for maintainers :) if you already have it ready to go th=
at
> is!

There probably haven't been that many patches since, but I guess why not
:)

I was sort of hoping to get the seccomp patches from Benjamin - that
have been waiting far longer - in first to see what overlap if any there
might be, but I think he and Hajime have already concluded there wasn't
all that much overlap anyway.

But it's good to hear that it'd be useful to you.

johannes

