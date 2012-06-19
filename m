Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <david@dit.upm.es>) id 1Sh6zM-00033w-Vr
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Jun 2012 22:33:32 +0000
Received: from mail.dit.upm.es ([138.4.2.7])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Sh6zJ-0007r9-LQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Jun 2012 22:33:32 +0000
Mime-Version: 1.0 (Apple Message framework v1278)
From: =?iso-8859-1?Q?David_Fern=E1ndez?= <david@dit.upm.es>
In-Reply-To: <CAFLxGvwqcM4Ajy+DQdpAO8rgc+X_e919_EXKiA8DkTyUQunTOw@mail.gmail.com>
Date: Wed, 20 Jun 2012 00:33:21 +0200
Message-Id: <62D36CCF-34D9-4CF9-A563-33D1D5896B73@dit.upm.es>
References: <4FE03E76.7090400@dit.upm.es>
	<CAFLxGvwqcM4Ajy+DQdpAO8rgc+X_e919_EXKiA8DkTyUQunTOw@mail.gmail.com>
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
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


El 19/06/2012, a las 11:03, richard -rw- weinberger escribi=F3:

> On Tue, Jun 19, 2012 at 10:55 AM, David Fern=E1ndez <david@dit.upm.es> wr=
ote:
>> Any idea of the cause of the problem? A simple 'diff' between 3.3 and
>> 3.4 versions shows the option parsing code has changed significantly.
> =

> Can you do a git bisect?

I've some problems with git bisect, but I manage to make the tests manually=
 and the result is:

v3.3.8 -> OK
v3.4-rc1 -> Could not compile (implicit declaration of switch_to function)
v3.4-rc2 -> Could not compile (implicit declaration of switch_to function)
v3.4-rc3 -> Fails

Let me know if I can help with any other test.

Best regards,
David

> =

> -- =

> Thanks,
> //richard


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

