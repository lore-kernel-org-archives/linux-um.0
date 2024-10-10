Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4660CF11F4
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 13:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fJX5aKd67axg/fQbGEhCLChQ9bm0yy9Pvw1YStXuntA=; b=yewgjgvF+b92XF1e0W3GMAy/Ft
	WfCRqYIksNUrAdk6dGM5oOjV3wqo1G76jJH9ehq+2rtDm87YLNwz4bpJCaYDKYL2wRpmUVmE6KOPJ
	TAWaZUrWCt/xoVOjdpx0du9vs4IwvK+5xhHru1hHAGwUJ9d3R39bnX0kkn/H7aN/vX+lzLf4ZT5ED
	+hmWqmLH5kjH0KZFNMhWtPOqPEQVUVZ/jqvn1JtLeAELt/M3EURY16evFMaspdn/nV9uM0OL1bUvv
	/4EMgE8VqB6XvqGwHTtgBVORk1amZU/gM4508VO7H0pL9iLmlgxkpML9T7DH5EKm2PjyzXZtqyBjb
	D4bTL/cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sytG4-0000000Cv7E-0IvN;
	Thu, 10 Oct 2024 13:31:12 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syri2-0000000Cc5k-1v0l
	for linux-um@lists.infradead.org;
	Thu, 10 Oct 2024 11:52:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fJX5aKd67axg/fQbGEhCLChQ9bm0yy9Pvw1YStXuntA=;
	t=1728561118; x=1729770718; b=HUoPCwGqjxij1hU3xYBI8s5jJxxGxq4JN7GOiIMnXN/q5sA
	dULljTfDoyxb5AhuzidQ9C+o4nVLM156rMc6RLvRqyum1OvS2jTijgRN5yuXvkzcVPMtvdXXAiwdn
	RTST1JLp3ZIAsgy1HzRFpDpw8E6gYECLx/4Kv24R8u1fUKGdC+UpbI1gyapYDUy4rWlTAvtaCSOIB
	TMoNX7ChKJ9V04rXX1PTK4kghl7U/csbuEt3xYIECclElOu61xiBVPilAvQ5X5gcJTO2sIdWdH0em
	bsKleHXXVR/5Zat6g7HcK2wbQ/Rq3OFTAho7RqjNwaFy7FV5lvBGix48s5sdHnVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syrhz-0000000641M-00IG;
	Thu, 10 Oct 2024 13:51:55 +0200
Message-ID: <c2cf9536c7dc5f0d805d6f79961c05bc0b8936bb.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 4/9] um: Add stub side of SECCOMP/futex based
 process handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Thu, 10 Oct 2024 13:51:54 +0200
In-Reply-To: <20240925203232.565086-5-benjamin@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
	 <20240925203232.565086-5-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_045158_520277_AA6AA487 
X-CRM114-Status: UNSURE (   7.21  )
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

On Wed, 2024-09-25 at 22:32 +0200, Benjamin Berg wrote:
>=20
> --- /dev/null
> +++ b/arch/x86/um/shared/sysdep/stub-data.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

That new file should possibly have double-include guards as common.

Can we use #pragma once yet? ;)

> +static __always_inline void
> +stub_seccomp_restore_state(struct stub_data_arch *arch)
> +{
> +	/* TODO: Use _writefsbase_u64/_writegsbase_u64 when possible */

Don't remember that, what was that about?

johannes

