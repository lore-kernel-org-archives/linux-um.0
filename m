Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC19C3600B
	for <linux-um@archiver.kernel.org>; Tue, 25 Mar 2025 16:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QelhuPqIgEevAm+vSlBFCfDLeQvBznIkSlhg3fqDPmY=; b=XW3+kTFkWYBBXooFoYe6m9gDI2
	PMVnSJQUY+KO0+oJ93gsHXbRxrSMnsdglShLZjAOlc06jEYq0w8q/sQksmUMOLAev5bwdejiQl7U1
	bTTNoWf2l7Guyzxr43EMrdG7ZiImTzOSFoV3cv+GGhcb76D1jhzpjMVtGBmvKuU0gGcc4lmH2+AAq
	hxMyWhbxzSD9LoQvaIs7tCepJkCHN2tiIc25Vx7hkUDpwG4vb0i/LCJBGu8ls1H4pN8CH3xzVro2w
	xq9OUiKRGIlNAQVYw0Qtcy0TaYO2Lr+fmEpwCCQGZ7R/Fh7NJXphT29o/sZtR6U4+KpRUd2UG9z45
	ssDMKpmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx7Ha-00000006VJR-2ZFb;
	Tue, 25 Mar 2025 16:37:42 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx7BI-00000006UbR-3BYz
	for linux-um@lists.infradead.org;
	Tue, 25 Mar 2025 16:31:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QelhuPqIgEevAm+vSlBFCfDLeQvBznIkSlhg3fqDPmY=;
	t=1742920270; x=1744129870; b=eYo2XgtGFVNWkeiDDsp4C4pbriFupk85aeV7I1W1Z5Ub05A
	XngKVm5IvQPaKaG8okVKdpxfL49/Ul4f8XKmFiHBqaR5ewUMmLN+y7QrqZ+kp9GbMZugUq+DJDnCC
	EDj27JNV1QFH2tG8FmJAf7MXcCn4y1dcFFkkHYVH0ZwQwjt9tktwlAgclByF+SMBFj3dNIG0UlrXp
	VAcq0ApE/aONn/D6Gh3lIRJQ6/mk3fFs+ojTkgGVzne4X1ex27ObqJY5ECJT44oKdFqGO/o2oicUQ
	MiNdu0U0/SSo5DJbgir913qeGYo326xrsN19Mor3KmbYbjktGj3w9ZOAl2EuqhnQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tx7BA-00000005DNH-0MOn;
	Tue, 25 Mar 2025 17:31:04 +0100
Message-ID: <e09f89242902f4a169196f16836e53665198f616.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/4] um: Add pthread-based helper support
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, Johannes Berg	
 <johannes@sipsolutions.net>, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
Date: Tue, 25 Mar 2025 17:31:02 +0100
In-Reply-To: <870c3af1-10e3-4629-93de-cb92a83de00d@antgroup.com>
References: <20250306150747.2926434-1-tiwei.btw@antgroup.com>
	 <20250306150747.2926434-2-tiwei.btw@antgroup.com>
	 <306312a14326a482cba476733a4adde1799b7ccf.camel@sipsolutions.net>
	 <bacc4abaaec8c254e33974d63482575e8e9448aa.camel@sipsolutions.net>
	 <870c3af1-10e3-4629-93de-cb92a83de00d@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_093112_798064_8F396CBF 
X-CRM114-Status: GOOD (  15.12  )
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

On Tue, 2025-03-18 at 22:55 +0800, Tiwei Bie wrote:
> On 2025/3/18 21:16, Johannes Berg wrote:
> > On Tue, 2025-03-18 at 14:06 +0100, Johannes Berg wrote:
> > > On Thu, 2025-03-06 at 23:07 +0800, Tiwei Bie wrote:
> > > > Introduce a new set of utility functions that can be used to create
> > > > pthread-based helpers. Helper threads created in this way will ensu=
re
> > > > thread safety for errno while sharing the same memory space.
> > >=20
> > > Using pthreads seemed odd, but Benjamin argues that it's the only way=
 to
> > > get libc to really sort it all out, unless we never use libc syscall
> > > functions, which is probably kind of unreasonable? Or maybe we could?
> >=20
> > It's a long list of symbols that are needed:
> > https://p.sipsolutions.net/2f0c8e0de1e69147.txt
>=20
> Thanks for the list! That's indeed a long one.

So, if we dropped libc, then I think that would also imply dropping the
abstraction to support hosts other than Linux. And then the hard split
between user/kernel code might not be needed anymore as one would
ideally not rely on system headers at all.

I can imagine that parts of the code base would really benefit (e.g.
include handling). While other parts would obviously become more
complicated (e.g. parsing /proc/cpuinfo, mcontext handling).

It seems to me that the cleanup potential is likely big enough to make
it worthwhile.

Benjamin

