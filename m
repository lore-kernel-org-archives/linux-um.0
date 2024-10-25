Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F03D0C5FB
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 10:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+I+eCDo4az0ex5eGjtpfYbV5PSXIcGBVngj6MP5K9Q=; b=EdER/erLlO/7gya3Mx6XKDmUep
	mz95Zyq33GW/LLm/oDNGf1AbLFosCOPd3d59N7LDdsh3H3Z4AvOHgzPGxYpJuvXacbxe5NVMALaW+
	/IxhJFdY55WYw4ZWvv6/9+ds4n5CzWWM36aZRnQwW4tu6feW5BAJznUiTXIozXlRQQUSO5i+iZf4W
	1L53/ClFHhqpZKgKK+nICw+twyiC5m4Q0xVKG0PudXmI2Lcd2baeWl/U33hlH0WJzAqPc7Ey98Avo
	FuK4HNjYWcvFQDaroS4gCoQhPCqItFSD4TXVIUuWYZ5Esj4waua56HoAyjEXz06OjnkXLHHneevqk
	sw4ST/UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4HbB-00000003Muc-1E6V;
	Fri, 25 Oct 2024 10:31:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GTg-000000039F1-2b0M
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 09:19:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Z+I+eCDo4az0ex5eGjtpfYbV5PSXIcGBVngj6MP5K9Q=;
	t=1729847968; x=1731057568; b=qVdNavlTrCt5pJY4rMm5iVCC1X7fKhRzViRF0yLSjRalwfQ
	+tRO4D7NH/bVk7EIhAL5ZlucXEuPTgf31zDuSxn4UCt9lVOSu76MIHAPZHYLAKVpfYrZdFLPjKAOY
	TdwtQ8s/ce5HbJ3pz3/sNd1A73L9xZpttLcQ9Bt30i5vnRgt+VO2ZlnpXkqzA5372dRtpipilN6AB
	+uuhBaT8xXImjkWppnozm9bf6THcaGSvOSda/ezMikZGWDxygRoEViz8fLAn6VYtx9cTiw0ONMja5
	ttJ5D/Jd85ej4nYLswATXw7MSXVYbnzOHv+T7yqxsOcxFK5f2YsADVwuKk5xpYhg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4GTe-00000004SUW-2931;
	Fri, 25 Oct 2024 11:19:26 +0200
Message-ID: <75c9b237111431362458ced4c5213b74ca8fcb13.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 05/13] x86/um: nommu: syscall translation by zpoline
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, 
	jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: ricarkol@google.com
Date: Fri, 25 Oct 2024 11:19:25 +0200
In-Reply-To: <2f3537884533232ab2ef2937e392d32736527bdc.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <2f3537884533232ab2ef2937e392d32736527bdc.1729770373.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_021928_680366_F0E3B11E 
X-CRM114-Status: GOOD (  17.85  )
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

On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
> This commit adds a mechanism to hook syscalls for unmodified userspace
> programs used under UML in !MMU mode. The mechanism, called zpoline,
> translates syscall/sysenter instructions with `call *%rax`, which can be
> processed by a trampoline code also installed upon an initcall during
> boot. The translation is triggered by elf_arch_finalize_exec(), an arch
> hook introduced by another commit.
>=20
> All syscalls issued by userspace thus redirected to a speicific function,

typo: "specific"

> +	if (down_write_killable(&mm->mmap_lock)) {
> +		err =3D -EINTR;
> +		return err;

?


What happens if the binary JITs some code and you don't find it? I don't
remember from your talk - there you seemed to say this was fine just
slow, but that was zpoline in a different context (container)?

Perhaps UML could additionally install a seccomp filter or something on
itself while running a userspace program? Hmm.


> +/**
> + * setup trampoline code for syscall hooks
> + *
> + * the trampoline code guides to call hooked function, __kernel_vsyscall
> + * in this case, via nop slides at the memory address zero (thus, zpolin=
e).
> + *
> + * loaded binary by exec(2) is translated to call the function.
> + */
> +static int __init setup_zpoline_trampoline(void)
> +{
> +	int i, ret;
> +	int ptr;
> +
> +	/* zpoline: map area of trampoline code started from addr 0x0 */
> +	__zpoline_start =3D 0x0;
> +
> +	ret =3D os_map_memory((void *) 0, -1, 0, 0x1000, 1, 1, 1);

(UM_)PAGE_SIZE?

> +	/**
> +	 * FIXME: shit red zone area to properly handle the case

"shift"? :)

> +	 */
> +
> +	/**
> +	 * put code for jumping to __kernel_vsyscall.
> +	 *
> +	 * here we embed the following code.
> +	 *
> +	 * movabs [$addr],%r11
> +	 * jmpq   *%r11
> +	 *
> +	 */
> +	ptr =3D NR_syscalls;
> +	/* 49 bb [64-bit addr (8-byte)]    movabs [64-bit addr (8-byte)],%r11 *=
/
> +	__zpoline_start[ptr++] =3D 0x49;
> +	__zpoline_start[ptr++] =3D 0xbb;
> +	__zpoline_start[ptr++] =3D ((uint64_t)
> +				  __kernel_vsyscall >> (8 * 0)) & 0xff;

&0xff seems pointless with a u8 array?

> +	/* permission: XOM (PROT_EXEC only) */
> +	ret =3D os_protect_memory(0, 0x1000, 0, 0, 1);

(UM_)PAGE_SIZE?

johannes

