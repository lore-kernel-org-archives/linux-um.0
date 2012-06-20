Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1ShFB0-0001lz-S5
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2012 07:18:06 +0000
Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ShFAw-00069u-Vr
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2012 07:18:06 +0000
Received: by lbol5 with SMTP id l5so204744lbo.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 20 Jun 2012 00:17:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <62D36CCF-34D9-4CF9-A563-33D1D5896B73@dit.upm.es>
References: <4FE03E76.7090400@dit.upm.es>
	<CAFLxGvwqcM4Ajy+DQdpAO8rgc+X_e919_EXKiA8DkTyUQunTOw@mail.gmail.com>
	<62D36CCF-34D9-4CF9-A563-33D1D5896B73@dit.upm.es>
Date: Wed, 20 Jun 2012 09:17:56 +0200
Message-ID: <CAFLxGvxHSwzZe_o=NztS+p=-Sz-MhDqM2MzC-3FsO-bXeENG3Q@mail.gmail.com>
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

On Wed, Jun 20, 2012 at 12:33 AM, David Fern=E1ndez <david@dit.upm.es> wrot=
e:
>
> El 19/06/2012, a las 11:03, richard -rw- weinberger escribi=F3:
>
>> On Tue, Jun 19, 2012 at 10:55 AM, David Fern=E1ndez <david@dit.upm.es> w=
rote:
>>> Any idea of the cause of the problem? A simple 'diff' between 3.3 and
>>> 3.4 versions shows the option parsing code has changed significantly.
>>
>> Can you do a git bisect?
>
> I've some problems with git bisect, but I manage to make the tests manual=
ly and the result is:

You have to bisect between v3.3 (Linus' tree) and v3.4-rc1.
To make 3.4-rc1 compile you have to always to apply a fix.
AFAIK the commit a3a85a763 (um: Disintegrate asm/system.h) fixes this.

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

