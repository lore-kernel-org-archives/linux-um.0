Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UbYrW-0006fW-Sj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 16:11:02 +0000
Received: from mail-wg0-f48.google.com ([74.125.82.48])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UbYrW-0005Pq-2I
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 May 2013 16:11:02 +0000
Received: by mail-wg0-f48.google.com with SMTP id f11so5586429wgh.27
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 May 2013 09:10:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <518FBE6A.50605@gmx.de>
References: <518FB97A.5070907@gmx.de>
	<CAFLxGvzn+Q=D4vjTNuggSTnQKVp0QYLPoHmUwAVBcRbSmD3HWQ@mail.gmail.com>
	<518FBE6A.50605@gmx.de>
Date: Sun, 12 May 2013 18:10:55 +0200
Message-ID: <CAFLxGvyvRb+WD-eLBFnH5O-sXjUdtUkXbKzG6HFqgzm+x2LUow@mail.gmail.com>
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

On Sun, May 12, 2013 at 6:08 PM, Toralf F=F6rster <toralf.foerster@gmx.de> =
wrote:
> On 05/12/2013 05:58 PM, richard -rw- weinberger wrote:
>> Do you have stub_pte_fix.diff applied?
> yes, both the stub and the strnlen patch

Okay, I fear stub_pte_fix.diff does not do the right thing.
/me cooks up a debug patch. Stay tuned.

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

