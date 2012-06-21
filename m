Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Shib0-00032r-L2
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jun 2012 14:42:54 +0000
Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Shiaz-0001Bu-MQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jun 2012 14:42:54 +0000
Received: by bkcjm2 with SMTP id jm2so648715bkc.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 21 Jun 2012 07:42:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FE32FBE.4050201@dit.upm.es>
References: <4FE03E76.7090400@dit.upm.es>
	<CAFLxGvwqcM4Ajy+DQdpAO8rgc+X_e919_EXKiA8DkTyUQunTOw@mail.gmail.com>
	<62D36CCF-34D9-4CF9-A563-33D1D5896B73@dit.upm.es>
	<CAFLxGvxHSwzZe_o=NztS+p=-Sz-MhDqM2MzC-3FsO-bXeENG3Q@mail.gmail.com>
	<4FE20217.2080101@dit.upm.es>
	<CAFLxGvw4=mcfqd_0HbP17AR5ZqR-NqMSVgPgFyYamTSu=vgfOQ@mail.gmail.com>
	<4FE32FBE.4050201@dit.upm.es>
Date: Thu, 21 Jun 2012 16:42:47 +0200
Message-ID: <CAFLxGvwE=ecLXN=RLhpSDO9JyDPeS5gr66inS0H2W6soiYUt0A@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] ubd option parsing problem when using cow
 filesystems in kernel 3.4
To: =?ISO-8859-1?Q?David_Fern=E1ndez?= <david@dit.upm.es>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jun 21, 2012 at 4:29 PM, David Fern=E1ndez <david@dit.upm.es> wrote:
>
> What command should I use to revert that specific commit? I'm not an expe=
rt
> in git, in fact I just learnt what a 'git bisect' is after your message
> ...:-)

E.g:
$ git show 026cee00 > sucker.diff
$ patch -p1 -R < sucker.diff

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

