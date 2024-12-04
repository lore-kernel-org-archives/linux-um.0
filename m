Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBA7E77170
	for <linux-um@archiver.kernel.org>; Wed,  4 Dec 2024 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pBm0RLZWuBcEhkU8t2N3W12QfMGCD1prm6tW7aGFc5w=; b=Ih0qEksRp0J2AyK8lu8xb6wL0S
	uFwz/T2kq0gxOWZ14CiNYLqmFsTcGOrgTZ3ARSTUsHhuLSBccVhKKNbzavTTXzfWcCL/ckqwkivbP
	ii3TG1zHA3sfd0d9Q+R6PWSlg0v2Mq8d3nEyV/GT8SnXH68UUc0k1rHaWAmOvCx+7OVY/vOJUUsZ9
	78mqRcJhn2dDlPnnRh8xQdYGHswl0uuXdxQYLfZHZUhkfs6W40mg2Jx/w+UWEdbzxaYCugvKKpeC8
	8WBqxq3wwodeJEqCqVAPweaRgiEvNOLhqO95WkP7X6oNUj1G8kpoSqlSeB825RhJPtX/K5rcxl30U
	W5p9PLoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsd0-0000000DFKG-0kkq;
	Wed, 04 Dec 2024 16:53:30 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIscJ-0000000DFEf-2dVX
	for linux-um@lists.infradead.org;
	Wed, 04 Dec 2024 16:52:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pBm0RLZWuBcEhkU8t2N3W12QfMGCD1prm6tW7aGFc5w=;
	t=1733331167; x=1734540767; b=iAdMYfCCW3bqVfY/1iVPJx5MpTe0bqaWm1RJaMrwQcW+kPC
	30LqjIjvllUKPSV2TF70lyg3oe+ACIT0I1xO8tYtU5QmX8JgLO589nM23xSH2I67mRp3ZHfd4X7B0
	zbaeetizcyJLc8d5kj8TpwuziuOw8GkmZEVZs/poHa27mB2ks0FGV9abZtR7vYvM7z9KAZf/pVJP4
	9KM8Is81azca28ZO2u7goZno7uu8azf9euL37K2f7hoOvMJY5xkYpnqmcDYCAcjdLuaOjMi828VK5
	uUdkgLmtE0fi3URfQ2wwlwvDvLNyVsLMrGTiQ0h5tD6OF93jRmPyLD9QD/BINUqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIscH-000000079iI-01fa;
	Wed, 04 Dec 2024 17:52:45 +0100
Message-ID: <8a3bead9e5664de347822a2106c53c9517131e79.camel@sipsolutions.net>
Subject: Re: [PATCH v3 08/13] um: nommu: configure fs register on host
 syscall invocation
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com
Date: Wed, 04 Dec 2024 17:52:44 +0100
In-Reply-To: <e3d540d8a9c034a76d731714ba25bab0a7bc9b4d.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
	 <e3d540d8a9c034a76d731714ba25bab0a7bc9b4d.1733199769.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_085247_663379_969C1C19 
X-CRM114-Status: UNSURE (   8.16  )
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

On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
>=20
> +static int os_x86_arch_prctl(int pid, int option, unsigned long *arg2)
> +{
> +	if (host_has_fsgsbase) {
> +		switch (option) {
> +		case ARCH_SET_FS:
> +			wrfsbase(*arg2);
> +			break;
> +		case ARCH_SET_GS:
> +			wrgsbase(*arg2);
> +			break;
> +		case ARCH_GET_FS:
> +			*arg2 =3D rdfsbase();
> +			break;
> +		case ARCH_GET_GS:
> +			*arg2 =3D rdgsbase();
> +			break;
> +		}
> +		return 0;
> +	} else {

Even checkpatch complains about else after return :) No need.

Also here, I think need better separation of MMU/no-MMU code. Perhaps
some of the functions should have "nommu" in the name too, and be
otherwise empty inlines.

johannes

