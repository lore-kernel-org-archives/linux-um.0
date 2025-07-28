Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310CFC87FC9
	for <linux-um@archiver.kernel.org>; Mon, 28 Jul 2025 14:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kan1Nvu4fdnj3Ipiy/I4P6TX4BP+4MimUGMZHY7um2M=; b=Uzj+oJAObC0l4PBba3LbUmkQmo
	aGsWjCFL4E5InBTAaDZZYr5rDNvKoVzY1N8Vvd0cFSxUWwjSHt9vlmrdPL4cOdnMHu+YUf5ZBzTap
	jikml9+U+7LZLCIvLNuSPY2TFxbyWx9kV0OcYtFEkQprxIZFwHKwJAnYrwLp1HtaO21s3+FK4uyjs
	4xIGhhZm6t/GNUiTgc0UhmqulFgeKELHNYWjMYCWMp6TEb+r1Rgzk/TwHaHT0vx9CVfl6izRDhY4J
	2U+hHaGzd9ur1WUYeuQ53qxFw0zZkqqqgf9RPgNCMzAN6MPPgbHzIS/vqGXNjpFnQuDCKy4UKc7Ph
	bW9QaoPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugOTK-0000000EbzG-2l7P;
	Mon, 28 Jul 2025 14:04:58 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugOKC-0000000EaCy-1bSA
	for linux-um@lists.infradead.org;
	Mon, 28 Jul 2025 13:55:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kan1Nvu4fdnj3Ipiy/I4P6TX4BP+4MimUGMZHY7um2M=;
	t=1753710932; x=1754920532; b=w5bbYMhu0kcwsMO3TwYomIAO+kQeRdx4qDuazyoi3CBCyWI
	HQLBM5b6/kcHzmlhCc8/G2jU+bTC2hII2CSl4rCWqu3tbT/DUPwg3oRWKhyBE0dSVxr7SoXphgWq1
	AHQbc4tNJoMaNNqfIkookFvUVdT7UPxoqyl7M8nunUXOG0nJYeHtRWyHW+nSGtUgBvadsKTxcZwe0
	kTqouCP5FNnF6BHJmIX1ZSxzgtqB97yCpX+9EmSB4L3FLxJY+epsMc3ujT2MmlDxEGTqroEv2odxN
	wicbQwpp+bUdPbffRnakSqn0DCOQXw4Y3ZV8bAeKLUoY7kB08opLoAwp+P7vPirQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ugOK9-0000000Crxq-0cYd;
	Mon, 28 Jul 2025 15:55:29 +0200
Message-ID: <80979dce038d684495b77d6a90d19df7a4b94b9c.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] um: Add initial SMP support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, tiwei.btw@antgroup.com
Date: Mon, 28 Jul 2025 15:55:28 +0200
In-Reply-To: <20250727062937.1369050-10-tiwei.bie@linux.dev> (sfid-20250727_083200_844163_0A31491B)
References: <20250727062937.1369050-1-tiwei.bie@linux.dev>
	 <20250727062937.1369050-10-tiwei.bie@linux.dev>
	 (sfid-20250727_083200_844163_0A31491B)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_065532_418461_463CE520 
X-CRM114-Status: UNSURE (   6.95  )
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

On Sun, 2025-07-27 at 14:29 +0800, Tiwei Bie wrote:
>=20
> +static void IPI_handler(int cpu, struct uml_pt_regs *regs)
> +{
> +	struct pt_regs *old_regs =3D set_irq_regs((struct pt_regs *)regs);
> +	unsigned char c;
> +	int fd;
> +
> +	irq_enter();
> +
> +	if (current->mm)
> +		os_alarm_process(current->mm->context.id.pid);
> +
> +	fd =3D uml_cpu_data[cpu].ipi_pipe[0];
> +	while (os_read_file(fd, &c, 1) =3D=3D 1) {

We were discussing the IPI stuff and started thinking maybe an RT signal
with sigqueue() passing the value to the si_value in SA_SIGINFO data
would be possible and have less overhead? That way there's nothing on
the SIGIO path, and you don't need a read() for the type of IPI?

johannes

