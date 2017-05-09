Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1d89Fg-0004j6-9r
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2017 17:48:48 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d89Fe-00033M-7g
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2017 17:48:48 +0000
References: <8EF94724-26BB-423D-B75F-1CF6646F72C3@m3y3r.de>
	<CAFLxGvyHNTgYm6FP1LUFV4TSTna4aHTfV+4rEfv55-s0W_9uxA@mail.gmail.com>
	<20170508170235.Horde.YC-JKHq_morEKrQOv2d0DV3@webmail.your-server.de>
	<d46e744a-da30-fe81-fb4d-2a4648550a27@nod.at>
	<76397EFF-15DB-4F55-B402-DBE7BA1FB02D@m3y3r.de>
	<3f832424-0ae6-1009-cf87-c94794e919ef@nod.at>
	<0419DC3A-B4B7-4005-B068-EF0583433B92@m3y3r.de>
	<D39536F2-909A-40FB-B47F-44A31C56D286@m3y3r.de>
	<66f46b90-6312-449f-2c52-d12fc53f18f6@nod.at>
	<20170509101536.Horde.EnvMo4uaHVafhqi80MdUNWc@webmail.your-server.de>
	<0c36ac98-761a-bf07-a6ef-13f0f7b7b561@nod.at>
	<20170509192508.Horde.q9LPitc8upyg8NEM65B6nWV@webmail.your-server.de>
From: Richard Weinberger <richard@nod.at>
Message-ID: <36c34fce-894c-d9e0-05c2-4f869f22101e@nod.at>
Date: Tue, 9 May 2017 19:48:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170509192508.Horde.q9LPitc8upyg8NEM65B6nWV@webmail.your-server.de>
Subject: Re: [uml-devel] [uml-user] UML on WSL
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
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Thomas,

Am 09.05.2017 um 19:25 schrieb Thomas Meyer:
>> IOW we write to 0xdeadbeef, catch the fault and fix it.
> 
> I get this:
> thomas@DESKTOP-DQBDJ0U:/mnt/c/Users/thomas/VmShare$ ./segtest
> SIGSEGV at 0x0, fixing up
> SIGSEGV at 0x0, fixing up
> SIGSEGV at 0x0, fixing up
> SIGSEGV at 0x0, fixing up
> SIGSEGV at 0x0, fixing up
> SIGSEGV at 0x0, fixing up
> SIGSEGV at 0x0, fixing up
> SIGSEGV at 0x0, fixing up
> SIGSEGV at 0x0, fixing up
> SIGSEGV at 0x0, fixing up
> SIGSEGV at 0x0, fixing up
> SIGSEGV at 0x0, fixing up
> SIGSEGV at 0x0, fixing up
> SIGSEGV at 0x0, fixing up

Meh, that's a show-stopper.
WSL does not provide a valid signal machine context...

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

