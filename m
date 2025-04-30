Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EFAC369D9
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 03:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9CEDC28qx7fQb4CxX63TTyagQppFHL9UMFvrjUs1JRk=; b=DL6v2qPN+ETAsYqQ4en+78RD16
	+X5CrGCn8VIWSqScUpHpt1C1IXl+3oyN1hugQA0dxzzRRuoQO5IchHnAGP+XnIgyG2EA1HLOfcduz
	9DkaV4s3ZS+z7dh/kFpaxuy4Z+sxcP0RNvVw1O+SXAKI7ngm30Psx1cECKCiYLyngz+5g5euSOqmi
	MtWPzodlfRyiPrgQJj9pN44g7WAcpl+AtuRCmqCQO2/1ECR/uHx6YFwI9kpCJo2syMDKOXs6MxDd0
	PNWQvyg5YDl+d0PnM53nZ8T1rnB4Pc32981NH6dXnhRMkqyoaiX+lROT1dGn7Fk6eig2C37AW8a5q
	O4dGU0Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9yII-0000000BbW9-2vxA;
	Wed, 30 Apr 2025 03:39:34 +0000
Received: from [23.94.54.125] (helo=airdropuniverse.estate)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9yIG-0000000BbUS-0ZfP
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 03:39:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=dkim; d=soorchico.com;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=acc@soorchico.com;
 bh=9CEDC28qx7fQb4CxX63TTyagQppFHL9UMFvrjUs1JRk=;
 b=v9hVDsYEC4CFQ/sbOF6Tz0RKlvSeA5bi5D2/1Ead6KGveokSmtIk4Ww+2CxertEKcm/CM5WhxIOo
   dXN+hsLrcJOz1PIJE5N5d4R8z59bxSXgIr4ciUVplhwAQQcdIDv292AsE5Ve/Yu8eIlKKYZ81SYV
   QlR7Igg+l7lVixISFWs=
From: =?UTF-8?B?THVrYXMgTcO8bGxlcg==?= <acc@soorchico.com>
To: linux-um@lists.infradead.org
Subject: =?UTF-8?B?Q29uZmlybSBDb3JyZWN0IEFjY291bnQgZm9yIFRvZGF54oCZcyBQYXltZW50?=
Date: 29 Apr 2025 20:23:35 -0700
Message-ID: <20250429202334.6993FAD8B8C462B5@soorchico.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_203932_225236_58A768BD 
X-CRM114-Status: UNSURE (   1.95  )
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

Dear linux-um,

I=E2=80=99m Lukas M=C3=BCller, Purchasing Manager at HorizonTech GmbH, a=20=

technology solutions provider based in Munich, Germany. We=E2=80=99re set=
=20
to send a payment to your company today per our customer=E2=80=99s=20
directive, Schneider Industries. The issue is, we=E2=80=99ve been=20
provided with two different account details, and our outreach to=20
Schneider Industries for clarification hasn=E2=80=99t been returned yet.

Attached are the two account documents we received. Could you=20
please review them and confirm the correct one so we can proceed=20
without delay? If it=E2=80=99s easier, I=E2=80=99m available at +49 89 1234=
 5678=20
to sort this out directly.
=20
Thank you in advance for your prompt assistance!

Best regards,
Lukas M=C3=BCller
Purchasing Manager
HorizonTech GmbH
Bayerstra=C3=9Fe 15
80335 Munich, Germany
lukas.mueller@horizontech.de=20
(mailto:lukas.mueller@horizontech.de) | +49 89 1234 5678
www.horizontech.de=20=20


