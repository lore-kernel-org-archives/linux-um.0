Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8F6C25B78
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 08:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kdfBd8EH3eRGtnH7TLrvqUejoNS9YTFjNs9j1O2nDas=; b=AfoeANycgJPPrrdfUx88PHEbVc
	36qCV2h8EfN7u795/3us+49UCn5l96G//p/c7PkKu+SZp8Hd58A5G8N9N2JO49EPsUBndM50fqp+S
	NGjaQNubDN3lVmEeMQ3BKR9QtBbr1fRClYmERc5cm2XIgtuR8rYk8Pt1TPwTDDEXgIaA2RXVonwPS
	v7hjy3/uw+TRc/JubM9VBpMKCkT0mY0jrvXXXVRqETA9h+4eOllDyYEA1OzZlMMnKZ2hchvFV1msP
	ivHHhLDy/AqGIaZX3zPtTYuqDXNCxwzTbNvqUe0/VFHfx7IYkDb+iQPD9q/YlxoqPYcWDcMlaMiFZ
	9LxWmTtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCbYX-00000006hRb-3gAC;
	Thu, 30 May 2024 08:54:41 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCbYU-00000006hR4-1x4y
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 08:54:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kdfBd8EH3eRGtnH7TLrvqUejoNS9YTFjNs9j1O2nDas=;
	t=1717059276; x=1718268876; b=PnxTx0i6GdlowOrRRI+QWJuTuIZ2ToBSdl+pG6dbrf4fed9
	zKTAD1rbp7/1xYCHULaCOpGrNX0s/YJZOCGwNYS953danh0wGFEdGkkaVS8bUWB7pwNGAdtvvVEgr
	X66i2PZ35Yev00/B8TY3ElvS0ld6f+TFv9FgSf6w7Tv7yDjwr6wWussNJ6SAmkSOcuIb65tFelJWV
	Sc7n6KDBIm/aNEjzpffKTsdW4pM+KSSpqr4Cp1eouTgNpyIYC9vAjH4zQSKIbv5inufsqvlk9uLvO
	5LqD9LwYbzzJHHg19twShrx6tHMlVhddd66JhrMGiT/yzSGzTFIzPS544ujY7mmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sCbYM-00000000wxc-0M63;
	Thu, 30 May 2024 10:54:30 +0200
Message-ID: <6a1a9b9fe5c7d8c7ecd2b42c9f61346318a5f659.camel@sipsolutions.net>
Subject: Re: [PATCH 3/5] um: Do a double clone to disable rseq
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, Johannes Berg
	 <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Date: Thu, 30 May 2024 10:54:27 +0200
In-Reply-To: <759a6a53-efbc-4b11-8065-622702eb120b@antgroup.com>
References: <20240528085419.1964424-1-benjamin@sipsolutions.net>
	 <20240528085419.1964424-4-benjamin@sipsolutions.net>
	 <5f5505da-ba67-421e-b0f5-6a5c19955f27@antgroup.com>
	 <4a9d3075304f39b818009081d496b0f245bad450.camel@sipsolutions.net>
	 <37d6a0e2-bbc2-4a93-bd7c-3cef847eba54@antgroup.com>
	 <759a6a53-efbc-4b11-8065-622702eb120b@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_015438_747678_60621658 
X-CRM114-Status: GOOD (  24.15  )
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

Hi,

On Thu, 2024-05-30 at 10:54 +0800, Tiwei Bie wrote:
> On 5/28/24 10:13 PM, Tiwei Bie wrote:
> > On 5/28/24 7:57 PM, Johannes Berg wrote:
> > > On Tue, 2024-05-28 at 18:16 +0800, Tiwei Bie wrote:
> > > > On 5/28/24 4:54 PM, benjamin@sipsolutions.net=C2=A0wrote:
> > > > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > > >=20
> > > > > Newer glibc versions are enabling rseq support by default. This r=
emains
> > > > > enabled in the cloned child process, potentially causing the host=
 kernel
> > > > > to write/read memory in the child.
> > > > >=20
> > > > > It appears that this was purely not an issue because the used mem=
ory
> > > > > area happened to be above TASK_SIZE and remains mapped.
> > > >=20
> > > > I also encountered this issue. In my case, with "Force a static lin=
k"
> > > > (CONFIG_STATIC_LINK) enabled, UML will crash immediately every time
> > > > it starts up. I worked around this by setting the glibc.pthread.rse=
q
> > > > tunable via GLIBC_TUNABLES [1] before launching UML.
> > > >=20
> > > > So another easy way to work around this issue without introducing r=
untime
> > > > overhead might be to add the GLIBC_TUNABLES=3Dglibc.pthread.rseq=3D=
0 environment
> > > > variable and exec /proc/self/exe in UML on startup.
> > > >=20
> > >=20
> > > It's also a bit of a question what to rely on - this would introduce =
a
> > > dependency on glibc behaviour, whereas doing the double-clone propose=
d
> > > here will work purely because of host kernel behaviour, regardless of
> > > what part of the system set up rseq, how the tunables work, etc.
> >=20
> > Makes sense. My previous concern was primarily about the runtime overhe=
ad,
> > but after taking a closer look at the patch, I realized that the double=
-clone
> > won't happen on the critical path, so there shouldn't be any performanc=
e
> > issues. I also think the double-clone proposal is better. :)
>=20
> But when combined with this series [1], things might be different..
> Double-clone will happen for each new mm context. That's something
> we might want to avoid.

I cannot believe that this overhead is something to worry about. The
CLONE_VM step should be really fast compared to the second clone as it
runs in the same MM as the kernel (it is how posix_spawn avoids the
fork overhead to execute another process if possible).

Note that using execve in the second step would speed things up even
more as the process will then run in a new MM instead of copying the
kernel MM and cleaning it.

That said, this patch can be made simpler by using CLONE_VFORK.

Benjamin

>=20
> [1] https://patchwork.ozlabs.org/project/linux-um/list/?series=3D408104
>=20
> Regards,
> Tiwei
>=20
>=20


