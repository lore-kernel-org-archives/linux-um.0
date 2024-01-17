Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF396C47DA2
	for <linux-um@archiver.kernel.org>; Wed, 17 Jan 2024 23:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:
	References:In-Reply-To:Content-Transfer-Encoding:MIME-Version:Content-Type:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fyXBSC0bnHo3boCpQubXQI92k6WFO1uOlIbnTuqgLD4=; b=QsO5cm4tpDMLzQS0BaGaL5z6QN
	vDv+MrV+hL74DSGpPcVWBy4VYwob9hfeAMNAbLECr+edzdR98FJXmtbgFZjPm7iAYxPdgynherVW/
	vueNCZ/r/n2KBdtZaklFORqLBGiTXCJIk8uBBdHOcl17b2HpGOUYWPaOKkVoDVE+ZMHXxuvwqzD+7
	IDSjmYdWfUEVNfB5HrUP+/HXGGf85JhXoDBzch8xzr9a+bje15D3fPcYMjLHmZ3wkZzqeTw0xaAES
	zo/JfqMXkWd8EW1h91km2HoVKSJpH7x0fBgeYj1i3xCzcoNFk+Z47pypWKpWqoRt3AyYh4yGRnjf3
	MVzxPyTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQEu0-0010nQ-1I;
	Wed, 17 Jan 2024 23:00:56 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQEtw-0010lI-1l;
	Wed, 17 Jan 2024 23:00:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id EB538B81255;
	Wed, 17 Jan 2024 23:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAA2C433C7;
	Wed, 17 Jan 2024 23:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705532450;
	bh=fyXBSC0bnHo3boCpQubXQI92k6WFO1uOlIbnTuqgLD4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WxeT3GBztptAaY54E7E/IibQmlI2auDqcjQAJU/gbKcJrpG8pzf4C7/y1Z3dWzZLM
	 C3E7KEby6UhIR9QxS/hXvDl6n8eBw+MdcCGzH5yULampXTr/OV2rJLG11LvS9RRIYn
	 YzrKFeKcLsRcvhdr0fNVMSHKSf2pNYsWc1rDfKFpxAjY7Fq70WYgFnxZbaQTF5F5AK
	 49xUOHmYbNMTvV9nsg29O/JNZUvnx4yb22BH/iUncI2nMgA9h7/UEOvfcq6VTOJbc5
	 yXO/XavnF5W6YWnqKq5QzKcjtF2A3erD1aVIOVPukufVmT4wvd8LbVFYOul5+8E2zE
	 tqh93Yr9GR9WQ==
Message-ID: <c3f239caee806419a8ad0ed45a627947.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240117175448.GB2779523-robh@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-2-sboyd@kernel.org> <ZaZtbU9hre3YhZam@FVFF77S0Q05N> <434b21afe1899b1567f3617261594842.sboyd@kernel.org> <20240117175448.GB2779523-robh@kernel.org>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
To: Rob Herring <robh@kernel.org>
Date: Wed, 17 Jan 2024 15:00:48 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_150052_734440_D98E0D58 
X-CRM114-Status: GOOD (  23.34  )
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

Quoting Rob Herring (2024-01-17 09:54:48)
> On Tue, Jan 16, 2024 at 05:27:18PM -0800, Stephen Boyd wrote:
> > Quoting Mark Rutland (2024-01-16 03:51:14)
> > > Hi Stephen,
> > >=20
> > > On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > > > Call this function unconditionally so that we can populate an empty=
 DTB
> > > > on platforms that don't boot with a firmware provided or builtin DT=
B.
> > > > There's no harm in calling unflatten_device_tree() unconditionally.
> > >=20
> > > For better or worse, that's not true: there are systems the provide b=
oth a DTB
> > > *and* ACPI tables, and we must not consume both at the same time as t=
hose can
> > > clash and cause all sorts of problems. In addition, we don't want peo=
ple being
> > > "clever" and describing disparate portions of their system in ACPI an=
d DT.
> > >=20
> > > It is a very deliberate choice to not unflatten the DTB when ACPI is =
in use,
> > > and I don't think we want to reopen this can of worms.
> >=20
> > Hmm ok. I missed this part. Can we knock out the initial_boot_params in
> > this case so that we don't unflatten a DTB when ACPI is in use?
>=20
> You mean so we don't unflatten the boot DTB, but instead unflatten the=20
> empty one, right? That sounds fine.

Yes. Note, I don't have any ACPI arm64 system on hand to test anything
with :-(

>=20
> Another thing to check is kexec because it will still need the original=20
> DTB I think. Though if you are doing ACPI boot and kexec'ing, kexec may=20
> write out everything needed by the next kernel and the empty DTB would=20
> work just fine.

Yeah, it looks like dt_is_stub() will keep doing its thing there. The
empty DTB will have nothing in it and so kexec with ACPI and the empty
DTB will continue to use ACPI, and then the empty DTB will be added in
again.

> Of course those users booting with ACPI and then=20
> kexec'ing to DT boot will be broken. Perhaps that's a feature...

I don't know how this part works. If you kexec to DT boot won't you run
through startup again and initial_boot_params will have a non-empty DTB
in it? I'd think this would keep working.

