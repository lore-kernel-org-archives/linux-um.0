Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Ubcvi-0006pg-Oh
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 20:31:38 +0000
Received: from mail-we0-f170.google.com ([74.125.82.170])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ubcvh-0000Oe-Uw
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 20:31:38 +0000
Received: by mail-we0-f170.google.com with SMTP id u54so5732441wes.29
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 May 2013 13:31:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <518FFBA3.6000800@gmx.de>
References: <518FB97A.5070907@gmx.de>
	<CAFLxGvzn+Q=D4vjTNuggSTnQKVp0QYLPoHmUwAVBcRbSmD3HWQ@mail.gmail.com>
	<518FBE6A.50605@gmx.de>
	<CAFLxGvyvRb+WD-eLBFnH5O-sXjUdtUkXbKzG6HFqgzm+x2LUow@mail.gmail.com>
	<CAFLxGvwEiE0dfw9Vju_Xg6mXkF_NH_OU_t7puPceYN42dphTLA@mail.gmail.com>
	<518FE33B.60701@gmx.de>
	<CAFLxGvyiKbbkPAG0h42y1fb=Z6YuboJPdyb+2Xk9Z2YYt7oryg@mail.gmail.com>
	<518FF354.7020408@gmx.de>
	<CAFLxGvxYjpt6X9MQF3Huh-Sqzm3CBMJAfGb_Qjpqu00iUzj=qg@mail.gmail.com>
	<518FFBA3.6000800@gmx.de>
Date: Sun, 12 May 2013 22:31:31 +0200
Message-ID: <CAFLxGvx+8wpBeF_TqOk3JKBEoADAS-NeatpJMuSVvaDhZNqE0g@mail.gmail.com>
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
Subject: Re: [uml-devel] WARNING: at mm/mmap.c:2757 exit_mmap+0x161/0x170()
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Sun, May 12, 2013 at 10:29 PM, Toralf F=F6rster <toralf.foerster@gmx.de>=
 wrote:
> On 05/12/2013 09:56 PM, richard -rw- weinberger wrote:
>> On Sun, May 12, 2013 at 9:53 PM, Toralf F=F6rster <toralf.foerster@gmx.d=
e> wrote:
>>> On 05/12/2013 09:45 PM, richard -rw- weinberger wrote:
>>>> Damn, we've underrun the counter. :-\
>>>> Can you please test the attached 3rd debug patch?
>>>
>>> yes - but give me a chance and attach a patch ;)
>>
>> *grrrr* I'm a way to stupid for that new gmail user interface.
>>
>> --
>> Thanks,
>> //richard
>>
>
> now it tooks less than 1/4 hour :
>
> 2013-05-12T22:27:14.170+02:00 trinity kernel: ------------[ cut here ]---=
---------
> 2013-05-12T22:27:14.170+02:00 trinity kernel: WARNING: at mm/mmap.c:2757 =
exit_mmap+0x164/0x190()
> 2013-05-12T22:27:14.170+02:00 trinity kernel: CPU: 0 PID: 1303 Comm: trin=
ity-child1 Not tainted 3.10.0-rc1-dirty #7
> 2013-05-12T22:27:14.170+02:00 trinity kernel: 3e7f7d9c 3e7f7dc8 0807bfca =
083d51b0 083d9a66 00000ac5 080eb8f4 080eb8f4
> 2013-05-12T22:27:14.170+02:00 trinity kernel: 000004f2 3f0ff8c0 4022f53c =
3e7f7dd8 0807c093 00000009 00000000 3e7f7e10
> 2013-05-12T22:27:14.170+02:00 trinity kernel: 080eb8f4 083d9a66 00000ac5 =
c0000000 00000000 3e6d7440 3f0ff8c0 00000000 3e7f7d70:  [<08060cff>] show_s=
tack+0xcf/0x100
> 2013-05-12T22:27:14.170+02:00 trinity kernel: 3e7f7d94:  [<0835ed99>] dum=
p_stack+0x26/0x28
> 2013-05-12T22:27:14.170+02:00 trinity kernel: 3e7f7da4:  [<0807bfca>] war=
n_slowpath_common+0x5a/0x80
> 2013-05-12T22:27:14.170+02:00 trinity kernel: 3e7f7dcc:  [<0807c093>] war=
n_slowpath_null+0x23/0x30
> 2013-05-12T22:27:14.170+02:00 trinity kernel: 3e7f7ddc:  [<080eb8f4>] exi=
t_mmap+0x164/0x190
> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7e14:  [<0807991d>] mmp=
ut+0x3d/0xb0
> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7e28:  [<08081086>] do_=
exit+0x2f6/0x880
> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7e78:  [<080816f9>] do_=
group_exit+0xa9/0xf0
> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7ea0:  [<08081759>] SyS=
_exit_group+0x19/0x20
> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7eac:  [<08062ac2>] han=
dle_syscall+0x82/0xb0
> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7ef4:  [<0807519d>] use=
rspace+0x46d/0x590
> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7fec:  [<0805f7fc>] for=
k_handler+0x6c/0x70
> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7ffc:  [<00000000>] 0x0
> 2013-05-12T22:27:14.172+02:00 trinity kernel:
> 2013-05-12T22:27:14.172+02:00 trinity kernel: ---[ end trace 44efa740a7cc=
38af ]---
> 2013-05-12T22:27:14.173+02:00 trinity kernel: XXX mm->nr_ptes: 4294967295

Okay, I have to find another solution for the issue. :-\

--
Thanks,
//richard

---------------------------------------------------------------------------=
---
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and =

their applications. This 200-page book is written by three acclaimed =

leaders in the field. The early access version is available now. =

Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

