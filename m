Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Re: [uml-user] 2.6.13 / cannot set up LDT for
 thread-local storage
In-Reply-To: <2accc2ff0509160423743a1ed6@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0509162245460.22926@filer.marasystems.com>
References: <2accc2ff0509111117747e8639@mail.gmail.com> 
	<2accc2ff0509160423743a1ed6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 16 Sep 2005 22:53:53 +0200 (CEST)
To: Nelson Castillo <nelsoneci@gmail.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Fri, 16 Sep 2005, Nelson Castillo wrote:

>  1) patching init/main.c to add the variable to the environment
>  2) using a wrapper to /sbin/init

Better to just add the variable to the kernel command line.. any 
XX=something string on the command line is set as environment variables to 
init.

> but it seems the environment is just discarded before
> running what is in inittab (I'm not sure, I should read the
> sources later).

It is not, but mingetty/login cleans up the environment on interactive 
logins. Many other commands is also very restrictive about what is 
preserved in the environment when starting childprocesses so relying on 
LD_ASSUME_KERNEL to be globally set for all processes in the whole system 
is generally not a good idea.. (very hard to guarantee).

> sysvinit should have a way to add a variable to the
> environment. Can it be done in intitab?

Not that I know of. But as the environment can be specified on the kernel 
command line this isn't really needed.

> # This module parses /etc/environment (the standard for  setting
> # environ vars) and also allows you to use an extended config
>
> - Do they mean standard in Debian?

No idea what stadard they refer to. It is not in the UNIX standard from 
what I can see.

Regards
Henrik


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
