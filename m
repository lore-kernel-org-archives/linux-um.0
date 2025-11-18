Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6CDCEBF97
	for <linux-um@archiver.kernel.org>; Tue, 18 Nov 2025 02:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=w2IiBFkWS6DSe00zi09tdszzyacxXMfj/k28E+x2XXU=; b=ZY2fCJ2DlIsgnA
	MMpYKM7ZWA4seanaYSsKgopO+L/3SVUwGhAdQQPICaUId69iBwpZ7LtjA57fkveQJxk71H+jkQIuk
	sJy18JvzmvkMvgzb9H2CRyPx7COlfZ0HUewC8t71aHNpW/jIw3SXn13VmvxO+dFNOvdIf6n3Lkt4E
	fj6flh7XQI7rhPvP6RJlYbqhVprJTHwVwHMtRnhEQVX7+mFfLfsMAqU7+8IckSwjauf4sZ2h7/hS5
	GI0J5On5HAsRXz6YUFB3KLhXGEe/pOi2umdeSPQUOzIjtP9l4PDR+k43dVlOe/uxhnxE+F3I88GVw
	U6+AqeHa2IwLwX+gArXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLBVO-0000000HETK-1i7S;
	Tue, 18 Nov 2025 02:31:42 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLBVM-0000000HESc-0jid
	for linux-um@lists.infradead.org;
	Tue, 18 Nov 2025 02:31:41 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-882451b353fso34123726d6.1
        for <linux-um@lists.infradead.org>; Mon, 17 Nov 2025 18:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20230601.gappssmtp.com; s=20230601; t=1763433098; x=1764037898; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:subject
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w2IiBFkWS6DSe00zi09tdszzyacxXMfj/k28E+x2XXU=;
        b=G3YXwB/7lgNy1wMV94awiK18E3FDYyJY/P7b6VW0221c3Z9ds+nl4QjrsaROmv5Gnx
         cbPal2+wzq6YHrNL84xk0pDVMWxLHSR4+K2OCp4YIYTr34LDI+IDZHtRbjLTbzEcTfe6
         PuRUw+9mt6WHx4rPUspwHwwibGqTgOHE6aVjUzoMY/UcDIpAhdMhN+c9a51wgQmpfeX0
         wsvLZPOC33RDJj+YQGDhWd2e9M/TrmclCAm6Zmz2vc5fJb5RtDOvfXNm4+SG32qWBhro
         j5MG/IBd/bpmVEKc07HxaHjLKbgLmYao8dgvCB6uroH4DHxd1dcthIKLP6SYeniGynYe
         tp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763433098; x=1764037898;
        h=content-transfer-encoding:mime-version:reply-to:message-id:subject
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2IiBFkWS6DSe00zi09tdszzyacxXMfj/k28E+x2XXU=;
        b=LgAeV0EvIAIQGIK9DuPZbvscmg/ao+Iqw0Gs1ohik5/0ZzDkVXEUNgrOarGbCXG3WU
         rRB4eLjTnqSjMBfIVPothlET+wHDeoVoG+/kEg8loQEeLI+53f+nqTl3kyEBUj2Zthua
         TRFcrNEQpyYUEu3ZSiLLqBi35OEdoSFzL6mtx5vXBl0YXreCerTBOWPPubUCbquQniOA
         PBhZ7KWbWrGiO23YfvuERk1yQlHykr/+QicqzXjHcN5wLwNV+p6+t6CdDCBD3TdWaXs8
         pLfwTL0kdog3xXnVB1F62U98k7ajwQR+8WlLs6Ksn8/yb5GClQG5U1ABB9/yAoh0+Ivy
         guBQ==
X-Gm-Message-State: AOJu0Yxymhd1iWwTqMzxKeXJYPpVgsSuyVsm/sya2ZFuHlfijfp8Qzsi
	phNcK2BBeZ6y8Wxxin+AoiggEpoUFL6kxEMbllHYYStQm278uuhgct8EtmrrTCp4PLwfo8pJSVD
	jio4=
X-Gm-Gg: ASbGncvzxQ6IXmXZdirLmh1OnsZKLTnZ+oyG2/DUYTxF1z4i1NZQX8K45IyLPpVQwmv
	4ySRERR3qvItylw2/a3dJi1J+D49ZEf6hsTalBXzeza1L3+V6e7fjSy8yd4gehpZX/j0stux6c4
	2psvw4ABIEVrh+rd19PISnFpTlcWg7kpTrGB3UJhO5HwLP/cue2mnDYYTX13dDap+qe4a9gYQOV
	hMI6HSdN0z/G/gu022O/sZyibgqOJk24w0JIDnsMrMPJejOqhAbF7xJ0at0l6qBSCbaIQtsC1lA
	3b/l4lQfidpfdihbsCt5oLVsVAympi4tmg4pFP5/1GjYZCKa8WBYURUaGfGefWv8gSr8TYJ0k6i
	7gVsY3IvwJqCRxb4w1X6Z9EDc2V1TMkeoBrnvBok9/89qfAio1ga7fBMrdCsU6LVfSYFox5Y/pD
	/R+HPSpTzgXljJxIafsnybr5bHdC951ZfHHlKsKxUg
X-Google-Smtp-Source: AGHT+IHUdKcsP1uLEfvkoeilVKI2pf5MCSqv24jXqmkwRs0dsE4a/bw2PQvwWhFV5Nif+44JxLmd6g==
X-Received: by 2002:ad4:594e:0:b0:87c:2900:1fa8 with SMTP id 6a1803df08f44-882926b1878mr244905666d6.46.1763433098238;
        Mon, 17 Nov 2025 18:31:38 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([199.58.83.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882865cf848sm104511636d6.56.2025.11.17.18.31.36
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:31:38 -0800 (PST)
Date: Mon, 17 Nov 2025 20:31:31 -0600
From: Glenn Washburn <development@efficientek.com>
To: linux-um <linux-um@lists.infradead.org>
Subject: No more non-root networking modes?
Message-ID: <20251117203131.479a1cfd@crass-HP-ZBook-15-G2>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_183140_302356_26984003 
X-CRM114-Status: UNSURE (   5.96  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi all,

I'm just now noticing that earlier this year obsolete networking
transports were removed (commit 65eaac591b75). This included SLiRP,
which was to my knowledge the only transport that supported network
access as an unprivileged user (no privileged access needed to setup
the transport either). Am I wrong about that? If not, I'm curious as to
why functionality that could not be achieved by other means was
dropped? And if there are any work arounds? I can understand why other
transports that need privileged access to setup, but were inferior to
other existing transports would be removed. I write this as someone who
is currently using the SLiRP transport.

Glenn

