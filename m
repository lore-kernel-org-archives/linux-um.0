Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <richard.weinberger@gmail.com>) id 1PK9Pa-00026a-12
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Nov 2010 12:52:54 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PK9PY-0004Pa-1z for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Nov 2010 12:52:53 +0000
Received: by gyd12 with SMTP id 12so954878gyd.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 Nov 2010 04:52:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CE8F332.3050205@meduna.org>
References: <20101118114143.GB23698@cs.unibo.it>
	<AANLkTimYG1jLwJ2tWLonFcoMWaQtaR9RG7HWJDbdE4cS@mail.gmail.com>
	<4CE8F332.3050205@meduna.org>
Date: Sun, 21 Nov 2010 13:52:45 +0100
Message-ID: <AANLkTi=G=gvHBzJOF8nfzV-+82W08jKJ7fxtiirOUb57@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [uml-devel] user-mode-linux-devel@lists.sourceforge.net,
 Jeff Dike <jdike@addtoit.com>
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
To: Stanislav Meduna <stano@meduna.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Nov 21, 2010 at 11:23 AM, Stanislav Meduna <stano@meduna.org> wrote:
> On 21.11.2010 10:35, Geert Uytterhoeven wrote:
>
>>> * user-mode-linux: dead or alive?
>
> >From a plain user's view: basically dead
>
> Why? See e.g. http://user-mode-linux.sourceforge.net/downloads.html
> SKAS3 is against 2.6.23 and unmaintained (my problem with
> skas3 corrupting floating point registers did not get fixed
> two years ago, although I tracked it to the skas3 and
> provided a complete example to reproduce it).
>
> SKAS4 is against 2.6.24 and marked as experimental.

Do we really need SKAS3/4?
SKAS0 is fine for everyone.
When you want a very fast virtualization solution UML is not the
best solution. Even with SKAS3/4.

> So what should a new user searching for a virtualization
> soultion take from it? Maybe there is an active development
> running, but I don't see it, alhough I am following the
> uml-devel.
>
> Having an unmaintained old and experimental new version
> is a sure way to hell for any software product, free
> or non-free...
>
>> Personally, I like UML because
>> =A0 - It's easy to get it running,
>> =A0 - I can run it without needing root access, so I can run it on any
>> Linux machine I have an account on[*],
>> =A0 - I can use it to do things that are limited to root-only, e.g.
>> =A0 =A0 =A0 * create device nodes on file system images,
>> =A0 =A0 =A0 * run wireshark to analyze network communication.
>> =A0 - I even use it to debug/develop code for the Amiga Zorro bus, by
>> adding a fake bus with fake devices ;-)
>
> As a help tool to run at the workstation, yes, by any means
> As a serious tool to virtualize services: no
>
> Regards
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Stano
>
> -------------------------------------------------------------------------=
-----
> Beautiful is writing same markup. Internet Explorer 9 supports
> standards for HTML5, CSS3, SVG 1.1, =A0ECMAScript5, and DOM L2 & L3.
> Spend less time writing and =A0rewriting code and more time creating great
> experiences on the web. Be a part of the beta today
> http://p.sf.net/sfu/msIE9-sfdev2dev
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

