Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jdike@addtoit.com>) id 1MGPEM-0004ON-CO
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 03:21:02 +0000
Received: from saraswathi.solana.com ([198.99.130.12])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGPEK-0003Xs-9H
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 03:21:02 +0000
Date: Mon, 15 Jun 2009 23:20:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20090616032052.GA15793@c2.user-mode-linux.org>
References: <6599ad830906111202u78bcf043nd0e6a54e7251d8d7@mail.gmail.com>
	<20090616010350.GA14840@c2.user-mode-linux.org>
	<6599ad830906151822v531e0682gbe3ba7f3466768a3@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6599ad830906151822v531e0682gbe3ba7f3466768a3@mail.gmail.com>
Subject: Re: [uml-devel] Building/runing UML in SMP mode
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
To: Paul Menage <menage@google.com>
Cc: Benjamin Blum <bblum@google.com>, user-mode-linux-devel@lists.sourceforge.net

On Mon, Jun 15, 2009 at 06:22:46PM -0700, Paul Menage wrote:
> On Mon, Jun 15, 2009 at 6:03 PM, Jeff Dike<jdike@addtoit.com> wrote:
> >
> > The problem with SMP on skas0
> 
> Does that mean that it works more easily on skas3?

Yup.  That completely avoids ptrace issues.  I think things should
just about work at that point.  When you have multiple threads on
different CPUs running simultaneously, they will just switch
themselves into the appropriate address space.  I can't think of any
problems with this offhand.

> > I actually had this somewhat working, but the code was a horror show,
> > with much nastiness about ignoring the signals that are needed in
> > order to prevent a detached process from running.
> >
> 
> So it's probably not on the horizon any time soon then?

No - I haven't done much with UML in a while...

				Jeff

-- 
Work email - jdike at linux dot intel dot com

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

