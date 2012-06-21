Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <david@dit.upm.es>) id 1ShiO0-0004RA-G9
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jun 2012 14:29:28 +0000
Received: from mail.dit.upm.es ([138.4.2.7])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ShiNz-0001Ds-1f
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jun 2012 14:29:28 +0000
Message-ID: <4FE32FBE.4050201@dit.upm.es>
Date: Thu, 21 Jun 2012 16:29:18 +0200
From: =?ISO-8859-1?Q?David_Fern=E1ndez?= <david@dit.upm.es>
MIME-Version: 1.0
References: <4FE03E76.7090400@dit.upm.es>
	<CAFLxGvwqcM4Ajy+DQdpAO8rgc+X_e919_EXKiA8DkTyUQunTOw@mail.gmail.com>
	<62D36CCF-34D9-4CF9-A563-33D1D5896B73@dit.upm.es>
	<CAFLxGvxHSwzZe_o=NztS+p=-Sz-MhDqM2MzC-3FsO-bXeENG3Q@mail.gmail.com>
	<4FE20217.2080101@dit.upm.es>
	<CAFLxGvw4=mcfqd_0HbP17AR5ZqR-NqMSVgPgFyYamTSu=vgfOQ@mail.gmail.com>
In-Reply-To: <CAFLxGvw4=mcfqd_0HbP17AR5ZqR-NqMSVgPgFyYamTSu=vgfOQ@mail.gmail.com>
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

On 20/06/12 19:13, richard -rw- weinberger wrote:
> On Wed, Jun 20, 2012 at 7:02 PM, David Fern=E1ndez<david@dit.upm.es>  wro=
te:
>> Finally I managed to do the git bisect with your indications. The result:
>>
>> # git bisect bad
>> 026cee0086fe1df4cf74691cf273062cc769617d is the first bad commit
>> commit 026cee0086fe1df4cf74691cf273062cc769617d
>> Author: Pawel Moll<pawel.moll@arm.com>
>> Date:   Mon Mar 26 12:50:51 2012 +1030
>>
>>     params:<level>_initcall-like kernel parameters
>>
>>     This patch adds a set of macros that can be used to declare
>>     kernel parameters to be parsed _before_ initcalls at a chosen
>>     level are executed.  We rename the now-unused "flags" field of
>>     struct kernel_param as the level.  It's signed, for when we
>>     use this for early params as well, in future.
>>
>>     Linker macro collating init calls had to be modified in order
>>     to add additional symbols between levels that are later used
>>     by the init code to split the calls into blocks.
>>
>>     Signed-off-by: Pawel Moll<pawel.moll@arm.com>
>>     Signed-off-by: Rusty Russell<rusty@rustcorp.com.au>
> Interesting.
> Reverting this commit makes the problem go away?

What command should I use to revert that specific commit? I'm not an =

expert in git, in fact I just learnt what a 'git bisect' is after your =

message ...:-)





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

