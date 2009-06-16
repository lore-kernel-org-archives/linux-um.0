Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <menage@google.com>) id 1MGO8s-0000RX-0m
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 02:11:18 +0000
Received: from smtp-out.google.com ([216.239.45.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGO8m-0000fI-Vz
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 02:11:17 +0000
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com
	[172.24.198.77]) by smtp-out.google.com with ESMTP id n5G1Mntj002199
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 15 Jun 2009 18:22:49 -0700
Received: from yw-out-1718.google.com (ywa6.prod.google.com [10.192.1.6])
	by wpaz13.hot.corp.google.com with ESMTP id n5G1MkYq008676
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 15 Jun 2009 18:22:47 -0700
Received: by yw-out-1718.google.com with SMTP id 6so1999864ywa.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 15 Jun 2009 18:22:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090616010350.GA14840@c2.user-mode-linux.org>
References: <6599ad830906111202u78bcf043nd0e6a54e7251d8d7@mail.gmail.com>
	<20090616010350.GA14840@c2.user-mode-linux.org>
Date: Mon, 15 Jun 2009 18:22:46 -0700
Message-ID: <6599ad830906151822v531e0682gbe3ba7f3466768a3@mail.gmail.com>
From: Paul Menage <menage@google.com>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Benjamin Blum <bblum@google.com>, user-mode-linux-devel@lists.sourceforge.net

On Mon, Jun 15, 2009 at 6:03 PM, Jeff Dike<jdike@addtoit.com> wrote:
>
> The problem with SMP on skas0

Does that mean that it works more easily on skas3?

> I actually had this somewhat working, but the code was a horror show,
> with much nastiness about ignoring the signals that are needed in
> order to prevent a detached process from running.
>

So it's probably not on the horizon any time soon then?

Thanks,

Paul

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

