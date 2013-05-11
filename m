Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Ub9zN-0003O0-HN
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 13:37:29 +0000
Received: from mail-wg0-f46.google.com ([74.125.82.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ub9zM-0000se-Ei
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 13:37:29 +0000
Received: by mail-wg0-f46.google.com with SMTP id n12so4779132wgh.13
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 11 May 2013 06:37:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvzNEcgwDcB2B1Qpo4isppm6u_w60tzLY0Sah5Sj4T_Q4A@mail.gmail.com>
References: <CAFLxGvwen6WwNoh3iZ2j+dK8iQsxVkjhnvaXjdfXATF+mmwtuw@mail.gmail.com>
	<518E02FB.6040808@gmx.de>
	<CAFLxGvxM_zK11csqpFmVw9q1sPTb1nO0=L5r0AUxf9F4mtfXsg@mail.gmail.com>
	<518E14B7.3030409@gmx.de> <20130511140139.1e6ee40b@sf>
	<CAFLxGvz1OO4Zet_Yq1GCwDz4D2FKygs45-H4UY_fyJ-SZ5weXQ@mail.gmail.com>
	<CAFLxGvzPCs3-RC34yxbdDCJOC17nBuhiMQV49wH2zth2JYM0+Q@mail.gmail.com>
	<518E455A.3010105@gmx.de>
	<CAFLxGvzNEcgwDcB2B1Qpo4isppm6u_w60tzLY0Sah5Sj4T_Q4A@mail.gmail.com>
Date: Sat, 11 May 2013 15:37:22 +0200
Message-ID: <CAFLxGvwNQBYaRcdugqAafF2iDBEweG51CjWzA9WK1vqz4G3gAw@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: multipart/mixed; boundary=f46d043893cd1bd63504dc71621f
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

--f46d043893cd1bd63504dc71621f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2013 at 3:26 PM, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> On Sat, May 11, 2013 at 3:19 PM, Toralf F=F6rster <toralf.foerster@gmx.de=
> wrote:
>> On 05/11/2013 02:27 PM, richard -rw- weinberger wrote:
>>> On Sat, May 11, 2013 at 2:26 PM, richard -rw- weinberger
>>> <richard.weinberger@gmail.com> wrote:
>>>> On Sat, May 11, 2013 at 1:01 PM, Sergei Trofimovic>> Toralf, please us=
e the attached patch.
>>>> Maybe it helps us.
>>>> In theory we call kmalloc() with at most PAGE_SIZE, which is okay.
>>>
>>> fixing -ENOATTACHMENT...
>>
>> applying that patch on top of Linus' tree (v3.9-12555-g2dbd3ca) gives :
>>
>>
>> 2013-05-11T15:15:37.166+02:00 trinity kernel: strndup_user_debug: strnle=
n_user() returned: 5
>> 2013-05-11T15:15:37.166+02:00 trinity kernel: strndup_user_debug: callin=
g memdup_user() with length: 5
>> 2013-05-11T15:15:37.166+02:00 trinity kernel: strndup_user_debug: strnle=
n_user() returned: 12
>> 2013-05-11T15:15:37.166+02:00 trinity kernel: strndup_user_debug: callin=
g memdup_user() with length: 12
>> 2013-05-11T15:15:37.166+02:00 trinity kernel: strndup_user_debug: strnle=
n_user() returned: 12
>> 2013-05-11T15:15:37.166+02:00 trinity kernel: strndup_user_debug: callin=
g memdup_user() with length: 12
>> 2013-05-11T15:15:37.000+02:00 trinity haveged: haveged starting up
>> 2013-05-11T15:15:37.000+02:00 trinity haveged: haveged: Completed tot pr=
ocedure B after 1171643 bytes
>> 2013-05-11T15:15:38.000+02:00 trinity dhcpcd[777]: version 5.6.4 startin=
g
>> 2013-05-11T15:15:38.000+02:00 trinity dhcpcd[777]: ipv6_open: Address fa=
mily not supported by protocol
>> 2013-05-11T15:15:38.000+02:00 trinity haveged: haveged: Completed tot pr=
ocedure A after 1035716 bytes
>> 2013-05-11T15:15:38.000+02:00 trinity haveged: haveged: version: 1.5; ar=
ch: x86; vendor: GenuineIntel; cores: 1/1, buffer: 128
>> 2013-05-11T15:15:38.000+02:00 trinity haveged: haveged: d_cache: 32K (00=
0020), i_cache: 32K (000020), i_index: 19/40, i_size: 32653/60731
>> 2013-05-11T15:15:38.000+02:00 trinity haveged: haveged: tot tests: BA8, =
continuous tests: B
>> 2013-05-11T15:15:38.000+02:00 trinity haveged: haveged: Completed contin=
uous procedure B after 1171643 bytes
>> 2013-05-11T15:15:38.000+02:00 trinity dhcpcd[777]: eth0: rebinding lease=
 of 192.168.1.63
>> 2013-05-11T15:15:38.000+02:00 trinity dhcpcd[777]: eth0: acknowledged 19=
2.168.1.63 from 192.168.0.254
>> 2013-05-11T15:15:38.000+02:00 trinity dhcpcd[777]: eth0: checking for 19=
2.168.1.63
>> 2013-05-11T15:15:43.000+02:00 trinity dhcpcd[777]: eth0: leased 192.168.=
1.63 for infinity
>> 2013-05-11T15:15:43.000+02:00 trinity dhcpcd[777]: forked to background,=
 child pid 811
>> 2013-05-11T15:15:44.000+02:00 trinity cron[855]: (CRON) STARTUP (V5.0)
>> 2013-05-11T15:15:44.944+02:00 trinity kernel: Virtual console 1 assigned=
 device '/dev/pts/6'
>> 2013-05-11T15:16:01.000+02:00 trinity sshd[874]: pam_unix(sshd:session):=
 session opened for user tfoerste by (uid=3D0)
>> 2013-05-11T15:16:02.827+02:00 trinity kernel: strndup_user_debug: strnle=
n_user() returned: 1
>> 2013-05-11T15:16:02.827+02:00 trinity kernel: strndup_user_debug: callin=
g memdup_user() with length: 1
>> 2013-05-11T15:16:02.827+02:00 trinity kernel: strndup_user_debug: strnle=
n_user() returned: 25
>> 2013-05-11T15:16:02.827+02:00 trinity kernel: strndup_user_debug: callin=
g memdup_user() with length: 25
>> 2013-05-11T15:16:02.827+02:00 trinity kernel: strndup_user_debug: strnle=
n_user() returned: -14
>> 2013-05-11T15:16:02.827+02:00 trinity kernel: ------------[ cut here ]--=
----------
>> 2013-05-11T15:16:02.827+02:00 trinity kernel: WARNING: at mm/slab_common=
.c:376 kmalloc_slab+0x33/0x80()
>> 2013-05-11T15:16:02.827+02:00 trinity kernel: CPU: 0 PID: 880 Comm: trin=
ity-child0 Not tainted 3.9.0-12555-g2dbd3ca-dirty #1
>> 2013-05-11T15:16:02.827+02:00 trinity kernel: 40db7da0 40db7dcc 0807bfca=
 083d3e6c 083d8623 00000178 080e1273 080e1273
>> 2013-05-11T15:16:02.827+02:00 trinity kernel: ffffffea 000000d0 00001000=
 40db7ddc 0807c093 00000009 00000000 40db7df0
>> 2013-05-11T15:16:02.835+02:00 trinity kernel: 080e1273 083d8623 00000178=
 00000000 40db7e14 080fac7b fffffff2 000000d0 40db7d74:  [<08060cff>] show_=
stack+0xcf/0x100
>> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7d98:  [<0835d63a>] du=
mp_stack+0x26/0x28
>> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7da8:  [<0807bfca>] wa=
rn_slowpath_common+0x5a/0x80
>> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7dd0:  [<0807c093>] wa=
rn_slowpath_null+0x23/0x30
>> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7de0:  [<080e1273>] km=
alloc_slab+0x33/0x80
>> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7df4:  [<080fac7b>] __=
kmalloc_track_caller+0x1b/0x110
>> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7e18:  [<080de1a6>] me=
mdup_user+0x26/0x70
>> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7e34:  [<080de3de>] st=
rndup_user_debug+0x6e/0xb0
>> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7e58:  [<0811dd48>] co=
py_mount_string+0x38/0x50
>> 2013-05-11T15:16:02.835+02:00 trinity kernel: 40db7e70:  [<0811e760>] Sy=
S_mount+0x30/0xf0
>> 2013-05-11T15:16:02.842+02:00 trinity kernel: 40db7eac:  [<08062ac2>] ha=
ndle_syscall+0x82/0xb0
>> 2013-05-11T15:16:02.842+02:00 trinity kernel: 40db7ef4:  [<0807519d>] us=
erspace+0x46d/0x590
>> 2013-05-11T15:16:02.842+02:00 trinity kernel: 40db7fec:  [<0805f7fc>] fo=
rk_handler+0x6c/0x70
>> 2013-05-11T15:16:02.842+02:00 trinity kernel: 40db7ffc:  [<00000000>] 0x=
0
>> 2013-05-11T15:16:02.842+02:00 trinity kernel:
>> 2013-05-11T15:16:02.842+02:00 trinity kernel: ---[ end trace 06fc96a70dc=
a162e ]---
>> 2013-05-11T15:16:02.842+02:00 trinity kernel: strndup_user_debug: callin=
g memdup_user() with length: -14
>> 2013-05-11T15:16:02.842+02:00 trinity kernel: strndup_user_debug: strnle=
n_user() returned: -14
>> 2013-05-11T15:16:02.842+02:00 trinity kernel: strndup_user_debug: callin=
g memdup_user() with length: -14
>> 2013-05-11T15:16:02.842+02:00 trinity kernel: strndup_user_debug: strnle=
n_user() returned: 16
>> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: callin=
g memdup_user() with length: 16
>> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: strnle=
n_user() returned: 1
>> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: callin=
g memdup_user() with length: 1
>> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: strnle=
n_user() returned: 70
>> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: callin=
g memdup_user() with length: 70
>> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: strnle=
n_user() returned: -14
>> 2013-05-11T15:16:02.850+02:00 trinity kernel: strndup_user_debug: callin=
g memdup_user() with length: -14
>>
>> --
>> MfG/Sincerely
>> Toralf F=F6rster
>> pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
>
> Does the attached patch fix the problem?

Found the real problem, UML's strnlen_user() is broken.
Please test the attached patch.

--
Thanks,
//richard

--f46d043893cd1bd63504dc71621f
Content-Type: application/octet-stream; name="um_strnlen_user.patch"
Content-Disposition: attachment; filename="um_strnlen_user.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hgku8vzj1

ZGlmZiAtLWdpdCBhL2FyY2gvdW0va2VybmVsL3NrYXMvdWFjY2Vzcy5jIGIvYXJjaC91bS9rZXJu
ZWwvc2thcy91YWNjZXNzLmMKaW5kZXggMWQzZTBjMS4uNGZmYjY0NCAxMDA2NDQKLS0tIGEvYXJj
aC91bS9rZXJuZWwvc2thcy91YWNjZXNzLmMKKysrIGIvYXJjaC91bS9rZXJuZWwvc2thcy91YWNj
ZXNzLmMKQEAgLTI1NCw2ICsyNTQsNiBAQCBpbnQgc3Rybmxlbl91c2VyKGNvbnN0IHZvaWQgX191
c2VyICpzdHIsIGludCBsZW4pCiAJbiA9IGJ1ZmZlcl9vcCgodW5zaWduZWQgbG9uZykgc3RyLCBs
ZW4sIDAsIHN0cm5sZW5fY2h1bmssICZjb3VudCk7CiAJaWYgKG4gPT0gMCkKIAkJcmV0dXJuIGNv
dW50ICsgMTsKLQlyZXR1cm4gLUVGQVVMVDsKKwlyZXR1cm4gMDsKIH0KIEVYUE9SVF9TWU1CT0wo
c3Rybmxlbl91c2VyKTsK
--f46d043893cd1bd63504dc71621f
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
--f46d043893cd1bd63504dc71621f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--f46d043893cd1bd63504dc71621f--


