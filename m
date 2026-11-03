Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CD606D833
	for <linux-um@archiver.kernel.org>; Tue,  3 Nov 2026 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2VQ3PHYn;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=phYYbU4H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=lxvkJiAgj3kjRCLEyxOYum6TDgyCWdasHNqflcDGJQY=; b=2VQ3PHYnLuOLCP
	5Zdhn8SFRTcQ7Ww/IgfWETqbCWTxouXwdpUodZQHWfcKPCIDCDb4OO7N8t6tcZP24ZCB6NIfDnCm4
	6Rq+AfmoA0/NuH2KJ27c+yNFfH/GYYX2mTSeimDtDFxhQSuhTL4qUqm9nMeuaT+gjZAetZRYX1FPC
	0b1OZR87DRBNAMLO6WAzBYPlL9Bqcctypq0kTrtbDruAHvtLDO2O3Z5++YxXBHWwIYsjTC1KhMJKg
	CCo62HfIxfWml00WnmWy2d6H1xr+7X61/sqRTd2gQfFortbUaSNvTXUTbkceyxLTT/pT7cxlGyaGe
	36HO16qsybDI3UDtytlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOCxB-00000002FiJ-3C1P;
	Tue, 03 Nov 2026 11:45:25 +0000
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOCx7-00000002FhH-4Bcq
	for linux-um@lists.infradead.org;
	Tue, 03 Nov 2026 11:45:23 +0000
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-36a0eecf73fso690706eec.3
        for <linux-um@lists.infradead.org>; Tue, 03 Nov 2026 03:45:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793706321; cv=none;
        d=google.com; s=arc-20260327;
        b=pYs8+qeSbhH9BA18FpCtx7xLpIuvtvm0aS2DiD4ufnkqb3OSojbqU+XZiBLbLN3Jir
         QTFO3ervnw5C+P/pLA3us7dFTh5btQh+JlWHWUhcQTUnY3m8sywHySNoPLM0r21Ia5oY
         oWnc0YSiFTpY1y/dgoUqkirU2B6QqLkB+OCyVmBum4zUyYURBaOZ/pAEvq1vBqcocOLW
         1s2riwwSGv1G+AxZsNJC6rQcAp69aTWa1innV0AvLlmRJy9ZyqHu9tRWG+kQtEIThH6R
         Rs7vmOjeIczSomR5pBLqom7tghFs+h2DMFDZnaLi9Pu6kzLQvIPYALKP7/5XdkxpGzoe
         Q0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lxvkJiAgj3kjRCLEyxOYum6TDgyCWdasHNqflcDGJQY=;
        fh=4oC6k+C9w5jWfLluCbcfyL4ngjcn2aCsI7cVpor34V8=;
        b=AyMA7d5XeN0q1gC49mZAiE4Ftwlx0fzTX9f5qcimKl3VOih6XqNlXBADDdb0Yazo8Z
         21IZ99Z1xrS71TsMj9FbSfCmDbs+QhZysHzYaJlSTBa3UsGbz20YjMvVY2+YhN9fpQf8
         mgB5TixPn+F+zLU2mvPFQ9FE2FDKTTLlaE4UXtF4kS6NopbARGVsqWWxqpH/rOc7xhD8
         cm9yHTgQuGnIZJ7Rn9+YagUW+phUlDQxu7R8bHW7srzNcZREy+g9+GjjPdXJ7CgVIYAU
         s7A8aqK+Ay7tI9rxCfgVq7O/Z+HVHkt7tr/IfUTujJ3jFyp8Wlrd8jGxpG3Dg5LUHk6k
         JRdA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793706321; x=1794311121; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lxvkJiAgj3kjRCLEyxOYum6TDgyCWdasHNqflcDGJQY=;
        b=phYYbU4HfqUpLoX3bek0H0S1F5lg6aFwND77Zdx9RleTcUUIzUqvxQEp0GoDxoYSKY
         r813MO142l8kEZpU/CQTab/7MxTQ2N9xKGBv1p0oOIzJGqEV4yp3LsxBr/1X+ncNPswg
         86JTXmdOiv7A4NEnpSKC87E1YDklbF6vG33humUJNvuk6v8Dv8/L74v4uACOGSG/c+ul
         PYZ3aamDZy6+LiFjfP7vZUts464t2VtxyHbbPmWufezhgjQKOlO9LSyVqbANe7MKWEHm
         +9JvoxtqbnKxeZOXzXpPABGcHfOXwgn19bKQgQSJUZBK5LGNeORaBCCfNvuciwAz8/+L
         3/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706321; x=1794311121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxvkJiAgj3kjRCLEyxOYum6TDgyCWdasHNqflcDGJQY=;
        b=SqKfMbTsSXKsT+x1EHfu5NC8YEHxSSf54a/gbtAxYH7mvEjMsKPLs389h0ww/8xEFE
         pZiOmuqrefdH1WfUdDvXZcG1JXaAPXzYuYk9gnrpvI2fxMppYcJ1wzxHrTeJdCXs9GCP
         BozaiUfm+95pZ/f+XC5KrjYy+gXNbeakDZVZ6YbRCPUI8Vjx1Yw7iWDaV0I1K8KNaEqp
         wV3UuNQxksje1OR5ntvHx1qjL7dDsSEk5ZzvWfPg+PQmbk0HKCNs8Kg7VRgCjDfFU2lQ
         k1uPc4LHVGC0R4CczLOgqnSG59Nhz51RebAr0Tjrfsu5g/mwnYl0Sn5nzfBc0+3mHjAi
         Oy/A==
X-Forwarded-Encrypted: i=1; AKwUvByEWj5WAmuJTnDCRq4FVCIYA49OnEQrrghnFa7rmpON0uSc/wY+ZnljRmBbFJT1nRkiG3E3Ld0ecQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z8VJRXf3biZM0/4dTElaH3xKtPHL9cyyquLK1SmDQToD0VM5Qlv
	Ili6kEqu3x1/vCv/MxJ3CGymIxVoEQ1e2d+ETZYoge/hHlvtsfQoO2Z2pBVHu3Klh5UwDDsXnux
	/hQiK3QWagVrXoPlLwBJByXLC+oqC24Y=
X-Gm-Gg: AYBFou2IDL8mzV1rfIKa5BpnBjjH7Rt/4Amuadg/R3BTm8GPgjV/F+ijXhhOEqMmt8r
	HzlpaoTh2imkD++EoQNZppppmJEQN1yGBKComrxx6V2roocF3H6P/9kHlOr0pKhM2Zn2oxpRMcN
	Wntu+UbdqCeW30VzTVqU/pql/B/eyy1xKZx5EFBH1rhu/ntt+yzvy7LSW+1t1N21P/s3N12Omi/
	12PiLlCODfbEg769N2eMER+y1N8LlMemX1FvWkOhNIwNLRM67F6i455e27u4HGJ9R3X5XDft7S2
	NRZ99vK2hprB9kQK17y5veLfrelh+40BGk3hlnZ8i4Jbb2VHGkB0DigNlyWdhpv3TMcjSaHxDFc
	QzOaDoRFQzM5pxtwYtAGy553VtSg2sGk5Y0/1hE4/5ak7q0C8wWNebsov+qh+w/nWamZQQk7qjg
	nIbsZy12pIjIaZKAldirHUdm5njxCbjzSQRuyPG5VOiuqLM1JWSqq19vu607bgsTcpWBESK5aoX
	q//TZybieU9pCgpO+n0pQS7hTx8sho6dIykpw==
X-Received: by 2002:a05:7301:fa6:b0:369:f195:a5ff with SMTP id
 5a478bee46e88-36a4231f8e3mr30050279eec.1.1793706321075; Tue, 03 Nov 2026
 03:45:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261004121230.373216-1-tomo@flapping.org> <20261103.180207.1243555897796693771.tomo@flapping.org>
 <0730c9d467af3897a547860d036a5591cb40905b.camel@sipsolutions.net>
In-Reply-To: <0730c9d467af3897a547860d036a5591cb40905b.camel@sipsolutions.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Nov 2026 12:45:08 +0100
X-Gm-Features: AclHuK_gmeoOoDJ8hjFrxZ2Ct739hHysvzbZePn09uV-dSGvfQoY4epHcMfdRjM
Message-ID: <CANiq72mbRR4PfPKkDRmyyAa_bqkfJocyPd6rjZQNpbz+3mPqxg@mail.gmail.com>
Subject: Re: [PATCH v1] rust: arch/um: Fix loading Rust modules
To: Johannes Berg <johannes@sipsolutions.net>
Cc: FUJITA Tomonori <tomo@flapping.org>, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	ojeda@kernel.org, a.hindborg@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	dakr@kernel.org, daniel.almeida@collabora.com, david@davidgow.net, 
	gary@garyguo.net, linux-um@lists.infradead.org, lossin@kernel.org, 
	tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev, 
	rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_034522_043003_EEBCA7EA 
X-CRM114-Status: UNSURE (   9.74  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 10:39=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> I guess I figured with the "rust:" prefix it'd go through their tree,
> but either way during the merge window and all I wasn't really paying
> attention to UML.
>
> I'll pick it up now.

Thanks!

(Yeah, I think the title should have been `um:` or `um: rust:` or
similar. Personally, I check the list of files and the kind of change
more than anything else for deciding trees, rather than the titles;
maybe I should check those more).

Cheers,
Miguel

