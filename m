Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1SF7Ay-0000LE-Gb
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2012 17:05:48 +0000
Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SF7Ax-0002Nb-J2
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2012 17:05:48 +0000
Received: by lagw12 with SMTP id w12so6658070lag.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 03 Apr 2012 10:05:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F7AFA9E.5020306@debian.org>
References: <E1SEjI8-0007kU-RE@franck.debian.org> <4F7AFA9E.5020306@debian.org>
Date: Tue, 3 Apr 2012 19:05:40 +0200
Message-ID: <CAFLxGvwSVTnoaky43CvUHs8gKT5m5w81YcUw6DC_PTeN2DF+AA@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] UML static linking and embedded library
To: rrs@debian.org
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Apr 3, 2012 at 3:26 PM, Ritesh Raj Sarraf <rrs@debian.org> wrote:
> Hello Richard and others,
>
> I currently have 2 severity E(rrors) lintian rejects for the build I am
> preparing for Debian.
>
> The details for both the rejects are explained at:
>
> http://lintian.debian.org/tags/binary-or-shlib-defines-rpath.html
> http://lintian.debian.org/tags/embedded-library.html
>
>
> Richard, Is this something that can be worked out upstream?

Solving the first issue is straight forward.
For the second one I've to think a bit why Jeff took the current
static linking approach.

Expect patches for both issues in 3.5. :-)

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

