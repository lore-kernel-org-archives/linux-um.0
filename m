Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24995E7F154
	for <linux-um@archiver.kernel.org>; Fri, 29 Sep 2023 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yxaq2jjUfA+F2EWiNQAz8YpV4Bjp1EHwgDPaHp3wk5k=; b=PUqP6TobsipiU3
	24kM3xZcle4zjM6pmyvPpDKRVt+QyOIq3YsITLf8ps6aEeAQz2KH2PDDSeUeo59aiulsGvhz8IY4g
	JcDm2kyfKLzg84lb6cxAjedqzYNLlfH4e3RIeSOT7p5MO2kKb5HhhimeGXEj/ENK7+KTiE86tcmZY
	l3dA/O5Cr9u7T2qZjDu+j5FgBazYQjucDozvOI0mx+xF/gg5rpn4FJdiJGSfq8qwjTOemnkyFPauX
	HhIHgtcVI6G72MHrmo6Vqnp6GbGKhYZ1IcFi7dAol94we3XVRAP+H1Fp3DB1a/Hsvk0A8J+jHSAE2
	9WRD3hrxED3iQHKStCcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmFXf-008CWH-2K;
	Fri, 29 Sep 2023 15:36:35 +0000
Received: from new3-smtp.messagingengine.com ([66.111.4.229])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qltFq-005dRZ-2C;
	Thu, 28 Sep 2023 15:48:44 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.nyi.internal (Postfix) with ESMTP id A3A69581DA3;
	Thu, 28 Sep 2023 11:48:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 28 Sep 2023 11:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1695916120; x=1695923320; bh=AE
	M/fDbI9O0BImAELzI+hfXsnObtdXB3nh8ZZCXXqn0=; b=byfYA1BNqc0YjQaASF
	s1x85iwtpsSetZH3v6T9P24VWHjtY/C2Cy0QBMN4anJkKAx/kEgik+7dgqX7WnUW
	La20mPl+Hw/VFhfjU9nQv4lI54y8w78+xdi3Se04xsEpK/yzVwzapQ8MJ/9B+Ktm
	JGLFbhwJ3F2I83/vnqG03iBpb0Id/foHd3DxxbBNAGkh1TS6cGFhv+xeNe2uxiVA
	1qtNw6fHsIlObgAbEcnfTbzpUBh/2qzRYo6CGPfmvxiTxQpNbUl8G4oC5H5iQo6x
	/sAEGT5XCYLJOHsqcHS9JN3fpYg+L/x6M1JiQIXk5Xp17LZq0Ehr9oFjxCiH0gfw
	Y0hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1695916120; x=1695923320; bh=AEM/fDbI9O0BI
	mAELzI+hfXsnObtdXB3nh8ZZCXXqn0=; b=bns6ZXaqrL/zYhXfQpEqgZrIk4z8L
	5qkMm8nanaHWiR3fzY/YJIDw4+d+6MfDnms8OZzMVU59EJQIob9K7kzc0B41836P
	pck63XByx3cERUFTmSSiKbBu5nhvH0jdl6mRd7HtSMoowPAFE7LbFjRy0HUXas/x
	zuZT/GjF5UmuSTx2Ncvja7fvvyhqK+7Jsd6ADNqIQbbTEHNte96FH8xT2LEQEdZk
	2T5+RXWDET2gc7L+8jx1gAormT1mlAdY8znZETSBE9x8HVOf/9oCuP13d29xSJA9
	mCd1merIfP+8lGUSyKAU/ig1OvFVLDfli/gPb0lxh+/QHFqcRvo9/s28g==
X-ME-Sender: <xms:VqAVZXE__W9HO3j590HO6-PACkehtw80tMv7d4HvGuKYSjIJuTI6RQ>
    <xme:VqAVZUWl9fcsyKK3QqTqaAvw8LGq2xDGW35Yno81JLQMi669bT02RVpu94lBxw_jn
    QgPm3RFzCYL7ZViZlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddtgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:VqAVZZK0D2-ZL7UQFk8qwItdKKtQYmBaNYQQiDAH1Nkr-cr3HctJAA>
    <xmx:VqAVZVF6Zr2MMOiB52aErwvKuBNf3pQG2N0wuyhcEBebAo-dKIjzzQ>
    <xmx:VqAVZdWedvPmt0lEk8LEYFOavVM-S9P9bXcBcS-G7nOKlASZgTlnaw>
    <xmx:WKAVZesnGxfxRtJdtAmFuBxiOG6TsPyAdAiRI9hFNWL4LJT1qfK_tQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BE4B9B60089; Thu, 28 Sep 2023 11:48:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com>
In-Reply-To: <20230928110554.34758-2-jlayton@kernel.org>
References: <20230928110554.34758-1-jlayton@kernel.org>
 <20230928110554.34758-2-jlayton@kernel.org>
Date: Thu, 28 Sep 2023 11:48:16 -0400
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jeff Layton" <jlayton@kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>, "David Sterba" <dsterba@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, "Kees Cook" <keescook@chromium.org>, "Jeremy Kerr" <jk@ozlabs.org>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>, "Christophe Leroy" <christophe.leroy@csgroup.eu>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Martijn Coenen" <maco@android.com>, "Joel Fernandes" <joel@joelfernandes.org>, "Carlos Llamas" <cmllamas@google.com>, "Suren Baghdasaryan" <surenb@google.com>, "Mattia Dongili" <malattia@linux.it>, "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>, "Brad Warrum" <bwarrum@linux.ibm.com>, "Ritu Agarwal" <rituagar@linux.ibm.com>, "Hans de Goede" <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Mark Gross" <markgross@kernel.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Eric Van Hensbergen" <ericvh@kernel.org>, "Latchesar Ionkov" <lucho@ionkov.net>, "Dominique Martinet" <asmadeus@codewreck.org>, "Christian Schoenebeck" <linux_oss@crudebyte.com>, "David Sterba" <dsterba@suse.com>, "David Howells" <dhowells@redhat.com>, "Marc Dionne" <marc.dionne@auristor.com>, "Ian Kent" <raven@themaw.net>, "Luis de Bethencourt" <luisbg@kernel.org>, "Salah Triki" <salah.triki@gmail.com>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, "Chris Mason" <clm@fb.com>, "Josef Bacik" <josef@toxicpanda.com>, "Xiubo Li" <xiubli@redhat.com>, "Ilya Dryomov" <idryomov@gmail.com>, "Jan Harkes" <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, "Joel Becker" <jlbec@evilplan.org>, "Christoph Hellwig" <hch@lst.de>, "Nicolas Pitre" <nico@fluxnic.net>, "Rafael J . Wysocki" <rafael@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Gao Xiang" <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>, "Yue Hu" <huyue2@coolpad.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>, "Namjae Jeon" <linkinjeon@kernel.org>, "Sungjong Seo" <sj1557.seo@samsung.com>, "Jan Kara" <jack@suse.com>, "Andreas Dilger" <adilger.kernel@dilger.ca>, "Jaegeuk Kim" <jaegeuk@kernel.org>, "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>, "Christoph Hellwig" <hch@infradead.org>, "Miklos Szeredi" <miklos@szeredi.hu>, "Bob Peterson" <rpeterso@redhat.com>, "Andreas Gruenbacher" <agruenba@redhat.com>, "Richard Weinberger" <richard@nod.at>, "Anton Ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes Berg" <johannes@sipsolutions.net>, "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>, "Mike Kravetz" <mike.kravetz@oracle.com>, "Muchun Song" <muchun.song@linux.dev>, "Jan Kara" <jack@suse.cz>, "David Woodhouse" <dwmw2@infradead.org>, "Dave Kleikamp" <shaggy@kernel.org>, "Tejun Heo" <tj@kernel.org>, "Trond Myklebust" <trond.myklebust@hammerspace.com>, "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>, "Neil Brown" <neilb@suse.de>, "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>, "Ryusuke Konishi" <konishi.ryusuke@gmail.com>, "Anton Altaparmakov" <anton@tuxera.com>, "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>, "Mark Fasheh" <mark@fasheh.com>, "Joseph Qi" <joseph.qi@linux.alibaba.com>, "Bob Copeland" <me@bobcopeland.com>, "Mike Marshall" <hubcap@omnibond.com>, "Martin Brandenburg" <martin@omnibond.com>, "Luis Chamberlain" <mcgrof@kernel.org>, "Iurii Zaikin" <yzaikin@google.com>, "Tony Luck" <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "Anders Larsen" <al@alarsen.net>, "Steve French" <sfrench@samba.org>,
 "Paulo Alcantara" <pc@manguebit.com>, "Ronnie Sahlberg" <lsahlber@redhat.com>, "Shyam Prasad N" <sprasad@microsoft.com>, "Sergey Senozhatsky" <senozhatsky@chromium.org>, "Phillip Lougher" <phillip@squashfs.org.uk>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Evgeniy Dushistov" <dushistov@mail.ru>, "Chandan Babu R" <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, "Damien Le Moal" <dlemoal@kernel.org>, "Naohiro Aota" <naohiro.aota@wdc.com>, "Johannes Thumshirn" <jth@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@google.com>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Hugh Dickins" <hughd@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "David S . Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "John Johansen" <john.johansen@canonical.com>, "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Eric Paris" <eparis@parisplace.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, autofs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, linux-efi@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,
 linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org,
 reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-trace-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 86/87] fs: switch timespec64 fields in inode to discrete integers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_084842_794964_3C81808D 
X-CRM114-Status: UNSURE (   7.78  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Fri, 29 Sep 2023 08:36:32 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, Sep 28, 2023, at 07:05, Jeff Layton wrote:
> This shaves 8 bytes off struct inode, according to pahole.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

FWIW, this is similar to the approach that Deepa suggested
back in 2016:

https://lore.kernel.org/lkml/1452144972-15802-3-git-send-email-deepa.kernel@gmail.com/

It was NaKed at the time because of the added complexity,
though it would have been much easier to do it then,
as we had to touch all the timespec references anyway.

The approach still seems ok to me, but I'm not sure it's worth
doing it now if we didn't do it then.

     Arnd

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
