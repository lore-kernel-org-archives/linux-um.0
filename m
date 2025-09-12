Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD68CA101F
	for <linux-um@archiver.kernel.org>; Fri, 12 Sep 2025 07:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j03RuNT7+4gCtGue33+Zbji2ovGTMqcwJmLO6kcquqI=; b=KlQC1tBIYwxNTVIQGtHbtdp1wF
	zAOLuGUnwX55/UTXYzXYkL6RnkEUQ5t/ooW0ZHooWLwoj9YchL51u920c6WYvd63c/jX8FgDFYO+6
	JqXBdEC4U/z7vKbnDp3V2uuonLJCuj4A+uXrIEvXuLBfeONM5+W4uGOyEnHgQlqT98qRwdUHKDo4h
	72giFEnoHxUq178nfhLrP8SfA2aP2ZJkoBYHRdkeOr3blUDltXNDKuZNLXEYbKhzAZu+o2KAfmvXL
	/WrhCdXfvLR9vObTjubfggZJxwiYhoMOBm7CskGXmfT7jsWSNS09c1vU5z9EUpdUDgtUVmKiQ+SCu
	NS758tzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwygH-00000007mNJ-42ad;
	Fri, 12 Sep 2025 07:58:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwygG-00000007mKB-0R95
	for linux-um@lists.infradead.org;
	Fri, 12 Sep 2025 07:58:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j03RuNT7+4gCtGue33+Zbji2ovGTMqcwJmLO6kcquqI=;
	t=1757663931; x=1758873531; b=BGQ8WFCJr5FV16pwx6L5qGSReQ5dCVC4/8aOlqIuoXxMKRP
	rDHKtK89gxx+D6h0K7lZJ2hK5qi/Tu+FvStO/BCOCZohqvi7VpWx3aB9mCzuH7+T2pnNUh7ptkCMd
	ooyVQwfPQMBQzBFfINIzX7TxUtrlSQZIao0LeY5plyOOXqTF9BAMykkvnRii6u5+jbK91RlkqBrcq
	JT70c1rpNCfTajuKDuGbEe37Y8MQ312ku1BDYJkweVInPd/3ZcKmP09DmkjVYYuZamnbM0C5SfXW6
	YbGUB24B/zQFPCNrZCtPTouHlLLfiq40Dj7pbsuD7FIBxUKeH/+ixsMLZsKnDnWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwyg6-0000000GtkT-28wT;
	Fri, 12 Sep 2025 09:58:42 +0200
Message-ID: <d8b8e87871f847473d4e2ca91fce00b7b12b8f19.camel@sipsolutions.net>
Subject: Re: [PATCH v2 08/10] um: Add initial SMP support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
 benjamin@sipsolutions.net, 	arnd@arndb.de, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	tiwei.btw@antgroup.com
Date: Fri, 12 Sep 2025 09:58:41 +0200
In-Reply-To: <20250912004501.2565976-1-tiwei.bie@linux.dev> (sfid-20250912_024557_736137_0C9523E1)
References: <03cb4661a6135a641c5a3779f2cb424356b8e345.camel@sipsolutions.net>
	 <20250912004501.2565976-1-tiwei.bie@linux.dev>
	 (sfid-20250912_024557_736137_0C9523E1)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_005852_161044_5186A28D 
X-CRM114-Status: GOOD (  13.12  )
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

On Fri, 2025-09-12 at 08:45 +0800, Tiwei Bie wrote:
> >=20
> > Another thing that isn't covered is anything relating to interrupt
> > affinity, I guess? Is that automatically not working, or will it look
> > like you can change things but that not do anything?
> >=20
> > I don't think it's important now (though eventually I would actually
> > like to have it for our simulations), but was just thinking about it.
>=20
> Currently, our irq_chips haven't implemented the irq_set_affinity
> method, so setting IRQ affinity is not supported at the moment, e.g.,
> attempting to set affinity through /proc/irq/IRQ#/smp_affinity will
> fail with EPERM. And yeah, we should support it eventually. :)

OK cool, thanks for taking a look!

johannes

