Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2497C4828D
	for <linux-um@archiver.kernel.org>; Wed, 31 Jan 2024 11:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ONLOpdhFVTK1PKOUo0h7113+HYlDSSoXMBK7/7cDZ1Q=; b=Comd4uwKw8onycZcXZOuNdQbOF
	6k+zQIS3EWouTgRk6mi2VPk9T3L0HuNcRAoYOKEzrgyBUHSBIks5SSycz+Z/K0UtBC9+3EXoH0Rd8
	WoGG6+Z3gn0tIEOxVltP61aOARnd1sMySb4JBLCn7ppKM43k+VHU8SwF0tTqOK5piSY2kNXrI/GAK
	xMoy7KvRMeZTIo90LA8i5/u6wIPx2CBcbo0Ofw/2TPoY/HlmW5RWdHhdOXMk7mk9L5VLZQQA/bP2+
	JKXJhgk8EwiI8fXU95/GSiRhSARg8sBEesu1hoOXqyaE7qOcC0JDdmAMu9/UVeE3o1smvufr04lhH
	raqRo80w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV8oh-000000036tM-1VKA;
	Wed, 31 Jan 2024 11:31:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6ey-00000002NBa-2I9Y
	for linux-um@bombadil.infradead.org;
	Wed, 31 Jan 2024 09:13:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ONLOpdhFVTK1PKOUo0h7113+HYlDSSoXMBK7/7cDZ1Q=; b=oxV+hVVaAsFRP+jEQ3xByjTAdr
	fxdCnc2DDIPmTSUhXyKdblIpIONo5FH5N9r5UtZbEtdMdzrfkJYu9C8I5XOT05H1/E/7+PDoBch6S
	OmLkqi1TfPr5t+vp6ylMIhFayYyptXGuaAhavFl8Qj1Im9nXZzAhkkIGNKGIVJfYIXm0tOQkT+E2v
	Z3x3Ys7rSVJrk3HuGlG4Ajby/7PVDkvrU5IrL0hauBJQW8Pi021NNkSGYuW43seDcqJwgcJ01Zh4e
	aN1B//INJ7MUzxLwGzONig/DxaJCNFS0/lK82Bwy4lcCOaphDXrgnxZqWIvIyJfMWrNevrBbBuLpy
	PhFtkGmQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6es-00000008tcp-1H3P
	for linux-um@lists.infradead.org;
	Wed, 31 Jan 2024 09:13:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONLOpdhFVTK1PKOUo0h7113+HYlDSSoXMBK7/7cDZ1Q=;
	b=MhGM0+RfbT5EBrWmE0hy7AOz2cCFwSsUhrkUAOe3NNRHRFUjeiBm9RbUQLDaWqxaFnbSTW
	g++aA3Y65jgz/cYW+IhN0gBJyYROG4Qj4o5trDyBGdNXrGN2R6Cxh95Y3CnQ/++g6HW7Ek
	Cx7HkqNxTA/+lqOoIFdJPFttTyQzJ1k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONLOpdhFVTK1PKOUo0h7113+HYlDSSoXMBK7/7cDZ1Q=;
	b=dNhod43Ejz9Mb8oXENtKKNS0jt7CSQqdFDFasc0HOjXWZOV9KgUnEFoV9f4iTdAoQrRl85
	k1rlszfDhi/oHPry2wTGI0W24A3mEZlwTXXAOtzOZ+Bklfsq7sSXb9OWSvRsFihiwsSqt3
	upwQgaofncC5BMMuKJu91OwoDoMHQIA=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-4kis69h2OH2i8wH0PN-u2A-1; Wed, 31 Jan 2024 04:13:16 -0500
X-MC-Unique: 4kis69h2OH2i8wH0PN-u2A-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-46b51ba4f38so1056308137.0
        for <linux-um@lists.infradead.org>; Wed, 31 Jan 2024 01:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692396; x=1707297196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONLOpdhFVTK1PKOUo0h7113+HYlDSSoXMBK7/7cDZ1Q=;
        b=Th/BckTN4uCO11zNQSCYmj31JahLi12H4rwdlvJgvvjkprPosWn4V55nmt3e8ZScCg
         URVYhKFtXn0oI1h7GyjTLCr67o/EYBx9bmnLuOJh5A9XZ+lQ4jDNeRqpEXrcsD0+SOIh
         +KZt3gGAGAluvkN3CnF+++JMPB1G3pGa7ih8H5BoEETBOOypTqfft9LzsoajuYx/MRfA
         9BJFWmmE9H4yIfe2djlWvCOR94n282D14Lcu8UKqN5GjiD5rWz3yYfQPqkfM+E7If+C1
         y+jU/md5a0BrVbTRRdOhY2BA+WtJmCAqoau/bIzKtJg57I2jUZ+bFHB9S+hpC61wKSnl
         vluA==
X-Gm-Message-State: AOJu0YzCLUnNPzSWV7zNlvoVttE4JSn6lueTquT3Zch1C47XDIdFL1Kl
	eR71wk9O1BJ+4tbuUd4D+/5UUH7UjoNpGtT2pycCNm/7uUDtvCjS/NAKJH5D6K3Xzz1QZiF8H1x
	Kh7Tk4LfJ9CSbu4pmN6LAbwEkpZK18MIK2iOsxksMbwJyoKmD3j2T1J0urzoQ//j9eVq9B4mGyl
	I8SDboyzNkQesHi9HKu2YqbnLdNbW9YLPHG56b
X-Received: by 2002:a05:6102:2753:b0:468:90e:2c88 with SMTP id p19-20020a056102275300b00468090e2c88mr691973vsu.35.1706692395774;
        Wed, 31 Jan 2024 01:13:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlqIGzGC6WJa2cNQxkOvPsG3lWuLc6yY/NsL+Ul0eahHSt+TTWHH5K0CdWrrzXTYNRodEQ2LjsVmuQ6Q+WlRc=
X-Received: by 2002:a05:6102:2753:b0:468:90e:2c88 with SMTP id
 p19-20020a056102275300b00468090e2c88mr691962vsu.35.1706692395533; Wed, 31 Jan
 2024 01:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-12-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:43 +0800
Message-ID: <CACGkMEtWt1ROwJCeEa5FbQfxV2eqo0xRqHQZMsq-Q2TcQBur9g@mail.gmail.com>
Subject: Re: [PATCH vhost 11/17] virtio_ring: export premapped to driver by
 struct virtqueue
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_091327_190648_24E78E25 
X-CRM114-Status: UNSURE (   7.69  )
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

On Tue, Jan 30, 2024 at 7:43=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Export the premapped to drivers, then drivers can check
> the vq premapped mode after the find_vqs().

This looks odd, it's the charge of the driver to set premapped, so it
should know it?

Thanks


