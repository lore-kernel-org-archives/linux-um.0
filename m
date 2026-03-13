Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF1E106ACFE
	for <linux-um@archiver.kernel.org>; Fri, 13 Mar 2026 00:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:
	References:In-reply-to:Subject:Cc:To:From:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KgAiLbof0iO8cGF8i0bS3fRoWLrp1RkGsUr3z87f+QY=; b=tJfo3xFdS2rSFH
	km7e8/FDzkHDp3tBMgehes+CzkSqKBlglnrGPF0KZrKb5Xhz79whULsyRfXI7OpwU2qfhqpqTiyMx
	EWE8Rk2SPA3VwaIshGQAvZWP4zX8vlgkGUYGEK7bzWSHctmwa2OrFTwuJww8AjekwawHxfcOqbV9c
	TRUOtlN/aFHRF8x4TGj+0RZgUx7bF6NbKc8NkuXy5TTCvZH9LHydN+ANwo09HK/nhZREEYEFg4vaF
	cvxuvg33a3qC38DdyDkk+XdxKD++TYJ1rQxpBGy3+W8YFHH+cmPf0INlwba8tpJ7XzfCEZk3Ch/zr
	M+k07dkB5zL7rUKIaYpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0q5s-0000000Fs44-02Qe;
	Fri, 13 Mar 2026 00:09:32 +0000
Received: from flow-b3-smtp.messagingengine.com ([202.12.124.138])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0q5p-0000000Fs2o-10ZN;
	Fri, 13 Mar 2026 00:09:30 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 453521300F4D;
	Thu, 12 Mar 2026 20:09:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 12 Mar 2026 20:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1773360565; x=1773367765; bh=KgAiLbof0iO8cGF8i0bS3fRoWLrp1RkGsUr
	3z87f+QY=; b=nmFe2jtLyLr+7u8+TDKRncwnQQgfmtMxU9rW2fcZXcAX5N/O+oK
	mkTcvLt2tGqnfh0yQZ9VxfeJXHOmQK3xmRCh0WkZO8z+9EbGkHt1EK+1v9oEDQFk
	yjK2H4B7GbHLcXZXF6XJNsP5Q5oExxA0/3HptDHC4Yo7bGMxV66pr3UW7B9oRSB4
	vuiTbATRXYBbLXhvd6Op9YEKWgq8ir7OPi6JV+oRhKZvn8t8u83ENmYYrl/BoZV0
	FrCRFffyXHlTGaGOZ5VUzpnpHtLR7Cp1SV1LfUlzqP/nSXhBI3LJq0G6aafkvcXQ
	H921q+OqQ7yY81EaudsM9yPaG6U2Be50mTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773360565; x=
	1773367765; bh=KgAiLbof0iO8cGF8i0bS3fRoWLrp1RkGsUr3z87f+QY=; b=G
	5Cai4ktm8ZYp5XyzSdEJarMpSfeXDzWAL8MTxUvYBQ2hpUgY3TIWYBA9NiTzGeNa
	5E83ul9G/GPuOexqHFwoNmE5Bf87gj016HXSgb9HA2ajcfY5cLlR/6Scnq1+bMSy
	L/Puu8DC52gTGANh4qz45QluS+yFcFx8cBkqURrLJFH5bOAyWf/oR6Uo1r93DRwO
	ChU+IBist6Pp1G8vs9yINCx1pw7Dl8SVJBTw/u/RobXjWABJlCOcI6SzK3FmMqVv
	JWB6ykQWBhykIIJXXf4XNnPkhW+lXc0X5IwRHItIgUJymc4RMF52UynxsiryvgQn
	Ohgl8jSg52zXQ1Ht0jvEQ==
X-ME-Sender: <xms:slWzaeXV7qa1u6neLd6Q1-cVt0VMASr8cnqysAFQocSTAtEfKc0JvQ>
    <xme:slWzaeSKlwNXuQd-ytFXXY0mVc_-Zjwa4_mmoEgCEIxrE6aOdvb3p8liU_ELdbDzk
    UaaJ6Rv9sIirpntfCZ3ed2iOF6DIF4YVBR0WyA36tWvjzE7914>
X-ME-Received: <xmr:slWzadcI0WZE_K5ZNf3p0KQMTKhUmZqGQsTQWME1TwSj7PSSkE9RCFBWyBYhQ55dSIow75rJ91K6-dY7EINULxs6lGnfRrWsj3AxXRa0e5UN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epgfeikeetueehudeigfefkeekleegheehueeifffhieefvdegueetgfekuddukeevnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeehuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhose
    iivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdigfhhs
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidquhhnihhonh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhtrhgr
    tggvqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdgvgihtgeesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdgvfhhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:slWzaSzNnugwYNYtiVWYHc4qaDBmXyQ51PSSBJ1uiNVJapnS6gluPA>
    <xmx:slWzaeEAu6gvMjez-LKBYzOhXf5W2TUuXYdFq9RYM3BZ9DviPSnwQA>
    <xmx:slWzaW4NCFWB-i4WBv0KYxfPr8CoLpfQ8pVU8lId_PRL8FTgtUuCaQ>
    <xmx:slWzaVHk7pykGSmnnTVs6z84wbljsuc816F1d1tD0LoUWms4qvgBoQ>
    <xmx:tVWzaRho-xmNtiFafDRGXsj1bH7ybmYtyFLigxgHrazcCccpxnyLB6O->
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 20:09:09 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Carlos Maiolino" <cem@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Jan Harkes" <jaharkes@cs.cmu.edu>, "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Steve French" <sfrench@samba.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Yuezhang Mo" <yuezhang.mo@sony.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Breno Leitao" <leitao@debian.org>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Ilya Dryomov" <idryomov@gmail.com>,
 "Alex Markuze" <amarkuze@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>,
 "Tyler Hicks" <code@tyhicks.com>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Jeremy Kerr" <jk@ozlabs.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 coda@cs.cmu.edu, linux-mm@kvack.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 gfs2@lists.linux.dev, linux-um@lists.infradead.org,
 linux-efi@vger.kernel.org
Subject: Re: [PATCH RFC 00/53] lift lookup out of exclive lock for dir ops
In-reply-to: <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
References: <20260312214330.3885211-1-neilb@ownmail.net>,
 <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
Date: Fri, 13 Mar 2026 11:09:04 +1100
Message-id: <177336054496.5556.4842794610845842132@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_170929_789433_21049BE4 
X-CRM114-Status: GOOD (  15.39  )
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
Reply-To: NeilBrown <neil@brown.name>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 13 Mar 2026, Linus Torvalds wrote:
> On Thu, 12 Mar 2026 at 14:44, NeilBrown <neilb@ownmail.net> wrote:
> >
> > This patch set progresses my effort to improve concurrency of
> > directory operations and specifically to allow concurrent updates
> > in a given directory.
> 
> I only got about half the patches, but the ones I did get didn't raise
> my hackles.
> 
> HOWEVER.
> 
> This is very much a "absolutely requires ACKs from Al" series. Al?

Yes, I'm looking forward to Al's thoughts

> 
> Also, because I only got about half the patches, and there's 53 of
> them total, I'd really like to see a git branch for something like
> this. It makes it easier to review for me, and I suspect it makes it
> easier for some of the test robots too.

github.com/neilbrown/linux.git branch pdirops

But if you have only time for one patch, 52/53 is the one to look at.

Thanks,
NeilBrown

> 
> But again - this needs Al to look at it. Iirc he had some fundamental
> concern with the last version - hopefully now fixed, but ...
> 
>                  Linus
> 
> 


