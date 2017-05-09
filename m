Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Tue, 09 May 2017 10:15:36 +0200
Message-ID: <20170509101536.Horde.EnvMo4uaHVafhqi80MdUNWc@webmail.your-server.de>
From: Thomas Meyer <thomas@m3y3r.de>
References: <8EF94724-26BB-423D-B75F-1CF6646F72C3@m3y3r.de>
	<CAFLxGvyHNTgYm6FP1LUFV4TSTna4aHTfV+4rEfv55-s0W_9uxA@mail.gmail.com>
	<20170508170235.Horde.YC-JKHq_morEKrQOv2d0DV3@webmail.your-server.de>
	<d46e744a-da30-fe81-fb4d-2a4648550a27@nod.at>
	<76397EFF-15DB-4F55-B402-DBE7BA1FB02D@m3y3r.de>
	<3f832424-0ae6-1009-cf87-c94794e919ef@nod.at>
	<0419DC3A-B4B7-4005-B068-EF0583433B92@m3y3r.de>
	<D39536F2-909A-40FB-B47F-44A31C56D286@m3y3r.de>
	<66f46b90-6312-449f-2c52-d12fc53f18f6@nod.at>
In-Reply-To: <66f46b90-6312-449f-2c52-d12fc53f18f6@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net


Zitat von Richard Weinberger <richard@nod.at>:

> Thomas,
>
> Can you please give the attached patch a try?

Hi,

attached patch work correctly under Linux. But no change under WSL. As  
stated in the relevant GH issue, there seems to be far more road  
blockers to make UML work under WSL.

With you patch I get under WSL:

thomas@DESKTOP-DQBDJ0U:/mnt/c/Users/thomas/VmShare$ ./linux
Core dump limits :
         soft - NONE
         hard - NONE
Checking that ptrace can change system call numbers...check_ptrace :  
failed to modify system call: Invalid Argument

>
> Thanks,
> //richard




------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

