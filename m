Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BD2C982FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Sep 2026 05:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YV8xmrLfuB0pp6kkajjjm++EqC/+8Rwh/pdBHgNrjZk=; b=3t5Flv9DKTgHuvSfHQZSAcRmHD
	pHBqHUDCXKhHv0U5jqe/9/x3V+TK8Dyk7kBAZHg4fuMYPCAN/RQAS/Ivrlkr4rArJ5krM44aP0Izy
	0wad/75bP2I0CtDnU5uHeGvOQACtTMOUFCS020KdIogJJeoNVu08wRcpVu/6uRJZzhAgBvIlhs46h
	K7zubXYE6JBtO+wxBKFVUP4t58Z05dUMUZtGxDhe9TBFTi7e0uLVRXrKIo9m0PX/gr45rJ7e93KQy
	w6hlw3yl4iwC/3zzY+ZrzjPCJW1N87sT1c2Xt/sft3WnD/Hcg22QRCQiJMz80WvteLYZM5Lgu2HeL
	0vHbHaSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8tUh-00000004IZk-3ExK;
	Tue, 22 Sep 2026 05:56:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8tUg-00000004IZQ-37yh
	for linux-um@bombadil.infradead.org;
	Tue, 22 Sep 2026 05:56:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YV8xmrLfuB0pp6kkajjjm++EqC/+8Rwh/pdBHgNrjZk=; b=KI6cdOQXQC+K1AsZqoFG+/L2ZO
	qiaMl0JrcwHFabPubmvRIdF6JF/LvUh9KDahkCLlVGago3Rq2j2DVWzYr/l6iU/4ix/8isVI28JV6
	8wnFfOr5f+04/74P6kJGrORJxC+Y4ecXo9tHebcPdfHcg+RlCIs671oLs1ENmvtqlm5VMa7wLYPb2
	kqXuBDg/NbLh44GObeyVWkg8SnLXdyyVIAHuIP2bei4YcIyxZ4a6sY4mpGSC9zRFqxQ+Q0L4lC9RU
	lfxBViHZOpLjQcu/0zq/z260IApWSLRM5CXNeeEUl8D+vvlxmK9KI6xkfqH628lnDRlEG4AT/Lr4q
	sPrO7QQg==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8tUa-0000000D8eF-0rrx
	for linux-um@lists.infradead.org;
	Tue, 22 Sep 2026 05:56:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YV8xmrLfuB0pp6kkajjjm++EqC/+8Rwh/pdBHgNrjZk=;
	t=1790056596; x=1791266196; b=XkCIsBBSqRNCM/IC7kflXKizhXjezOPsvetbMCMP6Wa8apf
	hzxZX5DTJ88lpRYNwuH/KAxQ3OGYsz0LaJfQ3jY0lLmHUESzoZktx01pnXFmsixKIJs2IJ6rtkB1H
	be76TeoKHwu8iPAsiS3A6+A6+gjD0OA/yjimiEdWfyYomTFgLSO0nHCdo+bifS8768yelH3VIz/tM
	QV2FBBxlp60YPq5YFejaoyjD7Sj7ZrQ1MDLP4HDiVQBvtwYGSYhly5dHYMdByAZLhlFEsMt4U8kSP
	LeLqMt85zLjtgNJHn6PpB9F7fNwqmMgoGOxSdS9cxFdtAI3d6lHeLuyJ4Crp0ErA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8tUO-00000006i1J-38TH;
	Tue, 22 Sep 2026 07:56:24 +0200
Message-ID: <aa560d2d2cbf94e50397740159c12e24e0ecf820.camel@sipsolutions.net>
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paulos Yibelo
	 <habte.yibelo@gmail.com>
Cc: netdev@vger.kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com,
 	willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 eperezma@redhat.com, 	xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
 pablo@netfilter.org, 	fw@strlen.de, phil@nwl.cc, razor@blackwall.org,
 idosch@nvidia.com, 	dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 linux-um@lists.infradead.org, 	virtualization@lists.linux.dev,
 netfilter-devel@vger.kernel.org, 	coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 07:56:23 +0200
In-Reply-To: <20260922005353-mutt-send-email-mst@kernel.org>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
	 <20260922030310.8684-2-habte.yibelo@gmail.com>
	 <20260922005353-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_065638_393691_44B0B6C4 
X-CRM114-Status: GOOD (  10.79  )
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

On Tue, 2026-09-22 at 01:14 -0400, Michael S. Tsirkin wrote:
>=20
> > =20
> > +/*
> > + * Return the L3 offset and protocol of an Ethernet frame starting at =
skb->data.
> > + * The offset is unused without NEEDS_CSUM, so avoid parsing and retur=
n zero.
> > + */
>=20
> for networking code multiline comments:
>=20
> /* always
>  * look like this
>  */
>=20
> /*
>  * never
>  * like this
>  */

This, for the record, is't really true any more - we dropped the special
rule a few years ago.

johannes

