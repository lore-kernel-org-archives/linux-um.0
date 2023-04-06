Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B62C7618D
	for <linux-um@archiver.kernel.org>; Thu,  6 Apr 2023 21:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=65YsBJn74l8Gg6UPiLFy+YHtc6R7bQHv4pV2BJfrL4Y=; b=sBRpYxBZmxMw67
	OUi0tEA67EI7R9219MJ481ff0rMsMTxHVMfjlhYWUIBwDB8AHSgi8jV0wNIPlNOEhiiRgJTX1jG4v
	aQXbm9yUq3wXKkTYLJd99cBI5B2vEsu9G2C2tpAtnlq3Ue4aI0WDx87/BeNdU0dUyp+kvl17fAO/c
	fBsw5LV2RQVYc2qNkTTC4zPonAUgE12quejjmLlsdinKaUz0K9e2OaL6kjDuIOrMx4pZYUGA56M9m
	r3kwCSb5/M9DCHPStuyVym7oinbFIASu96/gb123zeDj1QDU3clwpO1ut8/8rJt6IcYaissIVZLBU
	ixXXfqNwiU/VGXUZux+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkWta-008c2z-2o;
	Thu, 06 Apr 2023 21:11:50 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkWtY-008c2f-31
	for linux-um@lists.infradead.org;
	Thu, 06 Apr 2023 21:11:50 +0000
Received: by mail-yb1-xb29.google.com with SMTP id m16so27194411ybk.0
        for <linux-um@lists.infradead.org>; Thu, 06 Apr 2023 14:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815507; x=1683407507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRvtPQUV2zYorRzvvyk9uhdC19h2Vjgt+Tm3ZsdCYjA=;
        b=W0YIzTEoqAZ/3bYc0tW4jgPYd08YdI8gWg646NbnKp79ZBH/XY/oErXm9jgBxdiC8d
         U0fvEK8Nxi3Ez21mvI9AqDCPG5ToqbUQS2KdIfT46HbUknX6110tZKoVmSPuBLA0hfDS
         wtkDbSByssLdIt4FDnjPmrXxBMiDKr15HZ/y/VnAOm6n0kWroyZaViJlMgGkYOLxQtrZ
         Mg6pdmBAECBda1ytwim3y/3MIDlkuR/mABdUmpyxr6g50ZrWgKBsY7AWYy03oM/82W8e
         h2bSMjeuOaOT7E90bghq/X4fhKsr8TS+DCbzFbCyozdjEnhgIpsUP/3u4Se4mmqLCQPr
         0lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815507; x=1683407507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRvtPQUV2zYorRzvvyk9uhdC19h2Vjgt+Tm3ZsdCYjA=;
        b=217s8IeKMF66Jli28KTqumlI8KMiL+wPj9jd7O3Jm9FgU+S1yipBUF0Olr89tvZnFp
         lvjdWQVoJiZ00BaIvSTKabozmvdE4sColJ0N1xDDHS4sxR6/ibpN4bASbxxnEeZsMVoz
         bGuU9o1JjY1cXSA6g/PhAzl+t4bU6Z1BCiNB9tKZBzIwAALLo98Wd+wQdl8Hm6F6r+uz
         VGeQMNPNKFOe9vQyHi+aMP4KNwq6mOWnSn0rS9ty6KYdzTJ2pXeMovjdhs3gVreja2MD
         Wwyc3x1pkNnFZ78DTKlGkMv4x/pQaXm0YsR7ZFy5ecnNBsQ8j1Su0EDoCddQTregZ1eX
         kW/A==
X-Gm-Message-State: AAQBX9eNNyKxDzl6+yo3tZhAypzcd0n64ZKVrOZn+TPP9crGaXY3P/1U
	M3KoWeqpN/DPZC2FK72CAuYP7jDopaxKPl0Lhjs=
X-Google-Smtp-Source: AKy350YcXkPavjki9HRL+Z7tnU6nNO980ygqTGu4VbAMv+ZGBQchCmuLXurHaivbIhYFis9JDm090cwV2HdrkH3H7RE=
X-Received: by 2002:a25:c845:0:b0:b21:5fb4:c6e6 with SMTP id
 y66-20020a25c845000000b00b215fb4c6e6mr310684ybf.11.1680815507518; Thu, 06 Apr
 2023 14:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <I0YeaNjTtc4Nh47ZLJfAs6rgfAc_QZxhynNfz-GQKssVZ1S2UI_cTScCkp9-oX-hPYVcP3EfF7N0HMB9iAlm1FcvOJagnQoLeHtiW3bGCgM=@bamelis.dev>
In-Reply-To: <I0YeaNjTtc4Nh47ZLJfAs6rgfAc_QZxhynNfz-GQKssVZ1S2UI_cTScCkp9-oX-hPYVcP3EfF7N0HMB9iAlm1FcvOJagnQoLeHtiW3bGCgM=@bamelis.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Apr 2023 23:11:36 +0200
Message-ID: <CANiq72kO=ocCwcj30RYeRvc+np5ec21p4hQneOvZDZ28wKsJkw@mail.gmail.com>
Subject: Re: [PATCH] rust: sort uml documentation arch support table
To: dev <thomas@bamelis.dev>
Cc: "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_141148_988390_AEEB0BDE 
X-CRM114-Status: UNSURE (   5.75  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gU3VuLCBGZWIgMjYsIDIwMjMgYXQgNToyOOKAr1BNIGRldiA8dGhvbWFzQGJhbWVsaXMuZGV2
PiB3cm90ZToKPgo+IFRoZSBhcmNoX3N1cHBvcnQgdGFibGUgd2FzIG5vdCBzb3J0ZWQgYWxwaGFi
ZXRpY2FsbHkuCj4gU29ydHMgdGhlIHRhYmxlIHByb3Blcmx5LgoKQXBwbGllZCB0byBgcnVzdC1m
aXhlc2AsIHRoYW5rcyEKCkNoZWVycywKTWlndWVsCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXVtCg==
