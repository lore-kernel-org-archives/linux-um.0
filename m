Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D8FE7BDB8
	for <linux-um@archiver.kernel.org>; Mon, 16 Feb 2026 13:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	To:Cc:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wq+Zr6L88Web7nSkY4eKcKCq9RujjgnqldokSx/qmRA=; b=m3gtuc0dz8UsYme3XkV07fDzm5
	8VPCvA/jXTfFu8SWSDOReSmSqtNLbuOHerCoc53SlANbSuFlO8cUPkV2hjnTuTFOFW3c5ODTjQoUn
	2lCH019h8n0CnbelzgXKooMcbSnrwvBH/RDQZOcgh4u71lsFVLRw6LjJRZ4al+riMJKhFxfhT5p//
	iqld7H1+Knw0D7ma3sAxBTLMhU7EB+Es2nzLZKys5uFS8tUy6EiyLXyC3qK/zFl3wv1945f5GcVAT
	4UEHnWufSC8lAR2sRhXT5XF3d3YDL5j4VIHWRLCpy0u22bs0vXkdi2K4XMW/xleGl9sG42ZpZpeId
	OjNI9Uog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vryYa-00000006eJb-3h64;
	Mon, 16 Feb 2026 13:22:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vryYY-00000006eJG-0VmM
	for linux-um@lists.infradead.org;
	Mon, 16 Feb 2026 13:22:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D56E4342B;
	Mon, 16 Feb 2026 13:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8765CC116C6;
	Mon, 16 Feb 2026 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248146;
	bh=wq+Zr6L88Web7nSkY4eKcKCq9RujjgnqldokSx/qmRA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=frRDEktTVlJUto0BcqBtYAJGbVuzLzbUuaBjm/ndTovt7+86WajDsEmpOaJoX7xAK
	 xTuwIxVxoQlu5fSVLLaaHyXm2GDSE/HyLg2wrKJDxDzpaasnXFZ2FVOH248N/z6uMI
	 0wNjy2OX1hksnkGA2pvBOU/GUcP6A3k5S3lERUUJ9EAqnN23B1t09kzEL2gxgHHUl2
	 LlFtWvMTOg8qwCAEOmPYl1B2EKR7tk/AqnFSLM5hr9/RedmP4Q6TTomHQYX57FzzaH
	 g57X2Our9caSrPyL3BzddhAwD3BftWxAdtsR70fIQcoup19/YNrBB6YL5gq1utdI0L
	 +Lz7BIEH9Jt6g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 14:22:22 +0100
Message-Id: <DGGF2BKJP4BS.1CZFWVQTK144G@kernel.org>
Subject: Re: Mainline UML Rust stable io.rs unused imports
Cc: "David Gow" <davidgow@google.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Richard Weinberger"
 <richard@nod.at>, "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>, <driver-core@lists.linux.dev>,
 "linux-um" <linux-um@lists.infradead.org>, "rust-for-linux"
 <rust-for-linux@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <CANiq72khOYkt6t5zwMvSiyZvWWHMZuNCMERXu=7K=_5tT-8Pgg@mail.gmail.com> <DGGBI4DU4J4U.2JOBHL5IFUCTL@kernel.org>
In-Reply-To: <DGGBI4DU4J4U.2JOBHL5IFUCTL@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_052230_184492_652FF4A7 
X-CRM114-Status: UNSURE (   3.03  )
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

On Mon Feb 16, 2026 at 11:34 AM CET, Danilo Krummrich wrote:
> I will send a fix soon.

https://lore.kernel.org/driver-core/20260216131534.65008-1-dakr@kernel.org/

