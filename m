Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1ShOTb-0004hZ-PU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2012 17:13:55 +0000
Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ShOTV-0002Kl-S4
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jun 2012 17:13:55 +0000
Received: by lbol5 with SMTP id l5so956343lbo.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 20 Jun 2012 10:13:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FE20217.2080101@dit.upm.es>
References: <4FE03E76.7090400@dit.upm.es>
	<CAFLxGvwqcM4Ajy+DQdpAO8rgc+X_e919_EXKiA8DkTyUQunTOw@mail.gmail.com>
	<62D36CCF-34D9-4CF9-A563-33D1D5896B73@dit.upm.es>
	<CAFLxGvxHSwzZe_o=NztS+p=-Sz-MhDqM2MzC-3FsO-bXeENG3Q@mail.gmail.com>
	<4FE20217.2080101@dit.upm.es>
Date: Wed, 20 Jun 2012 19:13:43 +0200
Message-ID: <CAFLxGvw4=mcfqd_0HbP17AR5ZqR-NqMSVgPgFyYamTSu=vgfOQ@mail.gmail.com>
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

On Wed, Jun 20, 2012 at 7:02 PM, David Fern=E1ndez <david@dit.upm.es> wrote:
> Finally I managed to do the git bisect with your indications. The result:
>
> # git bisect bad
> 026cee0086fe1df4cf74691cf273062cc769617d is the first bad commit
> commit 026cee0086fe1df4cf74691cf273062cc769617d
> Author: Pawel Moll <pawel.moll@arm.com>
> Date: =A0 Mon Mar 26 12:50:51 2012 +1030
>
> =A0 =A0params: <level>_initcall-like kernel parameters
>
> =A0 =A0This patch adds a set of macros that can be used to declare
> =A0 =A0kernel parameters to be parsed _before_ initcalls at a chosen
> =A0 =A0level are executed. =A0We rename the now-unused "flags" field of
> =A0 =A0struct kernel_param as the level. =A0It's signed, for when we
> =A0 =A0use this for early params as well, in future.
>
> =A0 =A0Linker macro collating init calls had to be modified in order
> =A0 =A0to add additional symbols between levels that are later used
> =A0 =A0by the init code to split the calls into blocks.
>
> =A0 =A0Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> =A0 =A0Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Interesting.
Reverting this commit makes the problem go away?

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

