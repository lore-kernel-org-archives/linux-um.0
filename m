Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3C5C36018
	for <linux-um@archiver.kernel.org>; Sat,  5 Apr 2025 15:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fV5dHBpJfVmrE8DQ+hJRT9yCmP3MHqoqGuWkp/fak1I=; b=MSwcA9dc5ewXRXejNXYo77vMDH
	zD4A4mYZflwru9JrIT4zfQFUwgEl+YNN9FSZbN6WaQZaeGshKYalci/HWzpsCVFKxyaUH2gFFTWl0
	X4e9QfNcQc+bvI1Cq/UoDGbyBnvNotxOYziQLOZ/vYfNKbzOdDlEterlyyJEFizsK4Y47u6VYcOe8
	BFGN7fHFT0UStGuORIqlCfte0BzrxjL3w/7gMCWoa6ovLVsOqK5j/98iOa2GIXR86UBihoHC+E8vT
	jkXtMicJLJ113IeyUkWilEkMv8QLM8r1dYL/xOfWswFk+FIgdJG4nv9/zvkcqAvDQ0ub0hZTI8EmC
	snOiekVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u15VM-0000000E8qo-1zC7;
	Sat, 05 Apr 2025 15:32:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u15VK-0000000E8p8-0Nva
	for linux-um@lists.infradead.org;
	Sat, 05 Apr 2025 15:32:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8812443BC0;
	Sat,  5 Apr 2025 15:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B8AC4CEE4;
	Sat,  5 Apr 2025 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743867134;
	bh=RdPSb3R/N8g0+oYT6+2V0LNQyAZKsrTfROQEnTne+ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jVK6JF8RzIa2fTbodJS2FISwWudNboXPBdoMoty0m2mNay6iJThuDSiveMToI7V8O
	 6g42eS8E8LtVI1QtvaMdw0SCKHNRCfLy0HhQZ9huqFtTKXXYLeE0vgxLVvbbhyeWV9
	 /2AcgLtXGwCv+ZtdoJsPxpFgNHty72ixEgcls3MiRRT57BMJNjgXWrqquPIHsgUjWo
	 Xrc3yG2qtgjXemyHrcmVgYcq10cFR7TTNYhQzl+nTvdm+Ef7qp75wk6UO/6XQFrscS
	 v1OjaKgVM6dR70zKrI+gtG7dOiGVaMpbieSrkNOSwc3LpO/u9ElY/UEveU82g3GLiz
	 NgnIiJ3gmDWxw==
Date: Sat, 5 Apr 2025 16:31:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "=?UTF-8?B?TsOtY29s?=
 =?UTF-8?B?YXM=?= F. R. A. Prado" <nfraprado@collabora.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vinod Koul <vkoul@kernel.org>, Eric Biggers
 <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim
 <jaegeuk@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, kernel@collabora.com, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-media@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH] docs: Remove literal markup from Documentation/ paths
Message-ID: <20250405163158.55935fdf@jic23-huawei>
In-Reply-To: <874iz3g6w1.fsf@trenco.lwn.net>
References: <20250404-doc-paths-unliteral-v1-1-74718785444e@collabora.com>
	<20250404182006.000038cc@huawei.com>
	<874iz3g6w1.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250405_083218_170938_502CF088 
X-CRM114-Status: GOOD (  20.16  )
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

On Fri, 04 Apr 2025 11:42:54 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>=20
> > On Fri, 04 Apr 2025 11:37:28 -0400
> > N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> wrote:
> > =20
> >> Given that the automarkup Sphinx plugin cross-references
> >> "Documentation/*.rst" strings in the text to the corresponding
> >> documents, surrounding those strings with the literal markup (``) not
> >> only adds unnecessary markup in the source files, but actually prevents
> >> the automatic cross-referencing to happen (as it doesn't happen in
> >> literal blocks).
> >>=20
> >> Remove all the occurrences of the literal markup in
> >> "Documentation/*.rst" paths, except when the actual source file is bei=
ng
> >> referred. Also change the surrounding text when needed so it reads well
> >> both in the source and the web page (eg. 'see file Doc...' -> 'see
> >> Doc...').
> >>=20
> >> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> >> ---
> >>  Documentation/admin-guide/mm/numa_memory_policy.rst       | 2 +-
> >>  Documentation/admin-guide/serial-console.rst              | 2 +-
> >>  Documentation/driver-api/dmaengine/client.rst             | 2 +-
> >>  Documentation/driver-api/nvdimm/security.rst              | 2 +-
> >>  Documentation/filesystems/fscrypt.rst                     | 4 ++--
> >>  Documentation/iio/adis16475.rst                           | 4 ++--
> >>  Documentation/iio/adis16480.rst                           | 4 ++--
> >>  Documentation/iio/adis16550.rst                           | 4 ++--
> >>  Documentation/iio/adxl380.rst                             | 4 ++-- =20
> >
> > Split patch up by subsystem would be a good thing here as we may
> > get other changes to these docs during the cycle and resulting
> > merge conflicts if this all goes in as one patch. =20
>=20
> That seems like a way to add a significant amount of pain to a basic
> (but indeed useful) cleanup patch like this.  If the relevant
> maintainers insist on it then that's how it has to be done, but I bet I
> could just take the whole thing through docs with almost no trouble.
>=20
hmm.  I'll go with maybe. Let's cross fingers then.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> jon


