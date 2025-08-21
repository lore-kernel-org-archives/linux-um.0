Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95EBCA0EEB
	for <linux-um@archiver.kernel.org>; Thu, 21 Aug 2025 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=E2sh7PkU99v95gXhyMFBk9zs8wQA9SBmo0ZEWgF1/ao=; b=aLUpL5/qXDBa0V
	wr/hV3kax2e0PFGSaqb9wppgu05ZZz/hPVUJX7W2iS+tk58Q53ybYC6+xi3l4syfkmSdM2AXYmvgX
	tC4HgynN1DDNwm0mj6u4nAqBQjUdFZRL/eF3fZbbEdVU41wOWxv67XAUwuEX2VxpPp7bJm94mPK+u
	4fS1ipWZCYd9ahxv1EjSZZSwQIVFEr71kBT4sze9hFe+0AKqZ7Gkwy2uk3wvGDWedp9Qz6NCps4tl
	jmpz/eR1xHI3dMVHrhR2vCxX+xMYhFWq5GiuiQgGyqQ4ehjd+5SgwEk4eGW0IiwQ3GrDKhCNLGp/F
	KzfeXOZmRoN4cckndBdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up4XX-0000000GvHM-0gEf;
	Thu, 21 Aug 2025 12:37:11 +0000
Received: from securitygw1.exwire.com ([216.171.192.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up2P6-0000000GZLL-1y3T
	for linux-um@lists.infradead.org;
	Thu, 21 Aug 2025 10:20:21 +0000
X-exwire-MailScanner-EFA-Watermark: 1756375894.7111@NKFSP0puqCEtFyZhdLNzKA
X-exwire-MailScanner-EFA-To: linux-um@lists.infradead.org
X-exwire-MailScanner-EFA-From: nancymc@exwire.com
X-exwire-MailScanner-EFA-SpamScore: sssssss
X-exwire-MailScanner-EFA: Found to be clean
X-exwire-MailScanner-EFA-ID: 914F31CDD7B.A5438
X-exwire-MailScanner-EFA-Information: Please contact jdeverse@exwire.com for more information
Received: from smtp01.exwire.com (smtp01.exwire.com [216.171.192.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securitygw1.exwire.com (Postfix) with ESMTPS id 914F31CDD7B
	for <linux-um@lists.infradead.org>; Thu, 21 Aug 2025 03:11:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 securitygw1.exwire.com 914F31CDD7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=exwire.com;
	s=default; t=1755771094;
	bh=HV6ngFc0kAPeZqm3RhmqrUX5EZoxx49VvdfM3cgWoeI=;
	h=Reply-To:From:To:Subject:Date:From;
	b=jkyzytT8nmB6SYnnLgzRb1sYOjOBvP76r44Keun+ik9xyV4+x3M5nnjnF/FZI0btc
	 bmBDUAHZ3prZPj0PDCy6EPtNEevwmUa8FKwOgrnWSLO850SRywqLASZ/n7xqW74X1M
	 F/ovvG91GUyQN2uuof5LI/4SlOz1CSvl2iWFgxAk=
Received: from localhost (localhost [127.0.0.1])
	by smtp01.exwire.com (Postfix) with ESMTP id 9E40459E103
	for <linux-um@lists.infradead.org>; Thu, 21 Aug 2025 01:28:13 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.exwire.com
Received: from smtp01.exwire.com ([127.0.0.1])
	by localhost (smtp01.exwire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T1HbM03w9hak for <linux-um@lists.infradead.org>;
	Thu, 21 Aug 2025 01:28:13 -0700 (PDT)
Received: from [45.138.16.152] (unknown [45.138.16.152])
	by smtp01.exwire.com (Postfix) with ESMTPSA id 5DF4F5825C5
	for <linux-um@lists.infradead.org>; Wed, 20 Aug 2025 23:25:31 -0700 (PDT)
From: nancymc@exwire.com
To: linux-um@lists.infradead.org
Subject: xl
Date: 20 Aug 2025 23:25:30 -0700
Message-ID: <20250820232530.8B7E1ECBCA514EFB@exwire.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_032020_510042_0FCE56DD 
X-CRM114-Status: UNSURE (   2.13  )
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
Reply-To: info.superenalotto@gmail.com
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Wir freuen uns, Ihnen mitteilen zu k=C3=B6nnen, dass Sie zu den=20
Gewinnern der j=C3=BCngsten SuperEnalotto-Ziehung in Zusammenarbeit=20
mit Lotto24, EuroMillions und Powerball geh=C3=B6ren. Sie haben einen=20
einmaligen Gewinn von =E2=82=AC3.850.000  in der zweiten Gewinnklasse=20
gewonnen. Um Ihren Gewinn abzuwickeln, senden Sie uns bitte=20
folgende Informationen per E-Mail:

Vollst=C3=A4ndiger Name: Land: Wohnadresse: Alter: Geschlecht: Beruf:=20
Handynummer: WhatsApp-Nummer.

Im Namen der Online-Lotterieabteilungen SuperEnalotto,=20
EuroMillions und Powerball gratulieren wir Ihnen herzlich zu=20
Ihrem Gewinn.

Mit freundlichen Gr=C3=BC=C3=9Fen

Frau Katherine Federico
Leiterin Online-Zahlungen / Validierungsmanagerin
Code-Nachricht: 737GHS98

