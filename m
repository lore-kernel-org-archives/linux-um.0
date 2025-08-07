Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7F6C87FCF
	for <linux-um@archiver.kernel.org>; Thu,  7 Aug 2025 05:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cEQcG8GPrJW+UKN5jm5bqFoBNXrzoJ5U62zfh9ZcaqI=; b=PX/v+03vDD+1TOTngwJKeWxScd
	UFbbWYwnUU/u4oN/2w0Z2eZk+whqzDUn7Dq3TehFqKRIGBIWRrpDHhmwduPZq6qhMo+zQ1t0byoAK
	ZCosxXUf3/y1ezOwHTBTRRdbuLMDte4yTghvADkHlRxgTI2F5sDOsDII29qrJE1WCQMQGI/nmX6Yd
	BgVF0Mn4vU2pW9UmkVYRQ3NU3pOm6nuvRHtddziWKvW/QPv1SuCvR39+StrSYiIh333KDFyxQq8Yk
	7swEkUIe21IaIiIfk0oFoCloN7sz74xInHQGnpGlCm9zZvb1pZo9t/XB5TC65pRPlJoqQHyewBvDW
	wCalOcjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujstd-0000000HHrr-1iaS;
	Thu, 07 Aug 2025 05:10:33 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujsta-0000000HHr0-13a6
	for linux-um@lists.infradead.org;
	Thu, 07 Aug 2025 05:10:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cEQcG8GPrJW+UKN5jm5bqFoBNXrzoJ5U62zfh9ZcaqI=;
	t=1754543427; x=1755753027; b=QpMJZAqBT1qaTQNoYH8T9NAJpDFoXQKLPFgCF8jI9wS84/d
	HlFatFg5wg/rsNakCP3xfhUTzGlwBf4Mbh25pYqaK7HlpS/nwhaN41ek3IuVvfn7sMt9zLwWWsKpx
	XeV5WT1MNZc6BWCnCdqlX09MgLBzmifIRaZ3txE1K5aSqhAxwbnoYqsZ9zc3WW+5WTmecsWkeId4e
	vC/Z2PKfXp5qT1MJ9UXtAdufv6kLH/8UDtFKdaoui2Ye47StHOHOL7n0NJ8333WiNSgwRJJvHkrRg
	BiIBjjqMYUo91cpH0DcPrhjxobnm8Llj6WVha/ErkSlU4rRAhaPaNkEzRPbYh5Tw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1ujssB-0000000BqoD-1hbi;
	Thu, 07 Aug 2025 07:09:03 +0200
Message-ID: <69f40a6f907deb7225cb6c1c8f59926d98a580b2.camel@sipsolutions.net>
Subject: Re: [PATCH -next] um: Use ARRAY_SIZE for array length
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, richard@nod.at
Cc: anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Abaci Robot
	 <abaci@linux.alibaba.com>
Date: Thu, 07 Aug 2025 07:08:58 +0200
In-Reply-To: <20250807023227.2443863-1-jiapeng.chong@linux.alibaba.com>
References: <20250807023227.2443863-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_221030_313506_586C8B94 
X-CRM114-Status: GOOD (  12.38  )
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

there is a good reason for this. The bug is a false positive as the
relevant include is not (and cannot be) used in the file. This patch
does not even compile.

Benjamin

On Thu, 2025-08-07 at 10:32 +0800, Jiapeng Chong wrote:
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
>=20
> ./arch/um/kernel/skas/stub_exe.c:196:23-24: WARNING: Use ARRAY_SIZE.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D23410
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> =C2=A0arch/um/kernel/skas/stub_exe.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/um/kernel/skas/stub_exe.c
> b/arch/um/kernel/skas/stub_exe.c
> index cbafaa684e66..01a938a5bb4f 100644
> --- a/arch/um/kernel/skas/stub_exe.c
> +++ b/arch/um/kernel/skas/stub_exe.c
> @@ -193,7 +193,7 @@ noinline static void real_init(void)
> =C2=A0			BPF_STMT(BPF_RET | BPF_K,
> SECCOMP_RET_ALLOW),
> =C2=A0		};
> =C2=A0		struct sock_fprog prog =3D {
> -			.len =3D sizeof(filter) / sizeof(filter[0]),
> +			.len =3D ARRAY_SIZE(filter),
> =C2=A0			.filter =3D filter,
> =C2=A0		};
> =C2=A0

