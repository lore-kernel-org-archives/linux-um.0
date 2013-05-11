Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Ub9pJ-00017y-0Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 13:27:05 +0000
Received: from mail-we0-f178.google.com ([74.125.82.178])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ub9pH-0000Tf-S7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 13:27:04 +0000
Received: by mail-we0-f178.google.com with SMTP id q57so4795417wes.37
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 11 May 2013 06:26:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <518E455A.3010105@gmx.de>
References: <CAFLxGvwen6WwNoh3iZ2j+dK8iQsxVkjhnvaXjdfXATF+mmwtuw@mail.gmail.com>
	<518E02FB.6040808@gmx.de>
	<CAFLxGvxM_zK11csqpFmVw9q1sPTb1nO0=L5r0AUxf9F4mtfXsg@mail.gmail.com>
	<518E14B7.3030409@gmx.de> <20130511140139.1e6ee40b@sf>
	<CAFLxGvz1OO4Zet_Yq1GCwDz4D2FKygs45-H4UY_fyJ-SZ5weXQ@mail.gmail.com>
	<CAFLxGvzPCs3-RC34yxbdDCJOC17nBuhiMQV49wH2zth2JYM0+Q@mail.gmail.com>
	<518E455A.3010105@gmx.de>
Date: Sat, 11 May 2013 15:26:57 +0200
Message-ID: <CAFLxGvzNEcgwDcB2B1Qpo4isppm6u_w60tzLY0Sah5Sj4T_Q4A@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: multipart/mixed; boundary=f46d04389247e2363204dc713c3f
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Fwd: Re: [uml-user] WARNING: at
	mm/slab_common.c:376 kmalloc_slab+0x33/0x80()
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: Dave Jones <davej@redhat.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--f46d04389247e2363204dc713c3f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2013 at 3:19 PM, Toralf F=F6rster <toralf.foerster@gmx.de> =
wrote:
> On 05/11/2013 02:27 PM, richard -rw- weinberger wrote:
>> On Sat, May 11, 2013 at 2:26 PM, richard -rw- weinberger
>> <richard.weinberger@gmail.com> wrote:
>>> On Sat, May 11, 2013 at 1:01 PM, Sergei Trofimovic>> Toralf, please use=
 the attached patch.
>>> Maybe it helps us.
>>> In theory we call kmalloc() with at most PAGE_SIZE, which is okay.
>>
>> fixing -ENOATTACHMENT...
>
> applying that patch on top of Linus' tree (v3.9-12555-g2dbd3ca) gives :
>
>
> 2013-05-11T15:15:37.166+02:00 trinity kernel: strndup_user_debug: strnlen=
_user() returned: 5
> 2013-05-11T15:15:37.166+02:00 trinity kernel: strndup_user_debug: calling=
 memdup_user() with length: 5
> 2013-05-11T15:15:37.166+02:00 trinity kernel: strndup_user_debug: strnlen=
_user() returned: 12
> 2013-05-11T15:15:37.166+02:00 trinity kernel: strndup_user_debug: calling=
 memdup_user() with length: 12
> 2013-05-11T15:15:37.166+02:00 trinity kernel: strndup_user_debug: strnlen=
_user() returned: 12
> 2013-05-11T15:15:37.166+02:00 trinity kernel: strndup_user_debug: calling=
 memdup_user() with length: 12
> 2013-05-11T15:15:37.000+02:00 trinity haveged: haveged starting up
> 2013-05-11T15:15:37.000+02:00 trinity haveged: haveged: Completed tot pro=
cedure B after 1171643 bytes
> 2013-05-11T15:15:38.000+02:00 trinity dhcpcd[777]: version 5.6.4 starting
> 2013-05-11T15:15:38.000+02:00 trinity dhcpcd[777]: ipv6_open: Address fam=
ily not supported by protocol
> 2013-05-11T15:15:38.000+02:00 trinity haveged: haveged: Completed tot pro=
cedure A after 1035716 bytes
> 2013-05-11T15:15:38.000+02:00 trinity haveged: haveged: version: 1.5; arc=
h: x86; vendor: GenuineIntel; cores: 1/1, buffer: 128
> 2013-05-11T15:15:38.000+02:00 trinity haveged: haveged: d_cache: 32K (000=
020), i_cache: 32K (000020), i_index: 19/40, i_size: 32653/60731
> 2013-05-11T15:15:38.000+02:00 trinity haveged: haveged: tot tests: BA8, c=
ontinuous tests: B
> 2013-05-11T15:15:38.000+02:00 trinity haveged: haveged: Completed continu=
ous procedure B after 1171643 bytes
> 2013-05-11T15:15:38.000+02:00 trinity dhcpcd[777]: eth0: rebinding lease =
of 192.168.1.63
> 2013-05-11T15:15:38.000+02:00 trinity dhcpcd[777]: eth0: acknowledged 192=
.168.1.63 from 192.168.0.254
> 2013-05-11T15:15:38.000+02:00 trinity dhcpcd[777]: eth0: checking for 192=
.168.1.63
> 2013-05-11T15:15:43.000+02:00 trinity dhcpcd[777]: eth0: leased 192.168.1=
.63 for infinity
> 2013-05-11T15:15:43.000+02:00 trinity dhcpcd[777]: forked to background, =
child pid 811
> 2013-05-11T15:15:44.000+02:00 trinity cron[855]: (CRON) STARTUP (V5.0)
> 2013-05-11T15:15:44.944+02:00 trinity kernel: Virtual console 1 assigned =
device '/dev/pts/6'
> 2013-05-11T15:16:01.000+02:00 trinity sshd[874]: pam_unix(sshd:session): =
session opened for user tfoerste by (uid=3D0)
> 2013-05-11T15:16:02.827+02:00 trinity kernel: strndup_user_debug: strnlen=
_user() returned: 1
> 2013-05-11T15:16:02.827+02:00 trinity kernel: strndup_user_debug: calling=
 memdup_user() with length: 1
> 2013-05-11T15:16:02.827+02:00 trinity kernel: strndup_user_debug: strnlen=
_user() returned: 25
> 2013-05-11T15:16:02.827+02:00 trinity kernel: strndup_user_debug: calling=
 memdup_user() with length: 25
> 2013-05-11T15:16:02.827+02:00 trinity kernel: strndup_user_debug: strnlen=
_user() returned: -14
> 2013-05-11T15:16:02.827+02:00 trinity kernel: ------------[ cut here ]---=
---------
> 2013-05-11T15:16:02.827+02:00 trinity kernel: WARNING: at mm/slab_common.=
c:376 kmalloc_slab+0x33/0x80()
> 2013-05-11T15:16:02.827+02:00 trinity kernel: CPU: 0 PID: 880 Comm: trini=
ty-child0 Not tainted 3.9.0-12555-g2dbd3ca-dirty #1
> 2013-05-11T15:16:02.827+02:00 trinity kernel: 40db7da0 40db7dcc 0807bfca =
083d3e6c 083d8623 00000178 080e1273 080e1273
> 2013-05-11T15:16:02.827+02:00 trinity kernel: ffffffea 000000d0 00001000 =
40db7ddc 0807c093 00000009 00000000 40db7df0
> 2013-05-11T15:16:02.835+02:00 trinity kernel: 080e1273 083d8623 00000178 =
00000000 40db7e14 080fac7b fffffff2 000000d0 40db7d74:  [<08060cff>] show_s=
tack+0xcf/0x100
> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7d98:  [<0835d63a>] dum=
p_stack+0x26/0x28
> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7da8:  [<0807bfca>] war=
n_slowpath_common+0x5a/0x80
> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7dd0:  [<0807c093>] war=
n_slowpath_null+0x23/0x30
> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7de0:  [<080e1273>] kma=
lloc_slab+0x33/0x80
> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7df4:  [<080fac7b>] __k=
malloc_track_caller+0x1b/0x110
> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7e18:  [<080de1a6>] mem=
dup_user+0x26/0x70
> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7e34:  [<080de3de>] str=
ndup_user_debug+0x6e/0xb0
> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7e58:  [<0811dd48>] cop=
y_mount_string+0x38/0x50
> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7e70:  [<0811e760>] SyS=
_mount+0x30/0xf0
> 2013-05-11T15:16:02.842+02:00 trinity kernel: 40db7eac:  [<08062ac2>] han=
dle_syscall+0x82/0xb0
> 2013-05-11T15:16:02.842+02:00 trinity kernel: 40db7ef4:  [<0807519d>] use=
rspace+0x46d/0x590
> 2013-05-11T15:16:02.842+02:00 trinity kernel: 40db7fec:  [<0805f7fc>] for=
k_handler+0x6c/0x70
> 2013-05-11T15:16:02.842+02:00 trinity kernel: 40db7ffc:  [<00000000>] 0x0
> 2013-05-11T15:16:02.842+02:00 trinity kernel:
> 2013-05-11T15:16:02.842+02:00 trinity kernel: ---[ end trace 06fc96a70dca=
162e ]---
> 2013-05-11T15:16:02.842+02:00 trinity kernel: strndup_user_debug: calling=
 memdup_user() with length: -14
> 2013-05-11T15:16:02.842+02:00 trinity kernel: strndup_user_debug: strnlen=
_user() returned: -14
> 2013-05-11T15:16:02.842+02:00 trinity kernel: strndup_user_debug: calling=
 memdup_user() with length: -14
> 2013-05-11T15:16:02.842+02:00 trinity kernel: strndup_user_debug: strnlen=
_user() returned: 16
> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: calling=
 memdup_user() with length: 16
> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: strnlen=
_user() returned: 1
> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: calling=
 memdup_user() with length: 1
> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: strnlen=
_user() returned: 70
> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: calling=
 memdup_user() with length: 70
> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: strnlen=
_user() returned: -14
> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: calling=
 memdup_user() with length: -14
>
> --
> MfG/Sincerely
> Toralf F=F6rster
> pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

Does the attached patch fix the problem?

--
Thanks,
//richard

--f46d04389247e2363204dc713c3f
Content-Type: application/octet-stream; name="test.patch"
Content-Disposition: attachment; filename="test.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hgktvj7h0

ZGlmZiAtLWdpdCBhL21tL3V0aWwuYyBiL21tL3V0aWwuYwppbmRleCBhYjE0MjRkLi5jNGViNDM5
IDEwMDY0NAotLS0gYS9tbS91dGlsLmMKKysrIGIvbW0vdXRpbC5jCkBAIC0yMTAsNyArMjEwLDcg
QEAgY2hhciAqc3RybmR1cF91c2VyKGNvbnN0IGNoYXIgX191c2VyICpzLCBsb25nIG4pCiAKIAls
ZW5ndGggPSBzdHJubGVuX3VzZXIocywgbik7CiAKLQlpZiAoIWxlbmd0aCkKKwlpZiAobGVuZ3Ro
IDwgMSkKIAkJcmV0dXJuIEVSUl9QVFIoLUVGQVVMVCk7CiAKIAlpZiAobGVuZ3RoID4gbikK
--f46d04389247e2363204dc713c3f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
--f46d04389247e2363204dc713c3f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--f46d04389247e2363204dc713c3f--


