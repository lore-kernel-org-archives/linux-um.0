Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA7EC46CD2
	for <linux-um@archiver.kernel.org>; Mon, 22 Jan 2024 22:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:
	References:In-Reply-To:Content-Transfer-Encoding:MIME-Version:Content-Type:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qLrCVX24lVOfLJWuQgnlosNiXvjXp4qlzUK74n4Lv+k=; b=OKnFt/xrXZZrZPNxLzwxxXsKcV
	ZD2T9/DaybdZZ2qW2JHWo6q6GSjIAVf+zVV0/rFUrNCOIV+d3j+e5i9qlI7ptf0fTELsQ0s+qbacT
	dGL+IE679Xep9oxrjBiu8Q0MijjuADv0ygNC4FoFndEDnBSem0rfrNd6OeuQnFmmYnZAQnuebaHh5
	JgPQNXyj35vYuw4RWv0SjrNPn7UZvku+lWEVUWQkCfXQNxWEfltI3YloSC+n+gmes2HpYnnFgZ8KC
	kPBsxv8AYturw4W9+Sk78pwvlrqbDiZwzFV5eatAWmmjGW/wrCDISjqLTz4OemE3zF0Z0z6RkMV9w
	JRq64tGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rS35R-00EKPQ-0t;
	Mon, 22 Jan 2024 22:48:13 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rS35N-00EKOJ-1O;
	Mon, 22 Jan 2024 22:48:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AEA39CE2D13;
	Mon, 22 Jan 2024 22:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA8FC433C7;
	Mon, 22 Jan 2024 22:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705963686;
	bh=aRO5rI2gBLdjP2Ow80R5wBiyllC8SGlBK8PAr36wVzM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SIjjwsOE6XK+oLQbheaQg4QVbT9JVjy30vmiv3ORQOgq7S6FQv8k4XG1s+wW0x7pV
	 rx0n35Uq4nT+ZfAzyV16EE9P7CUcDxdy4Icwo2SNAdM9eOEySqywBnNzQ7Q2hl9E6p
	 Tgywv2wmPhDPHpupI2h6rmRx1SHz6teEPZdyv/hgNuoZeaFCxSSi3LMVS1B+ibfCbK
	 vKIDGeQ4xW+0SRKkxmJ2tElQ/1pSXE32RtcqnyaHKQaD1NOYmigFdzJeoeZzVPXj3/
	 b1n491PKznHSazyiLrteCXRpQiM73c5yKwOCGbF6NbuFEgi04cxyKmCb29ES6WsT/2
	 KFWIaCNP3a57Q==
Message-ID: <47062115ff518edf8c4b02e22f3058bc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSkymMzaOFtJ-6OuVaB4i4zoVafPMqssA=GHByMJ9VTsKg@mail.gmail.com>
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-7-sboyd@kernel.org> <CABVgOSkymMzaOFtJ-6OuVaB4i4zoVafPMqssA=GHByMJ9VTsKg@mail.gmail.com>
Subject: Re: [PATCH 6/6] of: Add KUnit test to confirm DTB is loaded
From: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>
To: David Gow <davidgow@google.com>
Date: Mon, 22 Jan 2024 14:48:03 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_144809_660203_803E9AB0 
X-CRM114-Status: GOOD (  16.44  )
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

Quoting David Gow (2024-01-15 21:03:12)
> On Sat, 13 Jan 2024 at 04:07, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Add a KUnit test that confirms a DTB has been loaded, i.e. there is a
> > root node, and that the of_have_populated_dt() API works properly.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
>=20
> I won't pretend to be a devicetree expert, but this looks good to me
> from a KUnit point of view, and passes comfortably here.
>=20
> checkpatch seems to have one complaint about the kconfig help text.
> Personally, I think the brief description is fine.
>=20
> Reviewed-by: David Gow <davidgow@google.com>
>=20

Thanks! I noticed that x86 has some devicetree init code. Did you happen
to try on an x86 kvm instance? Or only run on UML?

----8<----
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index afd09924094e..650752d112a6 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -283,22 +283,24 @@ void __init x86_flattree_get_config(void)
 	u32 size, map_len;
 	void *dt;
=20
-	if (!initial_dtb)
-		return;
+	if (initial_dtb) {
+		map_len =3D max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
=20
-	map_len =3D max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
+		dt =3D early_memremap(initial_dtb, map_len);
+		size =3D fdt_totalsize(dt);
+		if (map_len < size) {
+			early_memunmap(dt, map_len);
+			dt =3D early_memremap(initial_dtb, size);
+			map_len =3D size;
+		}
=20
-	dt =3D early_memremap(initial_dtb, map_len);
-	size =3D fdt_totalsize(dt);
-	if (map_len < size) {
-		early_memunmap(dt, map_len);
-		dt =3D early_memremap(initial_dtb, size);
-		map_len =3D size;
+		early_init_dt_verify(dt);
 	}
=20
-	early_init_dt_verify(dt);
 	unflatten_and_copy_device_tree();
-	early_memunmap(dt, map_len);
+
+	if (initial_dtb)
+		early_memunmap(dt, map_len);
 }
 #endif

