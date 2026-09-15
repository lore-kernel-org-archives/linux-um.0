Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21198C88E7F
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 12:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N/qDC8w+78iGOR02PfeQ9lasCpgoFwlOJHnQ1mx3Dgc=; b=AEEKXcIFmE9rczORacLgqQ5B3m
	pNCLGzQbjEwyoJDQuI5wfXlRYIKXL2rtiInQneSm9whilO1YIAU4NxJxz+AzTBlAn6McdKChZdWEi
	XJX//JDXRJd40yTnyHpY26qP6q72hlnnYpMOw6Fol46mKRTzsHdeiB8uKNUQacqMF1wUu5v3QH9EJ
	hlgkdxZfsISCG/WrhhAlE7albqvClM2oaASA7u3e5jGvI3z3fBWYyfkeT5/x3EKGPK1w1PjNmHDQO
	DiGyfX+q4wnEtz6HO4iVeZ7tzORBekaOXX7EEyYoJWfnfcDC//1BciufVimu/PwpUT/LT+CbJrhns
	PWuT4u8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S30-00000006Qlp-3N35;
	Tue, 15 Sep 2026 12:14:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S2y-00000006QkX-1H37;
	Tue, 15 Sep 2026 12:14:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 108AF414E2;
	Tue, 15 Sep 2026 12:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2741F000FF;
	Tue, 15 Sep 2026 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474439;
	bh=N/qDC8w+78iGOR02PfeQ9lasCpgoFwlOJHnQ1mx3Dgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CvwdtYplEMqh0mXb9UtTtEzUPZjlErl5BgHWZ3BUuzKN64/50zHMmE8tVi+y1B3X3
	 tAYkfuPSB1IfE0nhCXR7lcqXNSl51VqpY+L+oymG9YPh17XOrUi8G3/Aa+dnQeYFRj
	 NcQX+8avtvTCjCij+9TYtbgkkb7afe60hNSTSaGvh1L3t7pyiz8fuqxatGkMKmaKvM
	 8XOgUv1cgX6wWpD+3GvwOhIJtw3OnoMVeiRhGh4LZXzdsV358kdYIG5GabAq3BtAXs
	 I7hVAiVBYRClyrA05Lt47fHM9pl9LGtyPE+6dxCTPgbrcsy0AbO5y7C+JwxLWRY8kE
	 FeK/23S/8IuyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 35/50] ALSA: compress: install the task
 descriptors when the ioctl returns
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-parisc@vger.kernel.org, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFt?=
 =?utf-8?b?dXRhYmxlKQ==?= <brauner@kernel.org>, linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, io-uring@vger.kernel.org, kexec@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-hexagon@vger.kernel.org, linux-alpha@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-openrisc@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, "Jens
 Axboe" <axboe@kernel.dk>, linux-gpio@vger.kernel.org, "Jann Horn" <jannh@google.com>, linux-um@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-kernel@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-35-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-35-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:13:57 +0000
Message-Id: <20260915121358.1C2741F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

> Rely on the fd exit path machinery.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D35


