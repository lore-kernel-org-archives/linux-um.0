Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FD6D10BE8
	for <linux-um@archiver.kernel.org>; Sat, 26 Oct 2024 07:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HjUzzxAwaKixMcpX9j4nGfKZcPdhnOVLwA1pcfM2UwA=; b=WW8HwaMI7/m/oILboy0T8mIY6Y
	BwPfLJ4Rs1WKeY4smK5QUg+Gie0DCJqsXCUdJI8g6gf4G8dQiomGaiHW0aWy9l0CXGgMfhQ9h1jOL
	CW8cpg9fpK6pwhvh9XDfrtJCNLCusC3n0FBL2Pl4/iLs+bU9FPd133T7TFcX1JITJ9Ue/jbm8MHZB
	+q9D71Sll6lCFTr1Yhfx9QrW4LVDf9DjPrAKPp/3TxsFwl29SPPm4vLmtI56PnLYTNQDDSY9TtXjN
	GC9R9qLL8YQNY5q8gIYIdaOGYt+hx/c1jCASPu9g1l1UiBK5p3gFeIv8mQW1AjwWH9mIwjZ11Ud+P
	5xFLQZRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4bTu-000000069rc-0Bre;
	Sat, 26 Oct 2024 07:45:06 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4bTn-000000069qm-2e9q
	for linux-um@lists.infradead.org;
	Sat, 26 Oct 2024 07:45:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HjUzzxAwaKixMcpX9j4nGfKZcPdhnOVLwA1pcfM2UwA=;
	t=1729928698; x=1731138298; b=nmLaGMY7ZCygYHldbMOgsjAmdUfVGRxHoV1Mmc9sh8J2UDy
	pzCSpc4vxfsnPRhyckVenCDnrAB5q1eJwcdz05VOZeCP+f3R04Td65CnINNeav5GHHJdqxjMjr7CK
	i8sRh3D9A1/Sv+kQvFH13AnnQ/dyeejcc/6hlnsUTl0bLhPOfNbeKUDRRmFHGfAg5FquD/ezqO9rL
	vMrp0PoHgArhCjOXu0FGs5rZxytjkDn5jQ0U1I89rcQ8qStQS30XIu8K/XLtefU6k8TuEhw50DPdC
	7EngPj+deXHXUG3e62RNqWEed5IE5iv9VBw+Qmm3PtR1VJFzNLF2wmMUnFISlzuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4bTi-00000005JDR-3443;
	Sat, 26 Oct 2024 09:44:54 +0200
Message-ID: <cd892fb5436f1de0fa2ffc9c9ec229873227210f.camel@sipsolutions.net>
Subject: Re: [PATCH][next] um: Malloc just enough space for fitting pid file
From: Johannes Berg <johannes@sipsolutions.net>
To: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>, 
	richard@nod.at, anton.ivanov@cambridgegreys.com, kees@kernel.org, 
	tiwei.btw@antgroup.com, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 26 Oct 2024 09:44:53 +0200
In-Reply-To: <ZxxmLngMg3iNjOfK@mail.google.com>
References: <ZxxmLngMg3iNjOfK@mail.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241026_004459_700042_1C09336B 
X-CRM114-Status: UNSURE (   6.42  )
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

On Sat, 2024-10-26 at 16:46 +1300, Paulo Miguel Almeida wrote:
> umid is already generated during make_umid_init __initcall so there is
> no need to allocate UMID_LEN bytes to accommodate the max possible name
> for the umid segment of the filepath
>=20
> This patch replaces UMID_LEN occurences in which it's redundant

OK, I guess that's maybe all true, but can you say _why_ in the commit
log?

johannes


