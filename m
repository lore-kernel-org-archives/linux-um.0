Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69431CA0FFF
	for <linux-um@archiver.kernel.org>; Sat, 30 Aug 2025 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=E2sh7PkU99v95gXhyMFBk9zs8wQA9SBmo0ZEWgF1/ao=; b=OizabC53Kvo6h0
	J9ffKUxxmi+sJMS9AerPOTGFLa3B7VS6vl8N+hfW0ldObOlWx1q2gVaFLnG3ntD1WD2Ud6nxqg88J
	OVUiVmz30GSAmQGBKfRInke3GRXvXi8g5oizbw3JxyupSPjz5NYLgKGO0fs7odqQl5hC+DLb8pHF0
	e1LWiSG1W+WDCm2cC6oGSXYYzQHiXzh+oV71kZpnlCGMkBRigri2kW1sBdJNAWMvj3oQHlXYTSj31
	zWnLIgP5jSpuGytFsSSZ7yXxS6cQjiO++7+9GMbuFUoP6jXVxCbhNrD5MkBZbL7Bqq1BGs5uL5Mu3
	Ds3Wa639JLoHAr01X6Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usQX6-00000008JLJ-3ICL;
	Sat, 30 Aug 2025 18:42:36 +0000
Received: from mail.saluslaboris.com ([170.231.171.166])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usQX4-00000008JK7-2vyq
	for linux-um@lists.infradead.org;
	Sat, 30 Aug 2025 18:42:35 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.saluslaboris.com (Postfix) with ESMTP id DF45CDD143C6
	for <linux-um@lists.infradead.org>; Sat, 30 Aug 2025 13:33:19 -0500 (-05)
Received: from mail.saluslaboris.com ([127.0.0.1])
 by localhost (mail.saluslaboris.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id tr7RM30zucwa for <linux-um@lists.infradead.org>;
 Sat, 30 Aug 2025 13:33:19 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
	by mail.saluslaboris.com (Postfix) with ESMTP id 8F84ADD15F73
	for <linux-um@lists.infradead.org>; Sat, 30 Aug 2025 13:29:09 -0500 (-05)
X-Virus-Scanned: amavis at saluslaboris.com
Received: from mail.saluslaboris.com ([127.0.0.1])
 by localhost (mail.saluslaboris.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id h7EO6lgckP4k for <linux-um@lists.infradead.org>;
 Sat, 30 Aug 2025 13:29:09 -0500 (-05)
Received: from [45.138.16.152] (unknown [45.138.16.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.saluslaboris.com (Postfix) with ESMTPSA id 82747DD144E7
	for <linux-um@lists.infradead.org>; Sat, 30 Aug 2025 13:21:17 -0500 (-05)
From: edwin.herrera@saluslaboris.com
To: linux-um@lists.infradead.org
Subject: xls
Date: 30 Aug 2025 11:21:16 -0700
Message-ID: <20250830112116.76F131FA8BF53795@saluslaboris.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250830_114234_870030_CEBD499F 
X-CRM114-Status: UNSURE (  -0.49  )
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

