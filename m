Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnvDm-0004dP-9W for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 00:48:18 -0800
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CnvDh-0003u4-Iu for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 00:48:18 -0800
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
In-Reply-To: <200501100120.04746.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0501100923131.22992@filer.marasystems.com>
References: <200501082106.38306.rob@landley.net>
	<31487.1105315534@marajade.sandelman.ottawa.on.ca>
	<200501100120.04746.rob@landley.net>
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
Date: Mon, 10 Jan 2005 09:48:02 +0100 (CET)
To: Rob Landley <rob@landley.net>
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 10 Jan 2005, Rob Landley wrote:

> Did you read second sentence in the bit you just quoted?  How, exactly, could
> I chroot into there and compile stuff if ld isn't there?

Is the permissions on your hostfs tree set correctly?

Can you execute ld manually?

And again, have you tried with the -bb UML kernels?

http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.9-bb4/

> C) I've compiled this project on a machine with 32 megs of ram and no swap,
> and my laptop actually has 128 megs so if UML isn't giving itself at least 32
> it's making a bad decision...

UML gives itself as much memory as you tell it to on the kernel command 
line. Default to 32 MB IIRC.

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
