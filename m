Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7334C4345F
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 11:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CGVLx9qgz3TjtRvUwHvGwoshAcQcOViHaUvMOEjBRm0=; b=UyCNFXMbsCB/zJ/k/GSS3BK12s
	l2o/cyEaWfqe4vlqOvdfEqdRYoMU+sFH+6W9Anqu1iDTxTJwk/rqyNCNaXYtnTwcg9SvjECNJNkUL
	W4SLc2N1sQn5x7zDWh1kvtM9vnmEIAhCQxp5AQOzaDfwaQsON3JoOchLpH3nR2SFwKgH+KsDaSiF5
	OcZaylOPxKsotzpXJlLWS/hDZKxBIxnl+WNX7IAbHSgA5BLPz5PgRM7iHcrOFJTwoH2j8GzwsMHyn
	iPq9E3x1qVFa1K6xXS2e3LxUr6d50L2/Y8pxn8GwWo/TlZ+quAKcOV7hKvx3q88cKELKzanYpFLlC
	Stpe4zGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEMb-0000000H6lf-03CO;
	Tue, 23 Apr 2024 11:31:05 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEMX-0000000H6ik-14jF
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 11:31:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CGVLx9qgz3TjtRvUwHvGwoshAcQcOViHaUvMOEjBRm0=;
	t=1713871861; x=1715081461; b=FdCuzhTxSv/4k8l3LA58KdA/UGS7Ihi5yxjbDQz5WK1h/gu
	Mkj1YfMUzl0pjJ8/1PDoxJHs965Mgl1ePzqoPbyzbxP8hitOuV4ztwscqHWtrkp98GPqlLdYlGnTh
	qS7bOUE89vWSMIcEfaopcDwE0M5NYdC8HnFe9fUujZgP3DcBFsqTWUMs6ivoVE4y/J4LgsBBEdcAX
	6D6QIbAORIMu8OyIEly7Dyk8DLAZ9e8Lz8RnWerhiUxZDct524RovX0l88nlLAFBaH8Zk3j/mtOOB
	gsYFs25fHD5fSTwp1wxLQsNNXfZOeEDChK8J45MN6ZBFOh2lmIw6OO4byIWf4cdg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzEMU-0000000261M-2zNz;
	Tue, 23 Apr 2024 13:30:58 +0200
Message-ID: <e850e5016348805e7e2f427ed98cb1eb539fc434.camel@sipsolutions.net>
Subject: Re: [PATCH 5/7] um: Add an internal header shared among the user
 code
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Apr 2024 13:30:57 +0200
In-Reply-To: <20240423112457.2409319-6-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
	 <20240423112457.2409319-6-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_043101_317434_99C9691E 
X-CRM114-Status: UNSURE (   4.75  )
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
>  $(USER_OBJS:.o=3D.%): \
> -	c_flags =3D -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/inclu=
de/linux/kern_levels.h -include user.h $(CFLAGS_$(basetarget).o)
> +	c_flags =3D -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/inclu=
de/linux/kern_levels.h \
> +		-include user.h -include $(srctree)/arch/um/os-Linux/internal.h $(CFLA=
GS_$(basetarget).o)
>=20

Why not just include it explicitly? We do have the warnings?

johannes

