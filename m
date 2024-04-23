Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4B8C4345F
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 11:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZReZYBGsS5mYNtqYDrh+YYklkB/Yp7ikoMDuzoyx5Vc=; b=X7EkCiCkeO+V6g9U9qIHMB8VxT
	7jRP1dRalQG48HJSYyXz7oZ/mr/QygOfZfHegsE3KYfBEG0L3KeUJOk9nOHS78GUoKmDiIgPAlbvb
	uWD0pL1hCQAyn3VD3lsjtSIPJc7v7DmPNky9cGBbroJANLZ3XBo9GZvz09a49ET5j0OIeJ7ayncB9
	pCD8qAhYxipRX+YabhwODvtASJvwdNYMMglI+5/A4Jja3mDb0XuCQCdh2NWi8M/Fv8rVCCkEON9ST
	7g84x4xZft+GViSzXRTprZhGGZFyOwU45PfoTElOgPsLnJMM7MjcTC83+VXPfYzBuLu1sFxewbYJ+
	ly4bmVWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEL2-0000000H6ID-0NMA;
	Tue, 23 Apr 2024 11:29:28 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEKz-0000000H6Hc-43Jg
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 11:29:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZReZYBGsS5mYNtqYDrh+YYklkB/Yp7ikoMDuzoyx5Vc=;
	t=1713871765; x=1715081365; b=WD27y4+IqP2zzzS364JEd3TLjyLI7mBkpvYOkbYnl4EU8Jl
	4XaszPq+rj/bspu10hr1jyqCvwNBfic0iMzfL5z1Wml6GvaYEyHDxiZh39n5tgH6mGKqegKRUJFHa
	IHnruVzKvF5hYQc8tjc8vAPEh5kD67x2VV+LQehveiJ1LiHxW63XVYbEX+J+Drq6F2/dEtMnOxi4u
	QkIjG3dlguadz0LkZdBe2c3LaOtdCl6U61qZDJ9i6UQggzWFGUq5m7cUzsHlMnpkBeexmjcOuqNfP
	Ie0Iq/26/BE8s7aN0SHTcxEM+iUINhTp4/fIkDJ7UvCy4DpxDHsvl1BguaR0nMLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzEKx-000000025wR-13fF;
	Tue, 23 Apr 2024 13:29:23 +0200
Message-ID: <8134c423c1a7f911cb5ae2f2e8e40e80f2e5270f.camel@sipsolutions.net>
Subject: Re: [PATCH 2/7] um: Fix the -Wmissing-prototypes warning for
 __switch_mm
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Apr 2024 13:29:22 +0200
In-Reply-To: <20240423112457.2409319-3-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
	 <20240423112457.2409319-3-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_042926_048743_EAB17F41 
X-CRM114-Status: UNSURE (   6.56  )
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

On Tue, 2024-04-23 at 19:24 +0800, Tiwei Bie wrote:
>=20
> --- a/arch/um/include/shared/skas/mm_id.h
> +++ b/arch/um/include/shared/skas/mm_id.h
> @@ -15,4 +15,6 @@ struct mm_id {
>  	int kill;
>  };
> =20
> +extern void __switch_mm(struct mm_id *mm_idp);
>=20

Maybe drop the extern while at it?

johannes

