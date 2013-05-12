Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UbdpD-00019v-7G
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 21:28:59 +0000
Received: from mail-wg0-f48.google.com ([74.125.82.48])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UbdpC-00085G-BV
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 21:28:59 +0000
Received: by mail-wg0-f48.google.com with SMTP id f11so5738837wgh.27
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 May 2013 14:28:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvx+8wpBeF_TqOk3JKBEoADAS-NeatpJMuSVvaDhZNqE0g@mail.gmail.com>
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
	<CAFLxGvx+8wpBeF_TqOk3JKBEoADAS-NeatpJMuSVvaDhZNqE0g@mail.gmail.com>
Date: Sun, 12 May 2013 23:28:52 +0200
Message-ID: <CAFLxGvzSEY8iciEONkxNGeO6Lt5v4VcB2sF1XPcqLA=n8PUaAQ@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: multipart/mixed; boundary=089e013d18d2295a7804dc8c163b
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
Subject: Re: [uml-devel] WARNING: at mm/mmap.c:2757 exit_mmap+0x161/0x170()
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--089e013d18d2295a7804dc8c163b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2013 at 10:31 PM, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> On Sun, May 12, 2013 at 10:29 PM, Toralf F=F6rster <toralf.foerster@gmx.d=
e> wrote:
>> On 05/12/2013 09:56 PM, richard -rw- weinberger wrote:
>>> On Sun, May 12, 2013 at 9:53 PM, Toralf F=F6rster <toralf.foerster@gmx.=
de> wrote:
>>>> On 05/12/2013 09:45 PM, richard -rw- weinberger wrote:
>>>>> Damn, we've underrun the counter. :-\
>>>>> Can you please test the attached 3rd debug patch?
>>>>
>>>> yes - but give me a chance and attach a patch ;)
>>>
>>> *grrrr* I'm a way to stupid for that new gmail user interface.
>>>
>>> --
>>> Thanks,
>>> //richard
>>>
>>
>> now it tooks less than 1/4 hour :
>>
>> 2013-05-12T22:27:14.170+02:00 trinity kernel: ------------[ cut here ]--=
----------
>> 2013-05-12T22:27:14.170+02:00 trinity kernel: WARNING: at mm/mmap.c:2757=
 exit_mmap+0x164/0x190()
>> 2013-05-12T22:27:14.170+02:00 trinity kernel: CPU: 0 PID: 1303 Comm: tri=
nity-child1 Not tainted 3.10.0-rc1-dirty #7
>> 2013-05-12T22:27:14.170+02:00 trinity kernel: 3e7f7d9c 3e7f7dc8 0807bfca=
 083d51b0 083d9a66 00000ac5 080eb8f4 080eb8f4
>> 2013-05-12T22:27:14.170+02:00 trinity kernel: 000004f2 3f0ff8c0 4022f53c=
 3e7f7dd8 0807c093 00000009 00000000 3e7f7e10
>> 2013-05-12T22:27:14.170+02:00 trinity kernel: 080eb8f4 083d9a66 00000ac5=
 c0000000 00000000 3e6d7440 3f0ff8c0 00000000 3e7f7d70:  [<08060cff>] show_=
stack+0xcf/0x100
>> 2013-05-12T22:27:14.170+02:00 trinity kernel: 3e7f7d94:  [<0835ed99>] du=
mp_stack+0x26/0x28
>> 2013-05-12T22:27:14.170+02:00 trinity kernel: 3e7f7da4:  [<0807bfca>] wa=
rn_slowpath_common+0x5a/0x80
>> 2013-05-12T22:27:14.170+02:00 trinity kernel: 3e7f7dcc:  [<0807c093>] wa=
rn_slowpath_null+0x23/0x30
>> 2013-05-12T22:27:14.170+02:00 trinity kernel: 3e7f7ddc:  [<080eb8f4>] ex=
it_mmap+0x164/0x190
>> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7e14:  [<0807991d>] mm=
put+0x3d/0xb0
>> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7e28:  [<08081086>] do=
_exit+0x2f6/0x880
>> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7e78:  [<080816f9>] do=
_group_exit+0xa9/0xf0
>> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7ea0:  [<08081759>] Sy=
S_exit_group+0x19/0x20
>> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7eac:  [<08062ac2>] ha=
ndle_syscall+0x82/0xb0
>> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7ef4:  [<0807519d>] us=
erspace+0x46d/0x590
>> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7fec:  [<0805f7fc>] fo=
rk_handler+0x6c/0x70
>> 2013-05-12T22:27:14.172+02:00 trinity kernel: 3e7f7ffc:  [<00000000>] 0x=
0
>> 2013-05-12T22:27:14.172+02:00 trinity kernel:
>> 2013-05-12T22:27:14.172+02:00 trinity kernel: ---[ end trace 44efa740a7c=
c38af ]---
>> 2013-05-12T22:27:14.173+02:00 trinity kernel: XXX mm->nr_ptes: 429496729=
5
>
> Okay, I have to find another solution for the issue. :-\

After a short walk though mm land I've finally found an elegant way to
fix the issue.
Toralf, please test the attached patch.
So far it passed all my tests (calling madvise(), munmap() on the stub VMAs=
).

--
Thanks,
//richard

--089e013d18d2295a7804dc8c163b
Content-Type: application/octet-stream; name="stub_pte_fix4.diff"
Content-Disposition: attachment; filename="stub_pte_fix4.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hgmqiz810

ZGlmZiAtLWdpdCBhL2FyY2gvdW0va2VybmVsL3NrYXMvbW11LmMgYi9hcmNoL3VtL2tlcm5lbC9z
a2FzL21tdS5jCmluZGV4IGZmMDMwNjcuLjAwN2Q1NTAgMTAwNjQ0Ci0tLSBhL2FyY2gvdW0va2Vy
bmVsL3NrYXMvbW11LmMKKysrIGIvYXJjaC91bS9rZXJuZWwvc2thcy9tbXUuYwpAQCAtMTIzLDcg
KzEyMyw3IEBAIHZvaWQgdW1sX3NldHVwX3N0dWJzKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQogCS8q
IGR1cF9tbWFwIGFscmVhZHkgaG9sZHMgbW1hcF9zZW0gKi8KIAllcnIgPSBpbnN0YWxsX3NwZWNp
YWxfbWFwcGluZyhtbSwgU1RVQl9TVEFSVCwgU1RVQl9FTkQgLSBTVFVCX1NUQVJULAogCQkJCSAg
ICAgIFZNX1JFQUQgfCBWTV9NQVlSRUFEIHwgVk1fRVhFQyB8Ci0JCQkJICAgICAgVk1fTUFZRVhF
QyB8IFZNX0RPTlRDT1BZLAorCQkJCSAgICAgIFZNX01BWUVYRUMgfCBWTV9ET05UQ09QWSB8IFZN
X1BGTk1BUCwKIAkJCQkgICAgICBtbS0+Y29udGV4dC5zdHViX3BhZ2VzKTsKIAlpZiAoZXJyKSB7
CiAJCXByaW50ayhLRVJOX0VSUiAiaW5zdGFsbF9zcGVjaWFsX21hcHBpbmcgcmV0dXJuZWQgJWRc
biIsIGVycik7Cg==
--089e013d18d2295a7804dc8c163b
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
--089e013d18d2295a7804dc8c163b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--089e013d18d2295a7804dc8c163b--


