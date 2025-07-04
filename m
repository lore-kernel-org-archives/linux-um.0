Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C0CC83F03
	for <linux-um@archiver.kernel.org>; Fri,  4 Jul 2025 11:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p5XdvK5gQteG+3d+D+Dd/ElOWPl/rbmH6W2URxWTVc8=; b=mIfng+3jcmkz8v6sLWrLtQCFbd
	PCNfQKJV8gum8svQyhn9KK/LCaTZqtmBtgB3n50F4HpPMKzBYg0CH6/Eu+bnpU3WpcmYqCZlcheIQ
	byn670TNx44nOqOavbI3LZE3TkJTU0ZXHfoQ5xLHA3At3gUxk3kAdbnHbzfOzM9hGeH9zYWfk+pct
	/2ktr3f1ciFpppx3wH5QxQ2Zuo5ZnO5e3GHCgIaQSoHxmEopkon7z924l9kv6wEFC92XH9E/JhheF
	GT5vNj4WOjSFFMqaXYRTuJGa6pmxHEn/6N/24UrZzfqvMPeims5fkjx5Y30IvPB8NmOodJqi21PhQ
	nAy0wsVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXf4X-0000000EKbn-2fVr;
	Fri, 04 Jul 2025 11:59:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXf4U-0000000EKUv-3Ob2
	for linux-um@lists.infradead.org;
	Fri, 04 Jul 2025 11:59:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p5XdvK5gQteG+3d+D+Dd/ElOWPl/rbmH6W2URxWTVc8=;
	t=1751630354; x=1752839954; b=PX/icLiQtzYYxjq3UL6aGxb9E1RRp2UhNuMuQTNufVT2AFo
	8N6jWx6dBWn4STQjd5RJpupaabX5Vts3yZsiyboDtttBpIwCjEiQ/NSW138revIdmGoyzOfC2Uuc3
	115fKIqCkg1OqfoSA8Nxg91F4Z3R7cUwahldPEt5UJT8qSwr88lO2btvgPq168tODZz/PBNh+rTl0
	OeRVYtk8XIA9CNknErfZC/4BkrJAi/tBHN7PBlsEC2u72YyaUHrjyJyYXZNN2g5yiSLr7120XIXUu
	S2tXFHNVv/u9QUnfQy6qxIDlU7ug9yopTko3lltNh7jBdsAiZFC1LoPWkLsPM4kA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uXf4E-00000006oKn-1wUV;
	Fri, 04 Jul 2025 13:58:58 +0200
Message-ID: <98d145e6dd8e216a3f7e146ad4e401724c3d669b.camel@sipsolutions.net>
Subject: Re: [PATCH 21/23] um: ptrace: Use USER_REGSET_NOTE_TYPE() to
 specify regset note names
From: Johannes Berg <johannes@sipsolutions.net>
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>,  "H. Peter Anvin"	 <hpa@zytor.com>, Oleg
 Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>, linux-um@lists.infradead.org, x86@kernel.org
Date: Fri, 04 Jul 2025 13:58:57 +0200
In-Reply-To: <20250701135616.29630-22-Dave.Martin@arm.com>
References: <20250701135616.29630-1-Dave.Martin@arm.com>
	 <20250701135616.29630-22-Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_045914_847380_1015AA9F 
X-CRM114-Status: UNSURE (   8.57  )
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

On Tue, 2025-07-01 at 14:56 +0100, Dave Martin wrote:
> Instead of having the core code guess the note name for each regset,
> use USER_REGSET_NOTE_TYPE() to pick the correct name from elf.h.
>=20

Seems to work according to the test in the cover letter. Since it's part
of a larger series and this patch doesn't build by itself, I'll assume
you want to take them all together through some other tree, so:

Acked-by: Johannes Berg <johannes@sipsolutions.net>
Tested-by: Johannes Berg <johannes@sipsolutions.net>

johannes

