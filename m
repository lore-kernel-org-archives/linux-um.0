Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252DEC369A1
	for <linux-um@archiver.kernel.org>; Fri,  4 Apr 2025 17:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JzbhxxufdLBWNEgR9vh1QpsUJVM3j8df+P7niCurQOQ=; b=Am05wGkWhCDSIRh/2t/ok11S6g
	t7PKnQJQTAS0mwy71GJqadsroxYRjKppoM9POmGcWfW4gvRKbfGTAJPXL4rxr/wPTuGJZQ08y3xal
	R0HVORohQktlY6zfYVtrzE7lae+rT/saYTh5K0sJjwbVwBDhYqA+MKeLExvealh5sRiM/XS751tuO
	/WvrWH2B0TC1vDM1AwBwBsdBIIJNsoIn88Etrg5sloCVGS89QBr3y7YGRMmwXpymCaIwCTi1GHe2/
	uLEDhe/WWBHDnFqjix49MkaPbh0cXGxzvlBX4XmdFIx54Uj5UjUQ1V0ddFFAf2s+ZNEbBqVDT2XFo
	nSQN8AUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0l4H-0000000CR51-2Zej;
	Fri, 04 Apr 2025 17:43:01 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0l4F-0000000CR4K-49mx
	for linux-um@lists.infradead.org;
	Fri, 04 Apr 2025 17:43:01 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 712B140407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1743788575; bh=JzbhxxufdLBWNEgR9vh1QpsUJVM3j8df+P7niCurQOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gjzgvuRxZCBmi8B6mkrqXXRmMKQkpGQhbiqLXejxp/qRwu5yW7JSeYWStGwDZMaO+
	 B3f79u/9zrKGbFs5vQRDl/ICF/laMc5MDfcYEBYHwtMMTcfRWPwvW7+/gel1Nc42gY
	 DkfUyQLmULGr9Q08Npj3bYSv74wwxIaM7vXi0npgl0MqVahgRfkb/AhVrG1s/46cIj
	 zvUfYkYmt1a52pM4Gs14ivgHcAR+r8skBoqp8C1wzyt9JXJZYNfn7prWSbPfW3Rqa/
	 GieNnfvB9yehHrM8xXgX5u5KMqO7ag8pturer7DhZ+rq9ooE0/m8bgOq5AUQQv3iTH
	 gCYovv7u8iTTQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 712B140407;
	Fri,  4 Apr 2025 17:42:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, =?utf-8?Q?N=C3=ADcolas?=
 =?utf-8?Q?_F=2E_R=2E_A=2E_Prado?=
 <nfraprado@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vinod Koul
 <vkoul@kernel.org>, Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o"
 <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, James Bottomley
 <James.Bottomley@HansenPartnership.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, kernel@collabora.com, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-media@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH] docs: Remove literal markup from Documentation/ paths
In-Reply-To: <20250404182006.000038cc@huawei.com>
References: <20250404-doc-paths-unliteral-v1-1-74718785444e@collabora.com>
 <20250404182006.000038cc@huawei.com>
Date: Fri, 04 Apr 2025 11:42:54 -0600
Message-ID: <874iz3g6w1.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_104300_034215_9B9ABC6A 
X-CRM114-Status: GOOD (  16.24  )
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

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Fri, 04 Apr 2025 11:37:28 -0400
> N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> wrote:
>
>> Given that the automarkup Sphinx plugin cross-references
>> "Documentation/*.rst" strings in the text to the corresponding
>> documents, surrounding those strings with the literal markup (``) not
>> only adds unnecessary markup in the source files, but actually prevents
>> the automatic cross-referencing to happen (as it doesn't happen in
>> literal blocks).
>>=20
>> Remove all the occurrences of the literal markup in
>> "Documentation/*.rst" paths, except when the actual source file is being
>> referred. Also change the surrounding text when needed so it reads well
>> both in the source and the web page (eg. 'see file Doc...' -> 'see
>> Doc...').
>>=20
>> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>> ---
>>  Documentation/admin-guide/mm/numa_memory_policy.rst       | 2 +-
>>  Documentation/admin-guide/serial-console.rst              | 2 +-
>>  Documentation/driver-api/dmaengine/client.rst             | 2 +-
>>  Documentation/driver-api/nvdimm/security.rst              | 2 +-
>>  Documentation/filesystems/fscrypt.rst                     | 4 ++--
>>  Documentation/iio/adis16475.rst                           | 4 ++--
>>  Documentation/iio/adis16480.rst                           | 4 ++--
>>  Documentation/iio/adis16550.rst                           | 4 ++--
>>  Documentation/iio/adxl380.rst                             | 4 ++--
>
> Split patch up by subsystem would be a good thing here as we may
> get other changes to these docs during the cycle and resulting
> merge conflicts if this all goes in as one patch.

That seems like a way to add a significant amount of pain to a basic
(but indeed useful) cleanup patch like this.  If the relevant
maintainers insist on it then that's how it has to be done, but I bet I
could just take the whole thing through docs with almost no trouble.

jon

