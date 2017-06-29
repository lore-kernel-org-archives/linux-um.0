Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1dQTpU-0003O8-Ml
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2017 07:25:32 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dQTpS-0005Xx-Cr
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2017 07:25:32 +0000
References: <20170524003232.14319-1-f.fainelli@gmail.com>
	<cda59c31-1487-4c9d-8a6f-152caf93e1d3@gmail.com>
	<dbebd37c-bcae-14d9-445c-9f624008f9fb@nod.at>
	<6ca6b4d6-29e2-19bb-64ef-963d88e89bed@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <9d355537-0b43-9284-c88f-5b68422b2fd2@nod.at>
Date: Thu, 29 Jun 2017 09:25:18 +0200
MIME-Version: 1.0
In-Reply-To: <6ca6b4d6-29e2-19bb-64ef-963d88e89bed@gmail.com>
Content-Language: en-US
Subject: Re: [uml-devel] [PATCH v2] um: Avoid longjmp/setjmp symbol clashes
 with libpthread.a
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

Florian,

Am 29.06.2017 um 00:40 schrieb Florian Fainelli:
>> Hehe, yes.
>> This patch is good, I like it. :)
>> It will part of the next pull request.
> 
> Humm okay, did you apply the patch in one of your kernel trees on
> git.kernel.org or somewhere else?

Will happen soon since the merge window is near where I will post
a pull request...

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

