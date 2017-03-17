Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1cow5c-0005zD-LP
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 17:55:00 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cow5b-0007IZ-Oy
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 17:55:00 +0000
References: <0fbc8e03-783e-eed6-8e2e-100f8da6d36e@kot-begemot.co.uk>
	<CAFLxGvx0zpqgbp49DxQ_V8bxLGRKw6ziYstqK7hzcqUUvXuajQ@mail.gmail.com>
	<92e57cd0-8ef6-445d-ec61-a79a6f7a6da8@kot-begemot.co.uk>
	<9f1f1741-76ac-bff7-276b-76167c2bca51@nod.at>
	<5b5d5162-13b0-be10-ab12-7e5b32e7f032@kot-begemot.co.uk>
From: Richard Weinberger <richard@nod.at>
Message-ID: <a7678c4b-d0fe-1ce5-ad70-f08fc20a0298@nod.at>
Date: Fri, 17 Mar 2017 18:54:53 +0100
MIME-Version: 1.0
In-Reply-To: <5b5d5162-13b0-be10-ab12-7e5b32e7f032@kot-begemot.co.uk>
Subject: Re: [uml-devel] UML regression with latest RC 4.11-rc2
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Anton,

Am 17.03.2017 um 18:44 schrieb Anton Ivanov:
>> But you have to enable VM debugging to see it.
> 
> I have most debugging enabled to make sure I do not introduce any
> re-entrancy in the IRQ handlers and/or have any allocations of the wrong
> type where they do not belong.
> 
> We should probably submit a short patch #ifdef to turn this WARN() off
> for UML

Not before we understand the root cause. :)

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

