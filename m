Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F306CA1016
	for <linux-um@archiver.kernel.org>; Thu, 11 Sep 2025 07:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TNaDwTJZop2ddQ5UDh22YAz8ggmdQrz12HT+woTeAOQ=; b=scsh7Qb6JBaewThaK9u4d88ZtW
	A2ujCDtCFStdO/+bITBqvz9twtShYARH4HPNe0i2ZrTTvfotBAkb1OPvD2qSt1hW/iu8se3VqNPx+
	raOzNetgdDeIWewVdWPmAut4Tf3jIARLhkoRo4Kt5+cfWs6Bwj3fPTJo/42t2YjTk2FQdEPdzqHon
	Sa1Qor9eEGzw+fvQ9oafbxnSNJL9w0FF5UNgHKjdF1MNum4gXbyEFSi4vzf2x5cwiKmL0+8fzf5xN
	JUEJyytl8WsC9SfPXwNdgPIk2RyoXNNAhOKmBKLgFxKeWXfv3nKI8TOcDGGLQxSjbVlYtHYHk2saO
	zKuQjxtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbsg-00000001XfN-31r8;
	Thu, 11 Sep 2025 07:38:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbse-00000001Xdz-2oam
	for linux-um@lists.infradead.org;
	Thu, 11 Sep 2025 07:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TNaDwTJZop2ddQ5UDh22YAz8ggmdQrz12HT+woTeAOQ=;
	t=1757576288; x=1758785888; b=B9rY8sPkkGwMFNf/5xOK+bk3/QLG2nVu2zTqdlUjcuGiTjj
	7I7fuCdWb7HTzX1nWbkqyMaPXxkiUWwdb8C6GcDS8SN/dKNA96nRp4VPYduuBNHEig4JDfqRQ0Xf0
	eQmB0S5pwt3F3l/Bmoa7VvWmzVsXVeWwWoQJjSqGE6HBM37vcHBVCL1OviNHG/6MPuQsQE8R4Etev
	ZgrzKfPWGKxntonjhAaZ+OO0LLYBRJ88VC5UHxptolyTeMXxn1zo4XwHn3pvNw7w12dCLbwVcOBNX
	pQhrqsBAfPUXZtqW1OaL2sVW0aFwBKPNOgxzi9C3V5PcPa5i/+KCn58t6ZYGuSyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uwbsX-0000000Er1b-0oKo;
	Thu, 11 Sep 2025 09:38:01 +0200
Message-ID: <3c4bc989c4f10609eab699b26e8331bc878c2a0a.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, johannes@sipsolutions.net
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 09:37:58 +0200
In-Reply-To: <20250911043434.2897892-1-tiwei.bie@linux.dev>
References: <f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
	 <20250911043434.2897892-1-tiwei.bie@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_003808_709977_79B78F04 
X-CRM114-Status: GOOD (  14.71  )
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

Hi,

On Thu, 2025-09-11 at 12:34 +0800, Tiwei Bie wrote:
> On Wed, 10 Sep 2025 14:15:28 +0200, Johannes Berg wrote:
> > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > >=20
> > > Turn signals_enabled, signals_pending and signals_active into
> > > thread-local variables. This enables us to control and track
> > > signals independently on each CPU thread. This is a preparation
> > > for adding SMP support.
> >=20
> > [...]
> >=20
> > > +static __thread int signals_enabled;
> >=20
> > How much glibc infrastructure does __thread rely on? More
> > specifically:
> > Some time ago we had a discussion about building UML as a nolibc
> > binary,
> > what would that mean for the __thread usage here?
>=20
> We would need to parse TLS data (PT_TLS) from the ELF file ourselves
> and properly set up TLS when creating threads using clone().

I guess right now we cannot use PER_CPU variables in these files.
However, my expectation that this is possible when using nolibc, and
then it should be simple enough to replace the __thread.

Benjamin=20

