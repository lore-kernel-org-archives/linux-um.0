Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ChFhX-0008Lp-SU for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Dec 2004 15:15:27 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1ChFhX-0003OG-5G for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Dec 2004 15:15:27 -0800
Message-ID: <41CA0002.6050802@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Memory corruption/errors?
References: <63806.222.152.52.159.1103583370.squirrel@222.152.52.159>
	<41C963DC.8060401@fujitsu-siemens.com>
	<41C9D1F0.4000605@rimuhosting.com>
	<41C9E847.2060405@fujitsu-siemens.com>
	<41C9FD81.6000408@rimuhosting.com>
In-Reply-To: <41C9FD81.6000408@rimuhosting.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Thu, 23 Dec 2004 00:15:14 +0100
To: Peter <peter.spamcatcher@rimuhosting.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Peter wrote:
> I don't run TT mode UMLs.  So, no I haven't tried that.
> 
> I don't know about the sighandler.  The program runs as it was listed. 
> It is running on a 'regular' server (Debian, and/or WBL3) with other 
> processes running.  And the host servers happen to be running other 
> UMLs.  I don't know if that information helps.  (i.e. can a sighandler 
> in another process on the UML or on the host cause this problem?)
> 
> I'd be happy to try out a skas patch - preferably if it just applied to 
> the guest ;)  To see if it fixes things or not.
> 
> Regards, Peter
> 
I could try to create a patch, just for testing.
What machine is your host? It probably has fxsr?

Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
