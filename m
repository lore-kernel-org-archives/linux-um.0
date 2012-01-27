Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1RqoCj-0006AU-4g
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jan 2012 15:59:09 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RqoCd-0001Lj-S0
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jan 2012 15:59:09 +0000
Received: by mail-tul01m020-f175.google.com with SMTP id uo9so2655758obb.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 27 Jan 2012 07:59:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADBe2Pxk--RJHAp=FyAaeJkx+UO-+St=+J1sfyPn+DzVwyEhew@mail.gmail.com>
References: <CADBe2Pxk--RJHAp=FyAaeJkx+UO-+St=+J1sfyPn+DzVwyEhew@mail.gmail.com>
Date: Fri, 27 Jan 2012 16:59:03 +0100
Message-ID: <CAFLxGvwYzmHGi5z2RdhvjvKTf1Z+Dm3h61bVvAkED6OWGLkMvw@mail.gmail.com>
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
Subject: Re: [uml-devel] rw semaphore lost wakeup in x86_64
To: SeongHan Seo <long21s@gmail.com>
Cc: allsky@gmail.com, user-mode-linux-devel@lists.sourceforge.net, sangho1206.park@samsung.com

Hi,

On Fri, Jan 27, 2012 at 5:07 AM, SeongHan Seo <long21s@gmail.com> wrote:
> I discovered a bug in your =A0X86_64 configuration system a while back wh=
ich
> involves lost wakeups for rw semaphores
>
> In what follows is an analysis of the problem
>
> and I'd be much obliged if you'd commit it to the mainline kernel
>
> The Kernel in question is 2.6.35.14
>

Hmm, looks like this bug got already fixed by commit bfc39061 (um,
x86-64: Fix UML build after adding CFI annotations to lib/rwsem_64.S)

Can you please confirm?

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Try before you buy =3D See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

