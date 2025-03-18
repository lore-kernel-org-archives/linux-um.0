Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4076EC282EC
	for <linux-um@archiver.kernel.org>; Tue, 18 Mar 2025 10:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x8csu3wKb/gNsJWYJAmf10OJNUwdB24DwqhwlalAhaY=; b=sOVLbigX/1Ti5z3yt4ZNBpeN1a
	bWuqLzm/bcS6FM3Cc8mbDQDOmWxwBEFisIpV9Z4aFts4yQPzFbeeWXD3VWVk7BARuwPqaP3DzhYhZ
	X6k3V8EHrq4/GgecAfCwhOpoliEH3XnODmw3NAQQuifo0k0SlNHdCyradvTCAmQ46WAaDgO136fc7
	fvCGYqWY+biPMe6CvSenGM4/JqnNyZxSzOvFPbZzoH7D2ykjbgAzoeu0caHKGqSJ8uBhzoz7CvuEk
	Ju4gE3+FEgJu77LnMTGEvc+KG3t1TDENyXiRbFptVj9/atF96Q79Wb9FpHj+MUqfkzFbBsmPCXPz3
	Q+dzK3RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUEu-00000005W9z-1M3d;
	Tue, 18 Mar 2025 10:32:04 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuU8p-00000005V2H-2tJy
	for linux-um@lists.infradead.org;
	Tue, 18 Mar 2025 10:25:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=x8csu3wKb/gNsJWYJAmf10OJNUwdB24DwqhwlalAhaY=;
	t=1742293547; x=1743503147; b=VQmPZdOx5wgOmeuaBDW9VThDxi/Lgp1OGrUED9ak2f2wisN
	2JxBHSo2oCBL1zyyPV8gPVtCjrtYARPIoiUdiUezkGaWq0a7i+XG++90vc+WDfQ/804PgxL/yRTP5
	Ec9dshpeZN7OiAZNfhv/Pz/7PT/geJAGel+G713HHH6vKlBTvc3/6SC+1CkbetBw07q5MSASUB2z+
	rTEyfI3WoZD9Zp6r2DqY/cmMyqizjhZoiNkW6znLqkbCr0pBCuQwq2xTc02caklIlgza+kvQ1s/2R
	m3gfQKMtQacMqKhTfM9+N90uVsIBSW5XnI2GQKj0sszOdTrmQqxjS64FhzCzdt9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tuU8k-0000000FDbE-4BFd;
	Tue, 18 Mar 2025 11:25:43 +0100
Message-ID: <65820d1db7b2026c7e3e4153b88f7b36c7ff4568.camel@sipsolutions.net>
Subject: Re: [PATCH 2/9] um: Move faultinfo extraction into userspace routine
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Date: Tue, 18 Mar 2025 11:25:42 +0100
In-Reply-To: <20250224181827.647129-3-benjamin@sipsolutions.net>
References: <20250224181827.647129-1-benjamin@sipsolutions.net>
	 <20250224181827.647129-3-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_032547_725338_CA0A4924 
X-CRM114-Status: UNSURE (   5.84  )
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

On Mon, 2025-02-24 at 19:18 +0100, Benjamin Berg wrote:
>=20
> -static void handle_segv(int pid, struct uml_pt_regs *regs)
> -{
> -	get_skas_faultinfo(pid, &regs->faultinfo);
> -	segv(regs->faultinfo, 0, 1, NULL);
> -}
>=20

This, and below, no longer applies due to the other segv() changes. Easy
to fix, but also after the _next_ patch I get some lockdep complaints
that might warrant investigation, though I'm not entirely sure how
they'd be related.

johannes

