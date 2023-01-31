Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA1DC38142
	for <linux-um@archiver.kernel.org>; Tue, 31 Jan 2023 04:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=5uGnj4tOvsyL6RU4+1XBpMbD8eHIp6I7VrBQ+Lc0wEk=; b=jg/
	io6vBoyv2GoZjsmVIwjFmKvestpEMS1XcAKBpf/yFfIaxImGUYGGrRfNbaJ0rm7c3Zkdn0FKYd+Gs
	7D9JtqKEz5pYBffSN4m6EGKNm0Nj8fHfBDsj+n8EDrcRuLi/tTlsGN6vx8ZHI0h006XsspOQWk17R
	sqn0sSJwI2ojSsKuAEQLLGrdHm+puF8+/VGd8nlEuDoZx1KCOUctIvqAorS+POsfqocjlJe821kWD
	ZT/GQR1RHZG2FXrbYniAxz+oB2p4eaZdFQdDd3wNHAYFeBjtpNJDqyM1CBgU8Zze/AEzB1EvQuLpE
	r2K8jurt1EgzP+PgAQ3xTK7D5MVJYOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMi5y-006F5i-5b; Tue, 31 Jan 2023 04:18:10 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMi5v-006F5D-IB
	for linux-um@lists.infradead.org; Tue, 31 Jan 2023 04:18:09 +0000
Received: by mail-qt1-x831.google.com with SMTP id m26so12314104qtp.9
        for <linux-um@lists.infradead.org>; Mon, 30 Jan 2023 20:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LBIQUzC7/5QMM7LYpQr4X/+HmNwW1KBNqBv72Lc3P+A=;
        b=JjNp2g3oeR7aG3TFpYV6ufC8YxDH88f+UqmqZAJrCYCwOseNCZnKzqDbWzwd7Zom7J
         mwZRY6GcIdQpI9j+qp6+mqIrjZHDFZThaJCaCVR1hfSIiRrQTJqAOlIV+nd0Z9HcO6fK
         49P/mDwpdaWWm74SpC+6PDGawvAPRM6Y/7jTFG7C2Rb9nYFwnbMB7/OnHLpNHo+tnsIC
         nwCxDnW0LUiUY7UROeFfGRSM2JbE8AYFsMb2DTWAfryZTdv4E/ZIy2zloGV+l2SOtyNd
         vkYKP0iJcO1GBwXi5gDjQLIY8hQdFH/4CkoRWPTd9OV+Y+deX0pCXZDqchwjPLFr4tI7
         a6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBIQUzC7/5QMM7LYpQr4X/+HmNwW1KBNqBv72Lc3P+A=;
        b=wxBdtsnpZ+2srBETt/Fc/PZSw4v1XWSOBLKvYea0P/vQpH7diCFvmLCXZ/VvbbY+aI
         ugJ6pVYGfd9jh2j54jwdegu7yN6MPguALf6uWJ0Xap/hCiyvhatXI9BLWj5ehzt1gGUE
         Sc/H/zm5UgkRWQGHgPVbGH0gqqYmvewplEZmP0WewtmTOozYrf/uhpNm1Z74N57JOQ+V
         /lvcVaklWS+5rIMxyrHbMdELkpOudrA4fKfDVYJvPEqXUdiq2o6NmD2rSWt5RmIMorBW
         EUZ73Hkk05Fsm4mssisfZJhqpJwaZFT0SYEO6jrFdh7EzNqFlT0M2Wz/EVG/miTBIq1X
         CB3A==
X-Gm-Message-State: AO0yUKX2+yfvQ4YeSAZFbj3JjxscP8Ys+dRph1Rmnl1nksC7pAdolL+O
	kr19YUtnKcSDAwdkqspPyIgZH6ipEDcgrEzT
X-Google-Smtp-Source: AK7set/PEdxjr+rDF9Y00GB7CaSSRiOy5Ksuzp+bpQJMctwBXKaxG7l0fi9bXmRVvwpAyGp9Mc+5vg==
X-Received: by 2002:a05:622a:4cf:b0:3b8:385f:d72e with SMTP id q15-20020a05622a04cf00b003b8385fd72emr19755060qtx.48.1675138679419;
        Mon, 30 Jan 2023 20:17:59 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id pi48-20020a05620a37b000b006e16dcf99c8sm9371165qkn.71.2023.01.30.20.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 20:17:58 -0800 (PST)
Date: Mon, 30 Jan 2023 22:17:48 -0600
From: Glenn Washburn <development@efficientek.com>
To: linux-um <linux-um@lists.infradead.org>
Cc: Richard Weinberger <richard@nod.at>, Johannes Berg
 <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
 Glenn Washburn <development@efficientek.com>
Subject: Using ftrace
Message-ID: <20230130221748.5c472da5@crass-HP-ZBook-15-G2>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_201807_871099_C511B9BA 
X-CRM114-Status: UNSURE (   7.58  )
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
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

I'm trying to use the ftrace facility within UML. It appears as though
it exists in the menuconfig, but I can't seem to get the kernel to
recognize the tracefs filesystem. I'm wondering if someone can confirm
that either ftrace does or does not work in UML.

Thanks,
Glenn

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
