Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Mon, 08 May 2017 17:02:35 +0200
Message-ID: <20170508170235.Horde.YC-JKHq_morEKrQOv2d0DV3@webmail.your-server.de>
From: Thomas Meyer <thomas@m3y3r.de>
References: <8EF94724-26BB-423D-B75F-1CF6646F72C3@m3y3r.de>
	<CAFLxGvyHNTgYm6FP1LUFV4TSTna4aHTfV+4rEfv55-s0W_9uxA@mail.gmail.com>
In-Reply-To: <CAFLxGvyHNTgYm6FP1LUFV4TSTna4aHTfV+4rEfv55-s0W_9uxA@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net


Zitat von Richard Weinberger <richard.weinberger@gmail.com>:

> Thomas,
>
> On Sun, May 7, 2017 at 1:44 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
>> Hi,

Hi,

>>
>> Did anybody try to run UML on the new Windows 10 subsystem for Linux? I
>> wonder what missing functions may hinder to run UML on WSL?
>
> No idea.
> Can you try? I don't have access to a Windows 10 system right now
> where I could test.

Sadly, UML executable bails out very early. it Looks like WSL is  
missing some PTRACE stuff:

thomas@DESKTOP-DQBDJ0U:/mnt/c/Users/thomas/Downloads$ ./linux
Core dump limits :
         soft - NONE
         hard - NONE
Checking that ptrace can change system call numbers...check_ptrace:  
PTRACE_OLDSETOPTIONS failed: Invalid Argument

>
> --
> Thanks,
> //richard
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel




------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

