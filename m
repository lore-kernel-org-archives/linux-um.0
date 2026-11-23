Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848E0606A31E
	for <linux-um@archiver.kernel.org>; Mon, 23 Nov 2026 04:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QVFw9w8e;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=m3QkiGXf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=T8qyTQu8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:
	References:In-reply-to:Subject:Cc:To:From:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QmjJJluG72923u6dkKF4E6LX7QpWiZzvPettKxtw9Io=; b=QVFw9w8eXhjCwhuTk2Xg5DMidE
	gk/eDUxMOU7WiH4mia571adT5OmgICYRvuI3bflwXfab+kQm77OcVNb6RlMFgHRRHeCPCDFOqFvRs
	ak0qt/GahjzSbAXtHgq3ay+joQWRa1vUXjZgrGOZO3XZuapoli9k8EUmV5tI602VTOsgsOcuG2sx8
	JasauDpDhnpbLpst2S6ZtVgl7XIBgTg77oQNqG/DzjZhkFqU40J0wH5CoNIS4JEBoTsShj9HF9PhX
	89qWEzUnJbsa10CtzHNt/SoKimVSMc7mV0ss8OLCkmdDll7UANaZsqQsIOTvQe3sC48iFg7uxpeOq
	8/tf3yAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVLXM-00000002FKp-1R4V;
	Mon, 23 Nov 2026 04:20:16 +0000
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVLXH-00000002FJC-1eCn
	for linux-um@lists.infradead.org;
	Mon, 23 Nov 2026 04:20:15 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4BA921D005EA
	for <linux-um@lists.infradead.org>; Sun, 22 Nov 2026 23:20:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 22 Nov 2026 23:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1795407604; x=1795494004; bh=QmjJJluG72923u6dkKF4E6LX7QpWiZzvPet
	tKxtw9Io=; b=m3QkiGXf2sFup9A3ieASCnPMM7mmCZOy7O2V3R5BjVG++548QJ2
	d8c5OisIzbhCpkz6u68VbhZVXqo9Al71+FFkUr0iiWtR/x5tBvUfd/zkgjZCakJv
	AArZ2RETqgm+TiIl8guRPQpOsjE3zp5SkeXaUmnLItyfIwSdFdtp2eWF+AinccIZ
	gvxM0Ujb5Pn9Tcvy+S/WAGZZcE0kQwHX5/yYvynre9O6lRFmdHSkk79vJ1vDIgHB
	wZO9tnG8YQYOfxTUAqNvf5uwPIPsHNKr5RPovDb03uTTnaU9eJa0f9U03w9TYaAv
	9m6QkcsZtAphxQY2rBca26QtAMXWydg9ZAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795407604; x=
	1795494004; bh=QmjJJluG72923u6dkKF4E6LX7QpWiZzvPettKxtw9Io=; b=T
	8qyTQu82PPSMZDLrmkq6mglH95GwpcGVsKCcpd+v8o5/QOxNuccpTsneTgE07FbV
	5scBTlQL0ZEimWLcPC7pjXEzxgWh2/cLRqMD6JQwPjmnFl1VLMAinYW6OUAJ+WOM
	Weda4AlgHM1KghJ/q8IizM7DVowfqIX1PtO5DzUJiHuDaddTHSly86unvCW4+SVF
	8Lqe91fmdyR46Z9XcXdtinhcE6Jj2qPyFaLvq688Trczd1Y8jqCxyO1R8yX9kwia
	q5/POtvVq0+CXlhFI2D4s7Dm3yPANs9UhGm1QKAsZjN0ZcD5dGf4LPe0j/+0zTcP
	+Brf6dz9G9RBrF+I1/qRQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795407604; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:M79aJJKUTcwPQIUPkE60rbFy3f3CNx2knbsVqLnhWo3BbJa
	L6xcMPDsrlduMRmovL+ZrcNVsrdIQFo+awXl2NXNeqeuYQpLhmd2+K5eoXmX1axm
	9SqE+x/QRHFms0DHpEBpibVgz8F+KmI3R4H1g7k6f4M6TKoIOLsbbUO53/4xOgfL
	Kn5MQYkz8VINIIR3/3m6Qdc0ZAaaXNGAnuAcaKy3eYqR+M0J6vdGanAKve55IS+U
	/7ubMIWr1i1uF+xgHEuNhQ0wEjdIpH0E+UC+f7qUT/+XadUizCXgu5FRqbyLgTwk
	wTfuOHxutAZ3fhf7ag6pQ78AAfrL7yvCIYPbEAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:5DqTmm5+Aw5sDP+8zfo/9Yuk7Wsf8Q83qoFB+ud5qq8=:AbnOsTm4/ckYElt94OXxA6epjoXkd2Xej8CH/vMd7vk=;
X-ME-Sender: <xms:874Da_ITcrVk-rKo5AsqLnHB6Oa0XR1bRFMrLL8GFEdbtP2XUVYJBg>
    <xme:874DawVBzhTyASy-xrcN6Zt9H_gIGcEvJS1cuEykVVPC38viJSINzC2dbcbZwwCHZ
    crqlyjeyUqrUufdwfjOds4HM-iySDYN2RohmAZ79fxmmlK_Vo8>
X-ME-Received: <xmr:874Da8Olj2io5CvbpS9lpoKQ5F_K-657FrBXcvpAkbmasQ353BoHHQnJj2GPbzyIV9H8MlEr_rEvE1vczqTGfx8hrRbTJj4>
X-ME-Proxy-Cause: dmFkZTGv0kSxTW36hnuZ2AGsWuxeYAhFz6h0/5Jgx2+pY5uE0D7PdE4Q0ccZruKJ7qyqxD
    2T4Hz4bXAp1qumoqkTdvNfhT4icJvf7xmyYLbk4ZyQcRVrx9ngyL5QuHRT33O2vRuDxnqw
    QFYD6LxjSbc1grMJzygpKS7iBQgFblwMxKjKs6fsCyzSFmqk2EyUFyVHagO+R7mstf138H
    ZGFjPe8QO0Ot1g6TxuMlQxvyEfGjt+S7Kpz3mx50nyZ01Kw9eu/Ekv4c47lxL6g5yz5HQu
    2osoAB8JphtEtJr22E2M4mOyPQqK40EpR/yEGEMcnSjse5jDudxC5yil3Fy4vsRZv3+Ntc
    WTQtF9IYMpiHf/N5GvPWSN5uEUjfVT2lbtygQmuEM9lWUhr/OghNcEykG+n8F/HWqDUYMS
    oh4NKR7JMttnnoi7dSCFATtRHl8yXKKFIa8es3Hr94elzTjXbx/scZ8uA8c7EhfAkk1oHZ
    HPMNlFbNb7DzdF+diwT82ByBXs0nzLdajYoQa9MJGgw6QP0avBmCB24psqotbvb0ZdmqVk
    nZjUY0MJaIQHAzgMIdAU2T1Q6RVtuf0eXw6NhrvCaTKDjsEJYKUsaIBUb4vw/nIMMxMrMV
    MGIdq+h+9IXI9DB7+9i/MyVVds9ZoQUixWyKulcSOiug7Zquo+wPgDRc8aGg
X-ME-Proxy: <xmx:874Da0nNo5PMJ12iVr4b5RiCwQhI8ARzSgfw6ylg9_8wrm8C4R6iwA>
    <xmx:874Da3XjO_tLYiXyXJeSRyM9b6naC5Wlf7HIKOTKSeXa2gADvcXNdQ>
    <xmx:874Da7KdyLK4yOA1cVVtd4Fjg1LlOSb9pjb3ZYrydZJQ9FZ0roWWKw>
    <xmx:874DazatK-fEHcPrUH5a1Zuh6DGLnCPw8dttcZBjfBf1GRooTtsAQQ>
    <xmx:9L4Da_JXeh_YFXHJoErlSwqofBbs1Hd05ytwZIJPk0gekSWXgy5GTDO9>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 23:19:57 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Harkes" <jaharkes@cs.cmu.edu>,
 coda@cs.cmu.edu, "Jan Kara" <jack@suse.cz>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Hyunchul Lee" <hyc.lee@gmail.com>,
 "Carlos Maiolino" <cem@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, linux-fsdevel@vger.kernel.org,
 linux-um@lists.infradead.org, ntfs@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] VFS/xfs/ntfs: drop parent lock across
 d_alloc_parallel() in d_add_ci()
In-reply-to: <awB5mAWm9h1ksRFI@infradead.org>
References: <20261117000115.1433875-1-neilb@ownmail.net>
  <20261117000115.1433875-2-neilb@ownmail.net>
  <awB5mAWm9h1ksRFI@infradead.org>
Date: Mon, 23 Nov 2026 15:19:52 +1100
Message-id: <179540759290.1728055.6042791276963817025@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_202011_767696_C63DBF82 
X-CRM114-Status: UNSURE (   8.17  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: NeilBrown <neil@brown.name>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 21 Nov 2026, Christoph Hellwig wrote:
> On Tue, Nov 17, 2026 at 10:54:58AM +1100, NeilBrown wrote:
> >  					  const struct dentry_operations *);
> > -extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct =
qstr *);
> > +extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct =
qstr *,
>=20
> Please drop the extern and fix up the formatting if you touch the code.
> Bonus points for spelling out the arguments to actually make it
> readable.

I think inconsistent formatting is not much better than bad formatting.
Maybe I'll insert a patch which tidies up the whole stanza.

NeilBrown

