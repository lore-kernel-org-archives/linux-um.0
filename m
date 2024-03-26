Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B643CD1283
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 20:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pnO3hfDzNJhG1W8n4621OnBzOy9cpmEtEz5rXGN5tRg=; b=HfgXILnLlqaD6NuC0V53BQ62Hd
	ozSHYtodFIg3rXEQ1bo4RRLu/Y3ABL6yMhMUyZ22YaAXXvyUGnS+yiPQleASVtHnDpROr9tsIdWRz
	SGrzaMn9g5PYWGkwWrVForAn89OCfhDvOs/Z/PmbqEddc4tjNhtFMWsCbLMDR33a3aQgNCk2PNWs/
	XzcGqmMpvuwpYsp2MWO8gRNN9cbSs09hMVjf3QUK6sUKqHhX5VRG4S3cLbKkT6xuqI+gxPbZGm7nW
	UJHL1posCIjy8UIqiRJe01Rqx+bBC4+MJ5+jKvJcLo+ZRrKNxpSgMbH7/AdY1xoIcI18XgnMZ8Gwk
	GqdpAGVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpDMT-00000006KbD-46ib;
	Tue, 26 Mar 2024 20:25:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpDLR-00000006JxT-31ii
	for linux-um@bombadil.infradead.org;
	Tue, 26 Mar 2024 20:24:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=pnO3hfDzNJhG1W8n4621OnBzOy9cpmEtEz5rXGN5tRg=; b=IzWLF0pvI1yheL83y6L26r04yu
	UIB9Z9Yn8WN1XhIaURBSaRhFtF9GEezH04qDtyTFbcC28m2SWogz+fAZF6sXWT9rGwjAiqVaE8D6V
	XIGKE4lD6EUDwEDA/WLVDAiAtEFacFu0V1cQj3oFH924RPw0EeepS54QoziA5D19quBXj3vZOszrI
	gwwAMe3z48ZslDTTsn3ElfcPBdtXI0+ufHhCqZrfGzx1zJA99tGF1rtFWgI3MaCX7LMXuZFOEe5CD
	/BjtbIfLh9Q/ZaCq+gMzGWYN92vJbSIJnkj89zUEyA2GvPHUPo7jfyGCZatx4LBbBAQ5G4BoDHYOz
	1lLW2Dww==;
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpDLO-0000000HPjN-1nzJ
	for linux-um@lists.infradead.org;
	Tue, 26 Mar 2024 20:24:28 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a4dfe6564b6so39985266b.3
        for <linux-um@lists.infradead.org>; Tue, 26 Mar 2024 13:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711484664; x=1712089464; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnO3hfDzNJhG1W8n4621OnBzOy9cpmEtEz5rXGN5tRg=;
        b=aZmW6eJl0Fo7EFC33bqgfIyP66/BZsTfnU1GT173bx2x3oW71tw5GUU+edxXZxSbro
         z+5hg9xq4aCn7l/HoKQWfrZk21p6k/ZrZdKygAE7//N2XOlkb0OOm/4KAdBnXRyLVhet
         Ei+VWRa6jZgm7vArBFogAj58SByhzh+JKjQWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484664; x=1712089464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnO3hfDzNJhG1W8n4621OnBzOy9cpmEtEz5rXGN5tRg=;
        b=oIJ0nJG/BTdGSZ64dgh2GrJJqwmKyyvLidIEso9J2+OyjgrDdp2ypGAIsl6etBCN/J
         NKpN5p4FhgL3KOdWSJ0jltqXeDcRnXtdpExHVb92nlcUiHR9ljWJTm8kru7xb304f0DM
         ZyrsVXADlJqdRyoZvnStrhB7sVR+9bwzMSY92AWaLul+LbsHaJm7z2up9CLPnds31Soh
         cuc6e4/FFziXZ3WSOE8/ADXKKmiSw97SGUnpVEaB9r7t29MSY4df6lS+0CKSmhb7p7eW
         A8SLxfnH+aMGRp+7xuqRgCboibNi7bgJ5I40KL4p+v6mgLuklyT6LS5IMwbQo7DCX1GO
         UGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2nLOWFbmOO5hZYhvSM6P2W6E4hnmfX5E21vuv9Oi74/jo/TMx6ZjfItfzgzNydCIIXzZoEhCUweEDgXZPW5oDCclXJZCSm5SRwUES
X-Gm-Message-State: AOJu0YwTgXHa6RW9gl7FRSFMRa7q5/nQ1PZvj7JfHfuDfXiuXT5U37Y+
	kV6GfkO6rkFrivRV/lKjuqX9KJS4rl5NI6NwqJpvdCtcZRTd46L08g/zwPItG20++iXSBzhfcDd
	4Hg==
X-Google-Smtp-Source: AGHT+IHgOu4dv31UbFJF3vKdWqGX6Wt83JV4T0YpPkiVruN9Wqq7liNsF8V9uSq4PaRVj9zdtFeZxQ==
X-Received: by 2002:a17:907:9485:b0:a4a:348c:de85 with SMTP id dm5-20020a170907948500b00a4a348cde85mr1945460ejc.37.1711484664082;
        Tue, 26 Mar 2024 13:24:24 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id oq25-20020a170906cc9900b00a46c8dbd5e4sm4555724ejb.7.2024.03.26.13.24.23
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:24:23 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4149134390cso3350435e9.2
        for <linux-um@lists.infradead.org>; Tue, 26 Mar 2024 13:24:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQQPhr12uaNDmJES/EfmcMAitCPebwqm3gqjWhKSimA3U0bA58rSAxPWEUdwlDPlA8tK6iWK94b80kKBAuDWEChiixbJ/f1ahOY7aG
X-Received: by 2002:a17:907:2686:b0:a47:3c66:b396 with SMTP id
 bn6-20020a170907268600b00a473c66b396mr1888708ejc.64.1711484642859; Tue, 26
 Mar 2024 13:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com>
 <20240321101532.59272-2-xuanzhuo@linux.alibaba.com> <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
 <b420a545-0a7a-431c-aa48-c5db3d221420@redhat.com> <1711346901.0977402-2-xuanzhuo@linux.alibaba.com>
 <041867ab-6cff-4bd1-9a44-2ca847c1ad63@redhat.com>
In-Reply-To: <041867ab-6cff-4bd1-9a44-2ca847c1ad63@redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Tue, 26 Mar 2024 13:23:35 -0700
X-Gmail-Original-Message-ID: <CABVzXA=QHxAbkN5qorb5e8gKtd-c9P61z_ft07PPkkzaDMxB_A@mail.gmail.com>
Message-ID: <CABVzXA=QHxAbkN5qorb5e8gKtd-c9P61z_ft07PPkkzaDMxB_A@mail.gmail.com>
Subject: Re: [PATCH vhost v4 1/6] virtio_balloon: remove the dependence where
 names[] is null
To: David Hildenbrand <david@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_202426_641235_88B2D211 
X-CRM114-Status: GOOD (  39.71  )
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

On Mon, Mar 25, 2024 at 2:11=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 25.03.24 07:08, Xuan Zhuo wrote:
> > On Fri, 22 Mar 2024 22:02:27 +0100, David Hildenbrand <david@redhat.com=
> wrote:
> >> On 22.03.24 20:16, Daniel Verkamp wrote:
> >>> On Thu, Mar 21, 2024 at 3:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> >>>>
> >>>> Currently, the init_vqs function within the virtio_balloon driver re=
lies
> >>>> on the condition that certain names array entries are null in order =
to
> >>>> skip the initialization of some virtual queues (vqs). This behavior =
is
> >>>> unique to this part of the codebase. In an upcoming commit, we plan =
to
> >>>> eliminate this dependency by removing the function entirely. Therefo=
re,
> >>>> with this change, we are ensuring that the virtio_balloon no longer
> >>>> depends on the aforementioned function.
> >>>
> >>> This is a behavior change, and I believe means that the driver no
> >>> longer follows the spec [1].
> >>>
> >>> For example, the spec says that virtqueue 4 is reporting_vq, and
> >>> reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set,
> >>> but there is no mention of its virtqueue number changing if other
> >>> features are not set. If a device/driver combination negotiates
> >>> VIRTIO_BALLOON_F_PAGE_REPORTING but not VIRTIO_BALLOON_F_STATS_VQ or
> >>> VIRTIO_BALLOON_F_FREE_PAGE_HINT, my reading of the specification is
> >>> that reporting_vq should still be vq number 4, and vq 2 and 3 should
> >>> be unused. This patch would make the reporting_vq use vq 2 instead in
> >>> this case.
> >>>
> >>> If the new behavior is truly intended, then the spec does not match
> >>> reality, and it would need to be changed first (IMO); however,
> >>> changing the spec would mean that any devices implemented correctly
> >>> per the previous spec would now be wrong, so some kind of mechanism
> >>> for detecting the new behavior would be warranted, e.g. a new
> >>> non-device-specific virtio feature flag.
> >>>
> >>> I have brought this up previously on the virtio-comment list [2], but
> >>> it did not receive any satisfying answers at that time.
> >>
> >> Rings a bell, but staring at this patch, I thought that there would be
> >> no behavioral change. Maybe I missed it :/
> >>
> >> I stared at virtio_ccw_find_vqs(), and it contains:
> >>
> >>      for (i =3D 0; i < nvqs; ++i) {
> >>              if (!names[i]) {
> >>                      vqs[i] =3D NULL;
> >>                      continue;
> >>              }
> >>
> >>              vqs[i] =3D virtio_ccw_setup_vq(vdev, queue_idx++, callbac=
ks[i],
> >>                                           names[i], ctx ? ctx[i] : fal=
se,
> >>                                           ccw);
> >>              if (IS_ERR(vqs[i])) {
> >>                      ret =3D PTR_ERR(vqs[i]);
> >>                      vqs[i] =3D NULL;
> >>                      goto out;
> >>              }
> >>      }
> >>
> >> We increment queue_idx only if an entry was not NULL. SO I thought no
> >> behavioral change? (at least on s390x :) )
> >>
> >> It's late here in Germany, so maybe I'm missing something.
> >
> > I think we've encountered a tricky issue. Currently, all transports han=
dle queue
> > id by incrementing them in order, without skipping any queue id. So, I'=
m quite
> > surprised that my changes would affect the spec. The fact that the
> > 'names' value is null is just a small trick in the Linux kernel impleme=
ntation
> > and should not have an impact on the queue id.
> >
> > I believe that my recent modification will not affect the spec. So, let=
's
> > consider the issues with this patch set separately for now. Regarding t=
he Memory
> > Balloon Device, it has been operational for many years, and perhaps we =
should
> > add to the spec that if a certain vq does not exist, then subsequent vq=
s will
> > take over its id.
>
> Right, if I am not missing something your patch should have no
> functional change in that regard (that the current
> behavior/implementation might not match the spec is a different discussio=
n).
>
> @Daniel, if I'm missing something, please shout.

Thanks for digging into that - I think you're correct in that the
patch does not change the behavior, due to changes elsewhere in the
generic virtio and virtio-pci code. So in that sense, I guess this
should not block this particular patch.

It would be good to have the spec situation cleared up, though - I
guess in practice, all relevant drivers and device implementations are
already following the model where there are no gaps in the queue
numbering, rather than what the spec seems to indicate.

Thanks,
-- Daniel

