Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlcdF-000668-Vz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 15:28:33 -0800
Received: from [66.205.201.2] (helo=ucontrol.mobiledns.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AlcdF-0000AZ-Iw
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 15:28:33 -0800
From: Steven James <pyro@linuxlabs.com>
Subject: Re: [uml-devel] Kernel idles in loop after loading IPv4
In-Reply-To: <1075236841.15950.10.camel@rocket.innercite.com>
Message-ID: <Pine.LNX.4.58.0401272326020.25787@ucontrol.mobiledns.com>
References: <1075236841.15950.10.camel@rocket.innercite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 27 Jan 2004 23:28:07 +0000 (UTC)
To: Phil Nadeau <phil@innercite.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Greetings,

I ran into that as well, but didn't have time to do much about it. As a
further datapoint, if I disable all net support and pass it
init=/bin/bash, I get the bash prompt (ubd filesystems do get
checked/mounted) but then it goes into the idle loop and stays there.

G'day,
sjames


-------------------------steven james, director of research, linux labs
... ........ ..... ....                    230 peachtree st nw ste 2701
the original linux labs                             atlanta.ga.us 30303
      -since 1995                              http://www.linuxlabs.com
                                   office 404.577.7747 fax 404.577.7743
-----------------------------------------------------------------------


On Tue, 27 Jan 2004, Phil Nadeau wrote:

> Hello UML developers,
>
> I'm trying to use UML to set up a simulator for a high-availability
> cluster. I encounter the following unexpected behavior -
>
> On any kernel that I compile with IPv4 support, the kernel will stop
> intializing drivers after loading IPv4 support. The last message I see
> from the kernel is:
> NET: Registered protocol family 2
>
> Compiling with debug allows me to single-step through the kernel. I've
> traced execution from inet_init(), to synchronize_net(), to
> synchronize_kernel(), to a call to wait_for_completion(), to
> switch_to_tt(), after which the kernel spends all its time in the idle
> loop. This happens whether I'm using SKAS or TT mode.
>
> Host kernel is 2.6.1 with Stephen William's 2.6.1 SKAS patch (thanks
> Stephen). Guest kernel is 2.6.1 with the latest patch from Sourceforge
> (January 15th), without modules, and with nearly everything disabled at
> compile except core functionality and IPv4.
>
> I've tried to find similar cases in the FAQ's and the list archives, but
> I'm not seeing anything. It seems like the kernel is waiting for an
> event related to IPv4 initialization that it never gets, but I'm not
> familiar enough with the kernel proper to know what that might be. Does
> anyone have any ideas?
>
> Thanks in advance.
>
> --
> Phil Nadeau
> Software Services Manager
> phil.nadeau@innercite.com
> (916)932-3200, (800)921-5513
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
