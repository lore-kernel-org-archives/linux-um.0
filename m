Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373560A5BDA
	for <linux-um@archiver.kernel.org>; Tue, 20 Oct 2026 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QItz3Vkg;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PQDkfIrn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=; b=QItz3Vkg3UAaQLwxaNFMH0BtIG
	Jm2ncFUEAa419iuWmO0IkDamiZM/yIIxtkhm2135i5hPTEBg8rI5F/GT1NZjU7eHA5oDPWNU8LTFM
	LubRvvA9WLO6PN0v70B2jnFlB2ZVNm8ZvhXLwqqkKzm1aI2ErUbALbyAkHuIdnv1AE4Dzx/s/lzFL
	49dPOEf4lsBdbJiLd4jEpl8Mo6WtlIzcW61utz95lJT2y3mG2HK8OAkzSwIUs9IjpFF/zhP48crHd
	s5Kpuynqf631iwJ+qT8O80+GC3OizQqVTqv+H52iwGu9xReXamuiM40xjAhNhwIqu2p6P8RKncEu2
	Ur8oXxUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJCre-0000000ACkK-2h4j;
	Tue, 20 Oct 2026 16:39:02 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJCrZ-0000000ACi5-3Is1
	for linux-um@lists.infradead.org;
	Tue, 20 Oct 2026 16:38:59 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2e901e114fdso17356235ad.2
        for <linux-um@lists.infradead.org>; Tue, 20 Oct 2026 09:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792514336; cv=none;
        d=google.com; s=arc-20260327;
        b=W4XevN177pW8dDEUvD70JLmYZlST+8Qbj6vkznpFwCvvHGvSNDSebVRjgQKd3bjVvP
         /FemR9r1MtGD18HGrtweuaYWXnuu0563cMPsfUk7zi4y7B+h2/PFI2X1HUnIK1l9EF2U
         nCO9tKW2H+aJ9EwPxHFnXqaUDrQI7MiMe2ri7jG4y8DOGbN1mdccZiuzQetDIVDgAlej
         bfxp/Rg7ZhZTLXjQY/4RCuo3AsYO2w0n259Z6jH5ibNbluJz4f8IM8I863kO8qJ3ffRv
         j/Y0eu9rQ5Sc5+JmEW/YjBTwLJf1Zsl/8QhVOS39xfP4XjVrrO8vKBda1o6Qp+sv6w3c
         dKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        fh=Y4oBdUc6CpS9Gacty2NfQuICfBEQRY30SLe/yGRakbk=;
        b=bixFeGOXAzKfJf6in3jTia5a9Co89ZWBRKs0TQ/ioLPdVDA51saYY2RtmsXacQdCAs
         QM+7fnJk0U2ihu46fD7EWkp5c+vuth8MtnCgKDp7HMtA7hf5WPSms98cZzbiyBzQ40Ng
         sQqewbFOQcXex8yCyUaqG3+7PDPcsu60eDdU4T8PaI1Ud3tmtH5aXPwm2Me4APSEau5q
         U8APC1KDxwG6SwBS4JdfNByazYJ0vJryxwb/5qAAIxJxtzCIzLQmqzmpij0aidpM+4+n
         ew2O/nbbdcFsQ8qREvmUlMq3wy2pM9IXCV3Itdu/cRknB9R/XdDH0IS/lEk6gt+Odrci
         6POA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792514336; x=1793119136; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        b=PQDkfIrn/4QN4BfHfGId0N78PCb4K4m/3V+BIXSNEcXa2Ewa4K3XKjvKiP/dReHfLZ
         aUc4t/ge7NzAOwwzg4tLPEnyPziR284exZtXDdm49CxUG5In2O3NwqDfmFeU6OK5giHd
         6qplIo3brwYYFT/ysDElS+KQE3aOwhiDds9sP9rpOiJZ9EEeST/3ezhHW8pu0mmzcr4R
         1nUfRPyP0UX3LmODdsMkdHkkmVtBASnZXbHRp4Fuc9ZMmYLCjC9Dq+T0w+it6zYjBE3P
         0J/B9Di3nduVmUK0xhgN/9y13ID2c5IKKCU4jkRQfYXltRW3pI1DU+cXGgIdQQHhwUuO
         vvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514336; x=1793119136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        b=HaZ9rNZMs0L4+Qpl6PHG0E9hlQUUSArGa0QVQT+tFILPE0uhqwOoyCXTP47pp/7jBs
         cnjkwO6LmAP9Tu9bu9kbiAfGbkDespSs0nrvyuNGkyzA1P49CeKygT6bUqRx7ika/9SP
         Fdnjou7IPxQW5G/StqKS0P1izJtxGu7nxzrsQFRsDcuBATBv4GvWvwbSwuFjD++UGXjP
         1U309d9XErt0256sWDn+1hwVNch+4YOY4caNEX7LuTIaOi0Lam3Ztre+2qS3ZjAYBF3A
         wT+tZgooyjvEhqj70ieB3TrYaKyjye36AVTiYQ+PlTbFMlvjGRcvJ4TVPK2zEWjBbcq5
         iJrA==
X-Forwarded-Encrypted: i=1; AKwUvBzKuAkZC16s2BPpUzBB1JZKL2dfoEhae8wm8cj5F5ZCsvqdC4mSqSmfUn0tJBqRVe3nAYzaiLNzcA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ2elfs2Kq0rZwG4GQ9StKB7kN2pVgTpgCZTRCJBIHwsnDMZ6fA
	w28cVLplrtTVq2Ijn8SBihelt7U4I+/sGqCK+Y5P0qZhePOAKyJ1U/A3Ve9tvdU28yOmAqGYZzm
	SxSwHR7SKT3nqFGRlTR3Z/TUxJ7o2tWHk2Jd0dkGY
X-Gm-Gg: AYBFou16GCStvbCo0AgRWZXfYEZpKjjJzqP+iyBeXWbx4hJaA6j1ISzP6gDwIS5QgXX
	n6EwWveVJAh1rjBbVYhQ4ICm7zARBeSI0h2wzgS2uGchvJEvsE95DhPWuANvynjQn5cu1feuEGd
	tjrI7lpniwMNaWKwmdU37+b+ruj3mfae3POJxOtTjd/HIHTc3SgLmXZTdL3MG3a09+0GWmWo7nw
	eNK7I59imN8E2NzM99ZOrQ9Xull1SHw9+o0Y77YUDM6xR4ETos/HpANIuZmv6ulMH5RE26Sgd68
	/+Y0lx2ww+Sf6dGeUQBTANQk3/idPdL1HlCFDSx967qBwP9/EeL5G/Ry5OrQnHqhjcQCAjo5JqZ
	Yc2WbAKHpfHE=
X-Received: by 2002:a17:903:1111:b0:2e6:dcce:8227 with SMTP id
 d9443c01a7336-2e9a6c1a30dmr99034965ad.37.1792514336247; Tue, 20 Oct 2026
 09:38:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
In-Reply-To: <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Oct 2026 12:38:41 -0400
X-Gm-Features: AclHuK9ZakV6IFm9eD67kaqUic0iU1MgVPLS7VN6RgjPgTRZmZP6_X_XOYOX9ZU
Message-ID: <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_093858_240282_CA291F80 
X-CRM114-Status: GOOD (  14.18  )
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redha=
t.com> wrote:

...

> > * As pointed out by Sashiko, when you were converting all of the
> > arches, it looks like you missed alpha.  I took a quick look and it
> > appears that it should be a pretty straightforward conversion like
> > most of the others.
>
> I've actually dropped the alpha patch as per Magnus's request [1].
>
> [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4=
BLWOvDTt92t5Eg@mail.gmail.com/

The problem is that as things stand, this patchset breaks the build on
Alpha.  Perhaps this gets resolved during the current merge window,
but as you know we can't break the kernel build ...

https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.com

--=20
paul-moore.com

