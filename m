Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E64C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 22:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IMGjB8iifkRlusUX26IjKWrA0QjQ91+rW/mvmdRwm9M=; b=4J5CIDcp9XKWvcbwa7qflhmP+N
	frTWfzxnEpD7yCqpH995kv9OuB4OaDs3HQQpdIKJl4Exs6DBgh4I+Yoe7+0HfyUsTqgDjqyG5INfQ
	7kv2DF2LbUYEZvZ2otSlblOS6zGebQiDfMpbR4Mqjr5uXiZWJO4wPaGC5/dFHxYNODLHTad/3LxlM
	TxObxxRjTul7LlK1GO37ggjDVWfhdzoUMS1IezDMMT5XqKKj88LGd5lIfgjW5H9Wco3rSxWCFFC8Q
	46aTNsEgbxyBu/gHqU1OIh5Sp53ozweKrNggsfUd7eSxW1kCHk96X8URcgZTRfRXTZs3+WQIhSvbk
	EyGU1XLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPVMX-0000000EWPc-0eot;
	Thu, 04 Jul 2024 22:55:37 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPVMU-0000000EWOq-2lsh
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 22:55:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IMGjB8iifkRlusUX26IjKWrA0QjQ91+rW/mvmdRwm9M=;
	t=1720133733; x=1721343333; b=i2Hv9pNDmgzVmdYYbKIMeKgAQOX9U7TF5J6CDB+mSwrDN4m
	WsemnCj4bnZcRXzhYkXneKPMo8EW4b7bfJH21SXRAKe2gprEjmzTT8I2UZV1gAH5enKijoHZe874Y
	nZC1tsYVvvExH6lHklrsp0xHrGNb2aa3+n4PYY1PAOq8NtfczlQwsyfq/rX3o/4oe2eqePF3DOKCL
	0W8TJKZKe7zfHlG/Tddr7jVO0sYY0EXXrxTflsybBhgTorTbylDdhO/RQOwTQ+AcmTwT5jVw2dDda
	dJH0vYgRqhrWwgzejhAivvSF+8fZ2ddpOFR5O5jLceU8oTW8qs9F5x7t591NVxCA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPVMR-0000000ENNH-0VNQ;
	Fri, 05 Jul 2024 00:55:31 +0200
Message-ID: <c56aeb3368830bffd400fc2c701234130fdea485.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: vector: Replace locks guarding queue depth with
 atomics
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, 
	linux-um@lists.infradead.org
Date: Fri, 05 Jul 2024 00:55:30 +0200
In-Reply-To: <958adfdb-dfd0-48ef-bf63-e4d759e07f25@kot-begemot.co.uk>
References: <20240704122259.1869198-1-anton.ivanov@cambridgegreys.com>
	 <44d28d25de3d11458aef2755b44350d344a1caf8.camel@sipsolutions.net>
	 <958adfdb-dfd0-48ef-bf63-e4d759e07f25@kot-begemot.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_155534_875009_D2CCB73D 
X-CRM114-Status: GOOD (  17.73  )
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

On Thu, 2024-07-04 at 21:16 +0100, Anton Ivanov wrote:

> > > -	qi->queue_depth =3D 0;
> > > +	wmb(); /* Ensure that RX processing elsewhere sees the changes */
> > > +	atomic_set(&qi->queue_depth, 0);
> > >   }
> > I don't understand this.
> >=20
> > prep_queue_for_rx() is called by vector_mmsg_rx(), not in parallel or i=
n
> > a different thread or something, inside the NAPI polling. All it does i=
s
> > reset the queue to empty with all the SKBs allocated.
> >=20
> > After that, prep_queue_for_rx() calls uml_vector_recvmmsg() [1] which
> > fills the SKBs, and then vector_mmsg_rx() itself consumes them by going
> > over it and calling napi_gro_receive() (or whatever else).
> >=20
> > There's no parallelism here? The RX queue wouldn't even need locking or
> > atomic instructions at all at this point, since it's just "refill
> > buffers, fill buffers, release buffers to network stack".
> >=20
> > What am I missing?
>=20
> You are not missing anything.
>=20
> The rx and tx are using the same infra to map vectors to skbs arrays.
>=20
> I can make the RX use a set of lockless and atomicless functions, but=20
> this means duplicating some of the code.

Right. No need to duplicate I'd say, but I don't see then a need to add
a wmb() barrier here? It's confusing me because there's nothing
accessing it in parallel.

johannes

