Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C1BC7115C
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j9lxAywOv5yt4LeQ6A3AxT624fpEB3GL4l9rgh6gKj8=; b=tz4G0uTxB3dTX4Xa0y0xn1dHdA
	1juSpgt/4y190nPeoAPakRtphk8bfur7QkNbzKbaE3h6PV4OXm9cKRfi0dH6/tgVXhP1BFgEHSgxo
	AC9QwOv0pJwwnK4x9hx75kZKF/AtyclkRMVHGW9pSiMI2g3+7tIvbQbcflLySTa+L6fnDSvRSZhmu
	0Dnh0qu+sqcF/5avDCoGh59tPJUTIBxaQLZjRfqqHe6Yihi8iWQSlMOByB332BeitvohUS3Y2asVs
	tXBaok+YgJTuUvD3ZN3iz6sCU4fv31OFicP62X+qThehgFvASkWwTONVLidSOs8T6Q+QgN3YFtN/4
	caEAKjPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUT2B-00000009JFr-3o9n;
	Wed, 25 Jun 2025 16:31:39 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUP7c-00000008bXk-3Lk7;
	Wed, 25 Jun 2025 12:21:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j9lxAywOv5yt4LeQ6A3AxT624fpEB3GL4l9rgh6gKj8=;
	t=1750854058; x=1752063658; b=ihAz5zMX1AQj3zecYP4CMrTMRUafIXwy27LL6VgkajaA91g
	ahF5ViGb2R0udi3fDn7ZR+CxEkIsIkTWNwgl3Sbie81YEF/QGXvyTa1HsKX3a3gsMTdB9eAKrL9o0
	Bq9mS5iNBnlRlVqlfVTmQA5ew+jp5ZtWEDMZtgYJPdBU+cSxtGv8sRt6QxgvG6VqYG6emsF5LPcP6
	aocpBw6aVuEYGbmZaudn5KU7+YnJXmqqCfJsKw1pxG/+ZHtzTNW5Ptz8h9FanGqhfIBjvCYC2VCbk
	1MIDxdKD5IKQ5fpgbiBZkuKOCfTEgf6yt/Y5TprJ1FtWkFNuACI+J3BWyYeaE6LQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uUP7I-00000009xkX-2M7X;
	Wed, 25 Jun 2025 14:20:40 +0200
Message-ID: <dd87fa28e596126536d79281e87e2e0f52d9dfd4.camel@sipsolutions.net>
Subject: Re: [PATCH 6/9] kasan/um: call kasan_init_generic in kasan_init
From: Johannes Berg <johannes@sipsolutions.net>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com, 
	glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, catalin.marinas@arm.com, will@kernel.org, 
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
 mpe@ellerman.id.au, 	npiggin@gmail.com, christophe.leroy@csgroup.eu,
 hca@linux.ibm.com, 	gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, 	svens@linux.ibm.com, richard@nod.at,
 anton.ivanov@cambridgegreys.com, 	dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, 	tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	chris@zankel.net, jcmvbkbc@gmail.com, akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com, geert@linux-m68k.org, rppt@kernel.org, 
	tiwei.btw@antgroup.com, richard.weiyang@gmail.com, benjamin.berg@intel.com,
 	kevin.brodsky@arm.com, kasan-dev@googlegroups.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Date: Wed, 25 Jun 2025 14:20:38 +0200
In-Reply-To: <20250625095224.118679-7-snovitoll@gmail.com> (sfid-20250625_115328_891177_CC2D325A)
References: <20250625095224.118679-1-snovitoll@gmail.com>
	 <20250625095224.118679-7-snovitoll@gmail.com>
	 (sfid-20250625_115328_891177_CC2D325A)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_052100_841280_AFBA54C3 
X-CRM114-Status: UNSURE (   6.15  )
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

On Wed, 2025-06-25 at 14:52 +0500, Sabyrzhan Tasbolatov wrote:
> Call kasan_init_generic() which enables the static flag
> to mark generic KASAN initialized, otherwise it's an inline stub.
>=20
> Delete the key `kasan_um_is_ready` in favor of the global static flag in
> linux/kasan-enabled.h which is enabled with kasan_init_generic().
>=20
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218315
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>

Looks fine, I guess. You can test/build it without qemu - on x86 - by
using 'make ARCH=3Dum' or so.

I'm assuming it'll go through some kasan tree since there are
dependencies:

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

