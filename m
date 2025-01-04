Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88177E77188
	for <linux-um@archiver.kernel.org>; Sat,  4 Jan 2025 02:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MTyz2BPeDLlTIHhsSWuHdu+mofZpbwj9qrtZn/7HLec=; b=Jy4N5ib3GVa2v4WcTlr62kJOg8
	6xw1mXch0fPsl2G8umaizFTHYIMcW5cosHBPyVCb4Ib5GI4MVvvhO7QKsZKOl0iMxAkirKEZlYvio
	0ohEy575mP7NqjBfSlzLejr/oBjBWxX0pmTOcJ/rkBidSkdOHQGzHcklLROuOisKwHDx6FI45uqKM
	5DhVBWUg7zcrad9+fjf8XQJ31wXGrrmAR64rVJejVzsRA4vveVKLn2CxYwyrYbD4qRM401eQd3Pq0
	f64CLiwyEJM1+YNNEuC3E6lER7jZb0zM7Mi5P7egZ/w07yhvKKcXjWoYKyYoivZ3MrXiOjH2h4Byu
	z6Tnh2aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTteq-0000000ELvu-0IeW;
	Sat, 04 Jan 2025 02:12:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTtZY-0000000ELJA-2Xoo
	for linux-um@lists.infradead.org;
	Sat, 04 Jan 2025 02:07:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 79CED5C5E2D;
	Sat,  4 Jan 2025 02:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E24C4CED6;
	Sat,  4 Jan 2025 02:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735956445;
	bh=5+k5XIDfmklKhyQNZnytCq6Wbtr3vAtBCZfKfKHl6CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joD0NAbRBPE0lezKTTDP1O/kr2E6iJf9COWb+q26eFjVoffuI5L/uXxAbsoYlryoQ
	 fYP/yaVyXmntFcDd1a3Fy5BzamjHbURSTyP3IdaXyhV79hmDEblPiZtS6iVgzwGlo3
	 Kx4vTa/nHoqIBT7WaRKz0y7zXQ0mNg/SZWWNqb701SX3cdNH0ZRCTN14xhyhSGJ8Pg
	 cXiLSChUUEnHpXT+4yMfzWCREm/wGuuwBvwu0rahfPZ8BSGvXEuUhX3QReboXWGoBI
	 95VoZXg6cVJmIgpcGSWX14DR8XQkeIf/4vXIKDW+eMgmO5cxqmChke6AdKsiTp7rM/
	 m8eDNhFD+TAEA==
Date: Fri, 3 Jan 2025 18:07:22 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Marek =?utf-8?B?TWHFm2xhbmth?= <mmaslanka@google.com>,
	Adam Williamson <awilliam@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org, anton.ivanov@cambridgegreys.com,
	bp@alien8.de, brendan.higgins@linux.dev, da.gomez@samsung.com,
	danielt@kernel.org, dave.hansen@linux.intel.com,
	davidgow@google.com, dianders@chromium.org, hpa@zytor.com,
	jason.wessel@windriver.com, jikos@kernel.org,
	joe.lawrence@redhat.com, johannes@sipsolutions.net,
	jpoimboe@kernel.org, kgdb-bugreport@lists.sourceforge.net,
	kirill.shutemov@linux.intel.com, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	live-patching@vger.kernel.org, luto@kernel.org,
	mark.rutland@arm.com, mbenes@suse.cz, mhiramat@kernel.org,
	mingo@redhat.com, peterz@infradead.org, petr.pavlu@suse.com,
	pmladek@suse.com, richard@nod.at, rmoar@google.com,
	rostedt@goodmis.org, rppt@kernel.org, samitolvanen@google.com,
	shuah@kernel.org, song@kernel.org, tglx@linutronix.de,
	x86@kernel.org,
	Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH 6/8] modules: switch to execmem API for remapping as RW
 and restoring ROX
Message-ID: <Z3iX2mNtqSYrvYPT@bombadil.infradead.org>
References: <86eba318-464b-4b9b-a79e-64039b17be34@lucifer.local>
 <d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com>
 <9878d90f-faf3-4853-9a79-a21b4f58ab4c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9878d90f-faf3-4853-9a79-a21b4f58ab4c@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_180728_687365_3B4C6F03 
X-CRM114-Status: GOOD (  12.13  )
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

On Fri, Jan 03, 2025 at 07:58:13AM +0100, J=FCrgen Gro=DF wrote:
> On 03.01.25 03:06, Andrew Cooper wrote:
> > > Hi Mike,
> > >=20
> > > This commit is making my intel box not boot in mm-unstable :>) I bise=
cted it to
> > > this commit.
> >=20
> > For what it's worth, we've found the same under Xen too.
> >=20
> > There's one concrete bug in the series, failing to cope with the absence
> > of superpages (fix in
> > https://lore.kernel.org/xen-devel/6bb03333-74ca-4c2c-85a8-72549b85a5b4@=
suse.com/
> > but not formally posted yet AFAICT).
>=20
> Now sent out:
>=20
> https://lore.kernel.org/lkml/20250103065631.26459-1-jgross@suse.com/T/#u

Thanks,=20

Marek, Adam, can you try this patch? Although the reply here is for
another future series being worked on the fix is for commit
2e45474ab14f ("execmem: add support for cache of large ROX pages").

  Luis

