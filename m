Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BD606A326
	for <linux-um@archiver.kernel.org>; Fri,  6 Nov 2026 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=W5QYplw1;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kRgQP9V/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=upxm4MPlU7N3NfgqAJOH0IPRX5g3aVwXiEtIrdH4MTo=; b=W5QYplw1ycyEs6
	a6sYflngXtGtEy4PlLWyCSIXyS8N9yJeQooYRtjY3JwZe/PY4UMX5sEFF8N6KWDtM4BLSZ6veMWj7
	mVO9GYN2n5ajw1p1wgAi0ATpmJKtEh26opjDcpmLS1oY4bhGGdfgseQaCu+lpOLoWF/Yz3Ca/RziN
	WazcH0KdPXGiwcjxz0lIpxea2ptIOe8VWsBeN3iKOOyhDsSieO+ap26vzAyQU7UzV9qtHPomRZgya
	PTmhJbS/d/DTn/5Do4QcCJFeZi0Uz9a84OqpBXLWcT/D60fWvABbqEOFqO9bDVyvRXVs4efIFQo/5
	ANvFZ7XUbzthVYuzXPxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPD20-0000000BJDp-3Md1;
	Fri, 06 Nov 2026 06:02:32 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPD1y-0000000BJDN-238O
	for linux-um@lists.infradead.org;
	Fri, 06 Nov 2026 06:02:31 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-c45551fa84eso41546766b.3
        for <linux-um@lists.infradead.org>; Thu, 05 Nov 2026 22:02:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793944948; cv=none;
        d=google.com; s=arc-20260327;
        b=Z+roO5B66zl7t0VEfaDYUdoAN0/YbSJw61pKxdrAfAdTKfMymAY/JiFlduNJsK2WNJ
         TAUZ0QiCieWcsNeuhWxTKd9TJ37B1vzMUlcJwBcZXYC1mapD/KG4qSYVPECeEq6OhOVW
         9mAbxmGZ/QUcdzs6vfosrqlUZoORxSp9Na0lN6nL8RVAArs+n+Ow0ZRyAUTmvZjUaRyy
         eK/7Ww26Xnuy/KMbxXCEalUGCIWvKRWS3xyvPDazvc3hpSlkODxvfbgcxRENONKVT6iH
         Hj4hquKxPVamsNvSRJtMu6ZmUJt0kU0TbWofnuGD4D38EoiFOdZ8HYM87yrwMS95+uIT
         Vm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=upxm4MPlU7N3NfgqAJOH0IPRX5g3aVwXiEtIrdH4MTo=;
        fh=4zEZrlLUYfHCvp0n+tJOYOpF64bMMH8HP2Fp+kqT060=;
        b=gO9pGS+WPO9TzFhkkFN9Xkpo9Q+62k8z9TXRJAvyCmysz1KwegWWrZr0XVTcPoGrCl
         nzvBmUcolWVxOnoT4FeIvirNtZ9sEHMZ/Py5PmlOZBXbeHW18GbqNnlVtC8u6x6ItAVJ
         7Wk+Hkm8FIfNd4aBlY8hL/MS2okjICWwqc1liYiEZByPRIdh40//5eoN8Clr9RWWBusO
         +uFcZ8vpFeSoB2/htR5SGzQblz9aGy3dbaHNItxuKNfP1bG9Bi9/7coaA3Kjw1OfXVCE
         skTxVZ03Z23M09JFSChmhvFe9TNXqRlxJGubrfvmzYb0IqvSL2vKlkNWUnDBbUqqa+aC
         O7Xg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793944948; x=1794549748; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=upxm4MPlU7N3NfgqAJOH0IPRX5g3aVwXiEtIrdH4MTo=;
        b=kRgQP9V/ql8rLJTw0FRIUF5Iukt7YdyxJZQN0v3T3swsweiWFKmB92c8KQdHrBmbow
         8uEJTKZxMYPFSTv2qYRgFlbbDD2Kv/2oGSyL3c4nJVoKTzS9lc6s0IAV2QeaoEeGGjW0
         1zpi8wSKeN6Jlq6rG2no+FxItg3ztFfEIbzGij9rPxMQJjzATAM1t4yU1inJ+nAQ4gW1
         bl7bBZNnKRUTTIzfAn5xgLHQFkI6pDqYGC8pZaD3Ws9V1+LkIi4Bi672NMnZZ9MmYOdb
         AxYwC5xijflyRPlxkBn9O69vdkaRbSgxz3u+5bUldcEVkUIzBdCaXj6j4vKpAWmzP+hc
         bJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793944948; x=1794549748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=upxm4MPlU7N3NfgqAJOH0IPRX5g3aVwXiEtIrdH4MTo=;
        b=xsqhap3ZY7wcOB1r+dlZfCKpBI11whjGUcxxnag+M6RyzJZxJBFKqjgph5q9GAcdzP
         xLfc9U7l5/qchxJukOWa40553oyVkWPJOO9pIkAakurMrTG8d8E83UQ2vNH1XDngzYcy
         JeiWVmU5C0xea/hQPiOcHm7bXFOKVePdfi84gIA16Y5nvCSu9lPBTljwkUnSvoiNm81Y
         ymanOWh5BQsiPdL4+jlefMID6EwqFY0DaPQtHu0D5+ji7tCLNLHzDMdEicctPGzCDp4J
         SPyQQbcOptcO2Uhfqi5NScihp8/CPTqGlhFXh0XtpVOfv+ktsch4OFcEB8tLGovdITgh
         yKCw==
X-Forwarded-Encrypted: i=1; AKwUvByftOzoy7DuPTTvl8rHg2jL0KdzftE9x/FofukiQmMfXsEOyeXxZ3y97ZOUZUYn4KBQu0CVbobU4w==@lists.infradead.org
X-Gm-Message-State: APuU4Z+ENSZr1C8/tOKuGQ46DMF3OTpXTsKAo9+5PLeQ0aeEOAfRwUi9
	sSsdB6ZmSwJBFhYwdag3P6v2faVEZ6/c5FMCZXxzlWi74J0FERMWw6TJTB3WAxmsV4NbNUd5qTG
	QGj0XKzMjKp3PdnKvy9V+Nlp3paQhtoA=
X-Gm-Gg: AYBFou0trqi9WOUrT4J0nRns1bKldoEJJbpsS5QChVKqUM/NdDBd7VJyCc3UEqqt38u
	d+zVSJRmU2Bhl/jWkHhHtEo1xVRAU3aSDZbNTHlcibpxB5DYpN5R7JJ5Ima4MbHWEm41uVvHAI4
	QpIxYska58C90Pufu4K3nhZakuCHWxBEU2Hd8YGTuqiwCehcoE8JkFtUhtzyE1GE2yp7Qyp3MWX
	sWbtPocRwbESlnzR1uQjdjLgyYQ/8sexisJpZ/Oo4HUjtldU5zNM2P7c2YnoxT1B4t4aYaIr3l5
	E0jaKurrvMGtTQw1oLGEcK5hgeZkyiuCx31qgCSTWTr2F8pwip2Gpeyo5p5O6czuCd48aqUOrzE
	1Rs6rYYlKOo5LOvX7/X3GDM3LKfPuZaPiirOseOZrCsjFqG2fUYQA5CPthMm5NJorbPIg
X-Received: by 2002:a17:907:7b9e:b0:c42:4750:8d33 with SMTP id
 a640c23a62f3a-c4d355354efmr132932866b.28.1793944948293; Thu, 05 Nov 2026
 22:02:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105193426.2999631-1-stjepan.poljak@gmail.com> <20261105144316-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261105144316-mutt-send-email-mst@kernel.org>
From: Stjepan Poljak <stjepan.poljak@gmail.com>
Date: Fri, 6 Nov 2026 07:02:16 +0100
X-Gm-Features: AclHuK-YNzSXRW1RHjomN8YIUKv427RnMYB6bCZCxyhE73XOJIrYBtMyz-mjos8
Message-ID: <CAKVkeTxfwL9vFx_AFgevsQ1Kg0=DE9aSPYTcw8ZuyejhE+w7ng@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: return an error pointer from vring_create_virtqueue()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexander Graf <graf@amazon.com>, virtualization@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_220230_566835_DAAEDD2C 
X-CRM114-Status: UNSURE (   6.36  )
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

On Thu, Nov 5, 2026 at 8:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> not how you ae supposed to attribute LLM use.
>

Sorry about that. I've sent the v2 with corrected LLM disclosure as
"Assisted-by": https://lore.kernel.org/virtualization/20261106055635.301988=
9-1-stjepan.poljak@gmail.com/T/#u

Thank you,
Stjepan Poljak

