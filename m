Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZC3x-00087L-5E for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 09:45:17 -0800
Received: from bay24-f27.bay24.hotmail.com ([64.4.18.77] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CZC3w-0004CO-P3 for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 09:45:17 -0800
Message-ID: <BAY24-F272A756C4E6200D477EB2F83BE0@phx.gbl>
In-Reply-To: <20041130103255.GB5593@bytesex>
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: [uml-devel] Re: [PATCH] uml_router: cleanup #2
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
Date: Tue, 30 Nov 2004 17:44:53 +0000
To: kraxel@bytesex.org
Cc: User-mode-linux-devel@lists.sourceforge.net, uml@uxu.ch


Gerd Knorr wrote:
> > Patch 11 turns on the packet queue for the tuntap driver.  For technical
> > reasons, it's just too much work to implement on the current sockunix
> > driver.

>Guess thats the "one socket for all umls" thingy?

Yup, I now see what you mean by broken by design. :)  I think it is possible 
to do, but just not worth the effort or complexity when...

>You can create a new
>socket for every uml instance connecting, at least with protocol v3 (not
>sure about the older ones, but I think support for them can be dropped
>without breaking anything by now ...).

Your socket driver looks perfect for the job.   I think Jeff would be happy 
if both could run side by side.

Steve Schmidtke




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
