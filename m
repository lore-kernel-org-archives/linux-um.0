Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UbcDI-0006Y8-QF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 19:45:44 +0000
Received: from mail-wg0-f41.google.com ([74.125.82.41])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UbcDH-0005jP-UF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 19:45:44 +0000
Received: by mail-wg0-f41.google.com with SMTP id y10so2283434wgg.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 May 2013 12:45:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <518FE33B.60701@gmx.de>
References: <518FB97A.5070907@gmx.de>
	<CAFLxGvzn+Q=D4vjTNuggSTnQKVp0QYLPoHmUwAVBcRbSmD3HWQ@mail.gmail.com>
	<518FBE6A.50605@gmx.de>
	<CAFLxGvyvRb+WD-eLBFnH5O-sXjUdtUkXbKzG6HFqgzm+x2LUow@mail.gmail.com>
	<CAFLxGvwEiE0dfw9Vju_Xg6mXkF_NH_OU_t7puPceYN42dphTLA@mail.gmail.com>
	<518FE33B.60701@gmx.de>
Date: Sun, 12 May 2013 21:45:37 +0200
Message-ID: <CAFLxGvyiKbbkPAG0h42y1fb=Z6YuboJPdyb+2Xk9Z2YYt7oryg@mail.gmail.com>
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

On Sun, May 12, 2013 at 8:45 PM, Toralf F=F6rster <toralf.foerster@gmx.de> =
wrote:
> On 05/12/2013 06:31 PM, richard -rw- weinberger wrote:
>> Toralf, can you please replace stub_pte_fix.diff with the attached patch?
>
> Hhm,
>
> ok, now it tooks hours than minutes, but  :
>
> 013-05-12T20:37:17.000+02:00 trinity tfoerste: M=3D/mnt/nfs/n22
> 2013-05-12T20:37:17.000+02:00 trinity sshd[2344]: pam_unix(sshd:session):=
 session closed for user tfoerste
> 2013-05-12T20:40:01.000+02:00 trinity cron[2400]: (root) CMD (test -x /us=
r/sbin/run-crons && /usr/sbin/run-crons)
> 2013-05-12T20:40:47.755+02:00 trinity kernel: ------------[ cut here ]---=
---------
> 2013-05-12T20:40:47.755+02:00 trinity kernel: WARNING: at mm/mmap.c:2757 =
exit_mmap+0x164/0x190()
> 2013-05-12T20:40:47.755+02:00 trinity kernel: CPU: 0 PID: 2422 Comm: trin=
ity-child0 Not tainted 3.10.0-rc1-00002-gc17b38f #6
> 2013-05-12T20:40:47.755+02:00 trinity kernel: 408f7d9c 408f7dc8 0807bfba =
083d51b0 083d9a6e 00000ac5 080eb8e4 080eb8e4
> 2013-05-12T20:40:47.755+02:00 trinity kernel: 000007d8 40b026c0 3fdbe93c =
408f7dd8 0807c083 00000009 00000000 408f7e10
> 2013-05-12T20:40:47.755+02:00 trinity kernel: 080eb8e4 083d9a6e 00000ac5 =
c0000000 00000000 25d1f5d8 40b026c0 00000000 408f7d70:  [<08060cff>] show_s=
tack+0xcf/0x100
> 2013-05-12T20:40:47.755+02:00 trinity kernel: 408f7d94:  [<0835ed89>] dum=
p_stack+0x26/0x28
> 2013-05-12T20:40:47.755+02:00 trinity kernel: 408f7da4:  [<0807bfba>] war=
n_slowpath_common+0x5a/0x80
> 2013-05-12T20:40:47.755+02:00 trinity kernel: 408f7dcc:  [<0807c083>] war=
n_slowpath_null+0x23/0x30
> 2013-05-12T20:40:47.755+02:00 trinity kernel: 408f7ddc:  [<080eb8e4>] exi=
t_mmap+0x164/0x190
> 2013-05-12T20:40:47.757+02:00 trinity kernel: 408f7e14:  [<0807990d>] mmp=
ut+0x3d/0xb0
> 2013-05-12T20:40:47.757+02:00 trinity kernel: 408f7e28:  [<08081076>] do_=
exit+0x2f6/0x880
> 2013-05-12T20:40:47.757+02:00 trinity kernel: 408f7e78:  [<080816e9>] do_=
group_exit+0xa9/0xf0
> 2013-05-12T20:40:47.757+02:00 trinity kernel: 408f7ea0:  [<08081749>] SyS=
_exit_group+0x19/0x20
> 2013-05-12T20:40:47.757+02:00 trinity kernel: 408f7eac:  [<08062ab2>] han=
dle_syscall+0x82/0xb0
> 2013-05-12T20:40:47.757+02:00 trinity kernel: 408f7ef4:  [<0807518d>] use=
rspace+0x46d/0x590
> 2013-05-12T20:40:47.757+02:00 trinity kernel: 408f7fec:  [<0805f7fc>] for=
k_handler+0x6c/0x70
> 2013-05-12T20:40:47.757+02:00 trinity kernel: 408f7ffc:  [<00000000>] 0x0
> 2013-05-12T20:40:47.757+02:00 trinity kernel:
> 2013-05-12T20:40:47.757+02:00 trinity kernel: ---[ end trace 610449969e20=
fc68 ]---
> 2013-05-12T20:40:47.758+02:00 trinity kernel: XXX mm->nr_ptes: 4294967295
> 2013-05-12T20:40:50.000+02:00 trinity sshd[2350]: pam_unix(sshd:session):=
 session closed for user tfoerste

Damn, we've underrun the counter. :-\
Can you please test the attached 3rd debug patch?

The problem is that we have to install a mapping for the stub pages.
This mapping must not have a VMA. Otherwise a UML user process could
change this mapping.
So, we have to insert PTEs manually and play nasty games with mm->nr_ptes.

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

