Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoKBe-0000h6-CO for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 03:27:46 -0800
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CoKBb-0004oa-By for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 03:27:45 -0800
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
In-Reply-To: <200501110135.55716.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0501111222450.12245@filer.marasystems.com>
References: <200501082106.38306.rob@landley.net>
	<200501100120.04746.rob@landley.net>
	<3986.1105370511@marajade.sandelman.ottawa.on.ca>
	<200501110135.55716.rob@landley.net>
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
Date: Tue, 11 Jan 2005 12:27:36 +0100 (CET)
To: Rob Landley <rob@landley.net>
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>, user-mode-linux-devel@lists.sourceforge.net

On Tue, 11 Jan 2005, Rob Landley wrote:

> Don't have a real partition to mount it on, unless I want to cannibalize the
> host system's swap.  I could try ubd if you think it would help.

You are likely to experience less bugs using ubd than hostfs.

> /dev/console attaches to fd0 and fd1.  These are not ttys/ptys but file
> descriptors, hence they controlling tty sends the kill signal to the running
> process still attached to that terminal, which is the vmlinux instance I
> started.

OK. You won't have any easy way of sending Control-C then.

Try booting with the standard stdio console.

Regards
Henrik


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
