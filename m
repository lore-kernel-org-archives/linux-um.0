Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB63E9536D
	for <linux-um@archiver.kernel.org>; Wed,  4 Feb 2026 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MYBuTu5OB75A6/GrlgsR5Q1v5/fZBHf5I/RU1z8ZZiE=; b=tk3ZLPtNvcImFj
	PR4XhNcpz8kyoOUShDmT/4QkLqCs9R56vU4cbJLtiX5DOCQPUwJjdZ3ZpJPNN4kI/bZZO0jpB/BHm
	fX6gXkjFv41MHTevokbxPYf8trBqmuR+53FhhGLWiZBF7lYBx8q/rIl23DBlUnrE94HqYBjC3kSDC
	jZlQ+4hkIuI+UmPk34jkia1FVJzbXpHxFZDDVJDQg5S/lnAyrHVS2YDkWlmnDRi14s57eZf3d4bV+
	MeGFr/9Z52ivv7Kze7jZCBFzpkzOk+tSJ3WjoDo6xdEARl13Y2Jgxp3la5NDWx9hG8F7a+YsSPk5p
	IO/0i2rZvTzSCPwn0JbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vna3c-00000008Hfp-2tVH;
	Wed, 04 Feb 2026 10:24:24 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vna3b-00000008HfZ-1Kn2
	for linux-um@bombadil.infradead.org;
	Wed, 04 Feb 2026 10:24:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=MYBuTu5OB75A6/GrlgsR5Q1v5/fZBHf5I/RU1z8ZZiE=; b=PMBPvYmrS/PnuTYBJUHp4kP7R1
	SiCFlm+vJeIa1pjYmGLGsfsU5zy4m3e/ch1mYokATJ3WHB8gIB6wQQfpnsbh40/7qKHGvWUB1duSh
	9VTHbkPqKg/S5YVGrl34gy7+cChnRTBbeFzSGWzWs46bOmh5YYoU/2UXmmQ5d1cmKHiF7/OQVwgSe
	a/f1Mwm15bNNuVuXRIOMWkqMRKWlvLaECvn6+6Lrm4rqMR8MF+e1SRPrUKcxSjhYeKa2bcrbKTOWm
	VPdeC51k/ZUBZiMO5UzZ7uf9eehxtgMEX+QJx+S/4wdhWnynmaruSzJDn0Wf1BLd5EOMlGEnNT6WL
	J17vgh0Q==;
Received: from mail.central-kino-rottweil.de ([85.214.227.4])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vna3Y-00000000IsG-3Btd
	for linux-um@lists.infradead.org;
	Wed, 04 Feb 2026 10:24:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=central-kino-rottweil.de;
	s=2020; t=1770198433; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=MYBuTu5OB75A6/GrlgsR5Q1v5/fZBHf5I/RU1z8ZZiE=;
	b=Bdjv2WDRqdy8jnJxZNEKZvVdHxz4MmQk6KKZTaSAJTFnW97hUS0CHL83haWeqIx+rHUtDb
	v5TetEvFKl41AvZCARGPPlknzJLczOdIG4fyccL6E1AvXKjVMf4BwkknzXJw9iyK6QG3gk
	ZLw533KrqKi5Ibv+vpye9jvGLLJLjEzT4JTJ0ILWye0rVkd7hszEJ9wZRSYx60HF7yV/fj
	YrXwGLf4jHLZFyyXENvRbP7FFbG5uD9O0XuwFcBK5p7dpcIglYvxpzzUTPk1Zbuxwwe1uq
	USOLfqkkzWK7pNM6MzggUkxANrucpj6ENzNUKPn3DXHdMoCEcpcsfBljS/a7Ng==
From: fsj@central-kino-rottweil.de
To: linux-um@lists.infradead.org
Subject: /KXM/
Date: 4 Feb 2026 01:47:12 -0800
Message-ID: <20260204014711.5A3928BDC262ADE5@central-kino-rottweil.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=fsj@central-kino-rottweil.de smtp.mailfrom=fsj@central-kino-rottweil.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_102420_861222_DDAAB1D0 
X-CRM114-Status: UNSURE (  -0.98  )
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
Gewinnern der letzten SuperEnalotto-Ziehung in Zusammenarbeit mit=20
Lotto24 geh=C3=B6ren. EuroMillions und Powerball sind ebenfalls=20
enthalten. Sie haben einen einmaligen Gewinn von =E2=82=AC3.850.000  in=20
der zweiten Gewinnklasse erzielt. Um Ihren Gewinn zu bearbeiten,=20
senden Sie uns bitte die folgenden Informationen per E-Mail:

Vollst=C3=A4ndiger Name: Land: Adresse: Alter: Geschlecht: Beruf:=20
Mobilnummer: WhatsApp- und Telegram-Nummer.

Im Namen der Online-Lotterie-Abteilung SuperEnalotto gratulieren=20
wir Ihnen herzlich zu Ihrem wohlverdienten EuroMillions- und=20
Powerball-Gewinn!

