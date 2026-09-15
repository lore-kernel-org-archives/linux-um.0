Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE77C982C1
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 22:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=; b=W8Yk3V2ANK94J/iFLorbvdER4l
	2K8R8usOSLcybUHK7yvir2FxPuoS3MKjKCxm2UpGTkI9pAWyoVpMi+n500ub75yVr7ocgvNkr39zJ
	VNcqrbj1po/hcDCXexFJEqaoPimNnmkZsHfgTllfgmx91BZGwrzX0tUzaNrdyQ/jd9tixgMKrhiNA
	HhryKPyvKJheVzz3n9wmVNn+FOQClJTjPlfN1EUIoPTjGFrt+3iQnJtw+XrSEWnz13sXRctxjOVkb
	+zaAMdnj7hvnDvD6HxmCjZHN7HkYvpbV6oFRLhdWtjITBOhdbW/Ej6BKjf9jk2q8KgCQ5dSumcIWt
	HYXWJaaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6c3e-000000082lQ-437p;
	Tue, 15 Sep 2026 22:55:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6c3b-000000082k6-17SV
	for linux-um@bombadil.infradead.org;
	Tue, 15 Sep 2026 22:55:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=; b=CoT+JtrMijic3/aamEubT0JUc2
	oB2lvvxkGUnVMXsRVXGDHsDUiENUD1EcDI568nlpNZtqIRLJIp3rqeNnLf+1NyRP7CLhZHvX5dw0G
	IPfOwUwJuJuRFK5VzK3JGxU+g/FoGNespBtVPdmf6iCMZbglf3/G9HT/S4SP8IMHiFsicRNLZH1Vn
	HvxEgr9y4j3jTJfwfg5/Y3tz8yXiGR1xH8hiCNFqezjn1FAVlng/H0aWZPeXR+E8Q8aefFePuSr9f
	9n6q6CUT3Gqgb60UstmHghrvIpkLVyAAgFOKasy+/5DbHVcKu6UYRTvCn/WfvBxrs4NokiTZ5S3lK
	yuB6Sckw==;
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6c3X-00000007J4l-40Ff
	for linux-um@lists.infradead.org;
	Tue, 15 Sep 2026 22:55:18 +0000
Received: by mail-ej2-x10.google.com with SMTP id a640c23a62f3a-c254f6c7a58so58012766b.2
        for <linux-um@lists.infradead.org>; Tue, 15 Sep 2026 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789512914; x=1790117714; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=UjmYVQ4EekHgbAxownd4WXtzIR6TaeeiK8gdE7Z5yMPgKpCcWDwqlbuIwvnT5vf0/q
         f//2EZAO245ETQFQsbTLnyCFbB9Qr7Nfej+Xaeqii3ycNfa4Swp6LLxLQi194EEVT8oz
         +seH+aaTGH5hge5b2+OHq4B7+qDDsxykDDSFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512914; x=1790117714;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=GnxuDp/UytDXcd2A/vm6ZgvGEMxUBVwim0LRyJTOlSj85xriImT1fV7M2VTkVOLhfV
         yiuv9szzCGIzHHTaivIosz+NoUqpJ6Kj6RRkqSfp3oLIzfDwnzrVEKx1KY1JXZ8Ft5E5
         TUhjPwgy5EpTIKZidaGfCJ9cJG+4oh8pEe/LF75tM264oWn36XqyIb83/Gw9KgLtaIh9
         94UZfpb6+pQeERHHLtBDU8i4g/DfahWgtowNojO74P/K4H+h+ILu8IXo+N0akGWipVsD
         oz9pee5rcLtM3ovoCR+LN9uQ+o7mBWUSBDwbLDG37kbwdwz59yg1msMb04lwKdstNGag
         1Giw==
X-Forwarded-Encrypted: i=1; AKwUvBypXejZx7HKpKsF3eVAGhAw0w8iFtk5IbMmLzowT4FANEmL1MnKCwc8p0FYtkTbTuFC6or10m666g==@lists.infradead.org
X-Gm-Message-State: AFuF++mbKT0IyT4sr3bszjDcNBRoN9QxH5ydQXcJamG4fDmFR/AniyAy
	ihPGVPicuslq3JaCR7L+CYmM42kg5JOmOQ/nbf6kojg8BwR3Pk8eQhNDnmT9DBk2Zp/5j4uSxGY
	zr6TYLRR25Q==
X-Gm-Gg: AYBFou2I6Kzb1mIoM01wDmMTsQ9lEolBHcmaN+TBiAO7Ymd6hztVLU+eW6O/wXJpUWz
	HdjN9QJk8wT1J4LikxyUkq9u7W7rF6eniTEyLYd8Mlv4+52eHruQz6qkg0GlJ5nU8UN1+Aj5XHG
	dzXU2Q2n7GdMz2eDlVfKDb6ARcl2ldmYXqNc8rmwtFJdX27VwKPW3T3q3i1LEFCcpezy03hbfS0
	XnIh96Ak6/gGdeWwWyPmCzAxPX5+3OI9lFY7itqfjH/ipvSAaDhIVsmAFApAcim/VQVMfBJCOpZ
	Nxch4jzzbH/41+C5FtTQNDl61Ali6adI/VdaXqzWxgHb3u8sUC5sC3iYpoAbxYPrsPcUdG7m3Hi
	aod5F0z7wIK26esQrC2Ee+F8zpWBBsYNopVtkPAin0jWAtCfUy/vbvUqjRUSNmkCUWx6PggBXdr
	Kar2pfLd37La2tm3mS5WivfYH6wgrho06z1GxQfvdXig7uhFzUyFbXWAcahezIW7hlFsao71916
	4Qdhk29yxnd3iS6OSHtNI6Xl1Yxt+RmsiMi8ThoOV9cwc1JuVxkQr1pNDE=
X-Received: by 2002:a17:906:f596:b0:c29:183c:a5f with SMTP id a640c23a62f3a-c29e51dbbebmr9329066b.5.1789512914236;
        Tue, 15 Sep 2026 15:55:14 -0700 (PDT)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com. [74.125.228.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d228edfsm386381a12.10.2026.09.15.15.55.14
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 15:55:14 -0700 (PDT)
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9adea43b6so509034a12.0
        for <linux-um@lists.infradead.org>; Tue, 15 Sep 2026 15:55:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwJqN2r9ucBV4CeoG67FXiW9DOGNr2kVV/sHbIOQkP14nWppw+M7rbTaroDUNEvtgp1wG3QPYYcKg==@lists.infradead.org
X-Received: by 2002:a05:6402:5d1:b0:6a9:a6c0:e5ef with SMTP id
 4fb4d7f45d1cf-6aa2244ef06mr218172a12.37.1789512913950; Tue, 15 Sep 2026
 15:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com> <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
In-Reply-To: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 15:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
X-Gm-Features: AcwNN1Wx2MaYDtFtmeOlL6MnzYY7doY_FEPpziKatTBWbLOeKsjmritQ5JuAL3M
Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: rob.clark@oss.qualcomm.com
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_235516_421817_2E900649 
X-CRM114-Status: UNSURE (   9.53  )
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

On Tue, 15 Sept 2026 at 15:21, Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> With fd's it is more than just about error rollback.. exposing an fd
> to userspace mid-way thru an ioctl is an easy security bug to write..

That isn't very common code. It's something that is done by a few
strange cases, and yes, those cases should just do it right.

But "those few cases should do it right" does not mean "make a whole
new subsystem for this thing that makes a simple "open" actually be
slower and stranger".

             Linus

