Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159DBC28B30
	for <linux-um@archiver.kernel.org>; Thu, 20 Mar 2025 08:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YXHUUCcMVDbV1PXh/DTVkKQw7IhiVSSu5lO+/Mz07wg=; b=xqq4tPWSxl5ugpN4lRXBdPRNfp
	A2oCKPyy7L09c0lI3epR2rzgjIhJJt0qWdnPk4y5I60GWAqayjkEkzSoK3CvZtz4Lembydkv9GDxb
	Ufk8kfno7fE17IvyA9biBt8XqABtw2Y+9wq4aoxOqITqJc1DB9KSUcBCLhneUHro0Fvq2ANp7QJZq
	DekpD4iBjpe2Iq0IxRaebtamgG/kxmp/+1TmdVB10MuhNz3zTuSCeYRnuYC6cJZgnNJ3c5ORNKDxM
	RCEXiMgvR6tf+YiMNeMJBKrcD2wAL0nVm/jGrEr8g2yRo15Tn0o038HUqgoObB1qj8oJxWSm5iXgu
	eW11oXJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvBPi-0000000BYwE-0l3d;
	Thu, 20 Mar 2025 08:38:06 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvBKb-0000000BXgS-0Ouw
	for linux-um@lists.infradead.org;
	Thu, 20 Mar 2025 08:32:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YXHUUCcMVDbV1PXh/DTVkKQw7IhiVSSu5lO+/Mz07wg=;
	t=1742459566; x=1743669166; b=g6CNUpRDcjxZGeTlpyJwT/2PLo+uYrZKsVIZ+R5Ds3iOYMO
	BmyxDE1daNyckTflVSBU9UgQCMsCVoTHaVnLXOkUxdmVp8QvrcDtdHYP6+3CXrFs8lPyfI9chrZkd
	LGdE6Pjk7ZVkliMWe89e5UBhL8RUyzKkGoVJuUu++dI+6Qf6ENuircwTybKloH5++6lD/2uXDWywf
	+S7hyXWlbvnpa/m1+K1tsjTh7rIT9GLjev1kYCQFpJHMtVJp59Wjs8viQuN0OIycA+DAe00qWG872
	/LPtBwPWmcIidIhw8XeN+6S78EPxGnMRot75awNTu+kzp7zVMhaM6X55+nHWwFzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tvBKK-0000000HKc1-0cwL;
	Thu, 20 Mar 2025 09:32:32 +0100
Message-ID: <495e4b66edcc65ba9630cf1bbbb119b971af2df6.camel@sipsolutions.net>
Subject: Re: [PATCH v3 4/4] um: Prohibit the VM_CLONE flag in
 run_helper_thread()
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
Date: Thu, 20 Mar 2025 09:32:31 +0100
In-Reply-To: <20250319135523.97050-5-tiwei.btw@antgroup.com>
References: <20250319135523.97050-1-tiwei.btw@antgroup.com>
	 <20250319135523.97050-5-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_013249_145648_5EB3C4D8 
X-CRM114-Status: UNSURE (   5.68  )
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

On Wed, 2025-03-19 at 21:55 +0800, Tiwei Bie wrote:
> Directly creating helper threads with VM_CLONE using clone can
> compromise the thread safety of errno. Since all these helper
> threads have been converted to use os_run_helper_thread(), let's
> prevent using this flag in run_helper_thread().
>=20

I notice that now there's only one user left, the SIGWINCH handler,
maybe we could change that too? Anyway not related to this patch, of
course.

johannes

