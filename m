Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237ECCD11DD
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 08:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TYFqbUHOJ3/hT9xWTRUIGd5P6PahnEHSypeL9bbT9Fk=; b=H+vAtXaBFu7v3FXVJwbhcKeHp0
	X7/tnGfOpq6WBCOohBJcXuZe31tCSliu22eoIcgkT02ZbjaMV1R1xvwxkTSbt1QbgTek3QZhwqcI8
	bgReYyYhIzBzsMP+aHn899rAlGSKX7xVRvTUSVsrH+j0PWIO3OJGVKQOwQSUQKIK5z6iGQrq8a2i1
	cyKg1xHV234JE/Zk+UNd7uFaG57mOgE6ioAvYA3BwVFRZC92h7QFWTgcPsDszCqu72z+HNwOZ60xu
	oqGr8SZAqdTZ1gmUe4lu5ZLGdKGYtSEQJZY0p9GCMtV8fLqdV5RphYJKmdmLifKJpNXlj1VRdIvNK
	SeAJjqZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplPL-0000000D8m2-0Zkf;
	Thu, 28 Mar 2024 08:46:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplPG-0000000D8j1-0ZMz
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 08:46:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TYFqbUHOJ3/hT9xWTRUIGd5P6PahnEHSypeL9bbT9Fk=;
	t=1711615601; x=1712825201; b=mPMsa3S19e1fqcAEwaC4nsVunnpCPbvCCq/3kBCN1Tdqa/B
	dYoNfqKJUdQZFe9IIhFiCxXVqr8ENZqf3L7NOi24KHKggG3+Vrhx+o+RmS8k4duJxbh98RAB+3/WM
	4UVKou+vyw35FVjeybNP8s0Krt43z5yzWDtRzMfEZhyllP8wCiK48pQN3eD+QU4RPfbxlV+YbR2Z3
	C+K0R4gtlnQuWm8R2tmHHQ9LtIXPs0CqR9bMr/AOOGXxtr0nEGIb9XV299ZFKIYHdQJXsgPBv4Txf
	Kr8wksC/lAV5HVZPjkZ7OlUhUnBE2zoAmF2tFrJpMDH8jvMChxCykH0SDgdZuubg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rplPC-00000000nLU-0aP3;
	Thu, 28 Mar 2024 09:46:38 +0100
Message-ID: <9577110df4512a82dd27af0f831b569b502fe528.camel@sipsolutions.net>
Subject: Re: [PATCH v3 0/9] um: Minor fixes and cleanups
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: jani.nikula@intel.com, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Date: Thu, 28 Mar 2024 09:46:36 +0100
In-Reply-To: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_014642_260450_9B294553 
X-CRM114-Status: UNSURE (   7.68  )
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

On Wed, 2024-03-06 at 18:19 +0800, Tiwei Bie wrote:
> A series of minor fixes and cleanups for UML.
>=20
> Most changes in this series are very straightforward. Please consider
> picking this series for v6.9.
>=20
> There are still some remaining -Wmissing-prototypes warnings. I plan to
> send a followup RFC series first to fix those warnings.
>=20
> Feedbacks on this series would be appreciated. Thanks!

LGTM, thanks.

For the series, including 8 and 9 that were discussed before
(but Richard, feel free not to add that individually):

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

I also did build-testing for this, on 64-bit only though right now.

johannes

