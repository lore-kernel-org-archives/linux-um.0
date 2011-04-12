Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard.weinberger@gmail.com>) id 1Q9bfs-0003hv-2s
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2011 11:22:24 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q9bfr-0000pL-Cv
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2011 11:22:24 +0000
Received: by iwn10 with SMTP id 10so8890486iwn.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Apr 2011 04:22:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110412131333.52140ee2@sf>
References: <20110409170454.73aada78@sf>
	<BANLkTikkx-jgNDvh5NhhNvM-yWP2X3GgMA@mail.gmail.com>
	<20110412131333.52140ee2@sf>
Date: Tue, 12 Apr 2011 13:22:18 +0200
Message-ID: <BANLkTik9wLxTT5D1_nVu=cR+_vHx6zOsAQ@mail.gmail.com>
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
Subject: Re: [uml-devel] btrfs failure and BUG_ON behaviour
To: Sergei Trofimovich <slyich@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Apr 12, 2011 at 12:13 PM, Sergei Trofimovich <slyich@gmail.com> wro=
te:
> On Tue, 12 Apr 2011 01:13:30 +0200
> richard -rw- weinberger <richard.weinberger@gmail.com> wrote:
>
>> > =A0 Here we have BUG_ON in lookup_inline_extent_backref+0x2dc/0x3f0, b=
ut that pesky
>> > =A0 hard_handler. Is it an UML bug or known and expected behaviour?
>>
>> Can you please test the attached patch?
>> The trace was broken long before I started working on UML.
>
> Attached the BUG backtrace for a crash =A0without and with patch.
> Patched one looks great!

Good.

> The minor nit is Kbuild does not detect headers change, so I had to
> 'make clean' build dir first.

The patch adds only one file and does not touch anything else.
So Kbuild can't detect this.

> Thanks!
>
> --
>
> =A0Sergei
>

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

